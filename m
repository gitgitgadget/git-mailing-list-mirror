From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/26] unix-socket: make unlink() optional in unix_stream_listen()
Date: Mon,  3 Feb 2014 11:28:52 +0700
Message-ID: <1391401754-15347-5-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAG-0000u2-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbaBCE3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:40 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:48498 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbaBCE3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:39 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so6514783pbc.8
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yDHn78Lk/Qfv0SmbqI3dWpXq9qjxS4RC/3fVrbi5pf0=;
        b=L8kj41OeCY2DpgLjylooEcRo+Ck5ZNHPgI/JzlGH7ZY89ijy+BnyyCPI00hMYsjaFu
         V7/2JFsUNEU1TS1XO5zspL5K03z8hbbFygfrDljL52yoDzCgE3r7UFMPiWcVj7cNvmA6
         GQEA3DUsSB3zjWbG+ua9vt/Cr1eMLKQF2zlAJ/FcXobhyAo2q2CtsjjfEdWsWBe33oZr
         SnJksvMQO4udSrBu35dL5Oswe0jrEKjCvVzkDnBxDaNaWH8rEt92WJZAPWgeSMcBWHzk
         imwdb9y7u33hHd+EPlkYdbTfMfTdti1F17ITY9PqwMRhY+WJODpRh6eaLaoL5R575wXA
         cSzw==
X-Received: by 10.68.98.3 with SMTP id ee3mr35327605pbb.31.1391401779457;
        Sun, 02 Feb 2014 20:29:39 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id om6sm51410255pbc.43.2014.02.02.20.29.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:37 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241399>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 credential-cache--daemon.c | 2 +-
 unix-socket.c              | 5 +++--
 unix-socket.h              | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..1b995a9 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -207,7 +207,7 @@ static void serve_cache(const char *socket_path)
 {
 	int fd;
=20
-	fd =3D unix_stream_listen(socket_path);
+	fd =3D unix_stream_listen(socket_path, 1);
 	if (fd < 0)
 		die_errno("unable to bind to '%s'", socket_path);
=20
diff --git a/unix-socket.c b/unix-socket.c
index 01f119f..2be1af6 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -93,7 +93,7 @@ fail:
 	return -1;
 }
=20
-int unix_stream_listen(const char *path)
+int unix_stream_listen(const char *path, int replace)
 {
 	int fd, saved_errno;
 	struct sockaddr_un sa;
@@ -103,7 +103,8 @@ int unix_stream_listen(const char *path)
 		return -1;
 	fd =3D unix_stream_socket();
=20
-	unlink(path);
+	if (replace)
+		unlink(path);
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
=20
diff --git a/unix-socket.h b/unix-socket.h
index e271aee..18ee290 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -2,6 +2,6 @@
 #define UNIX_SOCKET_H
=20
 int unix_stream_connect(const char *path);
-int unix_stream_listen(const char *path);
+int unix_stream_listen(const char *path, int replace);
=20
 #endif /* UNIX_SOCKET_H */
--=20
1.8.5.2.240.g8478abd
