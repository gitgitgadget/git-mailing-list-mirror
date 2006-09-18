From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] revision traversal: prepare for commit log match.
Date: Sun, 17 Sep 2006 17:42:25 -0700
Message-ID: <7vac4yyphq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Blin <kai.blin@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 18 02:42:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7DV-0000pg-Ug
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 02:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWIRAm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWIRAm2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 20:42:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31969 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965175AbWIRAm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 20:42:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918004226.MNCX12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 20:42:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PciD1V00R1kojtg0000000
	Sun, 17 Sep 2006 20:42:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27216>

This is from a suggestion by Linus, just to mark the locations where we
need to modify to actually implement the filtering.

We do not have any actual filtering code yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 revision.c |   13 +++++++++++++
 revision.h |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index db01682..8fda20d 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,8 @@ #include "commit.h"
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
+#include <regex.h>
+#include "grep.h"
 
 static char *path_name(struct name_path *path, const char *name)
 {
@@ -1026,6 +1028,15 @@ static void mark_boundary_to_show(struct
 	}
 }
 
+static int commit_match(struct commit *commit, struct rev_info *opt)
+{
+	if (!opt->header_filter && !opt->message_filter)
+		return 1;
+
+	/* match it here */
+	return 1;
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -1085,6 +1096,8 @@ struct commit *get_revision(struct rev_i
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
 			continue;
+		if (!commit_match(commit, revs))
+			continue;
 		if (revs->prune_fn && revs->dense) {
 			/* Commit without changes? */
 			if (!(commit->object.flags & TREECHANGE)) {
diff --git a/revision.h b/revision.h
index c1f71af..35a1db4 100644
--- a/revision.h
+++ b/revision.h
@@ -67,6 +67,10 @@ struct rev_info {
 	const char	*add_signoff;
 	const char	*extra_headers;
 
+	/* Filter by commit log message */
+	struct grep_opt	*header_filter;
+	struct grep_opt	*message_filter;
+
 	/* special limits */
 	int max_count;
 	unsigned long max_age;
-- 
1.4.2.1.g414e5
