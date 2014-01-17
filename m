From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 07/14] read-cache: add config to start file watcher automatically
Date: Fri, 17 Jan 2014 16:47:33 +0700
Message-ID: <1389952060-12297-8-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W462z-0002uW-0B
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbaAQJsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:53 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56322 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbaAQJss (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:48 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so3809127pdi.9
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2jJlVtWcDlFtBfxSCZln/X4ygMnwldwTcDeKSlWrVns=;
        b=w/BMxbSWgEC92UjK2KlRABprlL3mutb9TE5jMl2OlM0xvqrPjSFBR6zYtqecWbDWii
         4yfsBSz8r6QgP5ob1gFnrUdUPxed28SlBbL1GVdy5AyLBi7ppw0pZo1854MdTbL1yn09
         DedaMnXzBvto8wzaBH2JdThbQzl/2ea9tGl9yjEmY4gQEZg8aygY3RV27nlpdWZdvOZH
         UX8Gji6km2fMItPwaftvjAZJDI2IwtMaHtvn7SPzjxKvf0wRfcKOTnSBYp4i8yiAFapa
         qHqemiBrOyLYYZe0gpKE7bMNJsykAnd34jGDFhwLXQurrYh3L69gpaEdjyNZCYDQDPri
         kD9w==
X-Received: by 10.68.14.130 with SMTP id p2mr1053459pbc.17.1389952127764;
        Fri, 17 Jan 2014 01:48:47 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id zc5sm21312284pbc.41.2014.01.17.01.48.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:46 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:41 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240586>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  5 +++++
 file-watcher-lib.c       | 18 +++++++++++++++---
 file-watcher-lib.h       |  2 +-
 file-watcher.c           |  8 ++++++--
 read-cache.c             | 17 +++++++++++++++--
 5 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e394399..3316b69 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1038,6 +1038,11 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
=20
+filewatcher.autorun::
+	Run `git file-watcher` automatically if the number of cached
+	entries is greater than this limit. Zero means no running
+	file-watcher automatically. Default value is zero.
+
 filewatcher.minfiles::
 	Start watching files if the number of watchable files are
 	above this limit. Default value is 65536.
diff --git a/file-watcher-lib.c b/file-watcher-lib.c
index ed14ef9..71c8545 100644
--- a/file-watcher-lib.c
+++ b/file-watcher-lib.c
@@ -1,16 +1,28 @@
 #include "cache.h"
+#include "run-command.h"
=20
 #define WAIT_TIME 20		/* in ms */
 #define TRACE_KEY "GIT_TRACE_WATCHER"
=20
-int connect_watcher(const char *path)
+int connect_watcher(const char *path, int autorun)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	struct stat st;
-	int fd =3D -1;
+	int fd =3D -1, ret;
=20
 	strbuf_addf(&sb, "%s.watcher", path);
-	if (!stat(sb.buf, &st) && S_ISSOCK(st.st_mode)) {
+	ret =3D stat(sb.buf, &st);
+	if (autorun && ret && errno =3D=3D ENOENT) {
+		const char *av[] =3D { "file-watcher", "--daemon", "--quiet", NULL }=
;
+		struct child_process cp;
+		memset(&cp, 0, sizeof(cp));
+		cp.git_cmd =3D 1;
+		cp.argv =3D av;
+		if (run_command(&cp))
+			return -1;
+		ret =3D stat(sb.buf, &st);
+	}
+	if (!ret && S_ISSOCK(st.st_mode)) {
 		struct sockaddr_un sun;
 		fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
 		sun.sun_family =3D AF_UNIX;
diff --git a/file-watcher-lib.h b/file-watcher-lib.h
index 0fe9399..ef3d196 100644
--- a/file-watcher-lib.h
+++ b/file-watcher-lib.h
@@ -1,7 +1,7 @@
 #ifndef __FILE_WATCHER_LIB__
 #define __FILE_WATCHER_LIB__
=20
-int connect_watcher(const char *path);
+int connect_watcher(const char *path, int autorun);
 ssize_t send_watcher(int sockfd, struct sockaddr_un *dest,
 		     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
diff --git a/file-watcher.c b/file-watcher.c
index 369af37..1b4ac0a 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -168,8 +168,9 @@ int main(int argc, const char **argv)
 	struct pollfd pfd[2];
 	int fd, err, nr;
 	const char *prefix;
-	int daemon =3D 0;
+	int daemon =3D 0, quiet =3D 0;
 	struct option options[] =3D {
+		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL(0, "daemon", &daemon,
 			 N_("run in background")),
 		OPT_END()
@@ -189,8 +190,11 @@ int main(int argc, const char **argv)
 	fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
 	sun.sun_family =3D AF_UNIX;
 	strlcpy(sun.sun_path, socket_path, sizeof(sun.sun_path));
-	if (bind(fd, (struct sockaddr *)&sun, sizeof(sun)))
+	if (bind(fd, (struct sockaddr *)&sun, sizeof(sun))) {
+		if (quiet)
+			exit(128);
 		die_errno("unable to bind to %s", socket_path);
+	}
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
diff --git a/read-cache.c b/read-cache.c
index 3aa541d..5dae9eb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -40,6 +40,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 struct index_state the_index;
 static int watch_lowerlimit =3D 65536;
 static int recent_limit =3D 1800;
+static int autorun_watcher =3D -1;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1518,6 +1519,10 @@ failed:
=20
 static int watcher_config(const char *var, const char *value, void *da=
ta)
 {
+	if (!strcmp(var, "filewatcher.autorun")) {
+		autorun_watcher =3D git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "filewatcher.minfiles")) {
 		watch_lowerlimit =3D git_config_int(var, value);
 		return 0;
@@ -1538,8 +1543,16 @@ static void validate_watcher(struct index_state =
*istate, const char *path)
 		return;
 	}
=20
-	git_config(watcher_config, NULL);
-	istate->watcher =3D connect_watcher(path);
+	if (autorun_watcher =3D=3D -1) {
+		git_config(watcher_config, NULL);
+		if (autorun_watcher =3D=3D -1)
+			autorun_watcher =3D 0;
+	}
+
+	istate->watcher =3D connect_watcher(path,
+					  autorun_watcher &&
+					  istate->cache_nr >=3D autorun_watcher);
+	autorun_watcher =3D 0;
 	if (istate->watcher !=3D -1) {
 		struct strbuf sb =3D STRBUF_INIT;
 		char *msg;
--=20
1.8.5.1.208.g05b12ea
