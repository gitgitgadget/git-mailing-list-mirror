From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/24] update-index: test the system before enabling untracked cache
Date: Sun,  8 Mar 2015 17:12:43 +0700
Message-ID: <1425809567-25518-21-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:15:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYEl-0004L3-Ui
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbbCHKPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:15:03 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40738 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbCHKPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:15:02 -0400
Received: by padfb1 with SMTP id fb1so55496925pad.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NnpTY95aO9vn1lPnkSDOJ+6YB7KU8z1CITOHosdJBUs=;
        b=JKnX0aVRW4p6k+MW8W2n8ouaKQ2YAgnQdOT9GJwv+TcCgCf6XkkGcSRmFU1Kvx9Lc6
         B/JsKMX2/T8G6WTY2VYyPaby1mWZ1iiFy+5drSvATyMkZixN0cZJiGqWaz0bQWsRwe8H
         FetAD7K6cLc3sR7k10TSlcx8GhAuQM6js9QSrPyAkzgduJ0jAFfyXuIYXLsz2ukoIZXM
         3EuYVNXNA3vod1L1J0AAtfpMhmqkWzE8HGKzhHSW6I8YONKSDNCGe0+3vk3asyjrBllC
         36aCSqvr1U5OpYOVzbu/5VhjnfCUpgrWKkFBKWHI6JLogla7nug2RHOlfDtxepkXDRvV
         rhnA==
X-Received: by 10.68.197.33 with SMTP id ir1mr41250005pbc.151.1425809701742;
        Sun, 08 Mar 2015 03:15:01 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id a4sm14385801pdf.57.2015.03.08.03.14.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:15:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:57 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265075>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt |   6 ++
 builtin/update-index.c             | 168 +++++++++++++++++++++++++++++=
++++++++
 2 files changed, 174 insertions(+)

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
index 3d2dedd..f5f6689 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -32,6 +32,7 @@ static int mark_valid_only;
 static int mark_skip_worktree_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
+static struct strbuf mtime_dir =3D STRBUF_INIT;
=20
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
@@ -47,6 +48,166 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
=20
+static void remove_test_directory(void)
+{
+	if (mtime_dir.len)
+		remove_dir_recursively(&mtime_dir, 0);
+}
+
+static const char *get_mtime_path(const char *path)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/%s", mtime_dir.buf, path);
+	return sb.buf;
+}
+
+static void xmkdir(const char *path)
+{
+	path =3D get_mtime_path(path);
+	if (mkdir(path, 0700))
+		die_errno(_("failed to create directory %s"), path);
+}
+
+static int xstat_mtime_dir(struct stat *st)
+{
+	if (stat(mtime_dir.buf, st))
+		die_errno(_("failed to stat %s"), mtime_dir.buf);
+	return 0;
+}
+
+static int create_file(const char *path)
+{
+	int fd;
+	path =3D get_mtime_path(path);
+	fd =3D open(path, O_CREAT | O_RDWR, 0644);
+	if (fd < 0)
+		die_errno(_("failed to create file %s"), path);
+	return fd;
+}
+
+static void xunlink(const char *path)
+{
+	path =3D get_mtime_path(path);
+	if (unlink(path))
+		die_errno(_("failed to delete file %s"), path);
+}
+
+static void xrmdir(const char *path)
+{
+	path =3D get_mtime_path(path);
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
+	int fd, ret =3D 0;
+
+	strbuf_addstr(&mtime_dir, "mtime-test-XXXXXX");
+	if (!mkdtemp(mtime_dir.buf))
+		die_errno("Could not make temporary directory");
+
+	fprintf(stderr, _("Testing "));
+	atexit(remove_test_directory);
+	xstat_mtime_dir(&st);
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	fd =3D create_file("newfile");
+	xstat_mtime_dir(&st);
+	if (!match_stat_data(&base, &st)) {
+		close(fd);
+		fputc('\n', stderr);
+		fprintf_ln(stderr,_("directory stat info does not "
+				    "change after adding a new file"));
+		goto done;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	xmkdir("new-dir");
+	xstat_mtime_dir(&st);
+	if (!match_stat_data(&base, &st)) {
+		close(fd);
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not change "
+				     "after adding a new directory"));
+		goto done;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	write_or_die(fd, "data", 4);
+	close(fd);
+	xstat_mtime_dir(&st);
+	if (match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info changes "
+				     "after updating a file"));
+		goto done;
+	}
+	fputc('.', stderr);
+
+	avoid_racy();
+	close(create_file("new-dir/new"));
+	xstat_mtime_dir(&st);
+	if (match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info changes after "
+				     "adding a file inside subdirectory"));
+		goto done;
+	}
+	fputc('.', stderr);
+
+	avoid_racy();
+	xunlink("newfile");
+	xstat_mtime_dir(&st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not "
+				     "change after deleting a file"));
+		goto done;
+	}
+	fill_stat_data(&base, &st);
+	fputc('.', stderr);
+
+	avoid_racy();
+	xunlink("new-dir/new");
+	xrmdir("new-dir");
+	xstat_mtime_dir(&st);
+	if (!match_stat_data(&base, &st)) {
+		fputc('\n', stderr);
+		fprintf_ln(stderr, _("directory stat info does not "
+				     "change after deleting a directory"));
+		goto done;
+	}
+
+	if (rmdir(mtime_dir.buf))
+		die_errno(_("failed to delete directory %s"), mtime_dir.buf);
+	fprintf_ln(stderr, _(" OK"));
+	ret =3D 1;
+
+done:
+	strbuf_release(&mtime_dir);
+	return ret;
+}
+
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
@@ -834,6 +995,8 @@ int cmd_update_index(int argc, const char **argv, c=
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
@@ -943,6 +1106,11 @@ int cmd_update_index(int argc, const char **argv,=
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
2.3.0.rc1.137.g477eb31
