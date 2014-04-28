From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/32] cache-tree: mark istate->cache_changed on cache tree update
Date: Mon, 28 Apr 2014 17:55:34 +0700
Message-ID: <1398682553-11634-14-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:56:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejEG-0002RN-CH
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbaD1Kz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:57 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:47446 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbaD1Kzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:43 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so5721453pbc.35
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1sFeUN0vPCPGQDU1RfGl4rKKHMxDlApXicmNurndv0Y=;
        b=svPncS9QUsA1S5wcqMz/n1m5GCKEsbZfkSbfRrRdMnI9dlQNGYuX3vJXIHNvOeEZLy
         vd/bjFix64Oin+mcSjpPyRE0deZ/hppzTR3CTvk+Im/0QQ6eYIDnYWyr/AhqXIB3BgtF
         XZ/8Hdq8toUKt/efFDRP0FlZ7WjGLZw+dCEYV+IxGU6PT+PMnn73r5ym8VVhclNFbdWb
         4tuoDiuWIY5KvkfTkz9mTj1D7fxVmD3d9PIYH0IFLIG/TgPDX/U/gxsWU9r1qzoMJRBS
         n0TRDpMqoOzrjMOUmkgCoz0T6ngkXDFQNVWo/lOgtmeY4kaGgtP7XrgOzbFsAWYHprYv
         SMsQ==
X-Received: by 10.66.120.201 with SMTP id le9mr24278419pab.98.1398682543091;
        Mon, 28 Apr 2014 03:55:43 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id yj6sm89627649pab.19.2014.04.28.03.55.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:10 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247280>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c           | 25 +++++++++++--------------
 cache-tree.h           |  2 +-
 merge-recursive.c      |  4 +---
 sequencer.c            |  4 +---
 test-dump-cache-tree.c |  7 ++++---
 5 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 23ddc73..18055f1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -151,7 +151,7 @@ void cache_tree_invalidate_path(struct index_state =
*istate, const char *path)
 		istate->cache_changed |=3D CACHE_TREE_CHANGED;
 }
=20
-static int verify_cache(const struct cache_entry * const *cache,
+static int verify_cache(struct cache_entry **cache,
 			int entries, int flags)
 {
 	int i, funny;
@@ -236,7 +236,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 }
=20
 static int update_one(struct cache_tree *it,
-		      const struct cache_entry * const *cache,
+		      struct cache_entry **cache,
 		      int entries,
 		      const char *base,
 		      int baselen,
@@ -398,18 +398,19 @@ static int update_one(struct cache_tree *it,
 	return i;
 }
=20
-int cache_tree_update(struct cache_tree *it,
-		      const struct cache_entry * const *cache,
-		      int entries,
-		      int flags)
+int cache_tree_update(struct index_state *istate, int flags)
 {
-	int i, skip;
-	i =3D verify_cache(cache, entries, flags);
+	struct cache_tree *it =3D istate->cache_tree;
+	struct cache_entry **cache =3D istate->cache;
+	int entries =3D istate->cache_nr;
+	int skip, i =3D verify_cache(cache, entries, flags);
+
 	if (i)
 		return i;
 	i =3D update_one(it, cache, entries, "", 0, &skip, flags);
 	if (i < 0)
 		return i;
+	istate->cache_changed |=3D CACHE_TREE_CHANGED;
 	return 0;
 }
=20
@@ -597,9 +598,7 @@ int write_cache_as_tree(unsigned char *sha1, int fl=
ags, const char *prefix)
=20
 	was_valid =3D cache_tree_fully_valid(active_cache_tree);
 	if (!was_valid) {
-		if (cache_tree_update(active_cache_tree,
-				      (const struct cache_entry * const *)active_cache,
-				      active_nr, flags) < 0)
+		if (cache_tree_update(&the_index, flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <=3D newfd) {
 			if (!write_locked_index(&the_index, lock_file, COMMIT_LOCK))
@@ -698,7 +697,5 @@ int update_main_cache_tree(int flags)
 {
 	if (!the_index.cache_tree)
 		the_index.cache_tree =3D cache_tree();
-	return cache_tree_update(the_index.cache_tree,
-				 (const struct cache_entry * const *)the_index.cache,
-				 the_index.cache_nr, flags);
+	return cache_tree_update(&the_index, flags);
 }
diff --git a/cache-tree.h b/cache-tree.h
index dfbcfab..154b357 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -30,7 +30,7 @@ void cache_tree_write(struct strbuf *, struct cache_t=
ree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long s=
ize);
=20
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, const struct cache_entry * =
const *, int, int);
+int cache_tree_update(struct index_state *, int);
=20
 int update_main_cache_tree(int);
=20
diff --git a/merge-recursive.c b/merge-recursive.c
index 442c1ec..0b5d34d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -265,9 +265,7 @@ struct tree *write_tree_from_memory(struct merge_op=
tions *o)
 		active_cache_tree =3D cache_tree();
=20
 	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(active_cache_tree,
-			      (const struct cache_entry * const *)active_cache,
-			      active_nr, 0) < 0)
+	    cache_tree_update(&the_index, 0) < 0)
 		die(_("error building trees"));
=20
 	result =3D lookup_tree(active_cache_tree->sha1);
diff --git a/sequencer.c b/sequencer.c
index 4fb0774..377c877 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -371,9 +371,7 @@ static int is_index_unchanged(void)
 		active_cache_tree =3D cache_tree();
=20
 	if (!cache_tree_fully_valid(active_cache_tree))
-		if (cache_tree_update(active_cache_tree,
-				      (const struct cache_entry * const *)active_cache,
-				      active_nr, 0))
+		if (cache_tree_update(&the_index, 0))
 			return error(_("Unable to update cache tree\n"));
=20
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sh=
a1);
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 47eab97..330ba4f 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -56,11 +56,12 @@ static int dump_cache_tree(struct cache_tree *it,
=20
 int main(int ac, char **av)
 {
+	struct index_state istate;
 	struct cache_tree *another =3D cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another,
-			  (const struct cache_entry * const *)active_cache,
-			  active_nr, WRITE_TREE_DRY_RUN);
+	istate =3D the_index;
+	istate.cache_tree =3D another;
+	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
--=20
1.9.1.346.ga2b5940
