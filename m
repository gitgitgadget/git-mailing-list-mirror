From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/26] file-watcher: remove socket on exit
Date: Mon,  3 Feb 2014 11:28:55 +0700
Message-ID: <1391401754-15347-8-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAZ-00011a-FG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbaBCE36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:58 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:60229 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaBCE35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:57 -0500
Received: by mail-pb0-f54.google.com with SMTP id uo5so6595997pbc.13
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FthyakbUpb/R+MuEU7uJCkBVs4F5TCc2qjkEKC7pBhQ=;
        b=HpvsAEXWklqiMb++HIcTVQ6DbdWRUwbd1g8W3qFb4MC7haMogxQMQ8yW3xnlctKZ+f
         DpcDQ+VxYkgOkEfGLjFoXmqY2lBZKWpWOkFX8fLf+KNxxUvVUPS3pS/nGpUNF0wk+jPj
         hUYxZZ9oDLZsTFVbmtHSXh+/JovBkM6Sxg0b6X6Zhl5PrkzitNqoJ1jXljssKOtzHR0r
         3CXQHOFnLx5ekUj/aI+MO2P0QK13u2GufG4EnrCugdv3U5tYtSOVXI+9g3w6ld/Hbd32
         DuQoNHJ5Loi2U/dtCXodP2Mwn4mf9U9pWYrywnsvoLfB3Tbt2cTvYUOJO1ndyOMSHQ8U
         IGGQ==
X-Received: by 10.68.229.106 with SMTP id sp10mr35153407pbc.23.1391401797340;
        Sun, 02 Feb 2014 20:29:57 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id xs1sm134241450pac.7.2014.02.02.20.29.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:54 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241402>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/file-watcher.c b/file-watcher.c
index 91f4cfe..9c639ef 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -56,6 +56,26 @@ static void accept_connection(int fd)
 	pfd_nr++;
 }
=20
+static const char *socket_path;
+static int do_not_clean_up;
+
+static void cleanup(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	if (do_not_clean_up)
+		return;
+	strbuf_addf(&sb, "%s/socket", socket_path);
+	unlink(sb.buf);
+	strbuf_release(&sb);
+}
+
+static void cleanup_on_signal(int signo)
+{
+	cleanup();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static const char permissions_advice[] =3D
 N_("The permissions on your socket directory are too loose; other\n"
    "processes may be able to read your file listing. Consider running:=
\n"
@@ -91,7 +111,6 @@ int main(int argc, const char **argv)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int i, new_nr, fd, quit =3D 0, nr_common;
-	const char *socket_path =3D NULL;
 	struct option options[] =3D {
 		OPT_END()
 	};
@@ -113,6 +132,9 @@ int main(int argc, const char **argv)
 		die_errno(_("unable to listen at %s"), sb.buf);
 	strbuf_reset(&sb);
=20
+	atexit(cleanup);
+	sigchain_push_common(cleanup_on_signal);
+
 	nr_common =3D 1;
 	pfd_alloc =3D pfd_nr =3D nr_common;
 	pfd =3D xmalloc(sizeof(*pfd) * pfd_alloc);
--=20
1.8.5.2.240.g8478abd
