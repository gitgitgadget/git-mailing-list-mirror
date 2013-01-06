From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/21] Convert refresh_index to take struct pathspec
Date: Sun,  6 Jan 2013 13:21:05 +0700
Message-ID: <1357453268-12543-19-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjdZ-0000c1-Li
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab3AFGWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:54 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:47883 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3AFGWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:53 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so8155845dad.27
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=aiQ+ZJWpTtpOgEzWc82qqbTSMJ0JlFeA7v1FW5L3jW8=;
        b=bFq0RbHdhSpV/KEPfU4j72slYQWqhdKI8wrizv95zxpYxM12XIBRq/bQUecE+TGsKx
         zJRrM2rVwUoXCghCyB5PlkFZ54Qq/bC1r9V2y+j2uycyBw6fYkq6Sr+Tk1lSRYOZLZi+
         lqmqUU6qJI/7ibc5YaybhK6QBjh2d+V5oH6aUgpnIUqsC/u0SYBeT71wsKG6pbjXYxE4
         r+7I5jLWKGE76jxZyQijrcqWoiUD7TyuIghfDyRn/s7YGRwpX6l2cI7ueYUHpb04LDkz
         YB4WN9B5X1qIRx2Gss6uDeGqvMlY5bQaHjpoT/mQ5TNXDkau1Yt4oTvG4eycpQgELiIz
         jDQQ==
X-Received: by 10.66.77.38 with SMTP id p6mr167614291paw.47.1357453371985;
        Sat, 05 Jan 2013 22:22:51 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id mt15sm35288055pbc.49.2013.01.05.22.22.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:23:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212772>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 14 ++++++--------
 builtin/commit.c |  2 +-
 builtin/rm.c     |  2 +-
 cache.h          |  2 +-
 read-cache.c     |  5 +++--
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index af36bc4..623f167 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -180,19 +180,17 @@ static void treat_gitlinks(const char **pathspec)
 	}
 }
=20
-static void refresh(int verbose, const char **pathspec)
+static void refresh(int verbose, const struct pathspec *pathspec)
 {
 	char *seen;
-	int i, specs;
+	int i;
=20
-	for (specs =3D 0; pathspec[specs];  specs++)
-		/* nothing */;
-	seen =3D xcalloc(specs, 1);
+	seen =3D xcalloc(pathspec->nr, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QU=
IET,
 		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
-	for (i =3D 0; i < specs; i++) {
+	for (i =3D 0; i < pathspec->nr; i++) {
 		if (!seen[i])
-			die(_("pathspec '%s' did not match any files"), pathspec[i]);
+			die(_("pathspec '%s' did not match any files"), pathspec->raw[i]);
 	}
         free(seen);
 }
@@ -437,7 +435,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 	if (refresh_only) {
-		refresh(verbose, pathspec.raw);
+		refresh(verbose, &pathspec);
 		goto finish;
 	}
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 71c5afb..193a37e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1208,7 +1208,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		parse_pathspec(&s.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
 	read_cache_preload(&s.pathspec);
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec.=
raw, NULL, NULL);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec=
, NULL, NULL);
=20
 	fd =3D hold_locked_index(&index_lock, 0);
 	if (0 <=3D fd)
diff --git a/builtin/rm.c b/builtin/rm.c
index d719d95..b5edde8 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -250,7 +250,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	}
=20
 	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
-	refresh_index(&the_index, REFRESH_QUIET, pathspec.raw, NULL, NULL);
+	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
=20
 	seen =3D NULL;
 	seen =3D xcalloc(pathspec.nr, 1);
diff --git a/cache.h b/cache.h
index 3c34ef5..41e1421 100644
--- a/cache.h
+++ b/cache.h
@@ -511,7 +511,7 @@ extern void fill_stat_cache_info(struct cache_entry=
 *ce, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "need=
s update" */
-extern int refresh_index(struct index_state *, unsigned int flags, con=
st char **pathspec, char *seen, const char *header_msg);
+extern int refresh_index(struct index_state *, unsigned int flags, con=
st struct pathspec *pathspec, char *seen, const char *header_msg);
=20
 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index fda78bc..dec2ba6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1093,7 +1093,8 @@ static void show_file(const char * fmt, const cha=
r * name, int in_porcelain,
 	printf(fmt, name);
 }
=20
-int refresh_index(struct index_state *istate, unsigned int flags, cons=
t char **pathspec,
+int refresh_index(struct index_state *istate, unsigned int flags,
+		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
 {
 	int i;
@@ -1128,7 +1129,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags, const char **p
 			continue;
=20
 		if (pathspec &&
-		    !match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
+		    !match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, see=
n))
 			filtered =3D 1;
=20
 		if (ce_stage(ce)) {
--=20
1.8.0.rc2.23.g1fb49df
