From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/45] archive: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:54 +0700
Message-ID: <1370759178-1709-22-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5s-0000lA-GC
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3FIG1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:07 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37577 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3FIG1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:06 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2729972pdj.31
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UTE0ij/my7zbrferiSqqGtB6hMB3tuyrpFklqZ3m+Ek=;
        b=utiRV1N8W50ZyIVhdK3iBok9LepRx+M4G6sIbrTFSoxND2UMPoKZvGV4j51rkKHqjO
         fxiJ9fDbXzb9SsBK/Q79uzvnFYkBpJhrvTdbQ8bWKWInmnY8JnEoc5hz1014zk/9zey6
         +wzwWypwsBgMRI4W3W5mlg7RxzJ6ucYxGslvGS+H5AuHV0SPs8g8OSunr1Qk9R5WUH5t
         htfZwB8EW2LN5gPGTxOiO7jEz/i40hC+G3e/GsIsvFkigSrHG/JhXoTEN25f/F+hn+OL
         3hqdFZCPUjmXaBu99iCUj45UZFUysyr0AgWNjotggCfztL8FlVS6qaE7ZcRFeamDysJn
         lWEA==
X-Received: by 10.66.72.41 with SMTP id a9mr9285711pav.133.1370759225974;
        Sat, 08 Jun 2013 23:27:05 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id qi1sm10201256pac.21.2013.06.08.23.27.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226913>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c | 19 +++++++++++--------
 archive.h |  4 +++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index c699a2d..99fadc8 100644
--- a/archive.c
+++ b/archive.c
@@ -5,7 +5,6 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
-#include "pathspec.h"
=20
 static char const * const archive_usage[] =3D {
 	N_("git archive [options] <tree-ish> [<path>...]"),
@@ -152,7 +151,6 @@ int write_archive_entries(struct archiver_args *arg=
s,
 	struct archiver_context context;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
-	struct pathspec pathspec;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -187,10 +185,8 @@ int write_archive_entries(struct archiver_args *ar=
gs,
 		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
 	}
=20
-	init_pathspec(&pathspec, args->pathspec);
-	err =3D read_tree_recursive(args->tree, "", 0, 0, &pathspec,
+	err =3D read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
 				  write_archive_entry, &context);
-	free_pathspec(&pathspec);
 	if (err =3D=3D READ_TREE_RECURSIVE)
 		err =3D 0;
 	return err;
@@ -223,7 +219,7 @@ static int path_exists(struct tree *tree, const cha=
r *path)
 	struct pathspec pathspec;
 	int ret;
=20
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, 0, 0, "", paths);
 	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, =
NULL);
 	free_pathspec(&pathspec);
 	return ret !=3D 0;
@@ -232,11 +228,18 @@ static int path_exists(struct tree *tree, const c=
har *path)
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec);
+	/*
+	 * must be consistent with parse_pathspec in path_exists()
+	 * Also if pathspec patterns are dependent, we're in big
+	 * trouble as we test each one separately
+	 */
+	parse_pathspec(&ar_args->pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
+		       "", pathspec);
 	if (pathspec) {
 		while (*pathspec) {
 			if (**pathspec && !path_exists(ar_args->tree, *pathspec))
-				die("path not found: %s", *pathspec);
+				die(_("pathspec '%s' did not match any files"), *pathspec);
 			pathspec++;
 		}
 	}
diff --git a/archive.h b/archive.h
index 895afcd..4a791e1 100644
--- a/archive.h
+++ b/archive.h
@@ -1,6 +1,8 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
=20
+#include "pathspec.h"
+
 struct archiver_args {
 	const char *base;
 	size_t baselen;
@@ -8,7 +10,7 @@ struct archiver_args {
 	const unsigned char *commit_sha1;
 	const struct commit *commit;
 	time_t time;
-	const char **pathspec;
+	struct pathspec pathspec;
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
--=20
1.8.2.83.gc99314b
