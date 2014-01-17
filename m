From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 10/14] file-watcher: automatically quit
Date: Fri, 17 Jan 2014 16:47:36 +0700
Message-ID: <1389952060-12297-11-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W463D-0003DU-80
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbaAQJtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:49:09 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:61187 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbaAQJtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:49:05 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so3910109pbc.20
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kevKXzBNATOfMHL8kZkzlGqwJj+yXrfB9AIEJvC3bvs=;
        b=Kh8dOHmNl6/Zt70EqOzRtcHpC7tklyUT2wKZGL6oIBpnsVYt2aYeiH2QQaNLISkeVM
         uugH0hUV/go54Fzfd/MvcoYQyLZzvUGmO9uIZJKdrvZALhKozQGhyJ69aF4hdzq7gKUo
         9Wc0dF/j1gS7OnlLcW0GSfvNi09XH+Yp1c3ale8DddQMNBWDniHI4KvsptsTMXHuCrZB
         2KDhfgVKFXa3dGmJcYgNtUnzQrfmOuMsnualGD+3xC8eyVxULyF7Od4LY+gkggKIgqxW
         0yMAbshdL3iS8rrQIzBgO+bYPgVkzmuPNlCCBjvwl3RvqAF7weZ24JaCJIqIebXz9wpT
         1QDQ==
X-Received: by 10.66.142.42 with SMTP id rt10mr1042898pab.1.1389952144663;
        Fri, 17 Jan 2014 01:49:04 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id i10sm28696974pat.11.2014.01.17.01.49.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:49:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:59 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240591>

If $GIT_DIR/index.watcher or $GIT_DIR/index is gone, exit. We could
watch this path too, but we'll waste precious resources (at least with
inotify). And with inotify, it seems to miss the case when $GIT_DIR is
moved. Just check if the socket path still exists every minute.

As the last resort, if we do not receive any commands in the last 6
hours, exit. The code is structured this way because later on inotify
is also polled. On an busy watched directory, the timeout may never
happen for us to kil the watcher, even if index.watcher is already
gone.

=46or mass cleanup, "killall -USR1 git-file-watcher" asks every watcher
process to question the purpose of its existence.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/file-watcher.c b/file-watcher.c
index df06529..f334e23 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -163,6 +163,12 @@ static void daemonize(void)
 #endif
 }
=20
+static int check_exit_please;
+static void check_exit_signal(int signo)
+{
+	check_exit_please =3D 1;
+}
+
 int main(int argc, const char **argv)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -172,6 +178,8 @@ int main(int argc, const char **argv)
 	const char *prefix;
 	int daemon =3D 0, quiet =3D 0, shutdown =3D 0;
 	const char *log_string =3D NULL;
+	struct stat socket_st;
+	struct timeval tv_last_command;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL(0, "daemon", &daemon,
@@ -217,6 +225,10 @@ int main(int argc, const char **argv)
=20
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
+	sigchain_push(SIGUSR1, check_exit_signal);
+
+	if (stat(socket_path, &socket_st))
+		die_errno("failed to stat %s", socket_path);
=20
 	if (daemon) {
 		strbuf_addf(&sb, "%s.log", socket_path);
@@ -234,17 +246,37 @@ int main(int argc, const char **argv)
 	pfd[nr].fd =3D fd;
 	pfd[nr++].events =3D POLLIN;
=20
+	gettimeofday(&tv_last_command, NULL);
 	for (;;) {
-		if (poll(pfd, nr, -1) < 0) {
+		int check_exit =3D check_exit_please;
+		int ret =3D poll(pfd, nr, check_exit ? 0 : 60 * 1000);
+		if (ret < 0) {
 			if (errno !=3D EINTR) {
 				error("Poll failed, resuming: %s", strerror(errno));
 				sleep(1);
 			}
 			continue;
+		} else if (!ret)
+			check_exit =3D 1;
+
+		if ((pfd[0].revents & POLLIN)) {
+			if (handle_command(fd))
+				break;
+			gettimeofday(&tv_last_command, NULL);
 		}
=20
-		if ((pfd[0].revents & POLLIN) && handle_command(fd))
-			break;
+		if (check_exit) {
+			struct stat st;
+			struct timeval now;
+			gettimeofday(&now, NULL);
+			if (tv_last_command.tv_sec + 6 * 60 < now.tv_sec)
+				break;
+			if (stat(socket_path, &st) ||
+			    st.st_ino !=3D socket_st.st_ino ||
+			    stat(get_index_file(), &st))
+				break;
+			check_exit_please =3D 0;
+		}
 	}
 	return 0;
 }
--=20
1.8.5.1.208.g05b12ea
