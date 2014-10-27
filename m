From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/19] untracked cache: mark what dirs should be recursed/saved
Date: Mon, 27 Oct 2014 19:10:34 +0700
Message-ID: <1414411846-4450-8-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8x-0002pZ-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbaJ0MLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:24 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33041 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbaJ0MLV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:21 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so5563117pdj.10
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=imoVumBL9j4/ZhSMkUHvXwYbLSXQ/IVpibjUgylWsbI=;
        b=ZkHVhZac+R3IQ6u7kH/jXyhJjHDoGr9JJQnrfOKumHK4uZXewTbqpRwIZ74Md7OK81
         KcrNKVbeU9LpWFC2xHUarTxrJ+odPdSwHjlsYEVAubdafBc3vZDHzEUxzH4vNPsTyW4H
         w28H3K0+Hz1fOl6wuvCIZIFIybe3tC5q/JF4AOhKj8Zga0LHEx3VOrKWY3Tq1gpvkDRE
         3Mx/JI114RYiwzoYcbo9AQm7/OgIWuEQ2A1m4xxAHdyxAKewd2fvbbAHexWbaYE879yr
         NeUxK9NRU+bei9NcCQM96pg/vbZQRpKrLcVlGohKpd+xH/JsdOa1kXZKKmq2kQLwVqR+
         /Ovg==
X-Received: by 10.66.184.76 with SMTP id es12mr23336206pac.3.1414411881388;
        Mon, 27 Oct 2014 05:11:21 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id ez4sm10776452pab.36.2014.10.27.05.11.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:24 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 dir.c | 14 +++++++++++++-
 dir.h |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 55780a7..d9675c8 100644
--- a/dir.c
+++ b/dir.c
@@ -614,9 +614,12 @@ static void invalidate_gitignore(struct untracked_=
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
@@ -1573,6 +1576,10 @@ int read_cached_dir(struct cached_dir *cdir)
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
@@ -1594,8 +1601,10 @@ static void close_cached_dir(struct cached_dir *=
cdir)
 	 * We have gone through this directory and found no untracked
 	 * entries. Mark it valid.
 	 */
-	if (cdir->untracked && !cdir->untracked->valid)
+	if (cdir->untracked) {
 		cdir->untracked->valid =3D 1;
+		cdir->untracked->recurse =3D 1;
+	}
 }
=20
 /*
@@ -1838,6 +1847,9 @@ static struct untracked_cache_dir *validate_untra=
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
index 1fefd4e..c302dcb 100644
--- a/dir.h
+++ b/dir.h
@@ -113,8 +113,9 @@ struct untracked_cache_dir {
 	/* null SHA-1 means this directory does not have .gitignore */
 	unsigned char exclude_sha1[20];
 	struct stat_data stat_data;
+	unsigned int recurse : 1;
 	unsigned int check_only : 1;
-	/* all data in this struct are good */
+	/* all data except 'dirs' in this struct are good */
 	unsigned int valid : 1;
 	unsigned int untracked_nr : 29;
 	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
--=20
2.1.0.rc0.78.gc0d8480
