From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gc: reject if another gc is running, unless --force is given
Date: Sat,  3 Aug 2013 11:20:05 +0700
Message-ID: <1375503605-32480-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 06:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5TJq-0005WP-Ta
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 06:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892Ab3HCETi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 00:19:38 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57751 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3HCETh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 00:19:37 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1365681pbc.35
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 21:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=J3h/UT2b8RkOXQmR7ErS7ud+Z/hr2WDyGpcpohxuYWU=;
        b=cWuPefgrjO8JYvCGz2+JFAXX4djHc0wfcPCah5RrhA1JJK4A0d/NFGVXv5QdAzn90Y
         MHbTzsFVtRk8QSwG3uT97sJ2fvIN1QF7hqQORrb9/CYu9lXinScFLqb5yYitbfV/kK2B
         tlCJslFmPkpxxR+J83BimqhKQUTwQzs/ROzuTtDAwxOkJoAT4FK/QWTPZu1PE+p8Prae
         MaowZ3RsTUeBHZQD5mz+3t81mWqyFQJFLwKctUAm+YrH9ugNJkz/RRp+Qerr10ebQ6EL
         4YJKh7SE+4JQGm9BCV2dYbOr9M3mvvElwgHWwHo0fHe5qJIutfGgvDEdc/ErISMjEBug
         FaMQ==
X-Received: by 10.66.13.99 with SMTP id g3mr9103816pac.51.1375503575926;
        Fri, 02 Aug 2013 21:19:35 -0700 (PDT)
Received: from lanh ([115.73.207.46])
        by mx.google.com with ESMTPSA id w8sm14052340pab.12.2013.08.02.21.19.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 21:19:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Aug 2013 11:20:09 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231558>

This may happen when `git gc --auto` is run automatically, then the
user, to avoid wait time, switches to a new terminal, keeps working
and `git gc --auto` is started again because the first gc instance has
not clean up the repository.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I don't know if the kill(pid, 0) trick works on Windows..

 Documentation/git-gc.txt |  6 +++++-
 builtin/gc.c             | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2402ed6..e158a3b 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the loc=
al repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-pr=
une]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-pr=
une] [--force]
=20
 DESCRIPTION
 -----------
@@ -72,6 +72,10 @@ automatic consolidation of packs.
 --quiet::
 	Suppress all progress reports.
=20
+--force::
+	Force `git gc` to run even if there may be another `git gc`
+	instance running on this repository.
+
 Configuration
 -------------
=20
diff --git a/builtin/gc.c b/builtin/gc.c
index 6be6c8d..07c566c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -169,9 +169,11 @@ static int need_to_gc(void)
=20
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
+	FILE *fp;
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
 	int quiet =3D 0;
+	int force =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -180,6 +182,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, N_("be more thorough (incr=
eased runtime)")),
 		OPT_BOOLEAN(0, "auto", &auto_gc, N_("enable auto-gc mode")),
+		OPT_BOOL(0, "force", &force, N_("force running gc even if there may =
be another gc running")),
 		OPT_END()
 	};
=20
@@ -225,6 +228,21 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 	} else
 		add_repack_all_option();
=20
+	if (!force && (fp =3D fopen(git_path("gc.pid"), "r")) !=3D NULL) {
+		uintmax_t pid;
+		if (fscanf(fp, "%"PRIuMAX, &pid) =3D=3D 1 && !kill(pid, 0)) {
+			if (auto_gc)
+				return 0; /* be quiet on --auto */
+			die(_("gc is already running"));
+		}
+		fclose(fp);
+	}
+
+	if ((fp =3D fopen(git_path("gc.pid"), "w")) !=3D NULL) {
+		fprintf(fp, "%"PRIuMAX"\n", (uintmax_t) getpid());
+		fclose(fp);
+	}
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
=20
--=20
1.8.2.83.gc99314b
