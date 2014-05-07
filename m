From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/20] update-index: test the system before enabling untracked cache
Date: Wed,  7 May 2014 21:51:59 +0700
Message-ID: <1399474320-6840-20-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3EH-0006Wb-3O
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbaEGOxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49336 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaEGOxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so1298126pab.1
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gR6Fxc6msp0TH0S4hiymxeiJEP8m0uvSVSEOYZd3eNg=;
        b=kXJ4Nwozg0TkRE2i1GUpQweix0+EbEvAlU/GwzQKyJ0jRp481Z7LJKBl5XCyQXNltC
         epGSbOHFS/wDFb1OXNycZveegRGIN8F54jlRgQ1Cyib9nLutch98McU1QMCgIDXnNjnR
         LnRmgycX4fJx2T0Tew3ErhruOa3noiMNfRpCJesKSh+/XIZD9YLA8ZpQga1/K6DEg+W6
         vcrOAlyKKRx8ACj76jqQ28KFzydv1Zu4kaH8oPwXj3xUamRGdkjfMrrDrLE2Eyx6Xl7C
         8cNJHvlHMHtSi9rpnG9YdFr/8V8BIDE5ql8KPmjoCUZS0X7YG5x7yrIY3nHiNZNdmKYO
         W2AA==
X-Received: by 10.66.226.145 with SMTP id rs17mr20065981pac.144.1399474425156;
        Wed, 07 May 2014 07:53:45 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id gu11sm3655373pbd.38.2014.05.07.07.53.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:45 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248325>

---
 builtin/update-index.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 003e28e..f18076b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -46,6 +46,145 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
 
+static void remove_test_directory(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addstr(&sb, git_path("dir-mtime-test"));
+	remove_dir_recursively(&sb, 0);
+	strbuf_release(&sb);
+}
+
+static void xmkdir(const char *path)
+{
+	if (mkdir(path, 0700))
+		die_errno(_("failed to create directory %s"), path);
+}
+
+static int xstat(const char *path, struct stat *st)
+{
+	if (stat(path, st))
+		die_errno(_("failed to stat %s"), path);
+	return 0;
+}
+
+static int create_file(const char *path)
+{
+	int fd = open(path, O_CREAT | O_RDWR, 0644);
+	if (fd < 0)
+		die_errno(_("failed to create file %s"), path);
+	return fd;
+}
+
+static void xunlink(const char *path)
+{
+	if (unlink(path))
+		die_errno(_("failed to delete file %s"), path);
+}
+
+static void xrmdir(const char *path)
+{
+	if (rmdir(path))
+		die_errno(_("failed to delete directory %s"), path);
+}
+
+static void avoid_racy(void)
+{
+	/*
+	 * not use if we could usleep(10) if USE_NSEC is defined. The
+	 * field nsec could be there, but the OS could choose to
+	 * ignore it?
+	 */
+	sleep(1);
+}
+
+static int test_if_untracked_cache_is_supported(void)
+{
+	struct stat st;
+	struct stat_data base;
+	int fd;
+
+	fprintf(stderr, _("Testing "));
+	xmkdir(git_path("dir-mtime-test"));
+	atexit(remove_test_directory);
+	xstat(git_path("dir-mtime-test"), &st);
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	fd = create_file(git_path("dir-mtime-test/newfile"));
+	xstat(git_path("dir-mtime-test"), &st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr,_("directory stat info does not "
+				    "change after adding a new file"));
+		return 0;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	xmkdir(git_path("dir-mtime-test/new-dir"));
+	xstat(git_path("dir-mtime-test"), &st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not change "
+				     "after adding a new directory"));
+		return 0;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	write_or_die(fd, "data", 4);
+	close(fd);
+	xstat(git_path("dir-mtime-test"), &st);
+	if (match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info changes "
+				     "after updating a file"));
+		return 0;
+	}
+	fputc('.', stderr);
+
+	avoid_racy();
+	close(create_file(git_path("dir-mtime-test/new-dir/new")));
+	xstat(git_path("dir-mtime-test"), &st);
+	if (match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info changes after "
+				     "adding a file inside subdirectory"));
+		return 0;
+	}
+	fputc('.', stderr);
+
+	avoid_racy();
+	xunlink(git_path("dir-mtime-test/newfile"));
+	xstat(git_path("dir-mtime-test"), &st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not "
+				     "change after deleting a file"));
+		return 0;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	xunlink(git_path("dir-mtime-test/new-dir/new"));
+	xrmdir(git_path("dir-mtime-test/new-dir"));
+	xstat(git_path("dir-mtime-test"), &st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not "
+				     "change after deleting a directory"));
+		return 0;
+	}
+
+	xrmdir(git_path("dir-mtime-test"));
+	fprintf_ln(stderr, _(" OK"));
+	return 1;
+}
+
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
@@ -823,6 +962,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			resolve_undo_clear_callback},
 		OPT_INTEGER(0, "index-version", &preferred_index_format,
 			N_("write index in this format")),
+		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
+			    N_("enable untracked cache without testing the filesystem"), 2),
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_END()
@@ -921,6 +1062,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (untracked_cache > 0) {
 		struct untracked_cache *uc;
 
+		if (untracked_cache < 2 &&
+		    !test_if_untracked_cache_is_supported())
+			return 1;
 		uc = xcalloc(1, sizeof(*uc));
 		uc->exclude_per_dir = ".gitignore";
 		/* should be the same flags used by git-status */
-- 
1.9.1.346.ga2b5940
