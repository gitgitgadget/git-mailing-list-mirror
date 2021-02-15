Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D2C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A0D64E08
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBOXUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 18:20:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:33330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBOXT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 18:19:57 -0500
Received: (qmail 9439 invoked by uid 109); 15 Feb 2021 23:19:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Feb 2021 23:19:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17332 invoked by uid 111); 15 Feb 2021 23:19:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Feb 2021 18:19:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Feb 2021 18:19:15 -0500
From:   Jeff King <peff@peff.net>
To:     Blake Burkhart <bburky@bburky.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 2/2] disallow symlinked .mailmap files
Message-ID: <YCsBc6jap4qqtbcE@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCsBA002yv8XpppM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Symlinked .mailmap files do not work as users might expect and open up a
security concern:

  - when we read the files from a blob (e.g., in a bare repository as
    HEAD:.mailmap), we would not respect the symlink (and in fact would
    treat the symlink target as a mailmap entry, which is confusing at
    best).

  - if the symlink points outside of the working tree, this can be used
    to exfiltrate data from a service that can be convinced to check out
    an untrusted repo and run "git shortlog" or similar

Let's give .mailmap the same treatment we gave to .gitignore and
.gitattributes: it will be disallowed for checkout, and produce an fsck
warning (which can be upgraded in severity using config).

Note that we're relying on our ntfs/hfs path-matching infrastructure
here. That was originally designed for .git*, but it should work in this
instance, too (the important thing is that our "needle" path is still
plain ASCII, so we don't need to know the full range of case folds).

The NTFS short-name hash was generated using the perl script included in
e7cb0b4455 (is_ntfs_dotgit: match other .git files, 2018-05-11). Though
note that I needed to use "%04x" when formatting the final hex, as the
hash value for this file happens to begin with a 0.

Reported-by: Blake Burkhart <bburky@bburky.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                      |  1 +
 fsck.c                       |  6 ++++++
 path.c                       |  5 +++++
 read-cache.c                 |  6 ++++--
 t/helper/test-path-utils.c   |  5 +++++
 t/t0060-path-utils.sh        | 10 ++++++++++
 t/t7450-bad-dotgitx-files.sh |  4 ++++
 utf8.c                       |  5 +++++
 utf8.h                       |  1 +
 9 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d928149614..a29084e87c 100644
--- a/cache.h
+++ b/cache.h
@@ -1254,6 +1254,7 @@ int is_ntfs_dotgit(const char *name);
 int is_ntfs_dotgitmodules(const char *name);
 int is_ntfs_dotgitignore(const char *name);
 int is_ntfs_dotgitattributes(const char *name);
+int is_ntfs_dotmailmap(const char *name);
 
 /*
  * Returns true iff "str" could be confused as a command-line option when
diff --git a/fsck.c b/fsck.c
index c75c7d7dc7..860af9cb5b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -81,6 +81,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
+	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	/* ignored (elevated when requested) */ \
@@ -703,6 +704,11 @@ static int fsck_tree(const struct object_id *tree_oid,
 				retval += report(options, tree_oid, OBJ_TREE,
 						 FSCK_MSG_GITATTRIBUTES_SYMLINK,
 						 ".gitattributes is a symlink");
+			if (is_hfs_dotmailmap(name) ||
+			    is_ntfs_dotmailmap(name))
+				retval += report(options, tree_oid, OBJ_TREE,
+						 FSCK_MSG_MAILMAP_SYMLINK,
+						 ".mailmap is a symlink");
 		}
 
 		if ((backslash = strchr(name, '\\'))) {
diff --git a/path.c b/path.c
index 7b385e5eb2..2c496d6161 100644
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
diff --git a/read-cache.c b/read-cache.c
index dd17ebd236..322eddb874 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -984,7 +984,8 @@ int verify_path(const char *path, unsigned mode)
 				if (S_ISLNK(mode)) {
 					if (is_hfs_dotgitmodules(path) ||
 					    is_hfs_dotgitignore(path) ||
-					    is_hfs_dotgitattributes(path))
+					    is_hfs_dotgitattributes(path) ||
+					    is_hfs_dotmailmap(path))
 						return 0;
 				}
 			}
@@ -998,7 +999,8 @@ int verify_path(const char *path, unsigned mode)
 				if (S_ISLNK(mode)) {
 					if (is_ntfs_dotgitmodules(path) ||
 					    is_ntfs_dotgitignore(path) ||
-					    is_ntfs_dotgitattributes(path))
+					    is_ntfs_dotgitattributes(path) ||
+					    is_ntfs_dotmailmap(path))
 						return 0;
 				}
 			}
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 732372b97f..98044d53fa 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -409,6 +409,11 @@ int cmd__path_utils(int argc, const char **argv)
 				     is_hfs_dotgitattributes,
 				     is_ntfs_dotgitattributes);
 	}
+	if (argc > 2 && !strcmp(argv[1], "is_dotmailmap")) {
+		return check_dotgitx("mailmap", argv + 2,
+				     is_hfs_dotmailmap,
+				     is_ntfs_dotmailmap);
+	}
 
 	if (argc > 2 && !strcmp(argv[1], "file-size")) {
 		int res = 0, i;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index fab077b6f7..de4960783f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -488,6 +488,16 @@ test_expect_success 'match .gitignore' '
 		GI250A~1
 '
 
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
diff --git a/t/t7450-bad-dotgitx-files.sh b/t/t7450-bad-dotgitx-files.sh
index 4b1edb150e..c12f0373fd 100755
--- a/t/t7450-bad-dotgitx-files.sh
+++ b/t/t7450-bad-dotgitx-files.sh
@@ -211,6 +211,10 @@ check_forbidden_symlink --fsck-warning gitignore vanilla .gitignore
 check_forbidden_symlink --fsck-warning gitignore ntfs ".gitignore ."
 check_forbidden_symlink --fsck-warning gitignore hfs ".${u200c}gitignore"
 
+check_forbidden_symlink --fsck-warning mailmap vanilla .mailmap
+check_forbidden_symlink --fsck-warning mailmap ntfs ".mailmap ."
+check_forbidden_symlink --fsck-warning mailmap hfs ".${u200c}mailmap"
+
 test_expect_success 'fsck detects non-blob .gitmodules' '
 	git init non-blob &&
 	(
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
2.30.1.986.gd86016a168
