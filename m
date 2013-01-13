From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/31] archive: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:24 +0700
Message-ID: <1358080539-17436-17-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:37:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMp1-0007D0-VX
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab3AMMhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:36 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64438 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab3AMMhf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:35 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so1691787pbc.14
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=B05O5RqXBx/H7f8XmBhsfAEPTQikDA1RNowD5ZPxz1s=;
        b=0cibBcu/h3KBmOnygWsKJ6aMxhe0HEivQ0BJtWp78tL+pDMxE2Lx0UkVh/dLz3B8zw
         pqOhJcOJ5Qy9HbpGiEeO7hbLITnhS5xy24SW2YNPWdx8hPTi0szqFWviatUY0F6Rt+QK
         SaU5uiYgofCthRWX6VEMXX2jrisfrvc+fD5bRYo91mysTAx1UImPX/ZOMFRRM0f0S49x
         DczyRLWhSqzTphq0vwFx3V2dEldlX4I4JrKN1i72NDBBioIDqg4E8if8q8T8aWd9X5z3
         RJ9RRBJLDblKQQHQFkrr1IJvnHme1W2uck9qbntmau8wGpqGppIvKY6+RXy80p8zSu1g
         axZQ==
X-Received: by 10.66.82.162 with SMTP id j2mr223333790pay.13.1358080654917;
        Sun, 13 Jan 2013 04:37:34 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id ai8sm6294325pbd.14.2013.01.13.04.37.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:37:45 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213356>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c | 16 ++++++++++------
 archive.h |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index 93e00bb..f1a28c9 100644
--- a/archive.c
+++ b/archive.c
@@ -151,7 +151,6 @@ int write_archive_entries(struct archiver_args *arg=
s,
 	struct archiver_context context;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
-	struct pathspec pathspec;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -186,10 +185,8 @@ int write_archive_entries(struct archiver_args *ar=
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
@@ -231,8 +228,15 @@ static int path_exists(struct tree *tree, const ch=
ar *path)
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec);
-	if (pathspec) {
+	/*
+	 * raw[] is used to check for unused pathspec. This is
+	 * tree_entry_interesting's limitation because it does not
+	 * mark "used" pathspec. The magic mask cannot be lifted until
+	 * it does.
+	 */
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
