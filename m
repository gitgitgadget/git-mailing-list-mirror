From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 15/22] Add parent rewriting to line history browser
Date: Sat, 24 Jul 2010 23:13:47 +0800
Message-ID: <1279984434-28933-16-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgSQ-0002K0-Rt
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab0GXPPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64670 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab0GXPPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:18 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so3930617pvc.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ErIupz6/PSgt2L0Xd1XMxrjUjTXjDhJBPWZ7EiOvtd8=;
        b=vu+nABXmodLjBW3cpoAssigtMej9F2c3BEoi79PCaTBzMk0zKpza1TQBOgQfGk7x4d
         rwD+dS+044t7+oSI3ZKqhvPHzNGg0ZyqA6Sd1cR5Gxh1uu0a5XOnfu6HmsxUBeGJ8VLi
         3jNbv+wYDAaYvolPA7i1sIs/dJNM9Ck+jsyiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LTMJcDl/Nn8UgGNXlgBj95OoVmUtYoBsOQ4I43fzkaTeKe6vqxDTQqd6KMCBQ+DrB6
         +0AzPJH7jQwdfOJBMfFX+G7QS0Mlrf7JZqV7v7nN4+I8oUfLisVsSmhpBeRY8Kp8SfIz
         ciEm0E1pyRp02d7jMmI3h5wINduoRMpyXhT0w=
Received: by 10.142.164.3 with SMTP id m3mr5954099wfe.293.1279984517979;
        Sat, 24 Jul 2010 08:15:17 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151653>

Walking forward through history (i.e., topologically earliest
commits first), we filter the parent list of every commit as
follows. Consider a parent P:
 - If P touches any of the interesting line ranges, we keep it.
 - If P is a merge, we also keep it.
 - Otherwise, P is rewritten to its (only) parent P^.

So, there will be more commits output than the
situation which parent rewrite is not on.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c     |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 line.h     |    2 +
 revision.c |    3 ++
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/line.c b/line.c
index 5317fe5..cc8be97 100644
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
@@ -1249,12 +1252,12 @@ int cmd_line_log_walk(struct rev_info *rev)
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
 		list->item->object.flags &= ~(RANGE_UPDATE | EVIL_MERGE | NEED_PRINT);
 		list = list->next;
 	}
@@ -1268,7 +1271,9 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT || rev->full_line_diff) {
+		if (commit->object.flags & NEED_PRINT || rev->full_line_diff || rev->graph) {
+			if (rev->graph)
+				graph_update(rev->graph, commit);
 			line_log_flush(rev, commit);
 		}
 
@@ -1293,3 +1298,86 @@ int cmd_line_log_walk(struct rev_info *rev)
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
+		list->item->object.flags &= ~(RANGE_UPDATE | EVIL_MERGE | NEED_PRINT);
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
index 3f5c827..a2083ec 100644
--- a/line.h
+++ b/line.h
@@ -136,4 +136,6 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 
 extern int cmd_line_log_walk(struct rev_info *rev);
 
+extern void limit_list_line(struct rev_info *rev);
+
 #endif
diff --git a/revision.c b/revision.c
index fb08978..a6527ca 100644
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
+	if (revs->rewrite_parents && revs->line_level_traverse)
+		limit_list_line(revs);
 	if (revs->simplify_merges)
 		simplify_merges(revs);
 	if (revs->children.name)
-- 
1.7.0.2.273.gc2413.dirty
