From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 20/22] some changes
Date: Sat, 24 Jul 2010 23:13:52 +0800
Message-ID: <1279984434-28933-21-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgSS-0002K0-1R
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273Ab0GXPPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56745 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab0GXPPh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:37 -0400
Received: by pzk26 with SMTP id 26so500153pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=j6FHcy2NBgr5BYbuh1EPDHVsieEdxMDj3oJzuGY5Tlc=;
        b=nfowXn7hJ2i1Tv/sfOTz03zEalifegiTYmkZsRFZkQCpqtcIOHr5lBwjXmw67e/mRX
         Qox8ntNsLjDhM8PN9pyFUni4olT9NfTTP/G6V86zXiRVWA2c4lp5MPPVKzCLpyMelC5f
         I2tNngskPYxxYru8qXJNwGx97y0OntmzIOZQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vkrZ60c7NifRMrQEaogc4WFRWCRYwHRKhdmzzCHPSTHDH9DYzEsVvDtSVAfO0VrAVx
         AbbvgYgEayVVkWw31rWVsDb9zQv0wmRaLvU5fPPtgKvFSw7Fppn/nnqGePbQke9EP4F9
         ky8k006NEhjZ3hmFIYR60574AewZOC8/wnmAk=
Received: by 10.142.210.2 with SMTP id i2mr6006538wfg.299.1279984536824;
        Sat, 24 Jul 2010 08:15:36 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151650>

1. if one parent is responsible for all ranges, then prune the
   parents list to only this one;
2. some other minor changes.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 106 insertions(+), 22 deletions(-)

diff --git a/line.c b/line.c
index ca8980d..272f166 100644
--- a/line.c
+++ b/line.c
@@ -470,15 +470,15 @@ void add_line_range(struct rev_info *revs, struct commit *commit, struct diff_li
 {
 	struct diff_line_range *ret = NULL;
 
-	if (r != NULL) {
-		ret = lookup_decoration(&revs->line_range, &commit->object);
-		if (ret != NULL) {
-			diff_line_range_merge(ret, r);
-		} else {
-			add_decoration(&revs->line_range, &commit->object, r);
-		}
-		commit->object.flags |= RANGE_UPDATE;
+	ret = lookup_decoration(&revs->line_range, &commit->object);
+	if (ret != NULL && r != NULL) {
+		diff_line_range_merge(ret, r);
+	} else {
+		add_decoration(&revs->line_range, &commit->object, r);
 	}
+
+	if (r != NULL)
+		commit->object.flags |= RANGE_UPDATE;
 }
 
 struct diff_line_range *lookup_line_range(struct rev_info *revs, struct commit *commit)
@@ -544,8 +544,26 @@ void map_lines(long p_start, long p_end, long t_start, long t_end,
 		return;
 	}
 
-	if (start == t_start && end == t_end) {
+	if (start == t_start && end == t_end)
+	{
+		*o_start = p_start;
+		*o_end = p_end;
+		return;
+	}
+
+	if (start == t_start)
+	{
 		*o_start = p_start;
+		*o_end = p_start + (end - start);
+		if (*o_end > p_end)
+			*o_end = p_end;
+		return;
+	}
+
+	if (end == t_end) {
+		*o_start = p_end - (end - start);
+		if (*o_start < p_start)
+			*o_start = p_start;
 		*o_end = p_end;
 		return;
 	}
@@ -771,7 +789,7 @@ static void map_range_cb(void *data, long same, long p_next, long t_next)
 	d->tlno = t_next;
 }
 
-static void assign_range_to_parent(struct rev_info *rev, struct commit *c,
+static int assign_range_to_parent(struct rev_info *rev, struct commit *c,
 		struct commit *p, struct diff_line_range *r,
 		struct diff_options *opt, int map)
 {
@@ -917,20 +935,49 @@ static void assign_range_to_parent(struct rev_info *rev, struct commit *c,
 		}
 	}
 
+	if (!map)
+		goto out;
+
 	if (rr) {
 		assert(p);
 		add_line_range(rev, p, rr);
 	}
 
+	/* debug output */
+	/*
+	fprintf(stderr, "%8s..%8s:\n", sha1_to_hex(p->object.sha1), sha1_to_hex(c->object.sha1));
+	while (r) {
+		fprintf(stderr, "file: %s\n", r->spec->path);
+		int n = 0;
+		for (; n < r->nr; n++) {
+			fprintf(stderr, "%d-%d, ", r->ranges[n].start, r->ranges[n].end);
+		}
+		r = r->next;
+	}
+	fprintf(stderr, "\n");
+	while (rr) {
+		fprintf(stderr, "file: %s\n", rr->spec->path);
+		int n = 0;
+		for (; n < rr->nr; n++) {
+			fprintf(stderr, "%d-%d, ", rr->ranges[n].start, rr->ranges[n].end);
+		}
+		rr = rr->next;
+	}
+	fprintf(stderr, "\n");
+	*/
+
 	/* and the ranges of current commit c is updated */
 	c->object.flags &= ~RANGE_UPDATE;
 	if (diff)
 		c->object.flags |= NEED_PRINT;
 
+out:
 	if (tree1)
 		free(tree1);
 	if (tree2)
 		free(tree2);
+
+	return diff;
 }
 
 static void diff_update_parent_range(struct rev_info *rev, struct commit *commit)
@@ -967,16 +1014,46 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 	 * be an evil merge.
 	 */
 	copy = diff_line_range_clone_deeply(r);
+	/* Never print out any diff for a merge commit */
+	commit->object.flags &= ~NEED_PRINT;
 	parents = commit->parents;
 	while (parents) {
 		struct commit *p = parents->item;
-		assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
+		int diff = 0;
+		diff = assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
+		/* Since all the ranges comes from this parent, we can ignore others */
+		if (diff == 0) {
+			/* parent rewriting code */
+			parents = commit->parents;
+			while (parents->item != p) {
+				struct commit_list *list = parents;
+				struct diff_line_range *line_range = NULL;
+				parents = parents->next;
+				line_range = lookup_line_range(rev, list->item);
+				add_line_range(rev, list->item, NULL);
+				free(line_range);
+				list->item->object.flags &= ~(RANGE_UPDATE | NEED_PRINT | EVIL_MERGE);
+				free(list);
+			}
+			commit->parents = parents;
+			parents = parents->next;
+			commit->parents->next = NULL;
+			while (parents) {
+				struct commit_list *list = parents;
+				struct diff_line_range *line_range = NULL;
+				parents = parents->next;
+				line_range = lookup_line_range(rev, list->item);
+				add_line_range(rev, list->item, NULL);
+				free(line_range);
+				list->item->object.flags &= ~(RANGE_UPDATE | NEED_PRINT | EVIL_MERGE);
+				free(list);
+			}
+			return;
+		}
 		assign_range_to_parent(rev, commit, p, copy, &rev->diffopt, 0);
 		parents = parents->next;
 	}
 
-	/* Never print out any diff for a merge commit */
-	commit->object.flags &= ~NEED_PRINT;
 	/*
 	 * yes, this must be an evil merge.
 	 */
@@ -1262,6 +1339,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 							c->object.flags & NEED_PRINT))
 		return;
 
+	if (rev->graph)
+		graph_update(rev->graph, c);
 	log.commit = c;
 	log.parent = NULL;
 	rev->loginfo = &log;
@@ -1275,12 +1354,21 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	fprintf(rev->diffopt.file, "%s\n", line_prefix);
 
 	if (c->object.flags & EVIL_MERGE)
-		return flush_nontrivial_merge(rev, nontrivial);
+		flush_nontrivial_merge(rev, nontrivial);
+	else {
+		while (range) {
+			if (range->diff || (range->nr && rev->full_line_diff))
+				diff_flush_filepair(rev, range);
+			range = range->next;
+		}
+	}
 
-	while (range) {
-		if (range->diff || (range->nr && rev->full_line_diff))
-			diff_flush_filepair(rev, range);
-		range = range->next;
+	while (rev->graph && !graph_is_commit_finished(rev->graph))
+	{
+		struct strbuf sb;
+		strbuf_init(&sb, 0);
+		graph_next_line(rev->graph, &sb);
+		fputs(sb.buf, opt->file);
 	}
 }
 
@@ -1316,8 +1404,6 @@ int cmd_line_log_walk(struct rev_info *rev)
 		if (commit->object.flags & NEED_PRINT ||
 			commit->object.flags & EVIL_MERGE ||
 			rev->full_line_diff || rev->graph) {
-			if (rev->graph)
-				graph_update(rev->graph, commit);
 			line_log_flush(rev, commit);
 		}
 
@@ -1350,8 +1436,6 @@ static enum rewrite_result rewrite_one(struct rev_info *rev, struct commit **pp)
 		p = *pp;
 		if (p->object.flags & RANGE_UPDATE)
 			assign_parents_range(rev, p);
-		if (p->parents && p->parents->next)
-			return rewrite_one_ok;
 		if (p->object.flags & NEED_PRINT)
 			return rewrite_one_ok;
 		if (!p->parents)
-- 
1.7.0.2.273.gc2413.dirty
