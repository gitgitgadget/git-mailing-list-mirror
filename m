From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/13] Introduce struct rev_list_fns to rev-list.c to reduce amount of conditional processing.
Date: Thu, 07 Jul 2005 02:39:34 +1000
Message-ID: <20050706163934.9851.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:57:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqDCT-0007UL-0a
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVGFQzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGFQvT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:51:19 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:3202 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262348AbVGFQjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:43 -0400
Received: (qmail 9861 invoked by uid 500); 6 Jul 2005 16:39:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Per a suggestion from Linus, I have introduced the rev_list_fns structure into
rev-list.c

The intent of this change is to make use of a strategy pattern to configure 
the behaviour of git-rev-list and so help limit the ever-increasing 
proliferation of boolean switches throughout the body of the code.

This change also makes --show-breaks imply --merge-order rather than require
it as before. There was no advantage to the previous strict argument
checking.

A subsequent change will take advantage of this pattern to introduce a
topological sort switch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 Documentation/git-rev-list.txt |    2 +
 rev-list.c                     |   54 +++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 18 deletions(-)

77418fc85cc40e56ef66c5031025399c5e6ed787
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -57,7 +57,7 @@ Commits marked with (^) are not parents 
 These "breaks" represent necessary discontinuities implied by trying to
 represent an arbtirary DAG in a linear form.
 
-*--show-breaks* is only valid if *--merge-order* is also specified.
+*--show-breaks* implies **-merge-order*.
 
 Author
 ------
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -39,6 +39,12 @@ static int merge_order = 0;
 static int show_breaks = 0;
 static int stop_traversal = 0;
 
+struct rev_list_fns {
+	struct commit_list * (*insert)(struct commit *, struct commit_list **);
+	struct commit_list * (*limit)(struct commit_list *);
+	void (*process)(struct commit_list *);
+};
+
 static void show_commit(struct commit *commit)
 {
 	commit->object.flags |= SHOWN;
@@ -410,9 +416,30 @@ static struct commit *get_commit_referen
 	die("%s is unknown object", name);
 }
 
+static void merge_order_sort(struct commit_list * list)
+{
+	if (sort_list_in_merge_order(list, &process_commit))
+		die("commit graph traversal failed");
+}
+
+struct rev_list_fns default_fns = {
+	&insert_by_date,
+	&limit_list,
+        &show_commit_list
+};
+
+struct rev_list_fns merge_order_fns = {
+	&commit_list_insert,
+	NULL,
+	&merge_order_sort
+};
+
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
+	struct commit_list *sorted = NULL;
+	struct commit_list **list_tail = &list;
+	struct rev_list_fns * fns = &default_fns;
 	int i, limited = 0;
 
 	for (i = 1 ; i < argc; i++) {
@@ -468,6 +495,7 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--show-breaks")) {
 			show_breaks = 1;
+			merge_order = 1;
 			continue;
 		}
 
@@ -477,26 +505,18 @@ int main(int argc, char **argv)
 			arg++;
 			limited = 1;
 		}
-		if (show_breaks && !merge_order)
-			usage(rev_list_usage);
 		commit = get_commit_reference(arg, flags);
 		if (!commit)
 			continue;
-		if (!merge_order) 
-			insert_by_date(commit, &list);
-		else 
-			commit_list_insert(commit, &list);
+		list_tail = &commit_list_insert(commit, list_tail)->next;
 	}
-
-	if (!merge_order) {		
-	        if (limited)
-			list = limit_list(list);
-		show_commit_list(list);
-	} else {
-		if (sort_list_in_merge_order(list, &process_commit)) {
-			  die("merge order sort failed\n");
-		}
-	}
-
+	if (merge_order)
+		fns=&merge_order_fns;
+	while (list)
+		fns->insert(pop_commit(&list), &sorted);
+	list=sorted;
+	if (limited && fns->limit)
+		list = fns->limit(list);
+	fns->process(list);
 	return 0;
 }
------------
