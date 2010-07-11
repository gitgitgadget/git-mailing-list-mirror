From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v1 2/4] add parent rewrite feature to line level log
Date: Sun, 11 Jul 2010 14:27:35 +0800
Message-ID: <1278829657-26607-3-git-send-email-struggleyb.nku@gmail.com>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXq3I-0003wy-E7
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0GKG35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:29:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46564 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0GKG3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:29:52 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so1397241pvc.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CUDXUFK7p+s4sadJf2lJRDN9QpNC0kejZfdzO9w77rw=;
        b=M0rAZiisNVE7J95N8LaFVv87/K5i/DvAtF6jgvIRGmVZYy7fCkdMHKnlySL5N1F9Qj
         U4vvyR9JzfM0nzCRq9Q6yZn56Mph16ndOyQrCus594dEyo12sGtUu098CaoXiDkSNA69
         Fg0qwhSGjST5cFKdODrDKS2OhO5a2Eg24dRqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e4OyTOykWJwOJqSl+yljtLP8bp62AGNkbajcgmJ6SZ3gGmV4my0EXQ8Ru9AUDRdPf8
         cRAb7KK3f7DrUofngVN7QGdlrLmx/hCVLODky/I7yNTG0N102jz4XvKCdWL8pWuzid3f
         IMu6v+hRku/7rJKfyxIm9vckuQyb/SZnWuYVw=
Received: by 10.114.73.12 with SMTP id v12mr14058533waa.175.1278829791910;
        Sat, 10 Jul 2010 23:29:51 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id b19sm1874759rvf.3.2010.07.10.23.29.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:29:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150759>

Two kinds of commit are qualified as a parent:
 1. The commit touch some lines of the current
    interesting range;
 2. The commit is a merge commit.

So, there will be more commits output than the
situation which parent rewrite is not set on.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c     |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 line.h     |    2 +
 revision.c |    3 ++
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/line.c b/line.c
index c08b510..0d62732 100644
--- a/line.c
+++ b/line.c
@@ -10,6 +10,9 @@
 #include "xdiff-interface.h"
 #include "strbuf.h"
 #include "log-tree.h"
+#include "graph.h"
+
+static int limited = 0;
 
 static void cleanup(struct diff_line_range *r)
 {
@@ -1213,12 +1216,12 @@ int cmd_line_log_walk(struct rev_info *rev)
 		die("revision walk prepare failed");
 
 	list = rev->commits;
-	if (list) {
+	if (list && !limited) {
 		list->item->object.flags |= RANGE_UPDATE;
 		list = list->next;
 	}
 	/* Clear the flags */
-	while (list) {
+	while (list && !limited) {
 		list->item->object.flags &= 0x0;
 		list = list->next;
 	}
@@ -1232,7 +1235,9 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT || rev->always_print) {
+		if (commit->object.flags & NEED_PRINT || rev->always_print || rev->graph) {
+			if (rev->graph)
+				graph_update(rev->graph, commit);
 			line_log_flush(rev, commit);
 		}
 
@@ -1257,3 +1262,86 @@ int cmd_line_log_walk(struct rev_info *rev)
 	return 0;
 }
 
+static enum rewrite_result rewrite_one(struct rev_info *rev, struct commit **pp)
+{
+	struct diff_line_range *r = NULL;
+	struct commit *p;
+	while (1) {
+		p = *pp;
+		if (p->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, p);
+		if (p->parents && p->parents->next)
+			return rewrite_one_ok;
+		if (p->object.flags & NEED_PRINT)
+			return rewrite_one_ok;
+		if (!p->parents)
+			return rewrite_one_noparents;
+
+		r = lookup_line_range(rev, p);
+		if (!r)
+			return rewrite_one_noparents;
+		*pp = p->parents->item;
+	}
+}
+
+/* The rev->commits must be sorted in topologically order */
+void limit_list_line(struct rev_info *rev)
+{
+	struct commit_list *list = rev->commits;
+	struct commit_list *commits = xmalloc(sizeof(struct commit_list));
+	struct commit_list *out = commits, *prev = commits;
+	struct commit *c;
+	struct diff_line_range *r;
+
+	if (list) {
+		list->item->object.flags |= RANGE_UPDATE;
+		list = list->next;
+	}
+	/* Clear the flags */
+	while (list) {
+		list->item->object.flags &= 0x0;
+		list = list->next;
+	}
+
+	list = rev->commits;
+	while (list) {
+		c = list->item;
+
+		if (c->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, c);
+
+		if (c->object.flags & NEED_PRINT ||
+			(c->parents && c->parents->next)) {
+			if (rewrite_parents(rev, c, rewrite_one))
+				die("Can't rewrite parent for commit %s",
+					sha1_to_hex(c->object.sha1));
+			commits->item = c;
+			commits->next = xmalloc(sizeof(struct commit_list));
+			prev = commits;
+			commits = commits->next;
+		} else {
+			r = lookup_line_range(rev, c);
+			if (r) {
+				cleanup(r);
+				r = NULL;
+				add_line_range(rev, c, r);
+			}
+		}
+
+		list = list->next;
+	}
+
+	prev->next = NULL;
+	free(commits);
+
+	list = rev->commits;
+	while (list) {
+		struct commit_list *l = list;
+		list = list->next;
+		free(l);
+	}
+
+	rev->commits = out;
+	limited = 1;
+}
+
diff --git a/line.h b/line.h
index b293894..90d7c1a 100644
--- a/line.h
+++ b/line.h
@@ -130,4 +130,6 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 
 extern int cmd_line_log_walk(struct rev_info *rev);
 
+extern void limit_list_line(struct rev_info *rev);
+
 #endif
diff --git a/revision.c b/revision.c
index 72d9654..659cec7 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "line.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1886,6 +1887,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->rewrite_parents && revs->line)
+		limit_list_line(revs);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
 	if (revs->children.name)
-- 
1.7.0.2.273.gc2413.dirty
