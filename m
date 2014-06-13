From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/32] cache-tree: mark istate->cache_changed on cache tree update
Date: Fri, 13 Jun 2014 19:19:32 +0700
Message-ID: <1402661991-14977-14-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQU6-0003Rm-3C
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbaFMMVZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47270 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaFMMVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:24 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so2123170pad.10
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b4ir6MreNjd+6KCDWY+bzXxiooOCWuu/3ZJs+6osKgY=;
        b=leBISVXpcdflkwgRQ6cc/N7jrZoWJxZk7Jo0FFP7kUgzkm+mMfV0RTqDvoPEJGTNEL
         5of2/LDy1CVMS+133UXByz4suCTw88soyOX63WUXfMMCddT5jCHiM+7a6q8I1E0Z4CbO
         syGFLYyUqqK6jSXN5yMLGmQsttFrMmULz5sdqe5Dtsmi9muoPTeVFQ5K4wU8aenoKWsC
         YngcjC+wWAe1RiSFySBXUlmw+s1lNQbuaxMMie5dA0eNE/R6SMlqjOY9nG8itaYI3j7c
         8HOVPmBpXcp8PBf8QxHlCHQ/44+Gq19rbavrrZFgnSHCxtiNLLsLJ719D9Lp5yLsE9Qb
         1APw==
X-Received: by 10.68.254.70 with SMTP id ag6mr2866668pbd.33.1402662083680;
        Fri, 13 Jun 2014 05:21:23 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id y2sm20668229pas.45.2014.06.13.05.21.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251569>

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
index 5ebc461..4b709db 100644
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
