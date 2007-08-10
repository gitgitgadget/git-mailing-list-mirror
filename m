From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Move old index entry removal from "unpack_trees()" into
 the individual functions
Date: Fri, 10 Aug 2007 12:15:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJZy1-0004xT-Dy
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926AbXHJTQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbXHJTQI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:16:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45941 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753790AbXHJTQH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 15:16:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJG0fh001866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 12:16:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJFsBN004155;
	Fri, 10 Aug 2007 12:15:54 -0700
X-Spam-Status: No, hits=-5.322 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_65,J_CHICKENPOX_66,J_CHICKENPOX_73,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.21__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55563>


This makes no changes to current code, but it allows the individual merge 
functions to decide what to do about the old entry.  They might decide to 
update it in place, rather than force them to always delete and re-add it.
    
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This commit on purpose does *not* change any behaviour, it just lays the 
groundwork for the next patch, which optimizes the hell out of the two 
common cases.

 unpack-trees.c |   29 +++++++++++++++++++++++------
 unpack-trees.h |   11 ++++++-----
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5d1ffd1..7fed5d2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -58,10 +58,17 @@ static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
 	return ret;
 }
 
+static inline void remove_entry(int remove)
+{
+	if (remove >= 0)
+		remove_cache_entry_at(remove);
+}
+
 static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 			    const char *base, struct unpack_trees_options *o,
 			    struct tree_entry_list *df_conflict_list)
 {
+	int remove;
 	int baselen = strlen(base);
 	int src_size = len + 1;
 	int i_stk = i_stk;
@@ -145,10 +152,11 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 
 		subposns = xcalloc(len, sizeof(struct tree_list_entry *));
 
+		remove = -1;
 		if (cache_name && !strcmp(cache_name, first)) {
 			any_files = 1;
 			src[0] = active_cache[o->pos];
-			remove_cache_entry_at(o->pos);
+			remove = o->pos;
 		}
 
 		for (i = 0; i < len; i++) {
@@ -214,13 +222,14 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 						printf("\n");
 				}
 #endif
-				ret = o->fn(src, o);
+				ret = o->fn(src, o, remove);
 
 #if DBRT_DEBUG > 1
 				printf("Added %d entries\n", ret);
 #endif
 				o->pos += ret;
 			} else {
+				remove_entry(remove);
 				for (i = 0; i < src_size; i++) {
 					if (src[i]) {
 						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
@@ -641,7 +650,8 @@ static void show_stage_entry(FILE *o,
 #endif
 
 int threeway_merge(struct cache_entry **stages,
-		struct unpack_trees_options *o)
+		struct unpack_trees_options *o,
+		int remove)
 {
 	struct cache_entry *index;
 	struct cache_entry *head;
@@ -657,6 +667,7 @@ int threeway_merge(struct cache_entry **stages,
 	int no_anc_exists = 1;
 	int i;
 
+	remove_entry(remove);		
 	for (i = 1; i < o->head_idx; i++) {
 		if (!stages[i] || stages[i] == o->df_conflict_entry)
 			any_anc_missing = 1;
@@ -809,12 +820,14 @@ int threeway_merge(struct cache_entry **stages,
  *
  */
 int twoway_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
+		struct unpack_trees_options *o,
+		int remove)
 {
 	struct cache_entry *current = src[0];
 	struct cache_entry *oldtree = src[1];
 	struct cache_entry *newtree = src[2];
 
+	remove_entry(remove);
 	if (o->merge_size != 2)
 		return error("Cannot do a twoway merge of %d trees",
 			     o->merge_size);
@@ -868,11 +881,13 @@ int twoway_merge(struct cache_entry **src,
  * stage0 does not have anything there.
  */
 int bind_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
+		struct unpack_trees_options *o,
+		int remove)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
+	remove_entry(remove);
 	if (o->merge_size != 1)
 		return error("Cannot do a bind merge of %d trees\n",
 			     o->merge_size);
@@ -891,11 +906,13 @@ int bind_merge(struct cache_entry **src,
  * - take the stat information from stage0, take the data from stage1
  */
 int oneway_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
+		struct unpack_trees_options *o,
+		int remove)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
+	remove_entry(remove);
 	if (o->merge_size != 1)
 		return error("Cannot do a oneway merge of %d trees",
 			     o->merge_size);
diff --git a/unpack-trees.h b/unpack-trees.h
index 9cd39a2..5517faa 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -4,7 +4,8 @@
 struct unpack_trees_options;
 
 typedef int (*merge_fn_t)(struct cache_entry **src,
-		struct unpack_trees_options *options);
+		struct unpack_trees_options *options,
+		int remove);
 
 struct unpack_trees_options {
 	int reset;
@@ -29,9 +30,9 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
 
-int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o);
-int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o);
-int bind_merge(struct cache_entry **src, struct unpack_trees_options *o);
-int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o);
+int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o, int);
+int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o, int);
+int bind_merge(struct cache_entry **src, struct unpack_trees_options *o, int);
+int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o, int);
 
 #endif
