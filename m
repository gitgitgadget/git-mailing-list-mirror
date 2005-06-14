From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 6/7] Remove DUPCHECK, UNINTERESTING flags from epoch.h
Date: Tue, 14 Jun 2005 12:04:45 +1000
Message-ID: <20050614020445.23350.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0mj-00074w-Mk
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFNCI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFNCI5
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:08:57 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:12673 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261406AbVFNCEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:48 -0400
Received: (qmail 23360 invoked by uid 500); 14 Jun 2005 02:04:45 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This change:

* moves --show-breaks detection into show_commit of rev-list.c,
  thereby cleaning up the logic in epoch.c
* replaces epoch.c's use of VISITED flag with the SEEN flag
* removes UNINTERESTING, DUPCHECK and DISCONTINUITY flags
  from epoch.h
* defines a new flag, LAST_TRAVERSAL_FLAG to allow other modules
  to use flags not used by epoch.c
* redefines flags private to rev-list.c in terms of LAST_TRAVERSAL_FLAG

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c     |   22 ++++++++--------------
 epoch.h     |   14 ++++++--------
 rev-list.c  |   26 +++++++++++++++-----------
 traversal.h |    1 +
 4 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -26,11 +26,9 @@ static struct fraction *one = NULL;
 static struct fraction *zero = NULL;
 
 #define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
-#define IS_UNINTERESTING(c) ((c)->object.flags & UNINTERESTING)
-#define IS_VISITED(c) ((c)->object.flags & VISITED)
+#define IS_SEEN(c) ((c)->object.flags & SEEN)
 #define IS_BASE(c) ((c)->object.flags & BASE)
 #define IS_LOCAL(c) ((c)->object.flags & LOCAL)
-#define IS_DISCONTINUITY(c) ((c)->object.flags & DISCONTINUITY)
 
 /* leave the assertions defined for now, maybe null def them later */
 #define ASSERT(x,m,c) if (!(x)) { assertion_failed(__LINE__, __FUNCTION__, m, c); } else {}
@@ -220,8 +218,8 @@ static void visit_edge(struct traversal 
 {
 	/*
 	 * pre-condition:
-	 * 	from->object.flags & VISITED &&
-	 * 	to->object.util => (to->object.flags & VISITED)
+	 * 	from->object.flags & SEEN &&
+	 * 	to->object.util => (to->object.flags & SEEN)
 	 */ 
 	if (traversal->edge_visitor)
 		(*(traversal->edge_visitor))(from, to);
@@ -249,10 +247,10 @@ static void clean_commit(struct traversa
 	if (traversal->clean)
 		(*(traversal->clean))(commit);
 	commit->object.util = NULL;
-	commit->object.flags &= ~(EPOCH_FLAGS);
+	commit->object.flags &= ~(TRAVERSAL_FLAGS);
 	/*
 	 * post-condition:
-	 * 	commit->object.util == NULL && !(commit->object.flag & EPOCH_FLAGS)
+	 * 	commit->object.util == NULL && !(commit->object.flag & TRAVERSAL_FLAGS)
 	 */		
 }
 
@@ -438,13 +436,13 @@ static void sort_unvisited(
 	struct commit_list *parents = NULL;
         struct commit * top = *stack?(*stack)->item:NULL;
 
-	if (IS_VISITED(head)) {
+	if (IS_SEEN(head)) {
 		if (!IS_BASE(head)) {
 			visit_commit(traversal, head, 0);
 		}
 		return;
 	}
-	head->object.flags |= VISITED;
+	head->object.flags |= SEEN;
         if (IS_BASE(head)) {
 		ASSERT(!top, "stack empty on visit to base", head);
 	} else {
@@ -461,10 +459,6 @@ static void sort_unvisited(
 			visit_edge(traversal, head, parent);
 			sort_unvisited(parent, stack, traversal);
 		}		
-		top=(*stack)?(*stack)->item:NULL;
-		if (top && !is_parent_of(top, head)) {
-			top->object.flags |= DISCONTINUITY;
-		}			
 		commit_list_insert(head, stack);	
         }
 }
@@ -626,7 +620,7 @@ int traverse_from_head(struct commit *he
 			base->object.flags |= (BOUNDARY|BASE);
 			
 		/* reset flags set by last iteration */
-		next->object.flags &= ~(BASE|VISITED);
+		next->object.flags &= ~(BASE|SEEN);
 		
 		/* sort with the optimal algorithm */
 		if (HAS_EXACTLY_ONE_PARENT(next))
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -4,15 +4,13 @@
 /**
  * Flags used by merge order logic and also by rev-list.c
  */
-#define UNINTERESTING  (1u<<2)
-#define BOUNDARY       (1u<<3)
-#define VISITED        (1u<<4)
-#define DISCONTINUITY  (1u<<5)
-#define DUPCHECK       (1u<<6)
-#define LOCAL          (1u<<7)
-#define BASE           (1u<<8)
+#define SEEN                    (1u<<0)
+#define BOUNDARY                (SEEN<<1)
+#define LOCAL                   (BOUNDARY<<1)
+#define BASE                    (LOCAL<<1)
+#define LAST_TRAVERSAL_FLAG     (BASE)
 
-#define EPOCH_FLAGS (UNINTERESTING|BOUNDARY|VISITED|DISCONTINUITY|DUPCHECK|LOCAL|BASE)
+#define TRAVERSAL_FLAGS         (BOUNDARY|SEEN|LOCAL|BASE)
 
 /**
  * Return codes for emitter method. Also used by rev-list.c
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -3,8 +3,9 @@
 #include "epoch.h"
 #include "user.h"
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
+#define INTERESTING	(LAST_TRAVERSAL_FLAG << 1)
+#define UNINTERESTING   (INTERESTING << 1)
+#define DUPCHECK        (UNINTERESTING << 1)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -34,16 +35,18 @@ static char * local_author = NULL;
 static int prune_at_author = 0;
 static int wrt_author = 0;
 static int stop_traversal = 0;
+static struct commit * last_printed = NULL;
 
 static void show_commit(struct commit *commit)
 {
+
 	if (show_breaks) {
 		prefix = "| ";
-		if (commit->object.flags & DISCONTINUITY) {
-			prefix = "^ ";     
-		} else if (commit->object.flags & BOUNDARY) {
+		if (commit->object.flags & BOUNDARY) {
 			prefix = "= ";
-		} 
+		} else if (last_printed && !is_parent_of(commit, last_printed)) {
+			prefix = "^ ";     
+		}
         }        		
 	printf("%s%s", prefix, sha1_to_hex(commit->object.sha1));
 	if (show_parents) {
@@ -59,6 +62,7 @@ static void show_commit(struct commit *c
 		pretty_print_commit(commit_format, commit->buffer, ~0, pretty_header, sizeof(pretty_header));
 		printf("%s%c", pretty_header, hdr_termination);
 	}	
+	last_printed = commit;
 }
 
 static int filter_commit(struct commit * commit)
@@ -198,7 +202,7 @@ static void mark_authors_own_uninteresti
  */
 static void mark_ancestors_uninteresting(struct commit * head, struct commit *parent)
 {
-	unsigned int flags, visited, boundary, uninteresting;
+	unsigned int flags, seen, boundary, uninteresting;
 	struct commit_list *next;
 
 	if (!(head->object.flags & UNINTERESTING)) {
@@ -206,7 +210,7 @@ static void mark_ancestors_uninteresting
 	}
 
 	flags = parent->object.flags;
-	visited = flags & VISITED;
+	seen = flags & SEEN;
 	boundary = flags & BOUNDARY;
 	uninteresting = flags & UNINTERESTING;
 
@@ -215,9 +219,9 @@ static void mark_ancestors_uninteresting
 	 * We only need to recurse if
 	 *      we are not on the boundary and
 	 *      we have not already been marked uninteresting and
-	 *      we have already been visited.
+	 *      we have already been seen.
 	 *
-	 * The main sort_unvisited traverse will mark unreachable
+	 * The main traversal will mark unreachable
 	 * all uninteresting, unvisited parents as they are visited
 	 * so there is no need to duplicate that traversal here.
 	 *
@@ -226,7 +230,7 @@ static void mark_ancestors_uninteresting
 	 * uninteresting or will be once the sort_unvisited
 	 * traverse reaches them.
 	 */
-	if (uninteresting || boundary || !visited)
+	if (uninteresting || boundary || !seen)
 		return;
 	for (next = parent->parents; next; next = next->next)
 		mark_ancestors_uninteresting(parent, next->item);
diff --git a/traversal.h b/traversal.h
new file mode 100644
--- /dev/null
+++ b/traversal.h
@@ -0,0 +1 @@
+/* workaround for git-apply issue */
------------
