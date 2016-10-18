Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C4120988
	for <e@80x24.org>; Tue, 18 Oct 2016 15:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761533AbcJRPNY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 11:13:24 -0400
Received: from nm28-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.158]:41657 "EHLO
        nm28-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752826AbcJRPNW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Oct 2016 11:13:22 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Oct 2016 11:13:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sbcglobal.net; s=s2048; t=1476803201; bh=kpXXdoPE2NJDktROURPn6YFH3itJT7+smeFvYFH2oGs=; h=From:To:Cc:Subject:Date:From:Subject; b=CAK9O2N+tL0arQ3GQ5UcX8Ge8mb3oy6X74Or3Aiy+mKjFs+qtlf5dLbe9MGtcsCFGh08Vd4VBg2VYfjYnCSeVY3ilbSBE0UekaV1yGENlXcLm+KYyaImN1YH7o/QSBF8FJk9j+poTbtVUIt1/3WRSyue91g1DC3Y87/PUGgp/3xnjMDeLdkbvOtQCxfQDi5E6dQIVPWm2wL4uW5fld0MqqnXtuq9VRuQ0eQBo7953BNkMnpz0ybhvjvhkG1HpZsNcRdGkOul0OKW0z1mR7qSFjYf9POemVTrH+Ed6BFRw1qAIHotV80p0To/8BQ3RrKxKOGWUm4VupWKk2tGsYqykA==
Received: from [98.138.100.118] by nm28.bullet.mail.ne1.yahoo.com with NNFMP; 18 Oct 2016 15:06:41 -0000
Received: from [98.138.226.56] by tm109.bullet.mail.ne1.yahoo.com with NNFMP; 18 Oct 2016 15:06:41 -0000
Received: from [127.0.0.1] by smtp207.mail.ne1.yahoo.com with NNFMP; 18 Oct 2016 15:06:41 -0000
X-Yahoo-Newman-Id: 418158.78252.bm@smtp207.mail.ne1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: yY6WkzAVM1nPIoHZ0KkngEKTxwbvUXC.dSBFyeOWwa0iuQK
 dt.5YgN76pL8dPZdwyCi002AmaUr5_Ywc1oaGE0rSZbvxeodnKj0ahON9AHG
 QSmCgnHs41va1pyXXXT4ckt8_QfzyaRIuhbONwmg4fkryhHmkj5.SBJqQr.z
 3rNEl2D4hcfYbVxke68j_WcshVNHMYhnr4IB8g0ohhdv7ujlYmwqJGB7ANsO
 z7xVZPdn6ZOzjsxpMRsgy3bcOlyZHJQQ3fzNR8zEoHheWdrFC2iGh8vk1Gdy
 qtPEh7d9zNS8SK0u50hQ3k2oWxEFjG1zBfE7MmyxSXm2UnlH2gY6j_GHdLJj
 JTLUqXmbZYcvP9dH.i87jPzJrXCXnCHJdsuzK3Y9bZvbVXGdOnykImM9QeKx
 7DnRgZeg8m0_J78fpdNIJyjn0OEPvGHYpyD2db6ORnpoDytntO7G9Yqk_O5.
 MdAi2DUofXMefEvvYchJKlIrRu20G6NF3.y2CFmDep8ZEVZn1gyTLpK0f8MK
 evhfqmaDYQEuEN0.ysY6e1OL.SCHFadGnLNvsWegOpTNPjN1X8UlGqDbEZfn
 i8aHE
X-Yahoo-SMTP: RfMTpXSswBAvHXkAeeQNI5gHzxpnJ2DwpMu4ffnqKdtAFQ--
From:   Luke Shumaker <lukeshu@sbcglobal.net>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net,
        Luke Shumaker <lukeshu@sbcglobal.net>
Subject: [PATCH] daemon, path.c: fix a bug with ~ in repo paths
Date:   Tue, 18 Oct 2016 11:06:29 -0400
Message-Id: <20161018150629.23205-1-lukeshu@sbcglobal.net>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The superficial aspect of this change is that git-daemon now allows paths
that start with a "~".  Previously, if git-daemon was run with
"--base-path=/srv/git", it was impossible to get it to serve
"/srv/git/~foo/bar.git".  An odd edge-case that was broken.

But from a source-code standpoint, the change is in path.c:enter_repo().  I
have adjusted it to take separate "strict_prefix" and "strict_suffix"
arguments, rather than a single "strict" argument.

I also make it clearer what the purpose of each path buffer is for, by
renaming them to chdir_path and ret_path; chdir_path is the path that we
pass to chdir(); return_path is the path we return to the user.  Using this
nomenclature, we can more easily explain the behavior of the function.
There are 3 DWIM measures that enter_repo() provides: tilde expansion,
suffix guessing, and gitfile expansion; it also trims trailing slashes.
Here is how they are applied to each path:

    +------------------------------+----------------+----------------+
    | Before this commit           | chdir_path     | ret_path       |
    +------------------------------+----------------+----------------+
    | trim trailing slashes        | !strict        | !strict        |
    | tilde expansion              | !strict        | false          |
    | suffix guessing              | !strict        | !strict        |
    | gitfile expansion (< 2.6.3)  | !strict        | false          |
    | gitfile expansion (>= 2.6.3) | true           | strict         |
    +------------------------------+----------------+----------------+
    | With this commit             | chdir_path     | ret_path       |
    +------------------------------+----------------+----------------+
    | trim trailing slashes        | true           | true           |
    | tilde expansion              | !strict_prefix | false          |
    | suffix guessing              | !strict_suffix | !strict_suffix |
    | gitfile expansion            | true           | false          |
    +------------------------------+----------------+----------------+

The separation of "strict" into "strict_prefix" and "strict_suffix" is
necessary for git-daemon because it has separate --strict-paths (affects
prefix and suffix) and --user-path (just prefix) flags that can be toggled
separately.

In the other programs where enter_repo() is called, I continued the
existing behavior of tying the prefix and suffix strictness together
together; though I am not entirely sure that they should all be enabling
tilde expansion.  But for now, their behavior hasn't changed.

Signed-off-by: Luke Shumaker <lukeshu@sbcglobal.net>
---
 builtin/receive-pack.c   |   2 +-
 builtin/upload-archive.c |   2 +-
 cache.h                  |   2 +-
 daemon.c                 |  42 +++++++--------
 http-backend.c           |   2 +-
 path.c                   | 135 +++++++++++++++++++++++++----------------------
 upload-pack.c            |   2 +-
 7 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 011db00..f430e96 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1860,7 +1860,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 	setup_path();
 
-	if (!enter_repo(service_dir, 0))
+	if (!enter_repo(service_dir, 0, 0))
 		die("'%s' does not appear to be a git repository", service_dir);
 
 	git_config(receive_pack_config, NULL);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 2caedf1..00d4ced 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -25,7 +25,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(upload_archive_usage);
 
-	if (!enter_repo(argv[1], 0))
+	if (!enter_repo(argv[1], 0, 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
 	/* put received options in sent_argv[] */
diff --git a/cache.h b/cache.h
index 4cba08e..6380be0 100644
--- a/cache.h
+++ b/cache.h
@@ -1024,7 +1024,7 @@ enum scld_error safe_create_leading_directories_const(const char *path);
 
 int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
-const char *enter_repo(const char *path, int strict);
+const char *enter_repo(const char *path, int strict_prefix, int strict_suffix);
 static inline int is_absolute_path(const char *path)
 {
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
diff --git a/daemon.c b/daemon.c
index 425aad0..118d337 100644
--- a/daemon.c
+++ b/daemon.c
@@ -170,27 +170,23 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		return NULL;
 	}
 
-	if (*dir == '~') {
-		if (!user_path) {
-			logerror("'%s': User-path not allowed", dir);
-			return NULL;
-		}
-		if (*user_path) {
-			/* Got either "~alice" or "~alice/foo";
-			 * rewrite them to "~alice/%s" or
-			 * "~alice/%s/foo".
-			 */
-			int namlen, restlen = strlen(dir);
-			const char *slash = strchr(dir, '/');
-			if (!slash)
-				slash = dir + restlen;
-			namlen = slash - dir;
-			restlen -= namlen;
-			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
-			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
-				 namlen, dir, user_path, restlen, slash);
-			dir = rpath;
-		}
+	if (*dir == '~' && *user_path && user_path[0] != '\0') {
+		/* Got either "~alice" or "~alice/foo";
+		 * rewrite them:
+		 *
+		 * ~alice     -> ~alice/user_dir
+		 * ~alice/foo -> ~alice/user_dir/foo
+		 */
+		int namlen, restlen = strlen(dir);
+		const char *slash = strchr(dir, '/');
+		if (!slash)
+			slash = dir + restlen;
+		namlen = slash - dir;
+		restlen -= namlen;
+		loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
+		snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
+		         namlen, dir, user_path, restlen, slash);
+		dir = rpath;
 	}
 	else if (interpolated_path && hi->saw_extended_args) {
 		struct strbuf expanded_path = STRBUF_INIT;
@@ -223,14 +219,14 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		dir = rpath;
 	}
 
-	path = enter_repo(dir, strict_paths);
+	path = enter_repo(dir, strict_paths || !user_path, strict_paths);
 	if (!path && base_path && base_path_relaxed) {
 		/*
 		 * if we fail and base_path_relaxed is enabled, try without
 		 * prefixing the base path
 		 */
 		dir = directory;
-		path = enter_repo(dir, strict_paths);
+		path = enter_repo(dir, strict_paths || !user_path, strict_paths);
 	}
 
 	if (!path) {
diff --git a/http-backend.c b/http-backend.c
index adc8c8c..d71ed81 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -697,7 +697,7 @@ int cmd_main(int argc, const char **argv)
 		not_found(&hdr, "Request not supported: '%s'", dir);
 
 	setup_path();
-	if (!enter_repo(dir, 0))
+	if (!enter_repo(dir, 0, 0))
 		not_found(&hdr, "Not a git repository: '%s'", dir);
 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
 	    access("git-daemon-export-ok", F_OK) )
diff --git a/path.c b/path.c
index fe3c4d9..636349e 100644
--- a/path.c
+++ b/path.c
@@ -646,96 +646,105 @@ char *expand_user_path(const char *path)
 }
 
 /*
- * First, one directory to try is determined by the following algorithm.
+ * chdir() to, and set_git_dir() to the directory found with "path", using the
+ * following algorithm.
  *
- * (0) If "strict" is given, the path is used as given and no DWIM is
- *     done. Otherwise:
- * (1) "~/path" to mean path under the running user's home directory;
- * (2) "~user/path" to mean path under named user's home directory;
- * (3) "relative/path" to mean cwd relative directory; or
- * (4) "/absolute/path" to mean absolute directory.
+ * (0) "relative/path" to mean cwd relative directory; or
+ * (1) "/absolute/path" to mean absolute directory.
+ * (2) trim trailing slashes
  *
- * Unless "strict" is given, we check "%s/.git", "%s", "%s.git/.git", "%s.git"
- * in this order. We select the first one that is a valid git repository, and
- * chdir() to it. If none match, or we fail to chdir, we return NULL.
+ * Unless "strict_prefix" is given:
+ * (3) "~/path" to mean path under the running user's home directory;
+ * (4) "~user/path" to mean path under named user's home directory;
  *
- * If all goes well, we return the directory we used to chdir() (but
- * before ~user is expanded), avoiding getcwd() resolving symbolic
- * links.  User relative paths are also returned as they are given,
- * except DWIM suffixing.
+ * Unless "strict_suffix" is given:
+ * (5) check "%s/.git", "%s", "%s.git/.git", "%s.git" in this order. We select
+ *     the first one that is a valid git repository, and chdir() to it. If none
+ *     match, we return NULL.
+ *
+ * And then, unconditionally:
+ * (6) If the result is a .git file (instead of a directory) that points to a
+ *     directory elsewhere, follow it.
+ *
+ * If all goes well, we return the input path with suffix alteration (steps 2,
+ * 5, 6) applied, but without prefix alteration (user paths) applied. The
+ * returned value is a pointer to a static buffer.
  */
-const char *enter_repo(const char *path, int strict)
+const char *enter_repo(const char *path, int strict_prefix, int strict_suffix)
 {
-	static struct strbuf validated_path = STRBUF_INIT;
-	static struct strbuf used_path = STRBUF_INIT;
+	/* chdir_path is the path we chdir() to */
+	static struct strbuf chdir_path = STRBUF_INIT;
+	/* ret_path is the path we return */
+	static struct strbuf ret_path = STRBUF_INIT;
+
+	int len;
+	const char *gitfile;
 
 	if (!path)
 		return NULL;
 
-	if (!strict) {
+	len = strlen(path);
+
+	/* strip trailing slashes */
+	while ((1 < len) && (path[len-1] == '/'))
+		len--;
+
+	/*
+	 * We can handle arbitrary-sized buffers, but this remains as a
+	 * sanity check on untrusted input.
+	 */
+	if (PATH_MAX <= len)
+		return NULL;
+
+	strbuf_reset(&chdir_path);
+	strbuf_add(&chdir_path, path, len);
+	strbuf_reset(&ret_path);
+	strbuf_add(&ret_path, path, len);
+
+	if (!strict_prefix && chdir_path.buf[0] == '~') {
+		/* operate only on chdir_path */
+		char *newpath = expand_user_path(chdir_path.buf);
+		if (!newpath)
+			return NULL;
+		strbuf_attach(&chdir_path, newpath, strlen(newpath),
+		              strlen(newpath));
+	}
+
+	if (!strict_suffix) {
+		/* operate on both chdir_path and ret_path */
 		static const char *suffix[] = {
 			"/.git", "", ".git/.git", ".git", NULL,
 		};
-		const char *gitfile;
-		int len = strlen(path);
 		int i;
-		while ((1 < len) && (path[len-1] == '/'))
-			len--;
-
-		/*
-		 * We can handle arbitrary-sized buffers, but this remains as a
-		 * sanity check on untrusted input.
-		 */
-		if (PATH_MAX <= len)
-			return NULL;
-
-		strbuf_reset(&used_path);
-		strbuf_reset(&validated_path);
-		strbuf_add(&used_path, path, len);
-		strbuf_add(&validated_path, path, len);
-
-		if (used_path.buf[0] == '~') {
-			char *newpath = expand_user_path(used_path.buf);
-			if (!newpath)
-				return NULL;
-			strbuf_attach(&used_path, newpath, strlen(newpath),
-				      strlen(newpath));
-		}
 		for (i = 0; suffix[i]; i++) {
 			struct stat st;
-			size_t baselen = used_path.len;
-			strbuf_addstr(&used_path, suffix[i]);
-			if (!stat(used_path.buf, &st) &&
+			size_t baselen = chdir_path.len;
+			strbuf_addstr(&chdir_path, suffix[i]);
+			if (!stat(chdir_path.buf, &st) &&
 			    (S_ISREG(st.st_mode) ||
-			    (S_ISDIR(st.st_mode) && is_git_directory(used_path.buf)))) {
-				strbuf_addstr(&validated_path, suffix[i]);
+			     (S_ISDIR(st.st_mode) && is_git_directory(chdir_path.buf)))) {
+				strbuf_addstr(&ret_path, suffix[i]);
 				break;
 			}
-			strbuf_setlen(&used_path, baselen);
+			strbuf_setlen(&chdir_path, baselen);
 		}
 		if (!suffix[i])
 			return NULL;
-		gitfile = read_gitfile(used_path.buf);
-		if (gitfile) {
-			strbuf_reset(&used_path);
-			strbuf_addstr(&used_path, gitfile);
-		}
-		if (chdir(used_path.buf))
-			return NULL;
-		path = validated_path.buf;
 	}
-	else {
-		const char *gitfile = read_gitfile(path);
-		if (gitfile)
-			path = gitfile;
-		if (chdir(path))
-			return NULL;
+
+	gitfile = read_gitfile(chdir_path.buf);
+	if (gitfile) {
+		/* operate only on chdir_path */
+		strbuf_reset(&chdir_path);
+		strbuf_addstr(&chdir_path, gitfile);
 	}
+	if (chdir(chdir_path.buf))
+		return NULL;
 
 	if (is_git_directory(".")) {
 		set_git_dir(".");
 		check_repository_format();
-		return path;
+		return ret_path.buf;
 	}
 
 	return NULL;
diff --git a/upload-pack.c b/upload-pack.c
index ca7f941..c73b776 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -859,7 +859,7 @@ int cmd_main(int argc, const char **argv)
 
 	dir = argv[0];
 
-	if (!enter_repo(dir, strict))
+	if (!enter_repo(dir, strict, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
-- 
2.10.0

