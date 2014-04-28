From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/32] cache-tree: mark istate->cache_changed on cache tree invalidation
Date: Mon, 28 Apr 2014 17:55:33 +0700
Message-ID: <1398682553-11634-13-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejE2-00027n-CE
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbaD1Kzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:44 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36481 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbaD1Kzi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:38 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so3828173pab.30
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=agQU3D5Fy/bb9aa+BDLwwHt5eV7W03gBoQhv2iLo3Rw=;
        b=q3eP07DjQAJtAO9sdY1/LBXR/lga1QM3spPKHmp4eOwgoOdIVFmYt1N88FcstXPwRO
         7weHWnbGj0oNz5ELHifBUbyn2HDgudP9D6ZP0MIrCJF+h3W4o84WrD51N3rsGVmLBIs7
         NNWt7v0zTQfYXJ1Lk6jbpk6p8mAb9mUnIpWJF/aBJYRXFBdGm5sAiu/cxm5Uejz61wjB
         ZCOpGspkEoTPdrXTUP/WxNkLG15gsRxCe6dRJ64sBQ2IpqDogl6tGWkk/x3sM3qwrZBa
         v2JVQz0rjBJDuqz0CiNEyDUHL+p4nxRSgECfiGHszJikFkvxquxwly1QTWoCHYdtcYI4
         pT9w==
X-Received: by 10.66.121.164 with SMTP id ll4mr7684185pab.129.1398682537424;
        Mon, 28 Apr 2014 03:55:37 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id kn10sm34176406pbd.60.2014.04.28.03.55.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:05 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247279>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c        |  2 +-
 builtin/update-index.c |  4 ++--
 cache-tree.c           | 15 +++++++++++----
 cache-tree.h           |  2 +-
 cache.h                |  1 +
 read-cache.c           |  6 +++---
 unpack-trees.c         |  2 +-
 7 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 88cb799..914d919 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2126,7 +2126,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 	 * right now, but someday we might optimize diff-index --cached
 	 * with cache-tree information.
 	 */
-	cache_tree_invalidate_path(active_cache_tree, path);
+	cache_tree_invalidate_path(&the_index, path);
=20
 	return commit;
 }
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e0e881b..fa3c441 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -55,7 +55,7 @@ static int mark_ce_flags(const char *path, int flag, =
int mark)
 			active_cache[pos]->ce_flags |=3D flag;
 		else
 			active_cache[pos]->ce_flags &=3D ~flag;
-		cache_tree_invalidate_path(active_cache_tree, path);
+		cache_tree_invalidate_path(&the_index, path);
 		active_cache_changed |=3D CE_ENTRY_CHANGED;
 		return 0;
 	}
@@ -267,7 +267,7 @@ static void chmod_path(int flip, const char *path)
 	default:
 		goto fail;
 	}
-	cache_tree_invalidate_path(active_cache_tree, path);
+	cache_tree_invalidate_path(&the_index, path);
 	active_cache_changed |=3D CE_ENTRY_CHANGED;
 	report("chmod %cx '%s'", flip, path);
 	return;
diff --git a/cache-tree.c b/cache-tree.c
index 52f8692..23ddc73 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -98,7 +98,7 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tr=
ee *it, const char *path)
 	return find_subtree(it, path, pathlen, 1);
 }
=20
-void cache_tree_invalidate_path(struct cache_tree *it, const char *pat=
h)
+static int do_invalidate_path(struct cache_tree *it, const char *path)
 {
 	/* a/b/c
 	 * =3D=3D> invalidate self
@@ -116,7 +116,7 @@ void cache_tree_invalidate_path(struct cache_tree *=
it, const char *path)
 #endif
=20
 	if (!it)
-		return;
+		return 0;
 	slash =3D strchrnul(path, '/');
 	namelen =3D slash - path;
 	it->entry_count =3D -1;
@@ -137,11 +137,18 @@ void cache_tree_invalidate_path(struct cache_tree=
 *it, const char *path)
 				(it->subtree_nr - pos - 1));
 			it->subtree_nr--;
 		}
-		return;
+		return 1;
 	}
 	down =3D find_subtree(it, path, namelen, 0);
 	if (down)
-		cache_tree_invalidate_path(down->cache_tree, slash + 1);
+		do_invalidate_path(down->cache_tree, slash + 1);
+	return 1;
+}
+
+void cache_tree_invalidate_path(struct index_state *istate, const char=
 *path)
+{
+	if (do_invalidate_path(istate->cache_tree, path))
+		istate->cache_changed |=3D CACHE_TREE_CHANGED;
 }
=20
 static int verify_cache(const struct cache_entry * const *cache,
diff --git a/cache-tree.h b/cache-tree.h
index f1923ad..dfbcfab 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -23,7 +23,7 @@ struct cache_tree {
=20
 struct cache_tree *cache_tree(void);
 void cache_tree_free(struct cache_tree **);
-void cache_tree_invalidate_path(struct cache_tree *, const char *);
+void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char =
*);
=20
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
diff --git a/cache.h b/cache.h
index 7155052..4c288e8 100644
--- a/cache.h
+++ b/cache.h
@@ -273,6 +273,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define CE_ENTRY_ADDED		(1 << 2)
 #define SOMETHING_CHANGED	(1 << 3) /* unclassified changes go here */
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
+#define CACHE_TREE_CHANGED	(1 << 5)
=20
 struct index_state {
 	struct cache_entry **cache;
diff --git a/read-cache.c b/read-cache.c
index 6971fc4..f1265d4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -65,7 +65,7 @@ void rename_index_entry_at(struct index_state *istate=
, int nr, const char *new_n
 	new->ce_namelen =3D namelen;
 	memcpy(new->name, new_name, namelen + 1);
=20
-	cache_tree_invalidate_path(istate->cache_tree, old->name);
+	cache_tree_invalidate_path(istate, old->name);
 	remove_index_entry_at(istate, nr);
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPL=
ACE);
 }
@@ -521,7 +521,7 @@ int remove_file_from_index(struct index_state *ista=
te, const char *path)
 	int pos =3D index_name_pos(istate, path, strlen(path));
 	if (pos < 0)
 		pos =3D -pos-1;
-	cache_tree_invalidate_path(istate->cache_tree, path);
+	cache_tree_invalidate_path(istate, path);
 	while (pos < istate->cache_nr && !strcmp(istate->cache[pos]->name, pa=
th))
 		remove_index_entry_at(istate, pos);
 	return 0;
@@ -939,7 +939,7 @@ static int add_index_entry_with_check(struct index_=
state *istate, struct cache_e
 	int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only =3D option & ADD_CACHE_NEW_ONLY;
=20
-	cache_tree_invalidate_path(istate->cache_tree, ce->name);
+	cache_tree_invalidate_path(istate, ce->name);
 	pos =3D index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_sta=
ge(ce));
=20
 	/* existing match? Just replace it. */
diff --git a/unpack-trees.c b/unpack-trees.c
index a722685..3beff8a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1263,7 +1263,7 @@ static void invalidate_ce_path(const struct cache=
_entry *ce,
 			       struct unpack_trees_options *o)
 {
 	if (ce)
-		cache_tree_invalidate_path(o->src_index->cache_tree, ce->name);
+		cache_tree_invalidate_path(o->src_index, ce->name);
 }
=20
 /*
--=20
1.9.1.346.ga2b5940
