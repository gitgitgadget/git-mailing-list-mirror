From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/12] Move term_columns() to pager.c
Date: Sun,  7 Mar 2010 19:09:34 +0700
Message-ID: <1267963785-473-2-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFNN-0000oh-Es
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab0CGMNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:41 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:64105 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0CGMNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:07 -0500
Received: by pzk32 with SMTP id 32so2186152pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6BkQ3RMGAqZnpzvis6e6BCwn7f7848lN313MEOXD3e8=;
        b=tBf3dLmAbzje9iEQI0YmcoSnVl6fwZjFfyBMrTs7HnbhdcJOgMUTKhOFAPjcqvUhAf
         KCQ3rICeWPxPdnM4Bytp3PHAgO4yiqzlfYNDxGhYgeKuXGWylrdQtFAQ+XGH3tIro2i0
         sZRGhpdpeyCeLn8Beo72jJWb1+UAJqtuUlNSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DZKolLOrCwzVWD8lm7bst6veJFt/FuJH+yveP5EU2q81qpzkkETO+t3BSlYr+KP+Ag
         7v5o/2IWTX+u2uY/H0Y/8GnAe1D8opMFmRrQZRwKVvwbB/auMQGsH13zIs/crhrysD/S
         0Jh4RON3BifhjXl22k7X0zeVG8K2sJvjEfevk=
Received: by 10.141.108.9 with SMTP id k9mr2220067rvm.226.1267963987009;
        Sun, 07 Mar 2010 04:13:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3590025pzk.6.2010.03.07.04.13.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:09:51 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141683>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 help.c  |   22 ----------------------
 pager.c |   23 +++++++++++++++++++++++
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 89f6a40..124f100 100644
--- a/cache.h
+++ b/cache.h
@@ -985,6 +985,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+extern int term_columns();
=20
 extern const char *editor_program;
 extern const char *excludes_file;
diff --git a/help.c b/help.c
index 7f4928e..888bf8c 100644
--- a/help.c
+++ b/help.c
@@ -4,28 +4,6 @@
 #include "levenshtein.h"
 #include "help.h"
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
index dac358f..fc6c3e0 100644
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
@@ -116,3 +117,25 @@ int pager_in_use(void)
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
1.7.0.1.370.gd3c5
