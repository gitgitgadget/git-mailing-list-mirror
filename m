From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/24] untracked cache: mark what dirs should be recursed/saved
Date: Sun,  8 Mar 2015 17:12:30 +0700
Message-ID: <1425809567-25518-8-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYDY-0002v0-Ec
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbbCHKNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:13:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40433 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbbCHKNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:13:47 -0400
Received: by padfb1 with SMTP id fb1so55491418pad.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NFGlq907lMKFfv+rGnLdE0YHjujT0V1Gg35/qGTZAoo=;
        b=RsNAr43nLFZR9ku6i4bfI6Cm0+8GOIu0qUVbv6AtdzvAn6eoGktoCUJP4PD3F1T5e4
         dYqIqoTu7/v0nSgdS340ZQMEzTGMEANCK86dI0eMzQYTJx31vRAIZVf7OYrXl9GAIhVa
         jrrKKYD3yb07bINlZ2ct8D+ChwGj5dgpKYvddgH6GOHcXBE5F8CKBiuWtxfK97N4m+bg
         EknGLRlXabFMMxohJVyCNXkGd92E8CYfhOnggezZNXoa8DU60LJSz9Yht+M258wS19VH
         FaF0vFMgDWECB2KypnY7jiQwrhWpzTknwNhB+SKxjS1kxUp3EtctD9k8iOQzjMX/NDTt
         7xBw==
X-Received: by 10.66.187.237 with SMTP id fv13mr41923147pac.48.1425809627292;
        Sun, 08 Mar 2015 03:13:47 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id ki2sm14424541pdb.33.2015.03.08.03.13.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:13:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:13:42 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265061>

If we redo this thing in a functional style, we would have one struct
untracked_dir as input tree and another as output. The input is used
for verification. The output is a brand new tree, reflecting current
worktree.

But that means recreate a lot of dir nodes even if a lot could be
shared between input and output trees in good cases. So we go with the
messy but efficient way, combining both input and output trees into
one. We need a way to know which node in this combined tree belongs to
the output. This is the purpose of this "recurse" flag.

"valid" bit can't be used for this because it's about data of the node
except the subdirs. When we invalidate a directory, we want to keep
cached data of the subdirs intact even though we don't really know
what subdir still exists (yet). Then we check worktree to see what
actual subdir remains on disk. Those will have 'recurse' bit set
again. If cached data for those are still valid, we may be able to
avoid computing exclude files for them. Those subdirs that are deleted
will have 'recurse' remained clear and their 'valid' bits do not
matter.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 14 +++++++++++++-
 dir.h |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 9bbe122..9642332 100644
--- a/dir.c
+++ b/dir.c
@@ -615,9 +615,12 @@ static void invalidate_gitignore(struct untracked_=
cache *uc,
 static void invalidate_directory(struct untracked_cache *uc,
 				 struct untracked_cache_dir *dir)
 {
+	int i;
 	uc->dir_invalidated++;
 	dir->valid =3D 0;
 	dir->untracked_nr =3D 0;
+	for (i =3D 0; i < dir->dirs_nr; i++)
+		dir->dirs[i]->recurse =3D 0;
 }
=20
 /*
@@ -1578,6 +1581,10 @@ static int read_cached_dir(struct cached_dir *cd=
ir)
 	}
 	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
 		struct untracked_cache_dir *d =3D cdir->untracked->dirs[cdir->nr_dir=
s];
+		if (!d->recurse) {
+			cdir->nr_dirs++;
+			continue;
+		}
 		cdir->ucd =3D d;
 		cdir->nr_dirs++;
 		return 0;
@@ -1599,8 +1606,10 @@ static void close_cached_dir(struct cached_dir *=
cdir)
 	 * We have gone through this directory and found no untracked
 	 * entries. Mark it valid.
 	 */
-	if (cdir->untracked)
+	if (cdir->untracked) {
 		cdir->untracked->valid =3D 1;
+		cdir->untracked->recurse =3D 1;
+	}
 }
=20
 /*
@@ -1843,6 +1852,9 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_excludes_file =3D dir->ss_excludes_file;
 	}
+
+	/* Make sure this directory is not dropped out at saving phase */
+	root->recurse =3D 1;
 	return root;
 }
=20
diff --git a/dir.h b/dir.h
index ff3d99b..95baf01 100644
--- a/dir.h
+++ b/dir.h
@@ -115,8 +115,9 @@ struct untracked_cache_dir {
 	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
 	unsigned int untracked_nr;
 	unsigned int check_only : 1;
-	/* all data in this struct are good */
+	/* all data except 'dirs' in this struct are good */
 	unsigned int valid : 1;
+	unsigned int recurse : 1;
 	/* null SHA-1 means this directory does not have .gitignore */
 	unsigned char exclude_sha1[20];
 	char name[FLEX_ARRAY];
--=20
2.3.0.rc1.137.g477eb31
