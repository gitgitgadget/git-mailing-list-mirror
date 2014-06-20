From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v5 2/2] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 19:06:44 -0700
Message-ID: <1403230004-11034-3-git-send-email-jmmahler@gmail.com>
References: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 04:07:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxoEj-0001IN-Fw
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 04:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbaFTCHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 22:07:21 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:42071 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbaFTCHP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 22:07:15 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so2543843pbb.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NzSW5Vq+NsMqikyisnZyvixbHOLWouy6PR8taGx3eZk=;
        b=cZ5FbwU4qvKpJaG05io5H2wecW7Z2nU+DgV2teqxETN1Q8uvregWXWiQw4eCY5b4Xk
         C6LWe/2BhGdzbaWJI1DMnx47vMtdKmrimDXyBnsQvOSAhPTkZdstCKlTh1YctwocAEi8
         xXEz4KnEvjlXFotyiYzUefFNuyS3Q8+ONM9KkuEJrNfMx6+I4gH2QQHrKUiFePpRo83T
         OfTNifeSuqjuNnvb9Y6mVxfyFb7xbS10oRN8coRs0SsGTFDOqYQV/tPafW86+h6poJ59
         yfjqNaJbsCUb2gDKS0qN83wTHROTo0RzcDkj2hgkW76Ahjo/JEAMWX0GyYsfIwBxG59y
         iI5A==
X-Received: by 10.68.211.233 with SMTP id nf9mr485656pbc.29.1403230034679;
        Thu, 19 Jun 2014 19:07:14 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id pw4sm10710474pbc.61.2014.06.19.19.07.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 19:07:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.694.g5736dad
In-Reply-To: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252207>

We often represent our strings as a counted string, i.e. a pair of the
pointer to the beginning of the string and its length, and the string
may not be NUL terminated to that length.

To compare a pair of such counted strings, unpack-trees.c and
read-cache.c implement their own name_compare() functions identically.
In addition, the cache_name_compare() function in read-cache.c is nearly
identical.  The only difference is when one string is the prefix of the
other string, in which case the former returns -1/+1 to show which one
is longer and the latter returns the difference of the lengths to show
the same information.

Unify these three functions by using the implementation from
cache_name_compare().  This does not make any difference to the existing
and future callers, as they must be paying attention only to the sign of
the returned value (and not the magnitude) because the original
implementations of these two functions return values returned by
memcmp(3) when the one string is not a prefix of the other string, and
the only thing memcmp(3) guarantees its callers is the sign of the
returned value, not the magnitude.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 cache.h        |  2 +-
 dir.c          |  3 +--
 read-cache.c   | 23 +++++++++++++----------
 tree-walk.c    | 10 ----------
 unpack-trees.c | 11 -----------
 5 files changed, 15 insertions(+), 34 deletions(-)

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
2.0.0.694.g5736dad
