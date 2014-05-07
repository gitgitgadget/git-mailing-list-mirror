From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/20] untracked cache: mark what dirs should be recursed/saved
Date: Wed,  7 May 2014 21:51:49 +0700
Message-ID: <1399474320-6840-10-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3DN-0005uW-M4
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbaEGOww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:52 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56080 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbaEGOww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:52 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1293266pab.36
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rcGKJt1XsmBASNIYmfp7/8vYMcBLe4194fOovtT9iXM=;
        b=EDpgSGdOYzGsRJSr0KKnmC9x242w/JzfAS00efcX2EbANZ5e8vNzS9RPG3LLtnVu91
         AIkhRQiygyo1zYE9dt4pZr7CRDJI2QD6zK+xEPbZ0W1oi/TBiDGVcpaChqIB5iJOwgMJ
         UW7c/x/GU/JdiwnE+K42I/WLtby38Kf2tB7K1+4z6BFgDIFpJKxPDsfIYlbJDb39LIrx
         I/8SvciCGG029Euvd0rOJBNZBXN9y5LDF0e6daolj7q35dWqW8eUXLdnQZFdwZAdfn5R
         hC35p/we1hqSvzRoqx6tvpD4Lb8rwT6KNbB7fAXPyCv9f78azE4iCJNVV6y8l9FImyb3
         s1Rw==
X-Received: by 10.66.148.230 with SMTP id tv6mr19750051pab.155.1399474371617;
        Wed, 07 May 2014 07:52:51 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id ov4sm3647391pbc.46.2014.05.07.07.52.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:51 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248315>

Suppose untracked cache stores that in directory A we need to recurse
in A/B and A/C. Then A/B is removed. When read_directory() is executed
again, of course we detect that we only need to recurse in A/C when in
A, not A/B any more.

We need a way though to let the write phase know not to write A/B
down. Which is the purpose of this bit. We can't simply destroy A/B
when A is invalidated, because at that moment we don't know if A/B is
deleted or not.
---
 dir.c | 15 ++++++++++++++-
 dir.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 205f323..63fa960 100644
--- a/dir.c
+++ b/dir.c
@@ -591,6 +591,7 @@ static void do_invalidate_gitignore(struct untracked_cache_dir *dir)
 	int i;
 	dir->valid = 0;
 	dir->untracked_nr = 0;
+	/* dir->recurse = 0; ? */
 	for (i = 0; i < dir->dirs_nr; i++)
 		do_invalidate_gitignore(dir->dirs[i]);
 }
@@ -605,9 +606,12 @@ static void invalidate_gitignore(struct untracked_cache *uc,
 static void invalidate_directory(struct untracked_cache *uc,
 				 struct untracked_cache_dir *dir)
 {
+	int i;
 	uc->dir_invalidated++;
 	dir->valid = 0;
 	dir->untracked_nr = 0;
+	for (i = 0; i < dir->dirs_nr; i++)
+		dir->dirs[i]->recurse = 0;
 }
 
 static int add_excludes(const char *fname,
@@ -1581,6 +1585,10 @@ int read_cached_dir(struct cached_dir *cdir)
 	}
 	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
 		struct untracked_cache_dir *d = cdir->untracked->dirs[cdir->nr_dirs];
+		if (!d->recurse) {
+			cdir->nr_dirs++;
+			continue;
+		}
 		cdir->ucd = d;
 		cdir->nr_dirs++;
 		return 0;
@@ -1602,8 +1610,10 @@ static void close_cached_dir(struct cached_dir *cdir)
 	 * We have gone through this directory and found no untracked
 	 * entries. Set untracked_nr to zero to make it valid.
 	 */
-	if (cdir->untracked && !cdir->untracked->valid)
+	if (cdir->untracked) {
 		cdir->untracked->valid = 1;
+		cdir->untracked->recurse = 1;
+	}
 }
 
 /*
@@ -1849,6 +1859,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		hashcpy(dir->untracked->excludes_file_sha1,
 			dir->excludes_file_sha1);
 	}
+
+	/* Make sure this directory is not dropped out at saving phase */
+	root->recurse = 1;
 	return root;
 }
 
diff --git a/dir.h b/dir.h
index 8955945..5dde37b 100644
--- a/dir.h
+++ b/dir.h
@@ -108,6 +108,7 @@ struct untracked_cache_dir {
 	/* null SHA-1 means this directory does not have .gitignore */
 	unsigned char exclude_sha1[20];
 	struct stat_data stat_data;
+	unsigned int recurse : 1;
 	unsigned int check_only : 1;
 	unsigned int valid : 1;
 	unsigned int untracked_nr : 29;
-- 
1.9.1.346.ga2b5940
