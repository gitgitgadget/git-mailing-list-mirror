From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] rev-list: '--indent' oneline output
Date: Sun, 20 May 2007 18:00:29 +0200
Message-ID: <1179676829751-git-send-email-prohaska@zib.de>
References: <20070518215603.GS15393@fieldses.org>
Cc: bfields@fieldses.org, torvalds@linux-foundation.org,
	junkio@cox.net, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 18:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpnqd-00047k-TG
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119AbXETQB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757355AbXETQB0
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:01:26 -0400
Received: from mailer.zib.de ([130.73.108.11]:41195 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757011AbXETQBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 12:01:25 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4KG0THN020832;
	Sun, 20 May 2007 18:00:29 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4KG0TcY017636;
	Sun, 20 May 2007 18:00:29 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <20070518215603.GS15393@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47848>

Summaries in oneline output are indented to show the location of
parents in merge commits. Indentation level is computed as the
smallest sum of parent locations along all paths that reach the
commit.

As a result, the output of
    git-rev-list --pretty=oneline --topo-order --indent
is formatted in a way that resembles merge summaries. All commits that
were pulled from a branch are indented with one additional space below
the summary of the merge commit.

WARNING: this patch changes the binary layout of commit.h. This could
probably be avoided by putting a bit more effort into the
implementation.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-rev-list.c |    7 ++++++-
 commit.h           |    1 +
 revision.c         |   19 +++++++++++++++----
 revision.h         |    3 ++-
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ebf53f5..fd880b0 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -50,6 +50,7 @@ static const char *header_prefix;
 
 static void show_commit(struct commit *commit)
 {
+	int i;
 	if (show_timestamp)
 		printf("%lu ", commit->date);
 	if (header_prefix)
@@ -86,8 +87,12 @@ static void show_commit(struct commit *commit)
 		     parents = parents->next)
 			parents->item->object.flags &= ~TMP_MARK;
 	}
-	if (revs.commit_format == CMIT_FMT_ONELINE)
+	if (revs.commit_format == CMIT_FMT_ONELINE) {
 		putchar(' ');
+		if (revs.indent)
+			for (i = 0; i < commit->level; i++)
+				putchar(' ');
+	}
 	else
 		putchar('\n');
 
diff --git a/commit.h b/commit.h
index 86e8dca..e0e7955 100644
--- a/commit.h
+++ b/commit.h
@@ -17,6 +17,7 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
+	int level;
 };
 
 extern int save_commit_buffer;
diff --git a/revision.c b/revision.c
index 0125d41..c965a23 100644
--- a/revision.c
+++ b/revision.c
@@ -372,7 +372,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
-	int add, rest;
+	int add, rest, indent;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -421,18 +421,24 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
 
 	rest = !revs->first_parent_only;
-	for (parent = commit->parents, add = 1; parent; add = rest) {
+	for (parent = commit->parents, add = 1, indent = 0; parent; add = rest, indent++) {
 		struct commit *p = parent->item;
 
 		parent = parent->next;
 		if (parse_commit(p) < 0)
 			return -1;
 		p->object.flags |= left_flag;
-		if (p->object.flags & SEEN)
+		if (p->object.flags & SEEN) {
+			if (commit->level + indent < p->level) {
+				p->level = commit->level + indent;
+			}
 			continue;
+		}
 		p->object.flags |= SEEN;
-		if (add)
+		if (add) {
+			p->level = commit->level + indent;
 			insert_by_date(p, list);
+		}
 	}
 	return 0;
 }
@@ -1080,6 +1086,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->commit_format = get_commit_format(arg+8);
 				continue;
 			}
+			if (!strcmp(arg, "--indent")) {
+				revs->indent = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--root")) {
 				revs->show_root_diff = 1;
 				continue;
@@ -1252,6 +1262,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
+				commit->level = 0;
 				insert_by_date(commit, &revs->commits);
 			}
 		}
diff --git a/revision.h b/revision.h
index 2845167..2a45955 100644
--- a/revision.h
+++ b/revision.h
@@ -63,7 +63,8 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
-			abbrev_commit:1;
+			abbrev_commit:1,
+			indent:1;
 	enum date_mode date_mode;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
-- 
1.5.2.rc3.88.g9f73-dirty
