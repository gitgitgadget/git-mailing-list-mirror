From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 31/46] Convert refresh_index to take struct pathspec
Date: Sun, 14 Jul 2013 15:35:54 +0700
Message-ID: <1373790969-13000-32-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHq1-0002yH-CB
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab3GNIjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:39:21 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:37074 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3GNIjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:39:20 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so10378793pbc.15
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7DuvmSbI8DrIP3XSxPDjIiI3lXiREmkIDS3nuHGNTHI=;
        b=SbdpJ8K6A0eQKPtF5NecQRzqVtuTXaI+8cAhj7FC5g5RwA/DOW49ViHxOV/2nQvvqc
         ncv7c2BHvpmiWj65/qBhpkm8r5Z6WOegdwwPbjalwGb5WMkEfSJjeIKBLAJgKQwUYd0M
         84phlz3zYnfte4hL4tLw+aGIHBmmuhYeYDSFC5GYDYHtRGaO8Lko/8jpj2mCpTOqwS07
         FT6mIsYtVcfKD6Ap+zJ4nJkGOHopxHDk37p6RpOt0rVE8hDzLDXOeMCdDM75YDiJ64p9
         hNf5NjlR/WEXhnDRgfstOFcbbqQKLVPyHohTzkkFoPQXdwggbmAi9JsuYdSTwPqm8mDj
         fNzg==
X-Received: by 10.66.161.166 with SMTP id xt6mr51133462pab.87.1373791159832;
        Sun, 14 Jul 2013 01:39:19 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id sz6sm57847604pab.5.2013.07.14.01.39.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:39:31 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230343>


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
index d039fc9..f5d6a33 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -226,19 +226,18 @@ static char *prune_directory(struct dir_struct *d=
ir, const char **pathspec,
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
@@ -524,7 +523,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 	if (refresh_only) {
-		refresh(verbose, pathspec.raw);
+		refresh(verbose, &pathspec);
 		goto finish;
 	}
 	if (implicit_dot && prefix)
diff --git a/builtin/commit.c b/builtin/commit.c
index eaecf7c..d34baab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1244,7 +1244,7 @@ int cmd_status(int argc, const char **argv, const=
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
index ee0ae4c..f08561d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -314,7 +314,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	}
=20
 	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
-	refresh_index(&the_index, REFRESH_QUIET, pathspec.raw, NULL, NULL);
+	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
=20
 	seen =3D NULL;
 	seen =3D xcalloc(pathspec.nr, 1);
diff --git a/cache.h b/cache.h
index 42c9920..b294277 100644
--- a/cache.h
+++ b/cache.h
@@ -520,7 +520,7 @@ extern void fill_stat_cache_info(struct cache_entry=
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
index d5201f9..6ad2ff6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1114,7 +1114,8 @@ static void show_file(const char * fmt, const cha=
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
@@ -1149,7 +1150,7 @@ int refresh_index(struct index_state *istate, uns=
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
1.8.2.83.gc99314b
