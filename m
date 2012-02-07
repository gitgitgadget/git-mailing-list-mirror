From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] cache-tree: update API to take abitrary flags
Date: Tue,  7 Feb 2012 19:46:41 +0700
Message-ID: <1328618804-31796-2-git-send-email-pclouds@gmail.com>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 13:41:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukMn-0006rE-Gs
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315Ab2BGMlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:41:44 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34915 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053Ab2BGMln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 07:41:43 -0500
Received: by daed14 with SMTP id d14so358770dae.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J63siIRK33aL85wio5qjaWIi4MxuB0a6hc7BiOE9rgc=;
        b=g7n4P3HIr/EzDH4Nur660QaOwZJUEo0v3m2Ltj9HI/CKAThfOoUyU4nHDMtZPQeXJH
         glqgSU0817No3B1QRyOSIPEpJQi6aApF/fAnbxfz79HDztGxQ4ElXyfGJznG9SlJy6np
         HU1qzxUdMArqPZETYAdpBK8+6sC0tH9xHKoww=
Received: by 10.68.240.135 with SMTP id wa7mr57397326pbc.7.1328618503133;
        Tue, 07 Feb 2012 04:41:43 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id p2sm16405989pbb.14.2012.02.07.04.41.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 04:41:42 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 07 Feb 2012 19:46:53 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190166>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c       |    4 ++--
 cache-tree.c           |   27 ++++++++++++---------------
 cache-tree.h           |    4 +++-
 merge-recursive.c      |    2 +-
 test-dump-cache-tree.c |    2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eba1377..bf42bb3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -400,7 +400,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 		fd =3D hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(1);
+		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -421,7 +421,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
-			update_main_cache_tree(1);
+			update_main_cache_tree(WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
diff --git a/cache-tree.c b/cache-tree.c
index 8de3959..16355d6 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -150,9 +150,10 @@ void cache_tree_invalidate_path(struct cache_tree =
*it, const char *path)
 }
=20
 static int verify_cache(struct cache_entry **cache,
-			int entries, int silent)
+			int entries, int flags)
 {
 	int i, funny;
+	int silent =3D flags & WRITE_TREE_SILENT;
=20
 	/* Verify that the tree is merged */
 	funny =3D 0;
@@ -241,10 +242,11 @@ static int update_one(struct cache_tree *it,
 		      int entries,
 		      const char *base,
 		      int baselen,
-		      int missing_ok,
-		      int dryrun)
+		      int flags)
 {
 	struct strbuf buffer;
+	int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
+	int dryrun =3D flags & WRITE_TREE_DRY_RUN;
 	int i;
=20
 	if (0 <=3D it->entry_count && has_sha1_file(it->sha1))
@@ -288,8 +290,7 @@ static int update_one(struct cache_tree *it,
 				    cache + i, entries - i,
 				    path,
 				    baselen + sublen + 1,
-				    missing_ok,
-				    dryrun);
+				    flags);
 		if (subcnt < 0)
 			return subcnt;
 		i +=3D subcnt - 1;
@@ -371,15 +372,13 @@ static int update_one(struct cache_tree *it,
 int cache_tree_update(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
-		      int missing_ok,
-		      int dryrun,
-		      int silent)
+		      int flags)
 {
 	int i;
-	i =3D verify_cache(cache, entries, silent);
+	i =3D verify_cache(cache, entries, flags);
 	if (i)
 		return i;
-	i =3D update_one(it, cache, entries, "", 0, missing_ok, dryrun);
+	i =3D update_one(it, cache, entries, "", 0, flags);
 	if (i < 0)
 		return i;
 	return 0;
@@ -572,11 +571,9 @@ int write_cache_as_tree(unsigned char *sha1, int f=
lags, const char *prefix)
=20
 	was_valid =3D cache_tree_fully_valid(active_cache_tree);
 	if (!was_valid) {
-		int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
-
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
-				      missing_ok, 0, 0) < 0)
+				      flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <=3D newfd) {
 			if (!write_cache(newfd, active_cache, active_nr) &&
@@ -672,10 +669,10 @@ int cache_tree_matches_traversal(struct cache_tre=
e *root,
 	return 0;
 }
=20
-int update_main_cache_tree (int silent)
+int update_main_cache_tree (int flags)
 {
 	if (!the_index.cache_tree)
 		the_index.cache_tree =3D cache_tree();
 	return cache_tree_update(the_index.cache_tree,
-				 the_index.cache, the_index.cache_nr, 0, 0, silent);
+				 the_index.cache, the_index.cache_nr, flags);
 }
diff --git a/cache-tree.h b/cache-tree.h
index 0ec0b2a..d8cb2e9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,13 +29,15 @@ void cache_tree_write(struct strbuf *, struct cache=
_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long s=
ize);
=20
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct cache_tree *, struct cache_entry **, int,=
 int, int, int);
+int cache_tree_update(struct cache_tree *, struct cache_entry **, int,=
 int);
=20
 int update_main_cache_tree(int);
=20
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
+#define WRITE_TREE_DRY_RUN 4
+#define WRITE_TREE_SILENT 8
=20
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/merge-recursive.c b/merge-recursive.c
index d83cd6c..6479a60 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -264,7 +264,7 @@ struct tree *write_tree_from_memory(struct merge_op=
tions *o)
=20
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0, 0) < 0)
+			      active_cache, active_nr, 0) < 0)
 		die("error building trees");
=20
 	result =3D lookup_tree(active_cache_tree->sha1);
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index e6c2923..a6ffdf3 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -59,6 +59,6 @@ int main(int ac, char **av)
 	struct cache_tree *another =3D cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, 0, 1, 0);
+	cache_tree_update(another, active_cache, active_nr, WRITE_TREE_DRY_RU=
N);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
--=20
1.7.8.36.g69ee2
