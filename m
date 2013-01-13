From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/31] Convert refresh_index to take struct pathspec
Date: Sun, 13 Jan 2013 19:35:31 +0700
Message-ID: <1358080539-17436-24-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMpq-00083W-2S
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab3AMMi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:26 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45254 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab3AMMiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:25 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so1701397pbc.36
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ZcGjKb7Xn14XetJz20cm3bYN2MHIDMSUKFsibegdPT4=;
        b=wlAAXxiS3Oo2Y5gBFpk7WxOvKF1VxPGxfU789Mr34duPpsjxQRMgtLRPm9xWGHzF2W
         8YM2rrAs8iZbJl0+ua6sK4bdarPx2QYG1tVk9mWZsjHfcgYRco+nD63qVSmr8O6h7SRj
         QuW7Gcz/u5nCREp3mBtNdeZMtg5rIWMInkF2f+X4NYTYqjNYCP0XRpJZh0l7WUM1sJD8
         vWmKSY7zNz1uNLi4v5+i4sKK14jW86aXQNc5apBsYnZbOuKDY/Maqb/Z36X1YP71elEd
         0mhd+V+TdwsPP1XQFqtGhahfTLY9u9DYoPrA0ypV14n/fmEcgXDbaqd2zt9z6L0Zj5BC
         gITw==
X-Received: by 10.68.136.163 with SMTP id qb3mr244568759pbb.129.1358080704714;
        Sun, 13 Jan 2013 04:38:24 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id nt5sm6287262pbb.59.2013.01.13.04.38.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:39 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213363>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c    | 15 +++++++--------
 builtin/commit.c |  2 +-
 builtin/rm.c     |  2 +-
 cache.h          |  2 +-
 read-cache.c     |  5 +++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 22076ff..7069b77 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -153,19 +153,18 @@ static char *prune_directory(struct dir_struct *d=
ir, const char **pathspec, int
 	return seen;
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
+			die(_("pathspec '%s' did not match any files"),
+			    pathspec->items[i].match);
 	}
         free(seen);
 }
@@ -404,7 +403,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index 8777c19..2fe6054 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1208,7 +1208,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		       prefix, argv);
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
index 1a2c932..b2a99c2 100644
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
index f3be326..803cfeb 100644
--- a/cache.h
+++ b/cache.h
@@ -533,7 +533,7 @@ extern void fill_stat_cache_info(struct cache_entry=
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
