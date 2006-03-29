From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Tue, 28 Mar 2006 16:50:04 -0800
Message-ID: <7vacbagjlv.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	<17448.54558.865097.519248@cargo.ozlabs.ibm.com>
	<7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
	<17449.48630.370867.10251@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 02:50:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOt2-0003Yc-PI
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWC2AuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWC2AuJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:50:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27050 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750718AbWC2AuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 19:50:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329005006.VBQX17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 19:50:06 -0500
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18151>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> How about this alternative patch, then?  It turned out to be
>> quite convoluted as I feared.
>
> That's brilliant.  Thank you!  With the patch to gitk below, the
> graph display on Linus' example looks much saner.
>
> Could you check in your patch to the git.git repository, please?

The patch I sent was a total mess, and the one in "pu" right now
was somewhat cleaned up but was still far suboptimal.  **Blush**

Most notably, the code from yesterday was re-injecting the
parents of the boundary commits into the list marked as
UNINTERESTING, which was unnecessary and stupid.  This one just
pops boundary commits off the list after consuming it.

Here is a cleaned-up one for eyeballing.

Although I am reasonably sure that this does not affect the way
it works when --boundary is not given, I'd pretty much
appreciate an independent sanity check on this one.  rev-list is
so fundamental to git.

-- >8 --
diff --git a/rev-list.c b/rev-list.c
index 441c437..f3a989c 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -7,9 +7,9 @@ #include "blob.h"
 #include "diff.h"
 #include "revision.h"
 
-/* bits #0-4 in revision.h */
+/* bits #0-5 in revision.h */
 
-#define COUNTED		(1u<<5)
+#define COUNTED		(1u<<6)
 
 static const char rev_list_usage[] =
 "git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -51,6 +51,8 @@ static void show_commit(struct commit *c
 		printf("%lu ", commit->date);
 	if (commit_prefix[0])
 		fputs(commit_prefix, stdout);
+	if (commit->object.flags & BOUNDARY)
+		putchar('-');
 	fputs(sha1_to_hex(commit->object.sha1), stdout);
 	if (show_parents) {
 		struct commit_list *parents = commit->parents;
diff --git a/revision.c b/revision.c
index d7678cf..745b0d2 100644
--- a/revision.c
+++ b/revision.c
@@ -419,6 +419,27 @@ static void limit_list(struct rev_info *
 			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
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
+	}
 	revs->commits = newlist;
 }
 
@@ -591,6 +612,10 @@ int setup_revisions(int argc, const char
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
@@ -731,13 +756,17 @@ struct commit *get_revision(struct rev_i
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
@@ -745,8 +774,19 @@ struct commit *get_revision(struct rev_i
 			rewrite_parents(commit);
 		}
 		/* More to go? */
-		if (revs->max_count)
-			pop_most_recent_commit(&revs->commits, SEEN);
+		if (revs->max_count) {
+			if (commit->object.flags & BOUNDARY) {
+				/* this is already uninteresting,
+				 * so there is no point popping its
+				 * parents into the list.
+				 */
+				struct commit_list *it = revs->commits;
+				revs->commits = it->next;
+				free(it);
+			}
+			else
+				pop_most_recent_commit(&revs->commits, SEEN);
+		}
 		commit->object.flags |= SHOWN;
 		return commit;
 next:
diff --git a/revision.h b/revision.h
index 6c2beca..61e6bc9 100644
--- a/revision.h
+++ b/revision.h
@@ -6,6 +6,7 @@ #define UNINTERESTING   (1u<<1)
 #define TREECHANGE	(1u<<2)
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
+#define BOUNDARY	(1u<<5)
 
 struct rev_info;
 
@@ -32,7 +33,8 @@ struct rev_info {
 			blob_objects:1,
 			edge_hint:1,
 			limited:1,
-			unpacked:1;
+			unpacked:1,
+			boundary:1;
 
 	/* special limits */
 	int max_count;
