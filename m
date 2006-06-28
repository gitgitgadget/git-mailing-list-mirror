From: Linus Torvalds <torvalds@osdl.org>
Subject: Prepare "git-merge-tree" for future work
Date: Wed, 28 Jun 2006 11:18:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606281054470.3782@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jun 28 20:18:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvecb-0002ng-At
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 20:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWF1SSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWF1SSh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 14:18:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWF1SSg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 14:18:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5SIISnW000642
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Jun 2006 11:18:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5SIIRxq021725;
	Wed, 28 Jun 2006 11:18:28 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22814>


This changes how "git-merge-tree" works in two ways:

 - instead of printing things out as we walk the trees, we save the 
   results in memory
 - when we've walked the tree fully, we print out the results in a more 
   explicit way, describing the data.

This is basically preparatory work for extending the git-merge-tree 
functionality in interestign directions.

In particular, git-merge-tree is also how you would create a diff between 
two trees _without_ necessarily creating the merge commit itself. In other 
words, if you were to just wonder what another branch adds, you should be 
able to (eventually) just do

	git merge-tree -p $base HEAD $otherbranch

to generate a diff of what the merge would look like. The current merge 
tree already basically has all the smarts for this, and the explanation of 
the results just means that hopefully somebody else than me could do the 
boring work.

(You'd basically be able to do the above diff by just changing the 
printout format for the explanation, and making the "changed in both" 
first do a three-way merge before it diffs the result).

The other thing that the in-memory format allows is rename detection 
(which the current code does not do). That's the basic reason why we don't 
want to just explain the differences as we go along - because we want to 
be able to look at the _other_ differences to see whether the reason an 
entry got deleted in either branch was perhaps because it got added in 
another place..

Rename detection should be a fairly trivial pass in between the tree 
diffing and the explanation.

In the meantime, this doesn't actually do anything new, it just outputs 
the information in a more verbose manner. 

For an example merge, commit 5ab2c0a47574c92f92ea3709b23ca35d96319edd in 
the git tree works well and shows renames, along with true removals and 
additions and files that got changed in both branches. Too see that as a 
tree merge, do:

	git-merge-tree 64e86c57 c5c23745 928e47e3

where the two last ones are the tips that got merged, and the first one is 
the merge base.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/merge-tree.c b/merge-tree.c
index 9dcaab7..fd0c211 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -1,11 +1,79 @@
 #include "cache.h"
 #include "tree-walk.h"
+#include "blob.h"
 
 static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
 
+struct merge_list {
+	struct merge_list *next;
+	struct merge_list *link;	/* other stages for this object */
+
+	unsigned int stage : 2,
+		     flags : 30;
+	unsigned int mode;
+	const char *path;
+	struct blob *blob;
+};
+
+static struct merge_list *merge_result, **merge_result_end = &merge_result;
+
+static void add_merge_entry(struct merge_list *entry)
+{
+	*merge_result_end = entry;
+	merge_result_end = &entry->next;
+}
+
 static void merge_trees(struct tree_desc t[3], const char *base);
 
+static const char *explanation(struct merge_list *entry)
+{
+	switch (entry->stage) {
+	case 0:
+		return "merged";
+	case 3:
+		return "added in remote";
+	case 2:
+		if (entry->link)
+			return "added in both";
+		return "added in local";
+	}
+
+	/* Existed in base */
+	entry = entry->link;
+	if (!entry)
+		return "removed in both";
+
+	if (entry->link)
+		return "changed in both";
+
+	if (entry->stage == 3)
+		return "removed in local";
+	return "removed in remote";
+}
+
+static void show_result_list(struct merge_list *entry)
+{
+	printf("%s\n", explanation(entry));
+	do {
+		struct merge_list *link = entry->link;
+		static const char *desc[4] = { "result", "base", "our", "their" };
+		printf("  %-6s %o %s %s\n", desc[entry->stage], entry->mode, sha1_to_hex(entry->blob->object.sha1), entry->path);
+		entry = link;
+	} while (entry);
+}
+
+static void show_result(void)
+{
+	struct merge_list *walk;
+
+	walk = merge_result;
+	while (walk) {
+		show_result_list(walk);
+		walk = walk->next;
+	}
+}
+
 /* An empty entry never compares same, not even to another empty entry */
 static int same_entry(struct name_entry *a, struct name_entry *b)
 {
@@ -15,24 +83,34 @@ static int same_entry(struct name_entry 
 		a->mode == b->mode;
 }
 
-static const char *sha1_to_hex_zero(const unsigned char *sha1)
+static struct merge_list *create_entry(unsigned stage, unsigned mode, const unsigned char *sha1, const char *path)
 {
-	if (sha1)
-		return sha1_to_hex(sha1);
-	return "0000000000000000000000000000000000000000";
+	struct merge_list *res = xmalloc(sizeof(*res));
+
+	memset(res, 0, sizeof(*res));
+	res->stage = stage;
+	res->path = path;
+	res->mode = mode;
+	res->blob = lookup_blob(sha1);
+	return res;
 }
 
 static void resolve(const char *base, struct name_entry *branch1, struct name_entry *result)
 {
+	struct merge_list *orig, *final;
+	const char *path;
+
 	/* If it's already branch1, don't bother showing it */
 	if (!branch1)
 		return;
 
-	printf("0 %06o->%06o %s->%s %s%s\n",
-		branch1->mode, result->mode,
-		sha1_to_hex_zero(branch1->sha1),
-		sha1_to_hex_zero(result->sha1),
-		base, result->path);
+	path = strdup(mkpath("%s%s", base, result->path));
+	orig = create_entry(2, branch1->mode, branch1->sha1, path);
+	final = create_entry(0, result->mode, result->sha1, path);
+
+	final->link = orig;
+
+	add_merge_entry(final);
 }
 
 static int unresolved_directory(const char *base, struct name_entry n[3])
@@ -71,16 +149,40 @@ static int unresolved_directory(const ch
 	return 1;
 }
 
+
+static struct merge_list *link_entry(unsigned stage, const char *base, struct name_entry *n, struct merge_list *entry)
+{
+	const char *path;
+	struct merge_list *link;
+
+	if (!n->mode)
+		return entry;
+	if (entry)
+		path = entry->path;
+	else
+		path = strdup(mkpath("%s%s", base, n->path));
+	link = create_entry(stage, n->mode, n->sha1, path);
+	link->link = entry;
+	return link;
+}
+
 static void unresolved(const char *base, struct name_entry n[3])
 {
+	struct merge_list *entry = NULL;
+
 	if (unresolved_directory(base, n))
 		return;
-	if (n[0].sha1)
-		printf("1 %06o %s %s%s\n", n[0].mode, sha1_to_hex(n[0].sha1), base, n[0].path);
-	if (n[1].sha1)
-		printf("2 %06o %s %s%s\n", n[1].mode, sha1_to_hex(n[1].sha1), base, n[1].path);
-	if (n[2].sha1)
-		printf("3 %06o %s %s%s\n", n[2].mode, sha1_to_hex(n[2].sha1), base, n[2].path);
+
+	/*
+	 * Do them in reverse order so that the resulting link
+	 * list has the stages in order - link_entry adds new
+	 * links at the front.
+	 */
+	entry = link_entry(3, base, n + 2, entry);
+	entry = link_entry(2, base, n + 1, entry);
+	entry = link_entry(1, base, n + 0, entry);
+
+	add_merge_entry(entry);
 }
 
 /*
@@ -172,5 +274,7 @@ int main(int argc, char **argv)
 	free(buf1);
 	free(buf2);
 	free(buf3);
+
+	show_result();
 	return 0;
 }
