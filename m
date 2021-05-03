Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE90C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196EC610C8
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhECUod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:44:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:43574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhECUoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:44:18 -0400
Received: (qmail 7620 invoked by uid 109); 3 May 2021 20:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:43:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7498 invoked by uid 111); 3 May 2021 20:43:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:43:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:43:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/9] t0060: test ntfs/hfs-obscured dotfiles
Message-ID: <YJBgattiouF9QlKo@coredump.intra.peff.net>
References: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
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
being used in some fsck checks, let's make sure they actually work by
throwing a few basic tests at them. Likewise, let's cover .mailmap
(which does need matching code added).

I didn't bother with the whole battery of tests that we cover for
.gitmodules. These functions are all based on the same generic matcher,
so it's sufficient to test most of the corner cases just once.

Note that the ntfs magic prefix names in the tests come from the
algorithm described in e7cb0b4455 (and are different for each file).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                    |  1 +
 path.c                     |  5 +++++
 t/helper/test-path-utils.c | 46 +++++++++++++++++++++++++++-----------
 t/t0060-path-utils.sh      | 30 +++++++++++++++++++++++++
 utf8.c                     |  5 +++++
 utf8.h                     |  1 +
 6 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index b785ffb383..e6dda88fb0 100644
--- a/cache.h
+++ b/cache.h
@@ -1271,6 +1271,7 @@ int is_ntfs_dotgit(const char *name);
 int is_ntfs_dotgitmodules(const char *name);
 int is_ntfs_dotgitignore(const char *name);
 int is_ntfs_dotgitattributes(const char *name);
+int is_ntfs_dotmailmap(const char *name);
 
 /*
  * Returns true iff "str" could be confused as a command-line option when
diff --git a/path.c b/path.c
index 9e883eb524..7bccd830e9 100644
--- a/path.c
+++ b/path.c
@@ -1493,6 +1493,11 @@ int is_ntfs_dotgitattributes(const char *name)
 	return is_ntfs_dot_str(name, "gitattributes", "gi7d29");
 }
 
+int is_ntfs_dotmailmap(const char *name)
+{
+	return is_ntfs_dot_str(name, "mailmap", "maba30");
+}
+
 int looks_like_command_line_option(const char *str)
 {
 	return str && str[0] == '-';
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 313a153209..229ed416b0 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -172,9 +172,22 @@ static struct test_data dirname_data[] = {
 	{ NULL,              NULL     }
 };
 
-static int is_dotgitmodules(const char *path)
+static int check_dotfile(const char *x, const char **argv,
+			 int (*is_hfs)(const char *),
+			 int (*is_ntfs)(const char *))
 {
-	return is_hfs_dotgitmodules(path) || is_ntfs_dotgitmodules(path);
+	int res = 0, expect = 1;
+	for (; *argv; argv++) {
+		if (!strcmp("--not", *argv))
+			expect = !expect;
+		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
+			res = error("'%s' is %s.git%s", *argv,
+				    expect ? "not " : "", x);
+		else
+			fprintf(stderr, "ok: '%s' is %s.git%s\n",
+				*argv, expect ? "" : "not ", x);
+	}
+	return !!res;
 }
 
 static int cmp_by_st_size(const void *a, const void *b)
@@ -382,17 +395,24 @@ int cmd__path_utils(int argc, const char **argv)
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
+		return check_dotfile("modules", argv + 2,
+				     is_hfs_dotgitmodules,
+				     is_ntfs_dotgitmodules);
+	}
+	if (argc > 2 && !strcmp(argv[1], "is_dotgitignore")) {
+		return check_dotfile("ignore", argv + 2,
+				     is_hfs_dotgitignore,
+				     is_ntfs_dotgitignore);
+	}
+	if (argc > 2 && !strcmp(argv[1], "is_dotgitattributes")) {
+		return check_dotfile("attributes", argv + 2,
+				     is_hfs_dotgitattributes,
+				     is_ntfs_dotgitattributes);
+	}
+	if (argc > 2 && !strcmp(argv[1], "is_dotmailmap")) {
+		return check_dotfile("mailmap", argv + 2,
+				     is_hfs_dotmailmap,
+				     is_ntfs_dotmailmap);
 	}
 
 	if (argc > 2 && !strcmp(argv[1], "file-size")) {
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0ff06b5d1b..de4960783f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -468,6 +468,36 @@ test_expect_success 'match .gitmodules' '
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
+test_expect_success 'match .mailmap' '
+	test-tool path-utils is_dotmailmap \
+		.mailmap \
+		.mail${u200c}map \
+		.Mailmap \
+		.mailmaP \
+		MAILMA~1 \
+		MABA30~1
+'
+
 test_expect_success MINGW 'is_valid_path() on Windows' '
 	test-tool path-utils is_valid_path \
 		win32 \
diff --git a/utf8.c b/utf8.c
index 5b39361ada..de4ce5c0e6 100644
--- a/utf8.c
+++ b/utf8.c
@@ -777,6 +777,11 @@ int is_hfs_dotgitattributes(const char *path)
 	return is_hfs_dot_str(path, "gitattributes");
 }
 
+int is_hfs_dotmailmap(const char *path)
+{
+	return is_hfs_dot_str(path, "mailmap");
+}
+
 const char utf8_bom[] = "\357\273\277";
 
 int skip_utf8_bom(char **text, size_t len)
diff --git a/utf8.h b/utf8.h
index fcd5167baf..9a16c8679d 100644
--- a/utf8.h
+++ b/utf8.h
@@ -61,6 +61,7 @@ int is_hfs_dotgit(const char *path);
 int is_hfs_dotgitmodules(const char *path);
 int is_hfs_dotgitignore(const char *path);
 int is_hfs_dotgitattributes(const char *path);
+int is_hfs_dotmailmap(const char *path);
 
 typedef enum {
 	ALIGN_LEFT,
-- 
2.31.1.926.gd12152deb6

