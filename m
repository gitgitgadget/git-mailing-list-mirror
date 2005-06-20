From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 6/7] Prevent git-rev-list without --merge-order producing duplicates in output
Date: Mon, 20 Jun 2005 12:29:38 +1000
Message-ID: <20050620022938.28641.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:26:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBzK-0006v1-A3
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFTCb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFTCb6
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:31:58 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:23171 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261406AbVFTC3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:40 -0400
Received: (qmail 28651 invoked by uid 500); 20 Jun 2005 02:29:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If b is reachable from a, then:

	 git-rev-list a b

argument would print one of the commits twice.

This patch fixes that problem. A previous problem fixed it for the
--merge-order switch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.h    |   13 +++++++------
 rev-list.c |    5 +++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -10,11 +10,12 @@ typedef int (*emitter_func) (struct comm
 
 int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
 
-#define UNINTERESTING  (1u<<2)
-#define BOUNDARY       (1u<<3)
-#define VISITED        (1u<<4)
-#define DISCONTINUITY  (1u<<5)
-#define DUPCHECK       (1u<<6)
+#define UNINTERESTING   (1u<<2)
+#define BOUNDARY        (1u<<3)
+#define VISITED         (1u<<4)
+#define DISCONTINUITY   (1u<<5)
+#define DUPCHECK        (1u<<6)
+#define LAST_EPOCH_FLAG (1u<<6)
 
 
-#endif				/* EPOCH_H */
+#endif	/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -5,6 +5,7 @@
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
 #define COUNTED		(1u << 2)
+#define SHOWN		(LAST_EPOCH_FLAG << 2)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -29,6 +30,7 @@ static int show_breaks = 0;
 
 static void show_commit(struct commit *commit)
 {
+	commit->object.flags |= SHOWN;
 	if (show_breaks) {
 		prefix = "| ";
 		if (commit->object.flags & DISCONTINUITY) {
@@ -55,7 +57,7 @@ static void show_commit(struct commit *c
 
 static int filter_commit(struct commit * commit)
 {
-	if (commit->object.flags & UNINTERESTING)
+	if (commit->object.flags & (UNINTERESTING|SHOWN))
 		return CONTINUE;
 	if (min_age != -1 && (commit->date > min_age))
 		return CONTINUE;
@@ -63,7 +65,6 @@ static int filter_commit(struct commit *
 		return STOP;
 	if (max_count != -1 && !max_count--)
 		return STOP;
-
 	return DO;
 }
 
------------
