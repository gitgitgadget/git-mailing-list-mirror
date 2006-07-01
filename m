From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] Add get_merge_bases_clean()
Date: Sun, 2 Jul 2006 01:29:26 +0200
Message-ID: <20060701232926.GA2513@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net> <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org> <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 02 01:29:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwou3-0007lh-Im
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWGAX32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGAX32
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:29:28 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:26596
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751211AbWGAX32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 19:29:28 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 08D54B478; Sun,  2 Jul 2006 01:29:27 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23077>

Add get_merge_bases_clean(), a wrapper for get_merge_bases() that cleans
up after doing its work and make get_merge_bases() NOT clean up.
Single-shot programs like git-merge-base can use the dirty and fast
version.

Also move the object flags used in get_merge_bases() out of the range
defined in revision.h.  This fixes the "66ae0c77...ced9456a
89719209...262a6ef7" test of the ... operator which is introduced with
the next patch.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
All object flags should probably be gathered into one place to avoid
future conflicts.

 commit.c |   20 ++++++++++++++++----
 commit.h |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 0431027..593414d 100644
--- a/commit.c
+++ b/commit.c
@@ -849,9 +849,10 @@ void sort_in_topological_order_fn(struct
 
 /* merge-rebase stuff */
 
-#define PARENT1 1
-#define PARENT2 2
-#define UNINTERESTING 4
+/* bits #0..7 in revision.h */
+#define PARENT1		(1u<< 8)
+#define PARENT2		(1u<< 9)
+#define UNINTERESTING	(1u<<10)
 
 static struct commit *interesting(struct commit_list *list)
 {
@@ -1080,9 +1081,20 @@ struct commit_list *get_merge_bases(stru
 		tmp = next;
 	}
 
-	/* reset flags */
+	return result;
+}
+
+struct commit_list *get_merge_bases_clean(struct commit *rev1,
+                                          struct commit *rev2)
+{
+	unsigned int flags1 = rev1->object.flags;
+	unsigned int flags2 = rev2->object.flags;
+	struct commit_list *result = get_merge_bases(rev1, rev2);
+
 	clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
 	clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+	rev1->object.flags = flags1;
+	rev2->object.flags = flags2;
 
 	return result;
 }
diff --git a/commit.h b/commit.h
index 89b9dad..3a26e29 100644
--- a/commit.h
+++ b/commit.h
@@ -106,5 +106,6 @@ int register_commit_graft(struct commit_
 int read_graft_file(const char *graft_file);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
+extern struct commit_list *get_merge_bases_clean(struct commit *rev1, struct commit *rev2);
 
 #endif /* COMMIT_H */
-- 
1.4.1.rc2.gfc04
