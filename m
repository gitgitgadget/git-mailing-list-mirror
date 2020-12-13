Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA38C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 00:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608D2224F9
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 00:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439952AbgLMA1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 19:27:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59288 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439944AbgLMA1L (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Dec 2020 19:27:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 901276076A;
        Sun, 13 Dec 2020 00:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607819152;
        bh=Swdyd6ZrgAQapM/BV/UyfoN/f73IbnjriGtsAe+jxx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=r7zwnVpK4rWOGML2mlLiiGCImFGzUbGEk5qmlEwPAK0rtdEtR6ux3K96YKGydTrGQ
         UXk9BGx5Dpq2O87iECgqBzJJliGEuH4o+Oms9SxXXzw8OZXd/wVCB6nwQKevnNJjNF
         s8lcoZkF2Nwq4mQrdjbJVDYDl+ht1PuPUUVBeXl2RiGUkOHek0WQga2kaeo1Bl6FuY
         uaMdJfZNAr4Gr9FdQlxXsmDk7OvmIe/4qJiA0bBRSdfkHvuaGr4vqi9psvpAwRcY2I
         QozRqO60HlAh3xpx5itpnwOCbUaIejW4/x31oVrLiqwcH+efQIlC/MRpIQAH6LNQL7
         al/43oUWNXb7z+Rg6jcoigPs9Us/Im5xNn3hJwatM5g7w1ZrjR4uYC9jPYlvxhHN8U
         j9DN9XCklE7qPf1njNt+9Tf06b/mqGMtkCXl/QSTgF7zV9ynD/DFZtkHIsEsTzNN9X
         CnlXe0sNEkF/xxM2JyUuHUjNPUhi6V1FWksiRAfM8k+fZq4U0r6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 1/2] abspath: add a function to resolve paths with missing components
Date:   Sun, 13 Dec 2020 00:25:28 +0000
Message-Id: <20201213002529.542928-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201213002529.542928-1-sandals@crustytoothpaste.net>
References: <20201213002529.542928-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, we have a function to resolve paths, strbuf_realpath.  This
function canonicalizes paths like realpath(3), but permits a trailing
component to be absent from the file system.  In other words, this is
the behavior of the GNU realpath(1) without any arguments.

In the future, we'll need this same behavior, except that we want to
allow for any number of missing trailing components, which is the
behavior of GNU realpath(1) with the -m option.  This is useful because
we'll want to canonicalize a path that may point to a not yet present
path under the .git directory.  For example, a user may want to know
where an arbitrary ref would be stored if it existed in the file system.

Let's refactor strbuf_realpath to move most of the code to an internal
function and then pass it two flags to control its behavior.  We'll add
a strbuf_realpath_forgiving function that has our new behavior, and
leave strbuf_realpath with the older, stricter behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 abspath.c | 64 +++++++++++++++++++++++++++++++++++++++----------------
 cache.h   |  2 ++
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/abspath.c b/abspath.c
index 6f15a418bb..39e06b5848 100644
--- a/abspath.c
+++ b/abspath.c
@@ -67,19 +67,15 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 #endif
 
 /*
- * Return the real path (i.e., absolute path, with symlinks resolved
- * and extra slashes removed) equivalent to the specified path.  (If
- * you want an absolute path but don't mind links, use
- * absolute_path().)  Places the resolved realpath in the provided strbuf.
- *
- * The directory part of path (i.e., everything up to the last
- * dir_sep) must denote a valid, existing directory, but the last
- * component need not exist.  If die_on_error is set, then die with an
- * informative error message if there is a problem.  Otherwise, return
- * NULL on errors (without generating any output).
+ * If set, any number of trailing components may be missing; otherwise, only one
+ * may be.
  */
-char *strbuf_realpath(struct strbuf *resolved, const char *path,
-		      int die_on_error)
+#define REALPATH_MANY_MISSING (1 << 0)
+/* Should we die if there's an error? */
+#define REALPATH_DIE_ON_ERROR (1 << 1)
+
+static char *strbuf_realpath_1(struct strbuf *resolved, const char *path,
+			       int flags)
 {
 	struct strbuf remaining = STRBUF_INIT;
 	struct strbuf next = STRBUF_INIT;
@@ -89,7 +85,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	struct stat st;
 
 	if (!*path) {
-		if (die_on_error)
+		if (flags & REALPATH_DIE_ON_ERROR)
 			die("The empty string is not a valid path");
 		else
 			goto error_out;
@@ -101,7 +97,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	if (!resolved->len) {
 		/* relative path; can use CWD as the initial resolved path */
 		if (strbuf_getcwd(resolved)) {
-			if (die_on_error)
+			if (flags & REALPATH_DIE_ON_ERROR)
 				die_errno("unable to get current working directory");
 			else
 				goto error_out;
@@ -129,8 +125,9 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 		if (lstat(resolved->buf, &st)) {
 			/* error out unless this was the last component */
-			if (errno != ENOENT || remaining.len) {
-				if (die_on_error)
+			if (errno != ENOENT ||
+			   (!(flags & REALPATH_MANY_MISSING) && remaining.len)) {
+				if (flags & REALPATH_DIE_ON_ERROR)
 					die_errno("Invalid path '%s'",
 						  resolved->buf);
 				else
@@ -143,7 +140,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			if (num_symlinks++ > MAXSYMLINKS) {
 				errno = ELOOP;
 
-				if (die_on_error)
+				if (flags & REALPATH_DIE_ON_ERROR)
 					die("More than %d nested symlinks "
 					    "on path '%s'", MAXSYMLINKS, path);
 				else
@@ -153,7 +150,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			len = strbuf_readlink(&symlink, resolved->buf,
 					      st.st_size);
 			if (len < 0) {
-				if (die_on_error)
+				if (flags & REALPATH_DIE_ON_ERROR)
 					die_errno("Invalid symlink '%s'",
 						  resolved->buf);
 				else
@@ -202,6 +199,37 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
+/*
+ * Return the real path (i.e., absolute path, with symlinks resolved
+ * and extra slashes removed) equivalent to the specified path.  (If
+ * you want an absolute path but don't mind links, use
+ * absolute_path().)  Places the resolved realpath in the provided strbuf.
+ *
+ * The directory part of path (i.e., everything up to the last
+ * dir_sep) must denote a valid, existing directory, but the last
+ * component need not exist.  If die_on_error is set, then die with an
+ * informative error message if there is a problem.  Otherwise, return
+ * NULL on errors (without generating any output).
+ */
+char *strbuf_realpath(struct strbuf *resolved, const char *path,
+		      int die_on_error)
+{
+	return strbuf_realpath_1(resolved, path,
+				 die_on_error ? REALPATH_DIE_ON_ERROR : 0);
+}
+
+/*
+ * Just like strbuf_realpath, but allows an arbitrary number of path
+ * components to be missing.
+ */
+char *strbuf_realpath_forgiving(struct strbuf *resolved, const char *path,
+				int die_on_error)
+{
+	return strbuf_realpath_1(resolved, path,
+				 ((die_on_error ? REALPATH_DIE_ON_ERROR : 0) |
+				  REALPATH_MANY_MISSING));
+}
+
 char *real_pathdup(const char *path, int die_on_error)
 {
 	struct strbuf realpath = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index 8d279bc110..487ebab8b0 100644
--- a/cache.h
+++ b/cache.h
@@ -1325,6 +1325,8 @@ static inline int is_absolute_path(const char *path)
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
+char *strbuf_realpath_forgiving(struct strbuf *resolved, const char *path,
+				int die_on_error);
 char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);
