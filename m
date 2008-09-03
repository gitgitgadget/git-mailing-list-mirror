From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] merge-recursive: move make_virtual_commit()'s virtual_id to merge_options
Date: Wed,  3 Sep 2008 19:34:38 +0200
Message-ID: <f2a1ff8d2fe354265a80534cd7beaaa95c2ffc54.1220463034.git.vmiklos@frugalware.org>
References: <cover.1220463034.git.vmiklos@frugalware.org>
 <e3e7f1cbf3746e7d2ef2c77227c9367a361c10b9.1220463034.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawHK-0004V7-KH
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbYICReq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754988AbYICReo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:34:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:59502 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800AbYICRel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:34:41 -0400
Received: from vmobile.example.net (dsl5401C25C.pool.t-online.hu [84.1.194.92])
	by yugo.frugalware.org (Postfix) with ESMTP id 4BA801DDC5C;
	Wed,  3 Sep 2008 19:34:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 60F5C84C9; Wed,  3 Sep 2008 19:34:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <e3e7f1cbf3746e7d2ef2c77227c9367a361c10b9.1220463034.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1220463034.git.vmiklos@frugalware.org>
References: <cover.1220463034.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94825>

This is the last patch in this series, now all static variables in
merge-recursive.c are moved to struct merge_options.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 merge-recursive.c |   24 ++++++++++++++----------
 merge-recursive.h |    1 +
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 964b8f3..4fa3308 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -40,13 +40,14 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
  * - *(int *)commit->object.sha1 set to the virtual id.
  */
 
-struct commit *make_virtual_commit(struct tree *tree, const char *comment)
+struct commit *make_virtual_commit(struct merge_options *o,
+				   struct tree *tree,
+				   const char *comment)
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
-	static unsigned virtual_id = 1;
 	commit->tree = tree;
 	commit->util = (void*)comment;
-	*(int*)commit->object.sha1 = virtual_id++;
+	*(int*)commit->object.sha1 = o->virtual_id++;
 	/* avoid warnings */
 	commit->object.parsed = 1;
 	return commit;
@@ -1245,7 +1246,7 @@ int merge_recursive(struct merge_options *o,
 		tree->object.parsed = 1;
 		tree->object.type = OBJ_TREE;
 		pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
-		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
+		merged_common_ancestors = make_virtual_commit(o, tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -1281,7 +1282,7 @@ int merge_recursive(struct merge_options *o,
 			    &mrtree);
 
 	if (o->call_depth) {
-		*result = make_virtual_commit(mrtree, "merged tree");
+		*result = make_virtual_commit(o, mrtree, "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
@@ -1289,7 +1290,9 @@ int merge_recursive(struct merge_options *o,
 	return clean;
 }
 
-static struct commit *get_ref(const unsigned char *sha1, const char *name)
+static struct commit *get_ref(struct merge_options *o,
+			      const unsigned char *sha1,
+			      const char *name)
 {
 	struct object *object;
 
@@ -1297,7 +1300,7 @@ static struct commit *get_ref(const unsigned char *sha1, const char *name)
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
-		return make_virtual_commit((struct tree*)object, name);
+		return make_virtual_commit(o, (struct tree*)object, name);
 	if (object->type != OBJ_COMMIT)
 		return NULL;
 	if (parse_commit((struct commit *)object))
@@ -1314,15 +1317,15 @@ int merge_recursive_generic(struct merge_options *o,
 {
 	int clean, index_fd;
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	struct commit *head_commit = get_ref(head, o->branch1);
-	struct commit *next_commit = get_ref(merge, o->branch2);
+	struct commit *head_commit = get_ref(o, head, o->branch1);
+	struct commit *next_commit = get_ref(o, merge, o->branch2);
 	struct commit_list *ca = NULL;
 
 	if (base_list) {
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
+			if (!(base = get_ref(o, base_list[i], sha1_to_hex(base_list[i]))))
 				return error("Could not parse object '%s'",
 					sha1_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
@@ -1376,4 +1379,5 @@ void init_merge_options(struct merge_options *o)
 	o->current_file_set.strdup_strings = 1;
 	memset(&o->current_directory_set, 0, sizeof(struct string_list));
 	o->current_directory_set.strdup_strings = 1;
+	o->virtual_id = 1;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index fd138ca..bc23fe0 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -15,6 +15,7 @@ struct merge_options {
 	struct strbuf obuf;
 	struct string_list current_file_set;
 	struct string_list current_directory_set;
+	unsigned virtual_id;
 };
 
 /* merge_trees() but with recursive ancestor consolidation */
-- 
1.6.0.1
