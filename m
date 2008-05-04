From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/3] revision API: split parent rewriting and parent printing options
Date: Sun,  4 May 2008 03:36:52 -0700
Message-ID: <1209897414-10091-2-git-send-email-adam@adamsimpkins.net>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 12:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsbcY-00071l-EI
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 12:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbYEDKhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 06:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbYEDKhb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 06:37:31 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:50472 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbYEDKg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 06:36:57 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id C17CB1B4009;
	Sun,  4 May 2008 06:36:55 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 6BEA21B4036;
	Sun,  4 May 2008 06:36:55 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 4B16414100C0; Sun,  4 May 2008 03:36:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.128.gc15ea
In-Reply-To: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81165>

This change allows parent rewriting to be performed without causing
the log and rev-list commands to print the parents.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 builtin-rev-list.c |    2 +-
 log-tree.c         |    4 ++--
 revision.c         |    7 ++++---
 revision.h         |    3 ++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index edc0bd3..476a870 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -77,7 +77,7 @@ static void show_commit(struct commit *commit)
 		      stdout);
 	else
 		fputs(sha1_to_hex(commit->object.sha1), stdout);
-	if (revs.parents) {
+	if (revs.print_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
 			printf(" %s", sha1_to_hex(parents->item->object.sha1));
diff --git a/log-tree.c b/log-tree.c
index d3fb0e5..74829d7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -231,7 +231,7 @@ void show_log(struct rev_info *opt)
 				putchar('>');
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
-		if (opt->parents)
+		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(commit);
 		putchar(opt->diffopt.line_termination);
@@ -271,7 +271,7 @@ void show_log(struct rev_info *opt)
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
-		if (opt->parents)
+		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
diff --git a/revision.c b/revision.c
index 4231ea2..a813304 100644
--- a/revision.c
+++ b/revision.c
@@ -1105,7 +1105,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				}
 			}
 			if (!strcmp(arg, "--parents")) {
-				revs->parents = 1;
+				revs->rewrite_parents = 1;
+				revs->print_parents = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--dense")) {
@@ -1524,13 +1525,13 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
 			/* drop merges unless we want parenthood */
-			if (!revs->parents)
+			if (!revs->rewrite_parents)
 				return commit_ignore;
 			/* non-merge - always ignore it */
 			if (!commit->parents || !commit->parents->next)
 				return commit_ignore;
 		}
-		if (revs->parents && rewrite_parents(revs, commit) < 0)
+		if (revs->rewrite_parents && rewrite_parents(revs, commit) < 0)
 			return commit_error;
 	}
 	return commit_show;
diff --git a/revision.h b/revision.h
index 31217f8..201bd97 100644
--- a/revision.h
+++ b/revision.h
@@ -46,7 +46,8 @@ struct rev_info {
 			unpacked:1, /* see also ignore_packed below */
 			boundary:2,
 			left_right:1,
-			parents:1,
+			rewrite_parents:1,
+			print_parents:1,
 			reverse:1,
 			cherry_pick:1,
 			first_parent_only:1;
-- 
1.5.5.1.128.gc15ea
