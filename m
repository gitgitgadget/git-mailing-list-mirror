From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/9] for-each-ref: add %(color:...)
Date: Sun, 19 May 2013 17:27:12 +0700
Message-ID: <1368959235-27777-7-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pX-0006qt-Kc
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab3ESK0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:49 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42239 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab3ESK0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:47 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so4845713pab.35
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+d/5MmCyScM+gXgOUF1efE4iX+HzG6ct9J53F8k6omU=;
        b=rz96P45CM8nSGslAFljYibPLJdwTZtnKI6m0smIjAhGS/8vjX0cYHTOH59OtgqSnjE
         vO4lTHQPHo5IlpX2Md/Y2O/1CrMqjBJQJhiiMrBI9Z89+8fy8llBgXcwOecqxR5MRW3w
         STR7RBnt/ZM1i0cNDDI9fGwC2vOKB3EKAVxpILuRL1dIX3J1eyh3vXsAzE34xJMugEud
         SipXZmkel+OYfPwu9n49UeaEa6E/3RuCs7T/G9nrotu7hssjPRZOwOwFkB7uUKkJw6yz
         rUi7CcDFz+B0gpcBGFKdx1jOLyRAgzetnaaWjXUSUs7qE9le2DJVtKkbFvXECrdWI5Jl
         SbVg==
X-Received: by 10.68.95.101 with SMTP id dj5mr25725889pbb.100.1368959207074;
        Sun, 19 May 2013 03:26:47 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id 10sm19189261pbr.45.2013.05.19.03.26.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:57 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224843>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.h               | 11 +++++++++++
 builtin/branch.c       | 12 ++----------
 builtin/for-each-ref.c | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/branch.h b/branch.h
index 64173ab..076babf 100644
--- a/branch.h
+++ b/branch.h
@@ -52,4 +52,15 @@ extern void install_branch_config(int flag, const ch=
ar *local, const char *origi
  */
 extern int read_branch_desc(struct strbuf *, const char *branch_name);
=20
+enum color_branch {
+	BRANCH_COLOR_RESET =3D 0,
+	BRANCH_COLOR_PLAIN =3D 1,
+	BRANCH_COLOR_REMOTE =3D 2,
+	BRANCH_COLOR_LOCAL =3D 3,
+	BRANCH_COLOR_CURRENT =3D 4,
+	BRANCH_COLOR_UPSTREAM =3D 5
+};
+extern int git_branch_config(const char *var, const char *value, void =
*cb);
+extern const char *branch_get_color(enum color_branch ix);
+
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index 7d084da..1aa282c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -43,14 +43,6 @@ static char branch_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_GREEN,	/* CURRENT */
 	GIT_COLOR_BLUE,		/* UPSTREAM */
 };
-enum color_branch {
-	BRANCH_COLOR_RESET =3D 0,
-	BRANCH_COLOR_PLAIN =3D 1,
-	BRANCH_COLOR_REMOTE =3D 2,
-	BRANCH_COLOR_LOCAL =3D 3,
-	BRANCH_COLOR_CURRENT =3D 4,
-	BRANCH_COLOR_UPSTREAM =3D 5
-};
=20
 static enum merge_filter {
 	NO_FILTER =3D 0,
@@ -79,7 +71,7 @@ static int parse_branch_color_slot(const char *var, i=
nt ofs)
 	return -1;
 }
=20
-static int git_branch_config(const char *var, const char *value, void =
*cb)
+int git_branch_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "column."))
 		return git_column_config(var, value, "branch", &colopts);
@@ -99,7 +91,7 @@ static int git_branch_config(const char *var, const c=
har *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
=20
-static const char *branch_get_color(enum color_branch ix)
+const char *branch_get_color(enum color_branch ix)
 {
 	if (want_color(branch_use_color))
 		return branch_colors[ix];
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b10d48a..db5c211 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,8 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "color.h"
+#include "branch.h"
=20
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -36,6 +38,7 @@ struct refinfo {
 	int flag;
 	const char *symref;
 	struct atom_value *value;
+	int auto_color;
 };
=20
 static struct {
@@ -78,6 +81,7 @@ static struct {
 	{ "current" },
 	{ "tracking" },
 	{ "tracking:upstream" },
+	{ "color" },
 };
=20
 /*
@@ -707,6 +711,21 @@ static void populate_value(struct refinfo *ref)
 			v->s =3D sb.buf;
 			continue;
 		}
+		else if (!prefixcmp(name, "color:")) {
+			const char *color =3D name + 6;
+			ref->auto_color =3D 0;
+			if (!prefixcmp(color, "red"))
+				v->s =3D GIT_COLOR_RED;
+			else if (!prefixcmp(color, "green"))
+				v->s =3D GIT_COLOR_GREEN;
+			else if (!prefixcmp(color, "blue"))
+				v->s =3D GIT_COLOR_BLUE;
+			else if (!prefixcmp(color, "reset"))
+				v->s =3D GIT_COLOR_RESET;
+			else if (!prefixcmp(color, "auto"))
+				ref->auto_color =3D 1;
+			continue;
+		}
 		else
 			continue;
=20
@@ -730,6 +749,19 @@ static void populate_value(struct refinfo *ref)
 			sprintf(s, "%s^{}", refname);
 			v->s =3D s;
 		}
+
+		if (ref->auto_color) {
+			if (!head) {
+				unsigned char sha1[20];
+				head =3D resolve_refdup("HEAD", sha1, 0, NULL);
+			}
+			if (strcmp(head, "HEAD") && !strcmp(ref->refname, head)) {
+				struct strbuf sb =3D STRBUF_INIT;
+				strbuf_addstr(&sb, branch_get_color(BRANCH_COLOR_CURRENT));
+				strbuf_addstr(&sb, v->s);
+				v->s =3D sb.buf;
+			}
+		}
 	}
=20
 	for (i =3D 0; i < used_atom_cnt; i++) {
@@ -1071,7 +1103,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 	sort_atom_limit =3D used_atom_cnt;
=20
 	/* for warn_ambiguous_refs */
-	git_config(git_default_config, NULL);
+	git_config(git_branch_config, NULL);
=20
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern =3D argv;
--=20
1.8.2.83.gc99314b
