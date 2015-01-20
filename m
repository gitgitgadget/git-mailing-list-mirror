From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/24] update-index: test the system before enabling untracked cache
Date: Tue, 20 Jan 2015 20:03:29 +0700
Message-ID: <1421759013-8494-21-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYVG-000447-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbbATNFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:05:48 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65207 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbbATNFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:05:48 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so45583742pab.7
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RhpLdvtuwYO+kgs5cI6h7QLAOeCBMsD07UJakRL4PEs=;
        b=hHMYz5xoLnq+ZCR8AYyoyoaYFAFhGFEs+iAAmEuMZqtED1Z6APA2miwrb7iPB56cBX
         0mE7VQnaey4dIAibe4DV4G82QfcQ4xz6bXXwmukByGDWx59IcO/hrgzZsQegQkdkMF5D
         x3d9zG5t1lGh6witIE2fQdkFts3RvA3lMpvoBG79FsZLgbujg46MB/P8WxZeTM6qf9wc
         HmXU20zZ8lz8K/JJLiO8+GaJyWV+Ykgiq8K3KAdOcuD4QLZw1WWXLgHEzMKW6yypYQ+B
         Vc0+KjVLdJlVUIBsZMo8xxytHi82pGBslJkwV1RqRttF6d59sIFtpF1g/m/vZgOtffOA
         u4Pg==
X-Received: by 10.70.131.78 with SMTP id ok14mr43132852pdb.112.1421759147459;
        Tue, 20 Jan 2015 05:05:47 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id jd1sm2935554pbd.49.2015.01.20.05.05.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:05:58 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262673>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt |   6 ++
 builtin/update-index.c             | 148 +++++++++++++++++++++++++++++=
++++++++
 2 files changed, 154 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index f9a35cd..ed32bae 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -180,6 +180,12 @@ may not support it yet.
 	system must change `st_mtime` field of a directory if files
 	are added or deleted in that directory.
=20
+--force-untracked-cache::
+	For safety, `--untracked-cache` performs tests on the working
+	directory to make sure untracked cache can be used. These
+	tests can take a few seconds. `--force-untracked-cache` can be
+	used to skip the tests.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3d2dedd..f23ec83 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -47,6 +47,147 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
=20
+static void remove_test_directory(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	strbuf_addstr(&sb, "dir-mtime-test");
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
+	int fd =3D open(path, O_CREAT | O_RDWR, 0644);
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
+	xmkdir("dir-mtime-test");
+	atexit(remove_test_directory);
+	xstat("dir-mtime-test", &st);
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	fd =3D create_file("dir-mtime-test/newfile");
+	xstat("dir-mtime-test", &st);
+	if (!match_stat_data(&base, &st)) {
+		close(fd);
+		fputc('\n', stderr);
+		fprintf_ln(stderr,_("directory stat info does not "
+				    "change after adding a new file"));
+		return 0;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	xmkdir("dir-mtime-test/new-dir");
+	xstat("dir-mtime-test", &st);
+	if (!match_stat_data(&base, &st)) {
+		close(fd);
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
+	xstat("dir-mtime-test", &st);
+	if (match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info changes "
+				     "after updating a file"));
+		return 0;
+	}
+	fputc('.', stderr);
+
+	avoid_racy();
+	close(create_file("dir-mtime-test/new-dir/new"));
+	xstat("dir-mtime-test", &st);
+	if (match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info changes after "
+				     "adding a file inside subdirectory"));
+		return 0;
+	}
+	fputc('.', stderr);
+
+	avoid_racy();
+	xunlink("dir-mtime-test/newfile");
+	xstat("dir-mtime-test", &st);
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
+	xunlink("dir-mtime-test/new-dir/new");
+	xrmdir("dir-mtime-test/new-dir");
+	xstat("dir-mtime-test", &st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not "
+				     "change after deleting a directory"));
+		return 0;
+	}
+
+	xrmdir("dir-mtime-test");
+	fprintf_ln(stderr, _(" OK"));
+	return 1;
+}
+
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
@@ -834,6 +975,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			N_("enable or disable split index")),
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
+		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
+			    N_("enable untracked cache without testing the filesystem"), 2)=
,
 		OPT_END()
 	};
=20
@@ -943,6 +1086,11 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 	if (untracked_cache > 0 && !the_index.untracked) {
 		struct untracked_cache *uc;
=20
+		if (untracked_cache < 2) {
+			setup_work_tree();
+			if (!test_if_untracked_cache_is_supported())
+				return 1;
+		}
 		uc =3D xcalloc(1, sizeof(*uc));
 		uc->exclude_per_dir =3D ".gitignore";
 		/* should be the same flags used by git-status */
--=20
2.2.0.84.ge9c7a8a
