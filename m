From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/45] Convert refresh_index to take struct pathspec
Date: Sun,  9 Jun 2013 13:26:04 +0700
Message-ID: <1370759178-1709-32-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ6t-0001NC-0Z
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3FIG2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:10 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47817 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3FIG2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:09 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so1417478pbc.3
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4gtDb5ZV4mE9T0//1aDqTzMdlSquyJBtDcwM6pnATc8=;
        b=W42uq0N4erbfsFHgvp/uMiv2hCX+ABMABURKvMMvwiijlYHvAn/knYQB/7Yxr3w5F/
         EUws5Ix4aODfgH8AALNDyL0J4m+dTnAOveupvSULLKSfMooHgq4XeFTEImjRO/HnWLeL
         i3NoxFmrAcyclmz4929Mug3TwR2TcE7wUPfZeZjQvyoxjsmNRVR0uzT71dfQsps4TzNP
         t62ZUdAhRkgnQ/2IZHaozEQixOH4msFNUeKUnE/gUkvvUnx/DeDjaJ30cwwXYo2HAZbU
         ED5rtPEC7nVhJOUYjNtpvj6SMgpA+MpyWqFQvw5e9di7R5VZcV/3yEm2CY5oM65QE1vI
         5l1g==
X-Received: by 10.66.67.5 with SMTP id j5mr9149511pat.176.1370759288598;
        Sat, 08 Jun 2013 23:28:08 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id pb5sm5514087pbc.29.2013.06.08.23.28.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:39 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226923>


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
index e5a3bb5..56bc7be 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1200,7 +1200,7 @@ int cmd_status(int argc, const char **argv, const=
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
index 0b38de3..9afc1c5 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -251,7 +251,7 @@ int cmd_rm(int argc, const char **argv, const char =
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
index f978e88..25410b9 100644
--- a/cache.h
+++ b/cache.h
@@ -499,7 +499,7 @@ extern void fill_stat_cache_info(struct cache_entry=
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
index 04ed561..27bbc35 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1097,7 +1097,8 @@ static void show_file(const char * fmt, const cha=
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
@@ -1132,7 +1133,7 @@ int refresh_index(struct index_state *istate, uns=
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
