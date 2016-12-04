Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FA01FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 19:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbcLDTss (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 14:48:48 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:36398 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbcLDTss (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 14:48:48 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 236BA20290
        for <git@vger.kernel.org>; Sun,  4 Dec 2016 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1480880927;
        bh=qACfN6HZyg/2ySP0X6EwDpjwBzjZiBrjRevHpqAhxPA=;
        h=From:To:Cc:Subject:Date:From;
        b=oSn7TFD104NEkf1XG8HYqyyCI4eTRGQh3AmxPhG8Kpa1NX/JXiQeEuOaU5pp22HMN
         XFGRgQHdOHxWpCaTJEg+LBoherLwScffAsh1sYnl9SN5VXrT1ZvkAZ/qKRKRYOXAy/
         cfdjHLuDx2KHcbu1HD/EOullj16lCHRZ36eLYMrI=
Received: from debian (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Sun,  4 Dec 2016 19:48:47 +0000 (UTC)
Received: from nottheoilrig by debian with local (Exim 4.88)
        (envelope-from <nottheoilrig@debian>)
        id 1cDcmD-00023i-Tg; Sun, 04 Dec 2016 12:48:45 -0700
From:   Jack Bates <bk874k@nottheoilrig.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jack Bates <jack@nottheoilrig.com>
Subject: [PATCH] diff: fix up SHA-1 abbreviations outside of repository
Date:   Sun,  4 Dec 2016 12:47:47 -0700
Message-Id: <20161204194747.7100-1-jack@nottheoilrig.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The three cases where "git diff" operates outside of a repository are 1)
when we run it outside of a repository, 2) when one of the files we're
comparing is outside of the repository we're in, and 3) the --no-index
option. Commit 4f03666 ("diff: handle sha1 abbreviations outside of
repository", 2016-10-20) only worked in the first case.
---
 builtin/diff.c                  |  4 +++-
 t/t4063-diff-no-index-abbrev.sh | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 t/t4063-diff-no-index-abbrev.sh

diff --git a/builtin/diff.c b/builtin/diff.c
index 7f91f6d..ec7c432 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -342,9 +342,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		       "--no-index" : "[--no-index]");
 
 	}
-	if (no_index)
+	if (no_index) {
 		/* If this is a no-index diff, just run it and exit there. */
+		startup_info->have_repository = 0;
 		diff_no_index(&rev, argc, argv);
+	}
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
diff --git a/t/t4063-diff-no-index-abbrev.sh b/t/t4063-diff-no-index-abbrev.sh
new file mode 100755
index 0000000..d1d6302
--- /dev/null
+++ b/t/t4063-diff-no-index-abbrev.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='don'\'' peek into .git when operating outside of a repository
+
+When abbreviating SHA-1s, if another object in the repository has the
+same abbreviation, we normally lengthen the abbreviation until it'\''s
+unique. Commit 4f03666 ("diff: handle sha1 abbreviations outside of
+repository", 2016-10-20) addressed the case of abbreviating SHA-1s
+outside the context of a repository. In that case we shouldn'\''t peek
+into a .git directory to make an abbreviation unique.
+
+To check that we don'\''t, create an blob with a SHA-1 that starts with
+0000. (Outside of a repository, SHA-1s are all zeros.) Then make an
+abbreviation and check that Git doesn'\''t lengthen it.
+
+The three cases where "git diff" operates outside of a repository are
+1) when we run it outside of a repository, 2) when one of the files
+we'\''re comparing is outside of the repository we'\''re in,
+and 3) the --no-index option.
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo 1 >a &&
+	echo 2 >b &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Create a blob
+		# 00002e907f44c3881822c473d8842405cfd96362
+		echo 119132 >collision &&
+		git add collision
+	)
+'
+
+cat >expect <<EOF
+:100644 100644 0000... 0000... M	../a
+EOF
+
+test_expect_success 'don'\''t peek into .git when operating outside of a repository' '
+	(
+		cd repo &&
+		test_must_fail git diff --raw --abbrev=4 ../a ../b >actual &&
+		test_cmp ../expect actual
+	)
+'
+
+test_done
-- 
2.10.2
