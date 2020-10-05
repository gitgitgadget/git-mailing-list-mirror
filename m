Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10615C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C996320659
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJEHVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:49252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEHVD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:21:03 -0400
Received: (qmail 30337 invoked by uid 109); 5 Oct 2020 07:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 07:21:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16545 invoked by uid 111); 5 Oct 2020 07:21:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 03:21:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 03:21:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] t0060: test obscured .gitattributes and .gitignore
 matching
Message-ID: <20201005072102.GE2291074@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005071751.GA2290770@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have tests that cover various filesystem-specific spellings of
".gitmodules", because we need to reliably identify that path for some
security checks. These are from dc2d9ba318 (is_{hfs,ntfs}_dotgitmodules:
add tests, 2018-05-12), with the actual code coming from e7cb0b4455
(is_ntfs_dotgit: match other .git files, 2018-05-11) and 0fc333ba20
(is_hfs_dotgit: match other .git files, 2018-05-02).

Those latter two commits also added similar matching functions for
.gitattributes and .gitignore. These ended up not being used in the
final series, and are currently dead code. But in preparation for them
being used, let's make sure they actually work by throwing a few basic
checks at them.

I didn't bother with the whole battery of tests that we cover for
.gitmodules. These functions are all based on the same generic matcher,
so it's sufficient to test most of the corner cases just once.

Note that the ntfs magic prefix names in the tests come from the
algorithm described in e7cb0b4455 (and are different for each file).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-path-utils.c | 41 ++++++++++++++++++++++++++------------
 t/t0060-path-utils.sh      | 20 +++++++++++++++++++
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 313a153209..9e253f8058 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -172,9 +172,22 @@ static struct test_data dirname_data[] = {
 	{ NULL,              NULL     }
 };
 
-static int is_dotgitmodules(const char *path)
+static int check_dotgitx(const char *x, const char **argv,
+			 int (*is_hfs)(const char *),
+			 int (*is_ntfs)(const char *))
 {
-	return is_hfs_dotgitmodules(path) || is_ntfs_dotgitmodules(path);
+	int res = 0, expect = 1;
+	for (; *argv; argv++) {
+		if (!strcmp("--not", *argv))
+			expect = !expect;
+		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
+			 res = error("'%s' is %s.%s", *argv,
+				     expect ? "not " : "", x);
+		else
+			fprintf(stderr, "ok: '%s' is %s.%s\n",
+				*argv, expect ? "" : "not ", x);
+	}
+	return !!res;
 }
 
 static int cmp_by_st_size(const void *a, const void *b)
@@ -382,17 +395,19 @@ int cmd__path_utils(int argc, const char **argv)
 		return test_function(dirname_data, posix_dirname, argv[1]);
 
 	if (argc > 2 && !strcmp(argv[1], "is_dotgitmodules")) {
-		int res = 0, expect = 1, i;
-		for (i = 2; i < argc; i++)
-			if (!strcmp("--not", argv[i]))
-				expect = !expect;
-			else if (expect != is_dotgitmodules(argv[i]))
-				res = error("'%s' is %s.gitmodules", argv[i],
-					    expect ? "not " : "");
-			else
-				fprintf(stderr, "ok: '%s' is %s.gitmodules\n",
-					argv[i], expect ? "" : "not ");
-		return !!res;
+		return check_dotgitx("gitmodules", argv + 2,
+				     is_hfs_dotgitmodules,
+				     is_ntfs_dotgitmodules);
+	}
+	if (argc > 2 && !strcmp(argv[1], "is_dotgitignore")) {
+		return check_dotgitx("gitignore", argv + 2,
+				     is_hfs_dotgitignore,
+				     is_ntfs_dotgitignore);
+	}
+	if (argc > 2 && !strcmp(argv[1], "is_dotgitattributes")) {
+		return check_dotgitx("gitattributes", argv + 2,
+				     is_hfs_dotgitattributes,
+				     is_ntfs_dotgitattributes);
 	}
 
 	if (argc > 2 && !strcmp(argv[1], "file-size")) {
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 56db5c8aba..b2e3cf3f4c 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -468,6 +468,26 @@ test_expect_success 'match .gitmodules' '
 		.gitmodules,:\$DATA
 '
 
+test_expect_success 'match .gitattributes' '
+	test-tool path-utils is_dotgitattributes \
+		.gitattributes \
+		.git${u200c}attributes \
+		.Gitattributes \
+		.gitattributeS \
+		GITATT~1 \
+		GI7D29~1
+'
+
+test_expect_success 'match .gitignore' '
+	test-tool path-utils is_dotgitignore \
+		.gitignore \
+		.git${u200c}ignore \
+		.Gitignore \
+		.gitignorE \
+		GITIGN~1 \
+		GI250A~1
+'
+
 test_expect_success MINGW 'is_valid_path() on Windows' '
 	test-tool path-utils is_valid_path \
 		win32 \
-- 
2.28.0.1295.g4824feede7

