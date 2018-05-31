Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70021F42D
	for <e@80x24.org>; Thu, 31 May 2018 22:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbeEaWpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 18:45:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:58494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750766AbeEaWpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 18:45:33 -0400
Received: (qmail 23959 invoked by uid 109); 31 May 2018 22:45:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 22:45:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18378 invoked by uid 111); 31 May 2018 22:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 18:45:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 18:45:31 -0400
Date:   Thu, 31 May 2018 18:45:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] index-pack: handle --strict checks of non-repo packs
Message-ID: <20180531224531.GB13127@sigill.intra.peff.net>
References: <20180531223901.GA18999@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531223901.GA18999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 73c3f0f704 (index-pack: check .gitmodules files with
--strict, 2018-05-04) added a call to add_packed_git(), with
the intent that the newly-indexed objects would be available
to the process when we run fsck_finish().  But that's not
what add_packed_git() does. It only allocates the struct,
and you must install_packed_git() on the result. So that
call was effectively doing nothing (except leaking a
struct).

But wait, we passed all of the tests! Does that mean we
don't need the call at all?

For normal cases, no. When we run "index-pack --stdin"
inside a repository, we write the new pack into the object
directory. If fsck_finish() needs to access one of the new
objects, then our initial lookup will fail to find it, but
we'll follow up by running reprepare_packed_git() and
looking again. That logic was meant to handle somebody else
repacking simultaneously, but it ends up working for us
here.

But there is a case that does need this, that we were not
testing. You can run "git index-pack foo.pack" on any file,
even when it is not inside the object directory. Or you may
not even be in a repository at all! This case fails without
doing the proper install_packed_git() call.

We can make this work by adding the install call.

Note that we should be prepared to handle add_packed_git()
failing. We can just silently ignore this case, though. If
fsck_finish() later needs the objects and they're not
available, it will complain itself. And if it doesn't
(because we were able to resolve the whole fsck in the first
pass), then it actually isn't an interesting error at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c       |  8 ++++++--
 t/t7415-submodule-names.sh | 10 ++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4ab31ed388..74fe2973e1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1482,8 +1482,12 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	} else
 		chmod(final_index_name, 0444);
 
-	if (do_fsck_object)
-		add_packed_git(final_index_name, strlen(final_index_name), 0);
+	if (do_fsck_object) {
+		struct packed_git *p;
+		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
+		if (p)
+			install_packed_git(the_repository, p);
+	}
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(hash));
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index a770d92a55..4157e1a134 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -122,6 +122,16 @@ test_expect_success 'transfer.fsckObjects handles odd pack (index)' '
 	test_must_fail git -C dst.git index-pack --strict --stdin <odd.pack
 '
 
+test_expect_success 'index-pack --strict works for non-repo pack' '
+	rm -rf dst.git &&
+	git init --bare dst.git &&
+	cp odd.pack dst.git &&
+	test_must_fail git -C dst.git index-pack --strict odd.pack 2>output &&
+	# Make sure we fail due to bad gitmodules content, not because we
+	# could not read the blob in the first place.
+	grep gitmodulesName output
+'
+
 test_expect_success 'fsck detects symlinked .gitmodules file' '
 	git init symlink &&
 	(
-- 
2.17.1.1443.gd58a3f03b7
