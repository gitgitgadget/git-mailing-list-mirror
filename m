From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 31/45] Convert refresh_index to take struct pathspec
Date: Fri, 15 Mar 2013 13:06:46 +0700
Message-ID: <1363327620-29017-32-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7Z-00077M-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3COG1j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:39 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:57713 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab3COG1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:38 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so2935786iae.11
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RLzaQdEcdTqBzSuqod7pIOch1jvC5YWT4pGH58qD/CY=;
        b=C+iRktHptXvP/9Hkj95yTPo55zQU3dmOmifXykP4SQRQbp/z/l+UUgTMOaex5tUCzR
         Qfnj6tAdrsSNRQCOGd2XLUqwuWSjvACJrTH4diayJC/D97RdT1rPTQMZNFLLFlPhJ670
         TpkNDVHRlUogaQnpKeOLCa6PrZj44dMYah/t/JhVIPoqyBqSnq8VfeGkePB0X4APyJrq
         VlW0wdgUBLHruViUynCb1ka3fcvosAGwlANGH6qzKEi7v86u25oGMkOvHymxHG7HKcPr
         wv1YzGXR6DNG9Bs3r0XPJ3/IOfMZr4E9hGp3Eaq2xzvp+L3h75s9i0Wd6+got/Fv/A2X
         Sy1Q==
X-Received: by 10.50.197.170 with SMTP id iv10mr411780igc.62.1363328857528;
        Thu, 14 Mar 2013 23:27:37 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ua6sm634145igb.0.2013.03.14.23.27.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:36 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:40 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218218>


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
index 2b20d7d..cae002d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -121,19 +121,18 @@ static char *prune_directory(struct dir_struct *d=
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
@@ -412,7 +411,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index eba53af..75ce807 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1198,7 +1198,7 @@ int cmd_status(int argc, const char **argv, const=
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
index eb1b745..b84d6c7 100644
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
index e5c3e26..26d0f98 100644
--- a/cache.h
+++ b/cache.h
@@ -490,7 +490,7 @@ extern void fill_stat_cache_info(struct cache_entry=
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
index 827ae55..9715af0 100644
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
1.8.0.rc0.19.g7bbb31d
