From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] file-watcher: support inotify
Date: Sun, 12 Jan 2014 18:03:42 +0700
Message-ID: <1389524622-6702-7-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 11:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Il3-00070S-0r
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaALK7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 05:59:04 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36847 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaALK7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:59:03 -0500
Received: by mail-pb0-f48.google.com with SMTP id up15so707872pbc.21
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7o8c22/B0bDJINHr3dwSuy4NOmc1NOthPUEpRY8Epm8=;
        b=Sf3P8+WQGO6jKdtZqExHoubam75ODQFVUPGPLlRqp10+Il0KDuu1nAuwwlWJ6e/2Tg
         /mwmChdjjrxfFddaQcXtnFrWOu064iu82gSpWO/nTdmLst0adAc0hnOq5ljj44PBzXGK
         wpdUfBjpGvff1WhWODVexnqoPuTT6bMr9aLpTIFqCVOzP33KhUhDhv8n+3NhEDT4QaXN
         P+HkDsVdSPBYx6BQTVlpTKN3HkvlQmVLMGxYTC9qDs0rumU/8DPzvxC5ZOiCuBgQyvf1
         LGkO8pTkHdmOcXhRzsv3jk+w9CcEmDxifcz/xI98k5wcucuG/9c5gWHuQFgDEWdrN3Wc
         czSg==
X-Received: by 10.68.89.162 with SMTP id bp2mr2110248pbb.151.1389524341937;
        Sun, 12 Jan 2014 02:59:01 -0800 (PST)
Received: from lanh ([115.73.194.184])
        by mx.google.com with ESMTPSA id xv2sm30141841pbb.39.2014.01.12.02.58.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 02:59:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 12 Jan 2014 18:04:19 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240345>

"git diff" on webkit:

        no file watcher  1st run   subsequent runs
real        0m1.361s    0m1.445s      0m0.691s
user        0m0.889s    0m0.940s      0m0.649s
sys         0m0.469s    0m0.495s      0m0.040s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.mak.uname |   1 +
 file-watcher.c   | 139 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 140 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 82d549e..603890d 100644
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
index 35781fa..1512b46 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -3,17 +3,140 @@
 #include "string-list.h"
 #include "pkt-line.h"
=20
+#ifdef HAVE_INOTIFY
+#include <sys/inotify.h>
+#endif
+
 static char index_signature[41];
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
+static int handle_inotify(int fd)
+{
+	char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
+	struct inotify_event *event;
+	struct dir_info *dir;
+	struct string_list_item *item;
+	int i;
+	int len =3D read(fd, buf, sizeof(buf));
+	if (len < 0)
+		return -1;
+	event =3D (struct inotify_event *)buf;
+
+	if (len <=3D sizeof(struct inotify_event))
+		return 0;
+
+	for (i =3D 0; i < watched_dirs.nr; i++) {
+		struct dir_info *dir =3D watched_dirs.items[i].util;
+		if (dir->wd =3D=3D event->wd)
+			break;
+	}
+	if (i =3D=3D watched_dirs.nr)
+		return 0;
+	dir =3D watched_dirs.items[i].util;
+
+	if (!dir->names_sorted) {
+		sort_string_list(&dir->names);
+		dir->names_sorted =3D 1;
+	}
+	item =3D string_list_lookup(&dir->names, event->name);
+	if (item) {
+		if (!strcmp(watched_dirs.items[i].string, "."))
+			string_list_append(&updated, event->name);
+		else {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addf(&sb, "%s/%s", watched_dirs.items[i].string,
+				    item->string);
+			string_list_append(&updated, sb.buf);
+			updated_sorted =3D 0;
+			strbuf_release(&sb);
+		}
+
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
+		int ret =3D inotify_add_watch(inotify_fd, dirname,
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
+	}
+	dir =3D item->util;
+	string_list_append(&dir->names, sep ? sep + 1 : path);
+	dir->names_sorted =3D 0;
+	return 0;
+}
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
+#else
+
 static int watch_path(char *path)
 {
 	return -1;
 }
=20
+static void reset_watches(void)
+{
+}
+
+#endif
+
 static void reset(const char *sig)
 {
+	reset_watches();
 	string_list_clear(&updated, 0);
 	strlcpy(index_signature, sig, sizeof(index_signature));
 }
@@ -155,6 +278,14 @@ int main(int argc, char **argv)
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
+#ifdef HAVE_INOTIFY
+	inotify_fd =3D inotify_init();
+	if (inotify_fd < 0)
+		die_errno("unable to initialize inotify");
+#else
+	die("no file watching mechanism is supported");
+#endif
+
 	if (getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &msgsize, &vallen))
 		die_errno("could not get SO_SNDBUF");
 	msg =3D xmalloc(msgsize + 1);
@@ -173,6 +304,10 @@ int main(int argc, char **argv)
 	nr =3D 0;
 	pfd[nr].fd =3D fd;
 	pfd[nr++].events =3D POLLIN;
+#ifdef HAVE_INOTIFY
+	pfd[nr].fd =3D inotify_fd;
+	pfd[nr++].events =3D POLLIN;
+#endif
=20
 	for (;;) {
 		if (poll(pfd, nr, -1) < 0) {
@@ -185,6 +320,10 @@ int main(int argc, char **argv)
=20
 		if ((pfd[0].revents & POLLIN) && handle_command(fd, msg, msgsize))
 			break;
+#ifdef HAVE_INOTIFY
+		if ((pfd[1].revents & POLLIN) && handle_inotify(inotify_fd))
+			break;
+#endif
 	}
 	return 0;
 }
--=20
1.8.5.2.240.g8478abd
