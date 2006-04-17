From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list --boundary: show boundary commits even when limited otherwise.
Date: Sun, 16 Apr 2006 18:53:43 -0700
Message-ID: <7vy7y5nf14.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060416115403.GS12638@nowhere.earth>
	<7vslodp4sk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 17 03:54:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVIwD-0003ME-Va
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 03:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWDQBxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 21:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWDQBxq
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 21:53:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22168 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750956AbWDQBxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 21:53:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417015345.QIZB24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Apr 2006 21:53:45 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <7vslodp4sk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 16 Apr 2006 14:51:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18811>

The boundary commits are shown for UI like gitk to draw them as
soon as topo-order sorting allows, and should not be omitted by
get_revision() filtering logic.  As long as their immediate
child commits are shown, we should not filter them out.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  > The real issue is "git-rev-list --boundary ran..ge -- path" does
  > not show boundary.  I am not sure if it even worked in the past;
  > will take a look.

  I _think_ this fixes it, but this is rev-list which I feel a
  bit uneasy touching.  A lower-impact approach of not filtering
  BOUNDARY commits at all does not work well; it  shows many
  isolated open-circle commits in gitk that do not touch the
  specified paths.

  I got tired of updating the private object.flags users, so
  just reserved the lower 16 bits for use of revision.c while I
  was at it.

 http-push.c |   10 +++++-----
 rev-list.c  |    4 ++--
 revision.c  |   29 +++++++++++++++++++++++++++--
 revision.h  |    3 ++-
 4 files changed, 36 insertions(+), 10 deletions(-)

298196646f35b6f5bc2131074204826d39aff8cf
diff --git a/http-push.c b/http-push.c
index 19a0f77..e7f7f44 100644
--- a/http-push.c
+++ b/http-push.c
@@ -60,12 +60,12 @@ #define LOCK_REQUEST "<?xml version=\"1.
 #define LOCK_TIME 600
 #define LOCK_REFRESH 30
 
-/* bits #0-6 in revision.h */
+/* bits #0-15 in revision.h */
 
-#define LOCAL    (1u << 7)
-#define REMOTE   (1u << 8)
-#define FETCHING (1u << 9)
-#define PUSHING  (1u << 10)
+#define LOCAL    (1u<<16)
+#define REMOTE   (1u<<17)
+#define FETCHING (1u<<18)
+#define PUSHING  (1u<<19)
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
diff --git a/rev-list.c b/rev-list.c
index 963707a..f5511e7 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -8,9 +8,9 @@ #include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 
-/* bits #0-6 in revision.h */
+/* bits #0-15 in revision.h */
 
-#define COUNTED		(1u<<7)
+#define COUNTED		(1u<<16)
 
 static const char rev_list_usage[] =
 "git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
diff --git a/revision.c b/revision.c
index 0505f3f..e1f9816 100644
--- a/revision.c
+++ b/revision.c
@@ -750,6 +750,17 @@ static void rewrite_parents(struct rev_i
 	}
 }
 
+static void mark_boundary_to_show(struct commit *commit)
+{
+	struct commit_list *p = commit->parents;
+	while (p) {
+		commit = p->item;
+		p = p->next;
+		if (commit->object.flags & BOUNDARY)
+			commit->object.flags |= BOUNDARY_SHOW;
+	}
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -787,8 +798,20 @@ struct commit *get_revision(struct rev_i
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
-		if (!(commit->object.flags & BOUNDARY) &&
-		    (commit->object.flags & UNINTERESTING))
+
+		/* We want to show boundary commits only when their
+		 * children are shown.  When path-limiter is in effect,
+		 * rewrite_parents() drops some commits from getting shown,
+		 * and there is no point showing boundary parents that
+		 * are not shown.  After rewrite_parents() rewrites the
+		 * parents of a commit that is shown, we mark the boundary
+		 * parents with BOUNDARY_SHOW.
+		 */
+		if (commit->object.flags & BOUNDARY_SHOW) {
+			commit->object.flags |= SHOWN;
+			return commit;
+		}
+		if (commit->object.flags & UNINTERESTING)
 			continue;
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
@@ -801,6 +824,8 @@ struct commit *get_revision(struct rev_i
 			if (revs->parents)
 				rewrite_parents(revs, commit);
 		}
+		if (revs->boundary)
+			mark_boundary_to_show(commit);
 		commit->object.flags |= SHOWN;
 		return commit;
 	} while (revs->commits);
diff --git a/revision.h b/revision.h
index 8970b57..4b27043 100644
--- a/revision.h
+++ b/revision.h
@@ -7,7 +7,8 @@ #define TREECHANGE	(1u<<2)
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
 #define BOUNDARY	(1u<<5)
-#define ADDED		(1u<<6)	/* Parents already parsed and added? */
+#define BOUNDARY_SHOW	(1u<<6)
+#define ADDED		(1u<<7)	/* Parents already parsed and added? */
 
 struct rev_info;
 
-- 
1.3.0.rc4.g878b
