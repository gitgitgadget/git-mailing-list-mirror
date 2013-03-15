From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 22/45] archive: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:37 +0700
Message-ID: <1363327620-29017-23-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO6V-0005xk-1m
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab3COG0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:32 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51538 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab3COG0b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:31 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so3955237iea.21
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ShBM0ocySlOkWzDgLYm4O3DVaAL87Davb8nuYCVRCfY=;
        b=X2oyKLsaaGU/I8kz/yPn0XUsA4/VwfD+gjCyDRv0jRgJA0UkUxQgT7SefYawbdQK5R
         EVMkRhcJ5nF/ufir9UU5bunnKCQ2XXP9ePnlRZq6jlKgQcWGwotQTPF6Ayi6vXFXxGXZ
         0BB4L6xWCiRPSzaqC8XgvXm89h4u+QCB0kILluRLMxxEDM7SvGbEe6phJ5Nc2Ltg8qs9
         rvBHBI6dKkrJ83jD1oqk6o0gcTucu/oFnovyHbhRC7kbdtr+PUTeZ28IoYRn5FUnaBv2
         vDGUano3BkJuXcxn8cHIlbsO4kMGQ1VG8hVxckicyG5CxiGhRsw/tS+OuwI0aONqrjAC
         S5Xw==
X-Received: by 10.50.195.231 with SMTP id ih7mr478985igc.55.1363328791400;
        Thu, 14 Mar 2013 23:26:31 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id xc3sm605573igb.10.2013.03.14.23.26.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:30 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:33 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218209>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c | 19 +++++++++++--------
 archive.h |  4 +++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 72c6b0f..95cd174 100644
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
 			if (!path_exists(ar_args->tree, *pathspec))
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
1.8.0.rc0.19.g7bbb31d
