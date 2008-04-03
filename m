From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] "log" and friends: --children option
Date: Thu, 03 Apr 2008 02:12:06 -0700
Message-ID: <7vlk3v2tg9.fsf@gitster.siamese.dyndns.org>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLVA-0006YE-J8
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbYDCJMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbYDCJMN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:12:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669AbYDCJMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:12:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D0A32390;
	Thu,  3 Apr 2008 05:12:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 22D72238F; Thu,  3 Apr 2008 05:12:09 -0400 (EDT)
In-Reply-To: <7v4paj486a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Apr 2008 02:08:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78736>

This adds a new --children option to the revision machinery.  In addition
to the list of parents, child commits of each commit are computed and
shown in the output from "git log" and friends.

Note that this does _not_ show all children of a commit.  It only shows
children on the commit ancestry you made the revision machinery traverse.
For example, "git log --children master..next" will not show side branches
forked from any commits shown in the range that have not been merged to
"next" (i.e. what are queued in 'pu' but not yet merged to 'next').

This patch was primarily done for adding the infrastructure to allow users
of revision machinery to find out children of commits; please consider the
current output not much more than debugging aid.  If you want to use it
from "git log" and friends, the output format needs a bit more serious
thought.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c |   20 ++++++++++++++++++++
 revision.c |   28 ++++++++++++++++++++++++++++
 revision.h |    1 +
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5b29639..75851d1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -32,6 +32,24 @@ void show_decorations(struct commit *commit)
 	putchar(')');
 }
 
+static void show_children(struct rev_info *revs, struct commit *commit, int abbrev)
+{
+	struct commit_list *p;
+
+	if (!revs->children.name)
+		return;
+	p = lookup_decoration(&revs->children, &commit->object);
+	if (!p)
+		return;
+	printf("child");
+	while (p) {
+		struct commit *child = p->item;
+		printf(" %s", diff_unique_abbrev(child->object.sha1, abbrev));
+		p = p->next;
+	}
+	putchar(revs->diffopt.line_termination);
+}
+
 /*
  * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
  * Signed-off-by: and Acked-by: lines.
@@ -236,6 +254,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			show_parents(commit, abbrev_commit);
 		show_decorations(commit);
 		putchar(opt->diffopt.line_termination);
+		show_children(opt, commit, abbrev_commit);
 		return;
 	}
 
@@ -297,6 +316,7 @@ void show_log(struct rev_info *opt, const char *sep)
 				return;
 			}
 		}
+		show_children(opt, commit, abbrev_commit);
 	}
 
 	if (!commit->buffer)
diff --git a/revision.c b/revision.c
index 196fedc..e5138b7 100644
--- a/revision.c
+++ b/revision.c
@@ -9,6 +9,7 @@
 #include "grep.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
+#include "decorate.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1309,6 +1310,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->no_walk = 0;
 				continue;
 			}
+			if (!strcmp(arg, "--children")) {
+				revs->children.name = "children";
+				revs->limited = 1;
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
@@ -1398,6 +1404,26 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	return left;
 }
 
+static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
+{
+	struct commit_list *l = xcalloc(1, sizeof(*l));
+
+	l->item = child;
+	l->next = add_decoration(&revs->children, &parent->object, l);
+}
+
+static void set_children(struct rev_info *revs)
+{
+	struct commit_list *l;
+	for (l = revs->commits; l; l = l->next) {
+		struct commit *commit = l->item;
+		struct commit_list *p;
+
+		for (p = commit->parents; p; p = p->next)
+			add_child(revs, p->item, commit);
+	}
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
@@ -1426,6 +1452,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->children.name)
+		set_children(revs);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index c8b3b94..966116c 100644
--- a/revision.h
+++ b/revision.h
@@ -98,6 +98,7 @@ struct rev_info {
 	struct diff_options pruning;
 
 	struct reflog_walk_info *reflog_info;
+	struct decoration children;
 };
 
 #define REV_TREE_SAME		0
-- 
1.5.5.rc3.139.g8b2cf
