Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90E120248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDDXZs (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:25:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:47410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728211AbfDDXZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:25:48 -0400
Received: (qmail 1448 invoked by uid 109); 4 Apr 2019 23:25:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:25:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20411 invoked by uid 111); 4 Apr 2019 23:26:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:26:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:25:46 -0400
Date:   Thu, 4 Apr 2019 19:25:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/12] packfile: check midx coverage with .idx rather than
 .pack
Message-ID: <20190404232546.GD21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have a .midx that covers many packfiles, we try to avoid opening
the .idx for those packfiles. However, there are a few problems with the
filename comparison we use:

  - we ask midx_contains_pack() about the .pack name, not the .idx name.
    But it compares to the latter.

  - we compute the basename of the pack using strrchr() to find the
    final slash. But that leaves an extra "/" at the start of our
    string; we need to advance past it.

    That also raises the question of what to do when the name does not
    have a slash at all. This should generally not happen (we always
    find files in "pack/"), but it doesn't hurt to be defensive here.

The tests don't notice because there's nothing about opening those .idx
files that would cause us to give incorrect output. It's just a little
slower. The new test checks this case by corrupting the covered .idx,
and then making sure we don't complain about it.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c                  | 17 ++++++++++++++---
 t/t5319-multi-pack-index.sh | 14 ++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 054269ae5d..e7ca135ed5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -472,6 +472,16 @@ static unsigned int get_max_fd_limit(void)
 #endif
 }
 
+static const char *pack_basename(struct packed_git *p)
+{
+	const char *ret = strrchr(p->pack_name, '/');
+	if (ret)
+		ret = ret + 1; /* skip past slash */
+	else
+		ret = p->pack_name; /* we only have a base */
+	return ret;
+}
+
 /*
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
@@ -486,15 +496,16 @@ static int open_packed_git_1(struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (!p->index_data) {
+	if (!p->index_data && the_repository->objects->multi_pack_index) {
 		struct multi_pack_index *m;
-		const char *pack_name = strrchr(p->pack_name, '/');
+		char *idx_name = pack_name_to_idx(pack_basename(p));
 
 		for (m = the_repository->objects->multi_pack_index;
 		     m; m = m->next) {
-			if (midx_contains_pack(m, pack_name))
+			if (midx_contains_pack(m, idx_name))
 				break;
 		}
+		free(idx_name);
 
 		if (!m && open_pack_index(p))
 			return error("packfile %s index unavailable", p->pack_name);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 8c4d2bd849..1ebf19ec3c 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -117,6 +117,20 @@ test_expect_success 'write midx with one v2 pack' '
 
 compare_results_with_midx "one v2 pack"
 
+test_expect_success 'corrupt idx not opened' '
+	idx=$(test-tool read-midx $objdir | grep "\.idx\$") &&
+	mv $objdir/pack/$idx backup-$idx &&
+	test_when_finished "mv backup-\$idx \$objdir/pack/\$idx" &&
+
+	# This is the minimum size for a sha-1 based .idx; this lets
+	# us pass perfunctory tests, but anything that actually opens and reads
+	# the idx file will complain.
+	test_copy_bytes 1064 <backup-$idx >$objdir/pack/$idx &&
+
+	git -c core.multiPackIndex=true rev-list --objects --all 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'add more objects' '
 	for i in $(test_seq 6 10)
 	do
-- 
2.21.0.714.gd1be1d035b

