From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/26] file-watcher: quit if $WATCHER/socket is gone
Date: Mon,  3 Feb 2014 11:29:10 +0700
Message-ID: <1391401754-15347-23-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBz-0001Z5-A3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbaBCEb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:27 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48803 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbaBCEb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:26 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so6587614pad.25
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6fhN6oz614zdfEbjtQ5GrQGxX4nUaiO89SXg2EJZJro=;
        b=Ztsf40k8fFvr3wpXlVGKZ4bShwc5U8mlW38XoAPyjfbtdENKpQT7DOXf6uIjFj2Htd
         qmO+VyflK5Tz2ivCNO/3IAsin+Yc2bkVALLaf8Alffi9TjMffkg/rEm4u8EocpueLsJt
         s8ug6FojnXG/yyjsWRtmG5caaMJirrYIzfrn2GS9LF9RsYse48RR9PVoseFFS/osVUTM
         GXLcr5nFE7QgK3a3mVt5YvHuh1eZcGHgsERD5HNxXE71TRBD6znKWnKRSRhK2dCrHlFi
         vGaKNckI5tuccy77Xv6XWW+eeRqInkE3hYlDUvjRnLJGNrvU+Dh26bNPicq8fE/XQ2o/
         Dvjg==
X-Received: by 10.66.192.162 with SMTP id hh2mr938361pac.150.1391401885837;
        Sun, 02 Feb 2014 20:31:25 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id os1sm134292230pac.20.2014.02.02.20.31.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:24 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241417>

This is more of an issue in development than in production. When a
file-watcher related test fails, the daemon may be left hanging. When
you rerun the same test, old $TRASH_DIRECTORY is wiped out and no one
can communicate with the old daemon any more. Make the old daemon quit
after 5 minutes in such cases.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/file-watcher.c b/file-watcher.c
index 5867942..1e45b25 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -834,11 +834,22 @@ static void check_socket_directory(const char *pa=
th)
 	free(path_copy);
 }
=20
+static void run_housekeeping(void)
+{
+	struct stat st;
+	struct strbuf sb =3D STRBUF_INIT;
+	strbuf_addf(&sb, "%s/socket", socket_path);
+	if (stat(sb.buf, &st) || !S_ISSOCK(st.st_mode))
+		exit(0);
+	strbuf_release(&sb);
+}
+
 int main(int argc, const char **argv)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int i, new_nr, fd, quit =3D 0, nr_common;
 	int daemon =3D 0;
+	time_t last_checked;
 	struct option options[] =3D {
 		OPT_BOOL(0, "detach", &daemon,
 			 N_("run in background")),
@@ -894,19 +905,25 @@ int main(int argc, const char **argv)
 		pfd[1].events =3D POLLIN;
 	}
=20
+	last_checked =3D time(NULL);
 	while (!quit) {
-		if (poll(pfd, pfd_nr, -1) < 0) {
+		int ret =3D poll(pfd, pfd_nr, 300000);
+		int time_for_housekeeping =3D 0;
+		if (ret < 0) {
 			if (errno !=3D EINTR) {
 				error("Poll failed, resuming: %s",
 				      strerror(errno));
 				sleep(1);
 			}
 			continue;
-		}
+		} else if (ret =3D=3D 0)
+			time_for_housekeeping =3D 1;
=20
 		if (inotify_fd && (pfd[1].revents & POLLIN)) {
 			if (handle_inotify(inotify_fd))
 				break;
+			if (last_checked + 300 < time(NULL))
+				time_for_housekeeping =3D 1;
 		}
=20
 		for (new_nr =3D i =3D nr_common; i < pfd_nr; i++) {
@@ -949,6 +966,11 @@ int main(int argc, const char **argv)
 			accept_connection(pfd[0].fd);
 		if (pfd[0].revents & (POLLHUP | POLLERR | POLLNVAL))
 			die(_("error on listening socket"));
+
+		if (time_for_housekeeping) {
+			run_housekeeping();
+			last_checked =3D time(NULL);
+		}
 	}
 	return 0;
 }
--=20
1.8.5.2.240.g8478abd
