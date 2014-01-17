From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 11/14] file-watcher: support inotify
Date: Fri, 17 Jan 2014 16:47:37 +0700
Message-ID: <1389952060-12297-12-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W463D-0003DU-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbaAQJtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:49:13 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:58554 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaAQJtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:49:11 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so2474835pdj.22
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/egE4t5ZpUGGBRf4VJ9vBOVKZ8M8A+MGD30VYGvM/m8=;
        b=zSkI2gTW3C9ya7xzi3Xmvc1oCGD8Lu9iKhig8BzG1UWYPhIYUK866lwoVgKa0Qutl9
         TR+IRhOxM2EXPOHfLv7gNyiWpAUzg9I6jDZ6SlXMuAwPWdoT/ws68H7w3zVK8jXG12Fq
         tqmvtt7MbERbNSOjakl7gY9GK0E1SpaP5TrW4KxNaLAmeLiOS0RAqsqudBLSyLgY7iUQ
         PAE6HX72YQ3LIpC/Oqh64Ojdgky/lErd0Rp11+PH7cZzwcBVukA+J8r3jyDfdNdv05uL
         LGdiQLBcsemOt79AvvT8FQrRkdeIuczYNJcKWAs3NnWHAyXYvTtaXRTCsMOOBhLLeXu5
         q1Hg==
X-Received: by 10.68.201.10 with SMTP id jw10mr1031631pbc.25.1389952150558;
        Fri, 17 Jan 2014 01:49:10 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id os1sm28668207pac.20.2014.01.17.01.49.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:49:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:49:04 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240590>

"git diff" on webkit:

        no file watcher  1st run   subsequent runs
real        0m1.361s    0m1.445s      0m0.691s
user        0m0.889s    0m0.940s      0m0.649s
sys         0m0.469s    0m0.495s      0m0.040s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.mak.uname  |   1 +
 file-watcher.c    | 194 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 git-compat-util.h |   3 +
 3 files changed, 198 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..ee548f5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -33,6 +33,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
+	BASIC_CFLAGS +=3D -DHAVE_INOTIFY
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
diff --git a/file-watcher.c b/file-watcher.c
index f334e23..356b58a 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -15,6 +15,166 @@ static char index_signature[41];
 static struct string_list updated =3D STRING_LIST_INIT_DUP;
 static int updated_sorted;
=20
+#ifdef HAVE_INOTIFY
+
+static struct string_list watched_dirs =3D STRING_LIST_INIT_DUP;
+static int watched_dirs_sorted;
+static int inotify_fd;
+
+struct dir_info {
+	int wd;
+	struct string_list names;
+	int names_sorted;
+};
+
+static void reset_watches(void)
+{
+	int i;
+	for (i =3D 0; i < watched_dirs.nr; i++) {
+		struct dir_info *dir =3D watched_dirs.items[i].util;
+		inotify_rm_watch(inotify_fd, dir->wd);
+		string_list_clear(&dir->names, 0);
+	}
+	string_list_clear(&watched_dirs, 1);
+}
+
+static void update(const char *base, const char *name)
+{
+	if (!strcmp(base, "."))
+		string_list_append(&updated, name);
+	else {
+		static struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addf(&sb, "%s/%s", base, name);
+		string_list_append(&updated, sb.buf);
+		strbuf_reset(&sb);
+	}
+	updated_sorted =3D 0;
+}
+
+static int do_handle_inotify(const struct inotify_event *event)
+{
+	struct dir_info *dir;
+	struct string_list_item *item;
+	int i;
+
+	if (event->mask & (IN_Q_OVERFLOW | IN_UNMOUNT)) {
+		/*
+		 * The connectionless nature of file watcher means we
+		 * can never tell we are reset in the middle of a
+		 * "session" because there are no "sessions". Close
+		 * the socket so all clients can react on it.
+		 */
+		exit(0);
+	}
+
+	/* Should have indexed them for faster access like trast's watch */
+	for (i =3D 0; i < watched_dirs.nr; i++) {
+		struct dir_info *dir =3D watched_dirs.items[i].util;
+		if (dir->wd =3D=3D event->wd)
+			break;
+	}
+	if (i =3D=3D watched_dirs.nr)
+		return 0;
+	dir =3D watched_dirs.items[i].util;
+
+	/*
+	 * If something happened to the watched directory, consider
+	 * everything inside modified
+	 */
+	if (event->mask & (IN_DELETE_SELF | IN_MOVE_SELF)) {
+		int dir_idx =3D i;
+		for (i =3D 0; i < dir->names.nr; i++)
+			update(watched_dirs.items[dir_idx].string,
+			       dir->names.items[i].string);
+		inotify_rm_watch(inotify_fd, dir->wd);
+		unsorted_string_list_delete_item(&watched_dirs, dir_idx, 1);
+		return 0;
+	}
+
+	if (!dir->names_sorted) {
+		sort_string_list(&dir->names);
+		dir->names_sorted =3D 1;
+	}
+	item =3D string_list_lookup(&dir->names, event->name);
+	if (item) {
+		update(watched_dirs.items[i].string, item->string);
+		unsorted_string_list_delete_item(&dir->names,
+						 item - dir->names.items, 0);
+		if (dir->names.nr =3D=3D 0) {
+			inotify_rm_watch(inotify_fd, dir->wd);
+			unsorted_string_list_delete_item(&watched_dirs, i, 1);
+		}
+	}
+	return 0;
+}
+
+static int handle_inotify(int fd)
+{
+	static char buf[10 * (sizeof(struct inotify_event) + NAME_MAX + 1)];
+	struct inotify_event *event;
+	int offset =3D 0;
+	int len =3D read(fd, buf, sizeof(buf));
+	if (len <=3D 0)
+		return -1;
+	for (event =3D (struct inotify_event *)(buf + offset);
+	     offset < len;
+	     offset +=3D sizeof(struct inotify_event) + event->len) {
+		if (do_handle_inotify(event))
+			return -1;
+	}
+	return 0;
+}
+
+static int watch_path(char *path)
+{
+	struct string_list_item *item;
+	char *sep =3D strrchr(path, '/');
+	struct dir_info *dir;
+	const char *dirname =3D ".";
+
+	if (sep) {
+		*sep =3D '\0';
+		dirname =3D path;
+	}
+
+	if (!watched_dirs_sorted) {
+		sort_string_list(&watched_dirs);
+		watched_dirs_sorted =3D 1;
+	}
+	item =3D string_list_lookup(&watched_dirs, dirname);
+	if (!item) {
+		/*
+		 * IN_CREATE is not included because we're targetting
+		 * lstat() for index vs worktree. If a file is not
+		 * tracked in index, it's not worth watching. If the
+		 * index has it, but the worktree is already gone
+		 * before watching, the file has already been marked
+		 * modified and should _not_ be watched.
+		 *
+		 * Problematic: IN_DONT_FOLLOW
+		 */
+		int ret =3D inotify_add_watch(inotify_fd, dirname,
+					    IN_DELETE_SELF | IN_MOVE_SELF |
+					    IN_ATTRIB | IN_DELETE | IN_MODIFY |
+					    IN_MOVED_FROM | IN_MOVED_TO);
+		if (ret < 0)
+			return -1;
+		dir =3D xmalloc(sizeof(*dir));
+		memset(dir, 0, sizeof(*dir));
+		dir->wd =3D ret;
+		dir->names.strdup_strings =3D 1;
+		item =3D string_list_append(&watched_dirs, dirname);
+		item->util =3D dir;
+		watched_dirs_sorted =3D 0;
+	}
+	dir =3D item->util;
+	string_list_append(&dir->names, sep ? sep + 1 : path);
+	dir->names_sorted =3D 0;
+	return 0;
+}
+
+#else
+
 static int watch_path(char *path)
 {
 	/*
@@ -26,8 +186,15 @@ static int watch_path(char *path)
 	return -1;
 }
=20
+static void reset_watches(void)
+{
+}
+
+#endif
+
 static void reset(void)
 {
+	reset_watches();
 	string_list_clear(&updated, 0);
 	index_signature[0] =3D '\0';
 }
@@ -180,6 +347,7 @@ int main(int argc, const char **argv)
 	const char *log_string =3D NULL;
 	struct stat socket_st;
 	struct timeval tv_last_command;
+	struct timeval tv_last_inotify;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL(0, "daemon", &daemon,
@@ -193,6 +361,15 @@ int main(int argc, const char **argv)
=20
 	git_extract_argv0_path(argv[0]);
 	git_setup_gettext();
+
+#ifdef HAVE_INOTIFY
+	inotify_fd =3D inotify_init();
+	if (inotify_fd < 0)
+		die_errno("unable to initialize inotify");
+#else
+	die("no file watching mechanism is supported");
+#endif
+
 	prefix =3D setup_git_directory();
 	argc =3D parse_options(argc, argv, prefix, options,
 			     file_watcher_usage, 0);
@@ -245,8 +422,13 @@ int main(int argc, const char **argv)
 	nr =3D 0;
 	pfd[nr].fd =3D fd;
 	pfd[nr++].events =3D POLLIN;
+#ifdef HAVE_INOTIFY
+	pfd[nr].fd =3D inotify_fd;
+	pfd[nr++].events =3D POLLIN;
+#endif
=20
 	gettimeofday(&tv_last_command, NULL);
+	gettimeofday(&tv_last_inotify, NULL);
 	for (;;) {
 		int check_exit =3D check_exit_please;
 		int ret =3D poll(pfd, nr, check_exit ? 0 : 60 * 1000);
@@ -265,6 +447,18 @@ int main(int argc, const char **argv)
 			gettimeofday(&tv_last_command, NULL);
 		}
=20
+#ifdef HAVE_INOTIFY
+		if ((pfd[1].revents & POLLIN)) {
+			struct timeval now;
+			if (handle_inotify(inotify_fd))
+				break;
+			gettimeofday(&now, NULL);
+			if (tv_last_inotify.tv_sec + 60 < now.tv_sec) {
+				check_exit =3D 1;
+				tv_last_inotify =3D now;
+			}
+		}
+#endif
 		if (check_exit) {
 			struct stat st;
 			struct timeval now;
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..de5996a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -128,6 +128,9 @@
 #else
 #include <poll.h>
 #endif
+#ifdef HAVE_INOTIFY
+#include <sys/inotify.h>
+#endif
=20
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
--=20
1.8.5.1.208.g05b12ea
