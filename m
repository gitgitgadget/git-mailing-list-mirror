From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/24] untracked cache: mark what dirs should be recursed/saved
Date: Tue, 20 Jan 2015 20:03:16 +0700
Message-ID: <1421759013-8494-8-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYTt-0003WN-Po
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbbATNEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:04:20 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61274 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbbATNES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:04:18 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so45567600pab.5
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ntzEKpDbO6Guu/oF6KLoxJabWRHPGIGIH1O94Yqc0vQ=;
        b=ILZxYYRdm1Hjx7m2MYE0gtIQh06PNUWOqw535sWENhATFvlTsv2WMais4gUBWyECwH
         SoS8lbH1uPuiePPFERRk1slzj1TjXJaAC7xPZlu4+SeZ2IR9uRmCKPFMG6KEDIH3uH2q
         493h7Jx/KAuV+qkKnwRJz1krLTKAuK1Ly57y/M38TAnS/guPBYemf2RmqI9In7ouymfH
         E7TS56kl5zQBajCEbBpc4+PBfMqCTfTaqmUPHxglfbxWarYkB9N/9PRS4DLqWYXB8Ld8
         phezmdd/C+vkgycpVRjvo1sRILhboaRy0wRpr1lFCm3zME1rAtABu41jQON+XJ5qBsBa
         kUzw==
X-Received: by 10.66.252.201 with SMTP id zu9mr53138589pac.123.1421759058159;
        Tue, 20 Jan 2015 05:04:18 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id cm10sm3215183pad.46.2015.01.20.05.04.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:04:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:04:28 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262660>

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
index 8c989e3..02cdc26 100644
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
@@ -1577,6 +1580,10 @@ static int read_cached_dir(struct cached_dir *cd=
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
@@ -1598,8 +1605,10 @@ static void close_cached_dir(struct cached_dir *=
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
@@ -1842,6 +1851,9 @@ static struct untracked_cache_dir *validate_untra=
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
2.2.0.84.ge9c7a8a
