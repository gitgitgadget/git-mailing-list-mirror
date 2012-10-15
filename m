From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/12] dir.c: refactor treat_gitlinks()
Date: Mon, 15 Oct 2012 13:28:03 +0700
Message-ID: <1350282486-4646-9-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeBK-0001aR-4r
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab2JOG3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44799 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2JOG3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4627017pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wc0oyrdsapl8OunJeEHOeePbYU/OSOnD1gH9CSuNxoA=;
        b=xsKnO5yd7N1fJr9pj4kWyBLcnpDJVCofp3RoSCzezr4hHyq22QMJe3r+fywjaHpfL6
         GBxWsy1wHXgUkPsGsQvGMQdx7SHlBOKUVwmhmUq0FLSHfjm2TAwxlAF41myagIeLi+wb
         0j0Lv830KIsQ7BvKwAP+QCC1xnTyT4MPSil/zs/UnBCkik319xNCTgB0lgRAfKMnQNDx
         ALrTmnVJd20oTmBAB0rqv1hmn85MKs/y7A7Cmhz8sgpaLx6pEiIJxO3c8DEWC/TOM2Do
         vVgThsLMM7yxSs049JpomTeS4A9VOXqbshuSQAtDpK6SCqS9PDcCoiQph9mDPhRCgbiB
         7ZQg==
Received: by 10.66.80.133 with SMTP id r5mr4484002pax.24.1350282570756;
        Sun, 14 Oct 2012 23:29:30 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id qv4sm7229513pbc.38.2012.10.14.23.29.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:29:20 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207720>

=46rom: Adam Spiers <git@adamspiers.org>

Extract the body of the for loop in treat_gitlinks() into a separate
treat_gitlink() function so that it can be reused elsewhere.  This
paves the way for a new check-ignore sub-command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c689f37..6d2fb0c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -153,31 +153,44 @@ static char *prune_directory(struct dir_struct *d=
ir, const char **pathspec, int
 	return seen;
 }
=20
-static void treat_gitlinks(const char **pathspec)
+/*
+ * Check whether path refers to a submodule, or something inside a
+ * submodule.  If the former, returns the path with any trailing slash
+ * stripped.  If the latter, dies with an error message.
+ */
+const char *treat_gitlink(const char *path)
 {
-	int i;
-
-	if (!pathspec || !*pathspec)
-		return;
-
+	int i, path_len =3D strlen(path);
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
 		if (S_ISGITLINK(ce->ce_mode)) {
-			int len =3D ce_namelen(ce), j;
-			for (j =3D 0; pathspec[j]; j++) {
-				int len2 =3D strlen(pathspec[j]);
-				if (len2 <=3D len || pathspec[j][len] !=3D '/' ||
-				    memcmp(ce->name, pathspec[j], len))
-					continue;
-				if (len2 =3D=3D len + 1)
-					/* strip trailing slash */
-					pathspec[j] =3D xstrndup(ce->name, len);
-				else
-					die (_("Path '%s' is in submodule '%.*s'"),
-						pathspec[j], len, ce->name);
+			int ce_len =3D ce_namelen(ce);
+			if (path_len <=3D ce_len || path[ce_len] !=3D '/' ||
+			    memcmp(ce->name, path, ce_len))
+				/* path does not refer to this
+				 * submodule or anything inside it */
+				continue;
+			if (path_len =3D=3D ce_len + 1) {
+				/* path refers to submodule;
+				 * strip trailing slash */
+				return xstrndup(ce->name, ce_len);
+			} else {
+				die (_("Path '%s' is in submodule '%.*s'"),
+				     path, ce_len, ce->name);
 			}
 		}
 	}
+	return path;
+}
+
+void treat_gitlinks(const char **pathspec)
+{
+	if (!pathspec || !*pathspec)
+		return;
+
+	int i;
+	for (i =3D 0; pathspec[i]; i++)
+		pathspec[i] =3D treat_gitlink(pathspec[i]);
 }
=20
 static void refresh(int verbose, const char **pathspec)
--=20
1.8.0.rc0.29.g1fdd78f
