From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/24] nd/untracked-cache updates
Date: Sun,  8 Feb 2015 15:55:24 +0700
Message-ID: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:56:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNep-0002FM-4G
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbbBHIzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 03:55:52 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39894 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbBHIzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:55:51 -0500
Received: by mail-pa0-f50.google.com with SMTP id rd3so26852310pab.9
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=d9wclA/JcQqFbkls12TmxeEdDUzYq1M/Orm0WftqxAE=;
        b=HslGe5emtS6d4uXAwdoDoQmQo9GQ/cU0HjTrXPiCDj/UWEFdZgbbyea5gSxaJBMcA4
         TeOuiMMEKd8WIAcGB2j02ktlgwVgH92Yo+VtCmeXwIUAa9kA/k9zdYSzFq2F0FsIgUce
         6EQcwlul+E3qyW9gHpr9f1Ho8CpIl49ScUb2kwchjudpUXS3MUR+gJxHiuTNjdm0vHWn
         NkMs9OgXVI1R+EnilxN97OCXUpJ8YDG6eecyWPY2isDksc/9zNMmM5OuQ33ld1fiFyqi
         dbGZTBCAVNxIIhAU9o703+ibcmAH0VIpRKSy+gW0q99X1OK18btOhQmPS0rgUcfT4v/H
         LtjQ==
X-Received: by 10.70.22.234 with SMTP id h10mr19403002pdf.118.1423385751321;
        Sun, 08 Feb 2015 00:55:51 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id oi5sm12934922pbb.7.2015.02.08.00.55.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:55:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:55:58 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263462>

Code changes are all in 20/24, to avoid hard coding the test path. The
rest is documentation changes.

-- 8<--
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7850f53..4dcad4e 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -59,7 +59,7 @@ shown (i.e. the same as specifying `normal`), to help you avoid
 forgetting to add newly created files.  Because it takes extra work
 to find untracked files in the filesystem, this mode may take some
 time in a large working tree.
-Consider to enable untracked cache and split index if supported (see
+Consider enabling untracked cache and split index if supported (see
 `git update-index --untracked-cache` and `git update-index
 --split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 0045b89..e24b4bc 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -269,9 +269,9 @@ Git index format
   - A number of directory blocks in depth-first-search order, each
     consists of
 
-    - The number of untracked entries, variable witdh encoding.
+    - The number of untracked entries, variable width encoding.
 
-    - The number of sub-directory blocks, variable with encoding.
+    - The number of sub-directory blocks, variable width encoding.
 
     - The directory name terminated by NUL.
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e76740d..fc5e108 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -32,6 +32,7 @@ static int mark_valid_only;
 static int mark_skip_worktree_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
+static struct strbuf mtime_dir = STRBUF_INIT;
 
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
@@ -49,28 +50,37 @@ static void report(const char *fmt, ...)
 
 static void remove_test_directory(void)
 {
-	struct strbuf sb = STRBUF_INIT;
-	strbuf_addstr(&sb, "dir-mtime-test");
-	remove_dir_recursively(&sb, 0);
-	strbuf_release(&sb);
+	if (mtime_dir.len)
+		remove_dir_recursively(&mtime_dir, 0);
+}
+
+static const char *get_mtime_path(const char *path)
+{
+	static struct strbuf sb = STRBUF_INIT;
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/%s", mtime_dir.buf, path);
+	return sb.buf;
 }
 
 static void xmkdir(const char *path)
 {
+	path = get_mtime_path(path);
 	if (mkdir(path, 0700))
 		die_errno(_("failed to create directory %s"), path);
 }
 
-static int xstat(const char *path, struct stat *st)
+static int xstat_mtime_dir(struct stat *st)
 {
-	if (stat(path, st))
-		die_errno(_("failed to stat %s"), path);
+	if (stat(mtime_dir.buf, st))
+		die_errno(_("failed to stat %s"), mtime_dir.buf);
 	return 0;
 }
 
 static int create_file(const char *path)
 {
-	int fd = open(path, O_CREAT | O_RDWR, 0644);
+	int fd;
+	path = get_mtime_path(path);
+	fd = open(path, O_CREAT | O_RDWR, 0644);
 	if (fd < 0)
 		die_errno(_("failed to create file %s"), path);
 	return fd;
@@ -78,12 +88,14 @@ static int create_file(const char *path)
 
 static void xunlink(const char *path)
 {
+	path = get_mtime_path(path);
 	if (unlink(path))
 		die_errno(_("failed to delete file %s"), path);
 }
 
 static void xrmdir(const char *path)
 {
+	path = get_mtime_path(path);
 	if (rmdir(path))
 		die_errno(_("failed to delete directory %s"), path);
 }
@@ -102,37 +114,40 @@ static int test_if_untracked_cache_is_supported(void)
 {
 	struct stat st;
 	struct stat_data base;
-	int fd;
+	int fd, ret = 0;
+
+	strbuf_addstr(&mtime_dir, "mtime-test-XXXXXX");
+	if (!mkdtemp(mtime_dir.buf))
+		die_errno("Could not make temporary directory");
 
 	fprintf(stderr, _("Testing "));
-	xmkdir("dir-mtime-test");
 	atexit(remove_test_directory);
-	xstat("dir-mtime-test", &st);
+	xstat_mtime_dir(&st);
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
 
 	avoid_racy();
-	fd = create_file("dir-mtime-test/newfile");
-	xstat("dir-mtime-test", &st);
+	fd = create_file("newfile");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		close(fd);
 		fputc('\n', stderr);
 		fprintf_ln(stderr,_("directory stat info does not "
 				    "change after adding a new file"));
-		return 0;
+		goto done;
 	}
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
 
 	avoid_racy();
-	xmkdir("dir-mtime-test/new-dir");
-	xstat("dir-mtime-test", &st);
+	xmkdir("new-dir");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		close(fd);
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not change "
 				     "after adding a new directory"));
-		return 0;
+		goto done;
 	}
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
@@ -140,52 +155,57 @@ static int test_if_untracked_cache_is_supported(void)
 	avoid_racy();
 	write_or_die(fd, "data", 4);
 	close(fd);
-	xstat("dir-mtime-test", &st);
+	xstat_mtime_dir(&st);
 	if (match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info changes "
 				     "after updating a file"));
-		return 0;
+		goto done;
 	}
 	fputc('.', stderr);
 
 	avoid_racy();
-	close(create_file("dir-mtime-test/new-dir/new"));
-	xstat("dir-mtime-test", &st);
+	close(create_file("new-dir/new"));
+	xstat_mtime_dir(&st);
 	if (match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info changes after "
 				     "adding a file inside subdirectory"));
-		return 0;
+		goto done;
 	}
 	fputc('.', stderr);
 
 	avoid_racy();
-	xunlink("dir-mtime-test/newfile");
-	xstat("dir-mtime-test", &st);
+	xunlink("newfile");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not "
 				     "change after deleting a file"));
-		return 0;
+		goto done;
 	}
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
 
 	avoid_racy();
-	xunlink("dir-mtime-test/new-dir/new");
-	xrmdir("dir-mtime-test/new-dir");
-	xstat("dir-mtime-test", &st);
+	xunlink("new-dir/new");
+	xrmdir("new-dir");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not "
 				     "change after deleting a directory"));
-		return 0;
+		goto done;
 	}
 
-	xrmdir("dir-mtime-test");
+	if (rmdir(mtime_dir.buf))
+		die_errno(_("failed to delete directory %s"), mtime_dir.buf);
 	fprintf_ln(stderr, _(" OK"));
-	return 1;
+	ret = 1;
+
+done:
+	strbuf_release(&mtime_dir);
+	return ret;
 }
 
 static int mark_ce_flags(const char *path, int flag, int mark)
-- 8<--
-- 
2.3.0.rc1.137.g477eb31
