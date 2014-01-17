From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 09/14] file-watcher: add --shutdown and --log options
Date: Fri, 17 Jan 2014 16:47:35 +0700
Message-ID: <1389952060-12297-10-git-send-email-pclouds@gmail.com>
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
	id 1W4631-0002uW-5W
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbaAQJtC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:49:02 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47026 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbaAQJs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:59 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so2473810pdj.25
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=I9m/g8srGBvGWrIZEukkSe02fapLKyZ/ZaQGTO5e/YA=;
        b=R5lTWZVuhcLVI9EbjiiSrY8nrfCGoU98TPLntiyJfWX0suO5vj0Fwcb7VOlVbom0cx
         gN8vEAKw6bkTuhpvs91TfhQ/JEqPk4QmMuUinsQMRmv4Nf2H3aSOckGcjB3rgxmWoI6X
         wto5CXRIxmTKfNUy1N1YmeFsidt9vJwq5MpryMU6SWAWq8icnuqGXJUQT08usg/8id2p
         ulbbhN6Qq3CVU47f8YzOaYs+q/yFsNHc+FRqAcdgdKaHzBEgFXnM/TEGsWfszzPSDY9w
         FsAYSPrXpqMTL/FokcG7P6sfQSNbwXUr2Ny0ElRD1q/GD2ohC6J1JC1P6dao0dsVK4TL
         tGmQ==
X-Received: by 10.66.27.107 with SMTP id s11mr1133532pag.64.1389952139140;
        Fri, 17 Jan 2014 01:48:59 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id qw8sm21334909pbb.27.2014.01.17.01.48.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:53 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240587>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/file-watcher.c b/file-watcher.c
index 1b4ac0a..df06529 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -113,6 +113,8 @@ static int handle_command(int fd)
 			remove_updated(arg + len + 1);
 	} else if (starts_with(msg, "watch ")) {
 		watch_paths(msg + 6, len - 6, fd, &sun);
+	} else if ((arg =3D skip_prefix(msg, "log "))) {
+		fprintf(stderr, "log %s\n", arg);
 	} else if (!strcmp(msg, "die")) {
 		exit(0);
 	} else {
@@ -168,11 +170,16 @@ int main(int argc, const char **argv)
 	struct pollfd pfd[2];
 	int fd, err, nr;
 	const char *prefix;
-	int daemon =3D 0, quiet =3D 0;
+	int daemon =3D 0, quiet =3D 0, shutdown =3D 0;
+	const char *log_string =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL(0, "daemon", &daemon,
-			 N_("run in background")),
+			 N_("run in background (default)")),
+		OPT_BOOL(0, "shutdown", &shutdown,
+			 N_("shut down running file-watcher daemon")),
+		OPT_STRING(0, "log", &log_string, "string",
+			   N_("string to log to index.watcher.log")),
 		OPT_END()
 	};
=20
@@ -190,11 +197,24 @@ int main(int argc, const char **argv)
 	fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
 	sun.sun_family =3D AF_UNIX;
 	strlcpy(sun.sun_path, socket_path, sizeof(sun.sun_path));
+
+	if (shutdown || log_string) {
+		struct stat st;
+		if (stat(socket_path, &st) || !S_ISSOCK(st.st_mode))
+			return 0;
+		if (log_string && send_watcher(fd, &sun, "log %s", log_string) < 0)
+			die_errno("failed to shut file-watcher down");
+		if (shutdown && send_watcher(fd, &sun, "die") < 0)
+			die_errno("failed to shut file-watcher down");
+		return 0;
+	}
+
 	if (bind(fd, (struct sockaddr *)&sun, sizeof(sun))) {
 		if (quiet)
 			exit(128);
 		die_errno("unable to bind to %s", socket_path);
 	}
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
--=20
1.8.5.1.208.g05b12ea
