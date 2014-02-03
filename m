From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/26] file-watcher: check socket directory permission
Date: Mon,  3 Feb 2014 11:28:54 +0700
Message-ID: <1391401754-15347-7-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAT-0000z3-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbaBCE3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:53 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:56823 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaBCE3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:52 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so6567865pab.26
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WHQDkt7X/T1EBw4I4QMEAhS655IMHMQG9NXsoh6KS+Q=;
        b=ZMVnVi/jLPyk9m5qEOLitliwN3tXtadEcGcu+l61WT/9sAQwLoJeOge9MBElplNhfn
         F9YU456EVRWwrS0q9mS681XeskOnK2va8Bk9lLD5IvBl70awZv0Z1PEqo7b10J2cVmHZ
         IfBSJtGJFCXneCqIyPAcFSa2Uybys4YbwmYHEa0KkfaNeFFBYgtN3iftBoy5Ig9KwBQn
         hlNLZ1wnVKwnPxS3oJiXWfZBurW+LtPaRhIxhpICmSYFq9YptxBK4HZBxslksc1Cab8x
         wolM8qEK+bl9je0QX8vAe4FdDx7EWRf1bbH/eUBDvMuBAvdXcPhiu+x6w8iSzC1SAFtq
         6YKg==
X-Received: by 10.67.14.69 with SMTP id fe5mr35396732pad.120.1391401791102;
        Sun, 02 Feb 2014 20:29:51 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id zc6sm134253810pab.18.2014.02.02.20.29.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:49 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241401>

Access to the unix socket $WATCHER/socket is covered by $WATCHER's
permission. While the file watcher does not carry much information,
repo file listing is sometimes not something you want other users to
see. Make sure $WATCHER has 0700 permission to stop unwanted access.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/file-watcher.c b/file-watcher.c
index a6d7f17..91f4cfe 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -56,6 +56,37 @@ static void accept_connection(int fd)
 	pfd_nr++;
 }
=20
+static const char permissions_advice[] =3D
+N_("The permissions on your socket directory are too loose; other\n"
+   "processes may be able to read your file listing. Consider running:=
\n"
+   "\n"
+   "	chmod 0700 %s");
+static void check_socket_directory(const char *path)
+{
+	struct stat st;
+	char *path_copy =3D xstrdup(path);
+	char *dir =3D dirname(path_copy);
+
+	if (!stat(dir, &st)) {
+		if (st.st_mode & 077)
+			die(_(permissions_advice), dir);
+		free(path_copy);
+		return;
+	}
+
+	/*
+	 * We must be sure to create the directory with the correct mode,
+	 * not just chmod it after the fact; otherwise, there is a race
+	 * condition in which somebody can chdir to it, sleep, then try to op=
en
+	 * our protected socket.
+	 */
+	if (safe_create_leading_directories_const(dir) < 0)
+		die_errno(_("unable to create directories for '%s'"), dir);
+	if (mkdir(dir, 0700) < 0)
+		die_errno(_("unable to mkdir '%s'"), dir);
+	free(path_copy);
+}
+
 int main(int argc, const char **argv)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -76,6 +107,7 @@ int main(int argc, const char **argv)
=20
 	socket_path =3D argv[0];
 	strbuf_addf(&sb, "%s/socket", socket_path);
+	check_socket_directory(sb.buf);
 	fd =3D unix_stream_listen(sb.buf, 0);
 	if (fd =3D=3D -1)
 		die_errno(_("unable to listen at %s"), sb.buf);
--=20
1.8.5.2.240.g8478abd
