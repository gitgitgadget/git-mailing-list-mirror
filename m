Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097AB20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfDESGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:06:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:48700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:06:24 -0400
Received: (qmail 11084 invoked by uid 109); 5 Apr 2019 18:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:06:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28234 invoked by uid 111); 5 Apr 2019 18:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:06:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:06:22 -0400
Date:   Fri, 5 Apr 2019 14:06:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/13] packfile: fix pack basename computation
Message-ID: <20190405180622.GF32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have a multi-pack-index that covers many packfiles, we try to
avoid opening the .idx for those packfiles. To do that we feed the pack
name to midx_contains_pack(). But that function wants to see only the
basename, which we compute using strrchr() to find the final slash. But
that leaves an extra "/" at the start of our string.

We can fix this by incrementing the pointer. That also raises the
question of what to do when the name does not have a '/' at all. This
should generally not happen (we always find files in "pack/"), but it
doesn't hurt to be defensive here.

Let's wrap all of that up in a helper function and make it publicly
available, since a later patch will need to use it, too.

The tests don't notice because there's nothing about opening those .idx
files that would cause us to give incorrect output. It's just a little
slower. The new test checks this case by corrupting the covered .idx,
and then making sure we don't complain about it.

We also have to tweak t5570, which intentionally corrupts a .idx file
and expects us to notice it. When run with GIT_TEST_MULTI_PACK_INDEX,
this will fail since we now will (correctly) not bother opening the .idx
at all. We can fix that by unconditionally dropping any midx that's
there, which ensures we'll have to read the .idx.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c                  | 12 +++++++++++-
 packfile.h                  |  6 ++++++
 t/t5319-multi-pack-index.sh | 14 ++++++++++++++
 t/t5570-git-daemon.sh       |  1 +
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 6e40bd89c7..7a2dd2fdbe 100644
--- a/packfile.c
+++ b/packfile.c
@@ -466,6 +466,16 @@ static unsigned int get_max_fd_limit(void)
 #endif
 }
 
+const char *pack_basename(struct packed_git *p)
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
@@ -482,7 +492,7 @@ static int open_packed_git_1(struct packed_git *p)
 
 	if (!p->index_data) {
 		struct multi_pack_index *m;
-		const char *pack_name = strrchr(p->pack_name, '/');
+		const char *pack_name = pack_basename(p);
 
 		for (m = the_repository->objects->multi_pack_index;
 		     m; m = m->next) {
diff --git a/packfile.h b/packfile.h
index b40fc34fb2..45bf792d79 100644
--- a/packfile.h
+++ b/packfile.h
@@ -31,6 +31,12 @@ char *sha1_pack_name(const unsigned char *sha1);
  */
 char *sha1_pack_index_name(const unsigned char *sha1);
 
+/*
+ * Return the basename of the packfile, omitting any containing directory
+ * (e.g., "pack-1234abcd[...].pack").
+ */
+const char *pack_basename(struct packed_git *p);
+
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
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
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 58ee787685..19e271bda6 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -90,6 +90,7 @@ test_expect_success 'fetch notices corrupt pack' '
 test_expect_success 'fetch notices corrupt idx' '
 	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
 	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
+	 rm -f objects/pack/multi-pack-index &&
 	 p=$(ls objects/pack/pack-*.idx) &&
 	 chmod u+w $p &&
 	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
-- 
2.21.0.729.g7d31bf3764

