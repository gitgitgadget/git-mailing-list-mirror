From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/21] archive: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:20:59 +0700
Message-ID: <1357453268-12543-13-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjd2-0008Va-RI
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab3AFGWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:20 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42415 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3AFGWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:19 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so10085269pad.9
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SJaKkUa9112SFERwBaGO8lg7QkoMGWJqjJsN+1RvxBE=;
        b=YbNgvD9UjU8JKZKB8IvS5RzfdiZBfMCs+XfjrvxqeVTeLq7unCitsdc7eYHs1ZdZII
         q4TUu6eg2PxYZfscWswV21gwmODGe62zCChjzWat8b4HMObQUDShhKJneyNw0m3Izzn7
         5ZoV0e281fEzQ0MEqNkwLj92IG2F4wpAW7b3Xj9xYckSIWlk25cLk0xOsUvJgOGeAZoP
         YW11mO+YKTAbzq3AN+bKCAGydDjJ/kkFjXU1BsSejVFtRlMqhHnIrCt3jBtc6Z1TfetE
         1XzK9gXcim/2rTEChHYUPN5RzpwS9ACl41yDFP7Ko8yeVEIc3T/zan423BFfjELYfM5f
         ep8w==
X-Received: by 10.68.232.71 with SMTP id tm7mr176965939pbc.118.1357453338504;
        Sat, 05 Jan 2013 22:22:18 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id rs7sm35299701pbc.2.2013.01.05.22.22.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:28 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212766>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c | 10 ++++------
 archive.h |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index 4666404..530badb 100644
--- a/archive.c
+++ b/archive.c
@@ -150,7 +150,6 @@ int write_archive_entries(struct archiver_args *arg=
s,
 	struct archiver_context context;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
-	struct pathspec pathspec;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -185,10 +184,8 @@ int write_archive_entries(struct archiver_args *ar=
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
@@ -230,8 +227,9 @@ static int path_exists(struct tree *tree, const cha=
r *path)
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec);
-	if (pathspec) {
+	parse_pathspec(&ar_args->pathspec, PATHSPEC_FROMTOP, 0, "", pathspec)=
;
+	if (ar_args->pathspec.nr) {
+		pathspec =3D ar_args->pathspec.raw;
 		while (*pathspec) {
 			if (!path_exists(ar_args->tree, *pathspec))
 				die("path not found: %s", *pathspec);
diff --git a/archive.h b/archive.h
index 895afcd..a98c49e 100644
--- a/archive.h
+++ b/archive.h
@@ -8,7 +8,7 @@ struct archiver_args {
 	const unsigned char *commit_sha1;
 	const struct commit *commit;
 	time_t time;
-	const char **pathspec;
+	struct pathspec pathspec;
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
--=20
1.8.0.rc2.23.g1fb49df
