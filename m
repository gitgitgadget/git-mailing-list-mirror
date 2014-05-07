From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/20] untracked cache: invalidate at index addition or removal
Date: Wed,  7 May 2014 21:51:53 +0700
Message-ID: <1399474320-6840-14-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Dx-0006HP-JM
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbaEGOxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:15 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49333 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaEGOxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:13 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1301598pad.9
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrdaKrvvV7UjBo0vH98H/op5fAvTDCf+1lIzr0JpABA=;
        b=L94hLJjYd+Df9TzXSO9vpIxQgKXmZH4dPeAnIaursSIeAS9FMMgvOv3oFbUTYkKDb4
         FLsEUl6qXfWVDtQKiOBmC4jpz3hTo6W9KRON2NAJM+jOsyPHlHf9U0PBN4+16JuYVHqf
         hCLk99yPa+AYxiVmo3+MfoyJIa6fkvrG5hn0ha3WULhffEI6YdiYs171a1/xpnjbHtDK
         7xbYMougun+KezMYE+Up3UWpZcx0yziRQvWIUQvKLckgDToxISC7R7OzpfvsSfTpe5ji
         RtjzXoiC/wsvT/+50oeq2HbftxLec+RUgGj204KYRGyvw786kXnC6ozdcA9N9Lg+UpOp
         wnQg==
X-Received: by 10.66.124.163 with SMTP id mj3mr19862966pab.38.1399474392643;
        Wed, 07 May 2014 07:53:12 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id ir10sm3642185pbc.59.2014.05.07.07.53.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:13 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248320>

Ideally we should replace untracked_cache_invalidate_path() with
untracked_cache_remove_from_index() and untracked_cache_add_to_index(),
and the two last functions will update untracked cache right away
instead of invalidating it and wait for read_directory() next time to
deal with it. But that may need some more work in unpack-trees.c. So
stay simple as the first step.
---
 dir.c          | 31 +++++++++++++++++++++++++++++++
 dir.h          |  4 ++++
 read-cache.c   |  4 ++++
 unpack-trees.c |  7 +++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 3c61b42..18fe44c 100644
--- a/dir.c
+++ b/dir.c
@@ -2363,3 +2363,34 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	free(uc);
 	return NULL;
 }
+
+void untracked_cache_invalidate_path(struct index_state *istate,
+				     const char *path)
+{
+	const char *sep;
+	struct untracked_cache_dir *d;
+	if (!istate->untracked || !istate->untracked->root)
+		return;
+	sep = strrchr(path, '/');
+	if (sep)
+		d = lookup_untracked(istate->untracked,
+				     istate->untracked->root,
+				     path, sep - path);
+	else
+		d = istate->untracked->root;
+	istate->untracked->dir_invalidated++;
+	d->valid = 0;
+	d->untracked_nr = 0;
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
index 42a09ff..d56c43a 100644
--- a/dir.h
+++ b/dir.h
@@ -295,6 +295,10 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+void untracked_cache_invalidate_path(struct index_state *, const char *);
+void untracked_cache_remove_from_index(struct index_state *, const char *);
+void untracked_cache_add_to_index(struct index_state *, const char *);
+
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 #endif
diff --git a/read-cache.c b/read-cache.c
index c350b7b..66c2279 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -66,6 +66,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	memcpy(new->name, new_name, namelen + 1);
 
 	cache_tree_invalidate_path(istate->cache_tree, old->name);
+	untracked_cache_remove_from_index(istate, old->name);
 	remove_index_entry_at(istate, nr);
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
@@ -520,6 +521,7 @@ int remove_file_from_index(struct index_state *istate, const char *path)
 	if (pos < 0)
 		pos = -pos-1;
 	cache_tree_invalidate_path(istate->cache_tree, path);
+	untracked_cache_remove_from_index(istate, path);
 	while (pos < istate->cache_nr && !strcmp(istate->cache[pos]->name, path))
 		remove_index_entry_at(istate, pos);
 	return 0;
@@ -948,6 +950,8 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	}
 	pos = -pos-1;
 
+	untracked_cache_add_to_index(istate, ce->name);
+
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
 	 * will always replace all non-merged entries..
diff --git a/unpack-trees.c b/unpack-trees.c
index 97fc995..35ef298 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "dir.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1258,8 +1259,10 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-	if (ce)
-		cache_tree_invalidate_path(o->src_index->cache_tree, ce->name);
+	if (!ce)
+		return;
+	cache_tree_invalidate_path(o->src_index->cache_tree, ce->name);
+	untracked_cache_invalidate_path(o->src_index, ce->name);
 }
 
 /*
-- 
1.9.1.346.ga2b5940
