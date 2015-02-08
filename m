From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/24] untracked cache: invalidate at index addition or removal
Date: Sun,  8 Feb 2015 15:55:36 +0700
Message-ID: <1423385748-19825-13-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNft-00030R-Md
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbbBHI5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:00 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34973 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbBHI47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:56:59 -0500
Received: by pdbfp1 with SMTP id fp1so24336447pdb.2
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LYO09zO3RidEsrMErSlr5xhmytNaiiUl+cA7+0iWGHA=;
        b=PUcBkSkJvlVQFIi5IkH9/zwBpt3R7F+CuN9T3TRnDYy2STkrcjXlHqYlNpiw1oZCKV
         PpNcuEuCIb0fW7arMqAvaElmbtWrrIJIzrAd+dlov6hN0IT3+tNVxXg++ZA1IT/H4ohP
         fNRBJZYAvS05fd0dOH7BztJZ/MiSAJpgzvsUUsdJC+iEF1ZviKyx+SvWLL8FNNSI9mVe
         Wa/i2jinif3fmc7ei+9KJiujzRyPyJruPOuL2nw9GvmmCjfpYv8hSBeTjhcy1/4JqIEu
         X+6SJoy9Jks9yLElhiasivy9sC0M74zhhYWWqDa6YAjPCF/BrXNCiO8AErY6Kpy4x+Cl
         Kqaw==
X-Received: by 10.70.10.100 with SMTP id h4mr19484274pdb.10.1423385819351;
        Sun, 08 Feb 2015 00:56:59 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id oj5sm12955752pdb.34.2015.02.08.00.56.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:56:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263474>

Ideally we should implement untracked_cache_remove_from_index() and
untracked_cache_add_to_index() so that they update untracked cache
right away instead of invalidating it and wait for read_directory()
next time to deal with it. But that may need some more work in
unpack-trees.c. So stay simple as the first step.

The new call in add_index_entry_with_check() may look strange because
new calls usually stay close to cache_tree_invalidate_path(). We do it
a bit later than c_t_i_p() in this function because if it's about
replacing the entry with the same name, we don't care (but cache-tree
does).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c          | 31 +++++++++++++++++++++++++++++++
 dir.h          |  4 ++++
 read-cache.c   |  4 ++++
 unpack-trees.c |  7 +++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index e7d7df3..30e23f8 100644
--- a/dir.c
+++ b/dir.c
@@ -2495,3 +2495,34 @@ done2:
 	}
 	return uc;
 }
+
+void untracked_cache_invalidate_path(struct index_state *istate,
+				     const char *path)
+{
+	const char *sep;
+	struct untracked_cache_dir *d;
+	if (!istate->untracked || !istate->untracked->root)
+		return;
+	sep =3D strrchr(path, '/');
+	if (sep)
+		d =3D lookup_untracked(istate->untracked,
+				     istate->untracked->root,
+				     path, sep - path);
+	else
+		d =3D istate->untracked->root;
+	istate->untracked->dir_invalidated++;
+	d->valid =3D 0;
+	d->untracked_nr =3D 0;
+}
+
+void untracked_cache_remove_from_index(struct index_state *istate,
+				       const char *path)
+{
+	untracked_cache_invalidate_path(istate, path);
+}
+
+void untracked_cache_add_to_index(struct index_state *istate,
+				  const char *path)
+{
+	untracked_cache_invalidate_path(istate, path);
+}
diff --git a/dir.h b/dir.h
index 40a679a..2ce7dd3 100644
--- a/dir.h
+++ b/dir.h
@@ -298,6 +298,10 @@ static inline int dir_path_match(const struct dir_=
entry *ent,
 			      has_trailing_dir);
 }
=20
+void untracked_cache_invalidate_path(struct index_state *, const char =
*);
+void untracked_cache_remove_from_index(struct index_state *, const cha=
r *);
+void untracked_cache_add_to_index(struct index_state *, const char *);
+
 void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, uns=
igned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
diff --git a/read-cache.c b/read-cache.c
index 3736a56..d643a3f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -78,6 +78,7 @@ void rename_index_entry_at(struct index_state *istate=
, int nr, const char *new_n
 	memcpy(new->name, new_name, namelen + 1);
=20
 	cache_tree_invalidate_path(istate, old->name);
+	untracked_cache_remove_from_index(istate, old->name);
 	remove_index_entry_at(istate, nr);
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPL=
ACE);
 }
@@ -537,6 +538,7 @@ int remove_file_from_index(struct index_state *ista=
te, const char *path)
 	if (pos < 0)
 		pos =3D -pos-1;
 	cache_tree_invalidate_path(istate, path);
+	untracked_cache_remove_from_index(istate, path);
 	while (pos < istate->cache_nr && !strcmp(istate->cache[pos]->name, pa=
th))
 		remove_index_entry_at(istate, pos);
 	return 0;
@@ -968,6 +970,8 @@ static int add_index_entry_with_check(struct index_=
state *istate, struct cache_e
 	}
 	pos =3D -pos-1;
=20
+	untracked_cache_add_to_index(istate, ce->name);
+
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
 	 * will always replace all non-merged entries..
diff --git a/unpack-trees.c b/unpack-trees.c
index 629c658..e5ddb0c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
+#include "dir.h"
=20
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1255,8 +1256,10 @@ static int verify_uptodate_sparse(const struct c=
ache_entry *ce,
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-	if (ce)
-		cache_tree_invalidate_path(o->src_index, ce->name);
+	if (!ce)
+		return;
+	cache_tree_invalidate_path(o->src_index, ce->name);
+	untracked_cache_invalidate_path(o->src_index, ce->name);
 }
=20
 /*
--=20
2.3.0.rc1.137.g477eb31
