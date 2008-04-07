From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 4/4] log and rev-list: Improve --graph output when commits have been pruned
Date: Mon,  7 Apr 2008 01:01:21 -0700
Message-ID: <1207555281-9362-4-git-send-email-adam@adamsimpkins.net>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-3-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 10:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimIs-0007zd-Oa
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbYDGIB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYDGIB0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:01:26 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:55233 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYDGIBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:01:25 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 96C071B4049;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 401031B4068;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id EB6A714100BB; Mon,  7 Apr 2008 01:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207555281-9362-3-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78955>

This change automatically enables parent rewriting when --graph is
specified.  This makes the graph output look much nicer when commit
pruning is enabled.

The existing rev_info "parents" flag has been split into
two flags: "rewrite_parents" causes the parents to be rewritten, while
"print_parents" causes the log and rev-list commands to print the
parents.  The --parents option now enables both rewrite_parents and
print_parents, while --graph enables only rewrite_parents.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 builtin-rev-list.c |    2 +-
 log-tree.c         |    4 ++--
 revision.c         |    8 +++++---
 revision.h         |    3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ac6a6f9..f8103bd 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -79,7 +79,7 @@ static void show_commit(struct commit *commit)
 		      stdout);
 	else
 		fputs(sha1_to_hex(commit->object.sha1), stdout);
-	if (revs.parents) {
+	if (revs.print_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
 			printf(" %s", sha1_to_hex(parents->item->object.sha1));
diff --git a/log-tree.c b/log-tree.c
index d2cb26a..4ad10af 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -240,7 +240,7 @@ void show_log(struct rev_info *opt, const char *sep)
 				putchar('>');
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
-		if (opt->parents)
+		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(commit);
 		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
@@ -305,7 +305,7 @@ void show_log(struct rev_info *opt, const char *sep)
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
-		if (opt->parents)
+		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
diff --git a/revision.c b/revision.c
index 6a1f513..7d9d333 100644
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
@@ -1204,6 +1205,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			}
 			if (!prefixcmp(arg, "--graph")) {
 				revs->topo_order = 1;
+				revs->rewrite_parents = 1;
 				revs->graph = graph_init();
 				continue;
 			}
@@ -1538,13 +1540,13 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
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
index d06b991..170543d 100644
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
1.5.3.6
