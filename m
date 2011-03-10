From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 05/10] rev-list/log: factor out revision mark generation
Date: Thu, 10 Mar 2011 15:44:58 +0100
Message-ID: <3d5377ae86c22a73bdce7896abe2953019039e0e.1299767412.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB7-0007ob-5o
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab1CJOsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:48:51 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33442 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581Ab1CJOst (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:49 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 04F3D20901;
	Thu, 10 Mar 2011 09:48:49 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 10 Mar 2011 09:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=2pJl9p3Y14saAbnryn9gYiU3EVw=; b=WijJnaO55E4pC8xd9LrASeJSb16+mDtu3ivc+Ir1ALLUWolTEkjYDe3Ve46h9F4nfD1rAnEMwMnvjQeoqGbqw98tzyHCTVlj+GNKpPWZ3KXP+0q+OBhClBm3K0N93VZHnXYlBWr0eo7crF/Ri+jJzJ9UWx9TTOPKpnA1Eg2u7u0=
X-Sasl-enc: n9w+ToH8O7WopSjzG/j5r6qTgKLrhRpOwbjgJ9wpoXPI 1299768528
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4288640D3AC;
	Thu, 10 Mar 2011 09:48:48 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168826>

Currently, we have identical code for generating revision marks ('<',
'>', '-') in 5 places.

Factor out the code to a single function get_revsion_mark() for easier
maintenance and extensibility.

Note that the check for !!revs in graph.c (which gets removed
effectively by this patch) is superfluous.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/rev-list.c |   14 ++------------
 graph.c            |   17 ++---------------
 log-tree.c         |   28 ++++------------------------
 pretty.c           |    6 +-----
 revision.c         |   16 ++++++++++++++++
 revision.h         |    1 +
 6 files changed, 26 insertions(+), 56 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..f458cb7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -64,18 +64,8 @@ static void show_commit(struct commit *commit, void *data)
 	if (info->header_prefix)
 		fputs(info->header_prefix, stdout);
 
-	if (!revs->graph) {
-		if (commit->object.flags & BOUNDARY)
-			putchar('-');
-		else if (commit->object.flags & UNINTERESTING)
-			putchar('^');
-		else if (revs->left_right) {
-			if (commit->object.flags & SYMMETRIC_LEFT)
-				putchar('<');
-			else
-				putchar('>');
-		}
-	}
+	if (!revs->graph)
+		fputs(get_revision_mark(revs, commit), stdout);
 	if (revs->abbrev_commit && revs->abbrev)
 		fputs(find_unique_abbrev(commit->object.sha1, revs->abbrev),
 		      stdout);
diff --git a/graph.c b/graph.c
index f1a63c2..ef2e24e 100644
--- a/graph.c
+++ b/graph.c
@@ -798,22 +798,9 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	}
 
 	/*
-	 * If revs->left_right is set, print '<' for commits that
-	 * come from the left side, and '>' for commits from the right
-	 * side.
+	 * get_revision_mark() handles all other cases without assert()
 	 */
-	if (graph->revs && graph->revs->left_right) {
-		if (graph->commit->object.flags & SYMMETRIC_LEFT)
-			strbuf_addch(sb, '<');
-		else
-			strbuf_addch(sb, '>');
-		return;
-	}
-
-	/*
-	 * Print '*' in all other cases
-	 */
-	strbuf_addch(sb, '*');
+	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
 }
 
 /*
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..1257040 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -380,18 +380,8 @@ void show_log(struct rev_info *opt)
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
 
-		if (!opt->graph) {
-			if (commit->object.flags & BOUNDARY)
-				putchar('-');
-			else if (commit->object.flags & UNINTERESTING)
-				putchar('^');
-			else if (opt->left_right) {
-				if (commit->object.flags & SYMMETRIC_LEFT)
-					putchar('<');
-				else
-					putchar('>');
-			}
-		}
+		if (!opt->graph)
+			fputs(get_revision_mark(opt, commit), stdout);
 		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
@@ -448,18 +438,8 @@ void show_log(struct rev_info *opt)
 		if (opt->commit_format != CMIT_FMT_ONELINE)
 			fputs("commit ", stdout);
 
-		if (!opt->graph) {
-			if (commit->object.flags & BOUNDARY)
-				putchar('-');
-			else if (commit->object.flags & UNINTERESTING)
-				putchar('^');
-			else if (opt->left_right) {
-				if (commit->object.flags & SYMMETRIC_LEFT)
-					putchar('<');
-				else
-					putchar('>');
-			}
-		}
+		if (!opt->graph)
+			fputs(get_revision_mark(opt, commit), stdout);
 		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
 		if (opt->print_parents)
diff --git a/pretty.c b/pretty.c
index 8549934..f21a30c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -859,11 +859,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		                              c->abbrev_parent_hashes.off;
 		return 1;
 	case 'm':		/* left/right/bottom */
-		strbuf_addch(sb, (commit->object.flags & BOUNDARY)
-		                 ? '-'
-		                 : (commit->object.flags & SYMMETRIC_LEFT)
-		                 ? '<'
-		                 : '>');
+		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
 		format_decoration(sb, commit);
diff --git a/revision.c b/revision.c
index 1fcaeb7..0de1608 100644
--- a/revision.c
+++ b/revision.c
@@ -2263,3 +2263,19 @@ struct commit *get_revision(struct rev_info *revs)
 		graph_update(revs->graph, c);
 	return c;
 }
+
+char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
+{
+	if (commit->object.flags & BOUNDARY)
+		return "-";
+	else if (commit->object.flags & UNINTERESTING)
+		return "^";
+	else if (!revs || revs->left_right) {
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			return "<";
+		else
+			return ">";
+	} else if (revs->graph)
+		return "*";
+	return "";
+}
diff --git a/revision.h b/revision.h
index d2ffde1..0e4b35e 100644
--- a/revision.h
+++ b/revision.h
@@ -165,6 +165,7 @@ extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,
 
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
+extern char *get_revision_mark(const struct rev_info *revs, const struct commit *commit);
 
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
-- 
1.7.4.1.317.gf445f
