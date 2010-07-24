From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 21/22] commit parents prunning code
Date: Sat, 24 Jul 2010 23:13:53 +0800
Message-ID: <1279984434-28933-22-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:16:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgST-0002K0-2v
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab0GXPPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56745 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab0GXPPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:40 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so500153pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cqO8qLWf+cOxCYAfNjSOhpHGDGzzwsaU+bDkyKQ+5kA=;
        b=AODmH2/mklAddA5Ll4CtuKeW09c2VWgac0vqB38Jv/X3DOhW5p28OjZBgcxwD/GfFF
         i3zvopG+r7cWZJzrbr8CzeuRDhbhM1niscsOOhlsUlToQlr6fEqW5wX1MRPD779aVGkk
         oez6o5lka+9t+dtmfeU4CrTYJaYsJ2loNGxcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sfy7l5K0hXR3wkH+78aL77Ezsc3gyWsoRCN+Eyj5VdtfjJyfWtHT4qoYPmgU4Pk2fk
         4QUmITpSVJfHZHfd6PAlqtOTjEykjK5cmMpzbRUUO4rGTlO79Ri0E6Op9pQHTKSWX071
         YCCSBJKZDHXTjf5+8Fv35U3qwG+0bexQdQtKI=
Received: by 10.142.207.9 with SMTP id e9mr6054913wfg.56.1279984539782;
        Sat, 24 Jul 2010 08:15:39 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151654>

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   48 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/line.c b/line.c
index 272f166..bc9fc76 100644
--- a/line.c
+++ b/line.c
@@ -390,6 +390,7 @@ struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
 	struct diff_line_range *ret = xmalloc(sizeof(*ret));
 	int i = 0;
 
+	assert(r);
 	DIFF_LINE_RANGE_INIT(ret);
 	ret->ranges = xcalloc(r->nr, sizeof(struct range));
 	memcpy(ret->ranges, r->ranges, sizeof(struct range) * r->nr);
@@ -993,13 +994,21 @@ static void diff_update_parent_range(struct rev_info *rev, struct commit *commit
 	assign_range_to_parent(rev, commit, c, r, &rev->diffopt, 1);
 }
 
+struct commit_state {
+	struct diff_line_range *range;
+	struct object obj;
+};
+
 static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 {
 	struct commit_list *parents = commit->parents;
 	struct diff_line_range *r = lookup_line_range(rev, commit);
 	struct diff_line_range *copy = NULL, *range = NULL;
+	struct decoration parents_state;
+	struct commit_state *state = NULL;
 	int nontrivial = 0;
 
+	memset(&parents_state, 0, sizeof(parents_state));
 	/*
 	 * If we are in linear history, update range and flush the patch if
 	 * necessary
@@ -1020,36 +1029,44 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 	while (parents) {
 		struct commit *p = parents->item;
 		int diff = 0;
+		struct diff_line_range *origin_range = lookup_line_range(rev, p);
+		if (origin_range)
+			origin_range = diff_line_range_clone_deeply(origin_range);
+
+		state = xmalloc(sizeof(*state));
+		state->range = origin_range;
+		state->obj = p->object;
+		add_decoration(&parents_state, &p->object, state);
 		diff = assign_range_to_parent(rev, commit, p, r, &rev->diffopt, 1);
 		/* Since all the ranges comes from this parent, we can ignore others */
 		if (diff == 0) {
-			/* parent rewriting code */
+			/* restore the state of parents before this one */
 			parents = commit->parents;
 			while (parents->item != p) {
 				struct commit_list *list = parents;
 				struct diff_line_range *line_range = NULL;
 				parents = parents->next;
 				line_range = lookup_line_range(rev, list->item);
-				add_line_range(rev, list->item, NULL);
-				free(line_range);
-				list->item->object.flags &= ~(RANGE_UPDATE | NEED_PRINT | EVIL_MERGE);
+				cleanup(line_range);
+				state = lookup_decoration(&parents_state, &list->item->object);
+				add_decoration(&parents_state, &list->item->object, NULL);
+				add_line_range(rev, list->item, state->range);
+				list->item->object = state->obj;
+				free(state);
 				free(list);
 			}
+
 			commit->parents = parents;
 			parents = parents->next;
 			commit->parents->next = NULL;
 			while (parents) {
 				struct commit_list *list = parents;
-				struct diff_line_range *line_range = NULL;
 				parents = parents->next;
-				line_range = lookup_line_range(rev, list->item);
-				add_line_range(rev, list->item, NULL);
-				free(line_range);
-				list->item->object.flags &= ~(RANGE_UPDATE | NEED_PRINT | EVIL_MERGE);
 				free(list);
 			}
-			return;
+			goto out;
 		}
+		/* take the ranges from 'commit', try to detect nontrivial merge */
 		assign_range_to_parent(rev, commit, p, copy, &rev->diffopt, 0);
 		parents = parents->next;
 	}
@@ -1066,6 +1083,17 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 		range = range->next;
 	}
 
+out:
+	parents = commit->parents;
+	while (parents) {
+		state = lookup_decoration(&parents_state, &parents->item->object);
+		if (state) {
+			cleanup(state->range);
+			free(state);
+		}
+		parents = parents->next;
+	}
+
 	if (nontrivial) {
 		add_decoration(&rev->nontrivial_merge, &commit->object, copy);
 	} else {
-- 
1.7.0.2.273.gc2413.dirty
