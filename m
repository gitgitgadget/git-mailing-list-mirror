From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v4] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 01:07:22 -0700
Message-ID: <1403165242-16849-2-git-send-email-jmmahler@gmail.com>
References: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:08:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxXOK-0004jo-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 10:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbaFSIIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 04:08:09 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:57484 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757336AbaFSIIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 04:08:05 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so1661608pbc.15
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FCfjHg+zUovJBqlrJoVeyg169ayr/Dkaqk/guAjpYpE=;
        b=H8yvKF2Q3ZdgfoVqxzB6g5ml34Rrtk3w7N9Hu6uGP+mMsgvSCPl4CIUkMlN8iwCDZv
         8DBAKBAmR6mVg/yIwjK6b6Trea8ILaWUNoH9Hi+4+0llshfh3VEc1uLDewJ2rtrc2h2B
         2EYk22rnQGPrv/q3g8RpxsIQj+Cfb27lTR/KA0EAbH8kZ4ln4ApuLFEMS4hqYj6zDnAW
         f7fUHaBxc9S2dEV7yncMu6xQLDMiqtxsz8UbSqpIWJ4ISiXyA1majhNJCOghxqQBu+xJ
         B54Pw9rq0wc0PUhmav3NM84nePxMfKXn42y7Ei5AaeVfApS9Q/jiM1OsQcHDDrjtmZX1
         ZZuQ==
X-Received: by 10.66.122.135 with SMTP id ls7mr3788412pab.84.1403165284644;
        Thu, 19 Jun 2014 01:08:04 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fe3sm7167452pbd.66.2014.06.19.01.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 01:08:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.693.g5dae59c
In-Reply-To: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252102>

Both unpack-trees.c and read-cache.c have their own name_compare()
function, which are identical.  And read-cache.c has a
cache_name_compare() function which is nearly identical to
name_compare() [1].  The cache_name_compare() function is not specific
to a cache, other than by being part of cache.h.

Generalize the cache_name_compare() function by renaming it to
name_compare().  Simplify the cache_name_stage_compare() function using
name_compare().  Then change the few instances which used
cache_name_compare() to name_compare() [2].

[1] cache_name_compare() is not identical to name_compare().  The former
    returns +1, -1, whereas the latter returns +N, -N.  But there is no
    place where name_compare() is used that needs the magnitude so this
    difference does not alter its behavior.

[2] The instances where cache_name_compare() is used have nothing to do
    with a cache.  The new name, name_compare(), makes it clear that no
    cache is involved.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 cache.h        |  2 +-
 dir.c          |  3 +--
 name-hash.c    |  2 +-
 read-cache.c   | 23 +++++++++++++----------
 tree-walk.c    | 10 ----------
 unpack-trees.c | 11 -----------
 6 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/cache.h b/cache.h
index c498a30..e3205fe 100644
--- a/cache.h
+++ b/cache.h
@@ -1027,7 +1027,7 @@ extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
+extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
diff --git a/dir.c b/dir.c
index 797805d..e65888d 100644
--- a/dir.c
+++ b/dir.c
@@ -1354,8 +1354,7 @@ static int cmp_name(const void *p1, const void *p2)
 	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
 	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
 
-	return cache_name_compare(e1->name, e1->len,
-				  e2->name, e2->len);
+	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
 static struct path_simplify *create_simplify(const char **pathspec)
diff --git a/name-hash.c b/name-hash.c
index be7c4ae..e2bea88 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -179,7 +179,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	 * Always do exact compare, even if we want a case-ignoring comparison;
 	 * we do the quick exact one first, because it will be the common case.
 	 */
-	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
+	if (len == namelen && !name_compare(name, namelen, ce->name, len))
 		return 1;
 
 	if (!icase)
diff --git a/read-cache.c b/read-cache.c
index 9f56d76..158241d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -434,18 +434,26 @@ int df_name_compare(const char *name1, int len1, int mode1,
 	return c1 - c2;
 }
 
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 {
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
-
-	cmp = memcmp(name1, name2, len);
+	size_t min_len = (len1 < len2) ? len1 : len2;
+	int cmp = memcmp(name1, name2, min_len);
 	if (cmp)
 		return cmp;
 	if (len1 < len2)
 		return -1;
 	if (len1 > len2)
 		return 1;
+	return 0;
+}
+
+int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+{
+	int cmp;
+
+	cmp = name_compare(name1, len1, name2, len2);
+	if (cmp)
+		return cmp;
 
 	if (stage1 < stage2)
 		return -1;
@@ -454,11 +462,6 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 	return 0;
 }
 
-int cache_name_compare(const char *name1, int len1, const char *name2, int len2)
-{
-	return cache_name_stage_compare(name1, len1, 0, name2, len2, 0);
-}
-
 static int index_name_stage_pos(const struct index_state *istate, const char *name, int namelen, int stage)
 {
 	int first, last;
diff --git a/tree-walk.c b/tree-walk.c
index 4dc86c7..5dd9a71 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -144,16 +144,6 @@ struct tree_desc_x {
 	struct tree_desc_skip *skip;
 };
 
-static int name_compare(const char *a, int a_len,
-			const char *b, int b_len)
-{
-	int len = (a_len < b_len) ? a_len : b_len;
-	int cmp = memcmp(a, b, len);
-	if (cmp)
-		return cmp;
-	return (a_len - b_len);
-}
-
 static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
 {
 	/*
diff --git a/unpack-trees.c b/unpack-trees.c
index 4a9cdf2..c4a97ca 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -629,17 +629,6 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 	return -1;
 }
 
-/* NEEDSWORK: give this a better name and share with tree-walk.c */
-static int name_compare(const char *a, int a_len,
-			const char *b, int b_len)
-{
-	int len = (a_len < b_len) ? a_len : b_len;
-	int cmp = memcmp(a, b, len);
-	if (cmp)
-		return cmp;
-	return (a_len - b_len);
-}
-
 /*
  * The tree traversal is looking at name p.  If we have a matching entry,
  * return it.  If name p is a directory in the index, do not return
-- 
2.0.0
