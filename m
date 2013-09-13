From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] name-hash: refactor polymorphic index_name_exists()
Date: Fri, 13 Sep 2013 07:15:41 -0400
Message-ID: <1379070943-36595-2-git-send-email-sunshine@sunshineco.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 13:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKRMQ-0000lU-SG
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 13:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab3IMLQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 07:16:21 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45736 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3IMLQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 07:16:18 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so936449obc.20
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tvhAhHntPyTVh8KfKSmxs2a7oCbPxBV5wS9sc9L97qI=;
        b=gFnP6Hl0dnvJ027eYSNMIKlt7MMhxn9v4BbupLi9UWOIh2V3c9O5aC70/ec8nG7BHz
         W9sRjE9AvUywubuLOx/Gmzdc6mtw6hFcJQw7h3cvjpo9gvVrvunqkAXHw1M1YBafOhTD
         4drmxgUVuP70LxTqvOwhmHmqd+mpVAIcxhMIrwaDJPz+FPx0pJIeGavfxvU6rWUhy4P3
         nmiW+cPz/kKJ6gBtcciKuc5v/mk5zjuPTsG2LfJsbLLTxK+Di+B/9pjXCsSfcBDQUUnN
         88CaX8qX8811nm3pfTLd66zLtoeWwbAXjbnYjOk2UIQGkRZjZuvCuvSaCoJrMYTSmzfS
         3Ygw==
X-Received: by 10.60.51.7 with SMTP id g7mr11956572oeo.6.1379070978442;
        Fri, 13 Sep 2013 04:16:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id it7sm13049040obb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 04:16:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.457.g424cb08
In-Reply-To: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234745>

Depending upon the absence or presence of a trailing '/' on the incoming
pathname, index_name_exists() checks either if a file is present in the
index or if a directory is represented within the index.  Each caller
explicitly chooses the mode of operation by adding or removing a
trailing '/' before invoking index_name_exists().

Since these two modes of operations are disjoint and have no code in
common (one searches index_state.name_hash; the other dir_hash), they
can be represented more naturally as distinct functions: one to search
for a file, and one for a directory.

Splitting index searching into two functions relieves callers of the
artificial burden of having to add or remove a slash to select the mode
of operation; instead they just call the desired function. A subsequent
patch will take advantage of this benefit in order to eliminate the
requirement that the incoming pathname for a directory search must have
a trailing slash.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 cache.h      |  2 ++
 dir.c        |  7 ++++---
 name-hash.c  | 47 ++++++++++++++++++++++++-----------------------
 read-cache.c |  2 +-
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index 9ef778a..03ec24c 100644
--- a/cache.h
+++ b/cache.h
@@ -314,6 +314,7 @@ extern void free_name_hash(struct index_state *istate);
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
+#define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
@@ -463,6 +464,7 @@ extern int write_index(struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
+extern struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
diff --git a/dir.c b/dir.c
index b439ff0..0080673 100644
--- a/dir.c
+++ b/dir.c
@@ -860,7 +860,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, ignore_case))
+	if ((len == 0 || pathname[len - 1] != '/') &&
+	    cache_name_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -885,11 +886,11 @@ enum exist_status {
 /*
  * Do not use the alphabetically sorted index to look up
  * the directory name; instead, use the case insensitive
- * name hash.
+ * directory hash.
  */
 static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
 {
-	const struct cache_entry *ce = cache_name_exists(dirname, len + 1, ignore_case);
+	const struct cache_entry *ce = cache_dir_exists(dirname, len + 1);
 	unsigned char endchar;
 
 	if (!ce)
diff --git a/name-hash.c b/name-hash.c
index 617c86c..5b01554 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -222,11 +222,35 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	return slow_same_name(name, namelen, ce->name, len);
 }
 
+struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen)
+{
+	struct cache_entry *ce;
+	struct dir_entry *dir;
+
+	lazy_init_name_hash(istate);
+	dir = find_dir_entry(istate, name, namelen);
+	if (dir && dir->nr)
+		return dir->ce;
+
+	/*
+	 * It might be a submodule. Unlike plain directories, which are stored
+	 * in the dir-hash, submodules are stored in the name-hash, so check
+	 * there, as well.
+	 */
+	ce = index_name_exists(istate, name, namelen - 1, 1);
+	if (ce && S_ISGITLINK(ce->ce_mode))
+		return ce;
+
+	return NULL;
+}
+
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	unsigned int hash = hash_name(name, namelen);
 	struct cache_entry *ce;
 
+	assert(namelen == 0 || name[namelen - 1] != '/');
+
 	lazy_init_name_hash(istate);
 	ce = lookup_hash(hash, &istate->name_hash);
 
@@ -237,29 +261,6 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 		}
 		ce = ce->next;
 	}
-
-	/*
-	 * When looking for a directory (trailing '/'), it might be a
-	 * submodule or a directory. Despite submodules being directories,
-	 * they are stored in the name hash without a closing slash.
-	 * When ignore_case is 1, directories are stored in a separate hash
-	 * table *with* their closing slash.
-	 *
-	 * The side effect of this storage technique is we have need to
-	 * lookup the directory in a separate hash table, and if not found
-	 * remove the slash from name and perform the lookup again without
-	 * the slash.  If a match is made, S_ISGITLINK(ce->mode) will be
-	 * true.
-	 */
-	if (icase && name[namelen - 1] == '/') {
-		struct dir_entry *dir = find_dir_entry(istate, name, namelen);
-		if (dir && dir->nr)
-			return dir->ce;
-
-		ce = index_name_exists(istate, name, namelen - 1, icase);
-		if (ce && S_ISGITLINK(ce->ce_mode))
-			return ce;
-	}
 	return NULL;
 }
 
diff --git a/read-cache.c b/read-cache.c
index 885943a..a59644a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -643,7 +643,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 			if (*ptr == '/') {
 				struct cache_entry *foundce;
 				++ptr;
-				foundce = index_name_exists(istate, ce->name, ptr - ce->name, ignore_case);
+				foundce = index_dir_exists(istate, ce->name, ptr - ce->name);
 				if (foundce) {
 					memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
 					startPtr = ptr;
-- 
1.8.4.457.g424cb08
