From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] employ new explicit "exists in index?" API
Date: Tue, 17 Sep 2013 03:06:15 -0400
Message-ID: <1379401577-36799-3-git-send-email-sunshine@sunshineco.com>
References: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 09:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpN6-0002AT-AO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab3IQHGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 03:06:46 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:61471 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab3IQHGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 03:06:44 -0400
Received: by mail-oa0-f42.google.com with SMTP id f4so936542oah.29
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E1IS35bU0tILRpvPMwdIr35+/hkU4bVER11Y8CcI3Ho=;
        b=FrYUvlEMfhwTPbP+5js3we2pzTDVMyQxUI61R6g774MvqIXF/hIlo5xj3/oajyvumk
         Q4wL79uzOWszXi0YY82Es8qkhzPDXfOLPe+7aiNP+rRTQZWJSJ3KEAOHtTdmH7C5luXN
         dyCsmzDXuBCxTrYZCtlkEbkhiWEZ6dykfEzzJdwDF+TuPojTOCmXniK1BZG8504OTi9j
         N0tieIrQUuwwNMQKc07KuYBv4xvBxOJasgki5bnl3s2nNu/rDXXHHjHxkVxJiqgO8AH9
         uSweTlaoX/lIgSHECcGXI/ptrAG5zV5O2UpP3Ik7oDhlqcYP7gMhlTsQqVKo6KPRHfvu
         VsXA==
X-Received: by 10.60.93.67 with SMTP id cs3mr29275909oeb.12.1379401603946;
        Tue, 17 Sep 2013 00:06:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d8sm37304079oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 00:06:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
In-Reply-To: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234853>

Each caller of index_name_exists() knows whether it is looking for a
directory or a file, and can avoid the unnecessary indirection of
index_name_exists() by instead calling index_dir_exists() or
index_file_exists() directly.

Invoking the appropriate search function explicitly will allow a
subsequent patch to relieve callers of the artificial burden of having
to add a trailing '/' to the pathname given to index_dir_exists().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 dir.c          | 10 +++++-----
 read-cache.c   |  4 ++--
 unpack-trees.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index b439ff0..a8401b9 100644
--- a/dir.c
+++ b/dir.c
@@ -860,7 +860,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, ignore_case))
+	if (cache_file_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -885,11 +885,11 @@ enum exist_status {
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
@@ -1071,7 +1071,7 @@ static int get_index_dtype(const char *path, int len)
 	int pos;
 	const struct cache_entry *ce;
 
-	ce = cache_name_exists(path, len, 0);
+	ce = cache_file_exists(path, len, 0);
 	if (ce) {
 		if (!ce_uptodate(ce))
 			return DT_UNKNOWN;
@@ -1131,7 +1131,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
-	int has_path_in_index = !!cache_name_exists(path->buf, path->len, ignore_case);
+	int has_path_in_index = !!cache_file_exists(path->buf, path->len, ignore_case);
 
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, path->buf, path->len);
diff --git a/read-cache.c b/read-cache.c
index 885943a..b8d3759 100644
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
@@ -652,7 +652,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		}
 	}
 
-	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
+	alias = index_file_exists(istate, ce->name, ce_namelen(ce), ignore_case);
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
diff --git a/unpack-trees.c b/unpack-trees.c
index 1a61e6f..35cb05e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1357,7 +1357,7 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
 {
 	const struct cache_entry *src;
 
-	src = index_name_exists(o->src_index, name, len, 1);
+	src = index_file_exists(o->src_index, name, len, 1);
 	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
@@ -1403,7 +1403,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	 * delete this path, which is in a subdirectory that
 	 * is being replaced with a blob.
 	 */
-	result = index_name_exists(&o->result, name, len, 0);
+	result = index_file_exists(&o->result, name, len, 0);
 	if (result) {
 		if (result->ce_flags & CE_REMOVE)
 			return 0;
-- 
1.8.4.535.g7b94f8e
