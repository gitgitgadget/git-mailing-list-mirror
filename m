From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] Move term_columns() to pager.c and save terminal width before pager
Date: Tue,  8 Feb 2011 22:22:15 +0700
Message-ID: <1297178541-31124-2-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQH-0006cM-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab1BHPYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab1BHPYA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:00 -0500
Received: by pzk35 with SMTP id 35so1140930pzk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=KnYL9DGEB6Qsf3vlgRhj0jr8XTTF6Im4HusFdvrTiq8=;
        b=q2pti/6sjHH77Y4nuCp+cYexmeDctFdXUue5KNcpmjA67b9w9J9UYAYSbP5/MRYCB+
         RdKEZn2i3v2ozLtwvB0PDdE8tESIyGCVM1GVbJgCpGx4XyaSaRvW/ZwnOJNPdYCgm6CI
         w9lKr4C3m3dG5nCvEvBfMYqUOtbpc6zsGkkUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UwTrBBngE/kD8Whx6bjhFdcdJ7inKfDbvJU9h/HH1bX1uZoy9bwSEhe0NCKCJwYilT
         PbCf/z1qSx3vGvuhB2Ltz2gJVfPl0NRkuTJsxTTVih8gbD3QPzkUff/k4Sp0iDZlJOpr
         iTYBxqNS2GRpwS2uHLe7NUD6nyw1jTrGBjF70=
Received: by 10.142.194.3 with SMTP id r3mr5439768wff.184.1297178640390;
        Tue, 08 Feb 2011 07:24:00 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id y42sm7712619wfd.10.2011.02.08.07.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:23:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:22:29 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166353>

term_columns() checks for terminal width via ioctl(1). After
redirecting, stdin is no longer terminal to get terminal width.

Check terminal width and save it before redirect stdin in setup_pager()
and let term_columns() reuse the value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 help.c  |   22 ----------------------
 pager.c |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index d83d68c..bcbd5f2 100644
--- a/cache.h
+++ b/cache.h
@@ -1045,6 +1045,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+extern int term_columns();
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/help.c b/help.c
index 7654f1b..1344208 100644
--- a/help.c
+++ b/help.c
@@ -5,28 +5,6 @@
 #include "help.h"
 #include "common-cmds.h"
=20
-/* most GUI terminals set COLUMNS (although some don't export it) */
-static int term_columns(void)
-{
-	char *col_string =3D getenv("COLUMNS");
-	int n_cols;
-
-	if (col_string && (n_cols =3D atoi(col_string)) > 0)
-		return n_cols;
-
-#ifdef TIOCGWINSZ
-	{
-		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				return ws.ws_col;
-		}
-	}
-#endif
-
-	return 80;
-}
-
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent =3D xmalloc(sizeof(*ent) + len + 1);
diff --git a/pager.c b/pager.c
index dac358f..ad447cf 100644
--- a/pager.c
+++ b/pager.c
@@ -12,6 +12,7 @@
  */
=20
 static int spawned_pager;
+static int max_columns;
=20
 #ifndef WIN32
 static void pager_preexec(void)
@@ -80,6 +81,15 @@ void setup_pager(void)
=20
 	spawned_pager =3D 1; /* means we are emitting to terminal */
=20
+#ifdef TIOCGWINSZ
+	{
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col)
+				max_columns =3D ws.ws_col;
+		}
+	}
+#endif
 	/* spawn the pager */
 	pager_argv[0] =3D pager;
 	pager_process.use_shell =3D 1;
@@ -116,3 +126,25 @@ int pager_in_use(void)
 	env =3D getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
+
+int term_columns()
+{
+	char *col_string =3D getenv("COLUMNS");
+	int n_cols;
+
+	if (col_string && (n_cols =3D atoi(col_string)) > 0)
+		return n_cols;
+
+	else if (spawned_pager && max_columns)
+		return max_columns;
+#ifdef TIOCGWINSZ
+	else {
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col)
+				return ws.ws_col;
+		}
+	}
+#endif
+	return 80;
+}
--=20
1.7.2.2
