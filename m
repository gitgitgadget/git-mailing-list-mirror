From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: warn users if action is taken in ambiguous situation
Date: Fri, 31 Aug 2012 21:38:54 +0700
Message-ID: <1346423934-7003-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 16:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7STc-0008TL-T8
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 16:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777Ab2HaOpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 10:45:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44559 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab2HaOpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 10:45:24 -0400
Received: by pbbrr13 with SMTP id rr13so4956519pbb.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=jgYBcDqwoXCPou1LdxRzumFlGZBJrg5RfxdbDtByZcA=;
        b=pmuRC41JpUivxzW4KllSpY0i1+nw+KrtEsoOS+upAr+aohsGZO1gunAbCdrp3dUDQ7
         HSiAabOsll5gd8WdIcwRZoFDjtwWtR7aX9YA+UxUKLwUfrVGOETkx6fwHeBKOFAzkERd
         M0h9bVQFrXPABtFiepTUSxM3eWtfMv1WAGBdRDh9vTUhNMsjMMHYAAx2s11DhEj3/1Y4
         HCwWs1Sr+wpOuro4mg+XXyk28KOB5t1h2LHbR9uCYRuAzbPic2Vtk+D8ahHpA0qaM9oT
         3jUp7ZNI31BHdctLaep4+7aWM5yTvStIGPZ/THC/K5heQbdQyq6GSuI+iuQSgesMB4WG
         FT2g==
Received: by 10.68.234.99 with SMTP id ud3mr17527122pbc.166.1346424324353;
        Fri, 31 Aug 2012 07:45:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.49.176])
        by mx.google.com with ESMTPS id gf3sm3559403pbc.74.2012.08.31.07.45.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 07:45:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 31 Aug 2012 21:38:56 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204586>

"git checkout foo" (no more arguments) always checks out existing
branch "foo" even if "foo" exists on working directory. To avoid
confusion to users who do not know this exception, say something along
the action.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Personally I disagree with the comment above the top chunk about
 stopping annoying users in this case. I think the annoyance is a good
 sign for them to rename their branches to something more sensible.

 builtin/checkout.c |  6 ++++--
 cache.h            |  2 ++
 setup.c            | 21 +++++++++++++++++----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d922c6..7bc4e8a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,8 +899,10 @@ static int parse_branchname_arg(int argc, const ch=
ar **argv,
 		 * even if there happen to be a file called 'branch';
 		 * it would be extremely annoying.
 		 */
-		if (argc)
-			verify_non_filename(NULL, arg);
+		const char *action =3D NULL;
+		if (!argc)
+			action =3D _("Checked out the new branch.");
+		verify_non_filename_gently(NULL, arg, action);
 	} else {
 		argcount++;
 		argv++;
diff --git a/cache.h b/cache.h
index 95daa69..95f11df 100644
--- a/cache.h
+++ b/cache.h
@@ -404,6 +404,8 @@ extern void verify_filename(const char *prefix,
 			    const char *name,
 			    int diagnose_misspelt_rev);
 extern void verify_non_filename(const char *prefix, const char *name);
+extern void verify_non_filename_gently(const char *prefix, const char =
*name,
+				       const char *preferred_action);
 extern int path_inside_repo(const char *prefix, const char *path);
=20
 #define INIT_DB_QUIET 0x0001
diff --git a/setup.c b/setup.c
index 3a1b2fd..4b776cf 100644
--- a/setup.c
+++ b/setup.c
@@ -133,7 +133,8 @@ void verify_filename(const char *prefix,
  * and we parsed the arg as a refname.  It should not be interpretable
  * as a filename.
  */
-void verify_non_filename(const char *prefix, const char *arg)
+void verify_non_filename_gently(const char *prefix, const char *arg,
+				const char *preferred_action)
 {
 	if (!is_inside_work_tree() || is_inside_git_dir())
 		return;
@@ -141,9 +142,21 @@ void verify_non_filename(const char *prefix, const=
 char *arg)
 		return; /* flag */
 	if (!check_filename(prefix, arg))
 		return;
-	die("ambiguous argument '%s': both revision and filename\n"
-	    "Use '--' to separate paths from revisions, like this:\n"
-	    "'git <command> [<revision>...] -- [<file>...]'", arg);
+	if (!preferred_action)
+		die(_("ambiguous argument '%s': both revision and filename\n"
+		      "Use '--' to separate paths from revisions, like this:\n"
+		      "'git <command> [<revision>...] -- [<file>...]'"), arg);
+	else {
+		warning(_("ambiguous argument '%s': both revision and filename\n"
+			  "Use '--' to separate paths from revisions, like this:\n"
+			  "'git <command> [<revision>...] -- [<file>...]'"), arg);
+		warning("%s", preferred_action);
+	}
+}
+
+void verify_non_filename(const char *prefix, const char *arg)
+{
+	verify_non_filename_gently(prefix, arg, NULL);
 }
=20
 /*
--=20
1.7.12.rc2.18.g61b472e
