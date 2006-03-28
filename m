From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Mon, 27 Mar 2006 23:52:38 -0800
Message-ID: <7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	<17448.54558.865097.519248@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Mar 28 09:52:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO90O-0008Ma-RL
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 09:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWC1Hwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 02:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWC1Hwk
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 02:52:40 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15772 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751358AbWC1Hwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 02:52:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328075239.OZEC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 02:52:39 -0500
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18113>

Paul Mackerras <paulus@samba.org> writes:

>> Not trivially.  We do not keep track of who are children of a
>> commit.
>
> Hmmm... how does the --topo-order logic ensure that parents are shown
> after all of their children?  Essentially I want that logic applied to
> the boundary parent commits as well as the requested commits.

The sort happens after we sift which commits are interesting and
which are not, and uninteresting ones are not subject to
sorting, so that is too late.

> The other thing is that if git-rev-list can actually list those
> boundary parents, complete with the whole commit message if --header
> is given, then that will save gitk from having to do a git-cat-file to
> get that information.

How about this alternative patch, then?  It turned out to be
quite convoluted as I feared.

For example, with this graph:

              C side
             /
	A---B---D master

This command

	$ git rev-list --boundary --header --parents side..master

would give:

	D B
        tree D^{tree}
        parent B
        ...
        \0-B A
        tree B^{tree}
        parent A
        ...
        \0

That is, it includes the UNINTERESING commits at the boundary,
which are usually not shown, in its output, but their object
names are prefixed with a '-'.

---
diff --git a/rev-list.c b/rev-list.c
index 441c437..a1f129b 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -7,9 +7,9 @@
 #include "diff.h"
 #include "revision.h"
 
-/* bits #0-4 in revision.h */
+/* bits #0-5 in revision.h */
 
-#define COUNTED		(1u<<5)
+#define COUNTED		(1u<<6)
 
 static const char rev_list_usage[] =
 "git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -51,6 +51,8 @@
 		printf("%lu ", commit->date);
 	if (commit_prefix[0])
 		fputs(commit_prefix, stdout);
+	if (commit->object.flags & BOUNDARY)
+		putchar('-');
 	fputs(sha1_to_hex(commit->object.sha1), stdout);
 	if (show_parents) {
 		struct commit_list *parents = commit->parents;
diff --git a/revision.c b/revision.c
index d67718c..a9b8f9d 100644
--- a/revision.c
+++ b/revision.c
@@ -390,6 +390,21 @@
 	}
 }
 
+void debug_list(struct commit_list *l)
+{
+	int i = 0;
+	while (l) {
+		struct commit *commit = l->item;
+		printf("%d: %x %s\n",
+		       i,
+		       commit->object.flags,
+		       sha1_to_hex(commit->object.sha1));
+		printf("  %s\n", commit->buffer);
+		l = l->next;
+		i++;
+	}
+}
+
 static void limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -418,6 +433,27 @@
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
 		p = &commit_list_insert(commit, p)->next;
+	}
+	if (revs->boundary) {
+		list = newlist;
+		while (list) {
+			struct commit *commit = list->item;
+			struct object *obj = &commit->object;
+			struct commit_list *parent = commit->parents;
+			if (obj->flags & (UNINTERESTING|BOUNDARY)) {
+				list = list->next;
+				continue;
+			}
+			while (parent) {
+				struct commit *pcommit = parent->item;
+				parent = parent->next;
+				if (!(pcommit->object.flags & UNINTERESTING))
+					continue;
+				pcommit->object.flags |= BOUNDARY;
+				p = &commit_list_insert(pcommit, p)->next;
+			}
+			list = list->next;
+		}
 	}
 	revs->commits = newlist;
 }
@@ -587,10 +623,14 @@
 				revs->remove_empty_trees = 1;
 				continue;
 			}
-			if (!strncmp(arg, "--no-merges", 11)) {
+			if (!strcmp(arg, "--no-merges")) {
 				revs->no_merges = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--boundary")) {
+				revs->boundary = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--objects")) {
 				revs->tag_objects = 1;
 				revs->tree_objects = 1;
@@ -731,13 +771,17 @@
 	do {
 		struct commit *commit = revs->commits->item;
 
-		if (commit->object.flags & (UNINTERESTING|SHOWN))
+		if (commit->object.flags & SHOWN)
+			goto next;
+		if (!(commit->object.flags & BOUNDARY) &&
+		    (commit->object.flags & UNINTERESTING))
 			goto next;
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			goto next;
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			return NULL;
-		if (revs->no_merges && commit->parents && commit->parents->next)
+		if (revs->no_merges &&
+		    commit->parents && commit->parents->next)
 			goto next;
 		if (revs->prune_fn && revs->dense) {
 			if (!(commit->object.flags & TREECHANGE))
@@ -745,8 +789,12 @@
 			rewrite_parents(commit);
 		}
 		/* More to go? */
-		if (revs->max_count)
-			pop_most_recent_commit(&revs->commits, SEEN);
+		if (revs->max_count) {
+			unsigned flag = SEEN;
+			if (commit->object.flags & BOUNDARY)
+				flag |= UNINTERESTING;
+			pop_most_recent_commit(&revs->commits, flag);
+		}
 		commit->object.flags |= SHOWN;
 		return commit;
 next:
diff --git a/revision.h b/revision.h
index 6c2beca..61e6bc9 100644
--- a/revision.h
+++ b/revision.h
@@ -6,6 +6,7 @@
 #define TREECHANGE	(1u<<2)
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
+#define BOUNDARY	(1u<<5)
 
 struct rev_info;
 
@@ -32,7 +33,8 @@
 			blob_objects:1,
 			edge_hint:1,
 			limited:1,
-			unpacked:1;
+			unpacked:1,
+			boundary:1;
 
 	/* special limits */
 	int max_count;
