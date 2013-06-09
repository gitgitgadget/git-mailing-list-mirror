From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] log: --author-date-order
Date: Sun,  9 Jun 2013 16:24:37 -0700
Message-ID: <1370820277-30158-5-git-send-email-gitster@pobox.com>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 01:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uloyo-0004dh-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab3FIXYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:24:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab3FIXYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:24:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1AD026E69;
	Sun,  9 Jun 2013 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iEG1
	E9k5psvQ1tETf/GcvkoSb6Q=; b=XWHdm8AFzPL82jPuEfu7L49siFerafiaOWd5
	kwWCakOo34mYCK/oGIhWaU4pior7Hn8bm1AZ3+LEi5TUCVG/WU5qeWynv+ghj/tk
	UxD7qVBKYvf5wNkRRBmKK1ptIRUjawjvG5URkxeEZIXr4VPtaJQ2hgAQDaOQG7Ol
	SfcdwDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	oG084p5Z+Tp1pw2CoGFiQ2HxOBNrw336mPqDP+xIgUmBtwRius5Qh6bHJM5I/ztH
	MTuLJc9yvjifoVOF0vfHsVEEq8JE+eVSv74r1bkFOVkYvDJouMwRq77wea1aOxMM
	8GDAaD3NrAVU1z47OT+HtrtYKehrDYJZ7aFFVuOEiv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7D8926E68;
	Sun,  9 Jun 2013 23:24:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3FE326E64;
	Sun,  9 Jun 2013 23:24:46 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-477-gc2fede3
In-Reply-To: <1370820277-30158-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C60BDF06-D15B-11E2-921A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227212>

Sometimes people would want to view the commits in parallel
histories in the order of author dates, not committer dates.

Teach "topo-order" sort machinery to do so, using a commit-info slab
to record the author dates of each commit, and commit-queue to sort
them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt |  4 +++
 commit.c                           | 59 ++++++++++++++++++++++++++++++++++++++
 commit.h                           |  3 +-
 revision.c                         |  3 ++
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3bdbf5e..8302402 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -617,6 +617,10 @@ By default, the commits are shown in reverse chronological order.
 	Show no parents before all of its children are shown, but
 	otherwise show commits in the commit timestamp order.
 
+--author-date-order::
+	Show no parents before all of its children are shown, but
+	otherwise show commits in the author timestamp order.
+
 --topo-order::
 	Show no parents before all of its children are shown, and
 	avoid showing commits on multiple lines of history
diff --git a/commit.c b/commit.c
index cc6d385..f3a2f09 100644
--- a/commit.c
+++ b/commit.c
@@ -510,6 +510,53 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
+/* record author-date for each commit object */
+define_commit_slab(author_date_slab, unsigned long);
+
+static void record_author_date(struct author_date_slab *author_date,
+			       struct commit *commit)
+{
+	const char *buf, *line_end;
+	struct ident_split ident;
+	char *date_end;
+	unsigned long date;
+
+	for (buf = commit->buffer; buf; buf = line_end + 1) {
+		line_end = strchrnul(buf, '\n');
+		if (prefixcmp(buf, "author ")) {
+			if (!line_end[0] || line_end[1] == '\n')
+				return; /* end of header */
+			continue;
+		}
+		if (split_ident_line(&ident,
+				     buf + strlen("author "),
+				     line_end - (buf + strlen("author "))) ||
+		    !ident.date_begin || !ident.date_end)
+			return; /* malformed "author" line */
+		break;
+	}
+
+	date = strtoul(ident.date_begin, &date_end, 10);
+	if (date_end != ident.date_end)
+		return; /* malformed date */
+	*(author_date_slab_at(author_date, commit)) = date;
+}
+
+static int compare_commits_by_author_date(struct commit *a, struct commit *b,
+					  void *cb_data)
+{
+	struct author_date_slab *author_date = cb_data;
+	unsigned long a_date = *(author_date_slab_at(author_date, a));
+	unsigned long b_date = *(author_date_slab_at(author_date, b));
+
+	/* newer commits with larger date first */
+	if (a_date < b_date)
+		return 1;
+	else if (a_date > b_date)
+		return -1;
+	return 0;
+}
+
 static int compare_commits_by_commit_date(struct commit *a, struct commit *b, void *unused)
 {
 	/* newer commits with larger date first */
@@ -530,6 +577,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	struct indegree_slab indegree;
 	struct commit_queue queue;
 	struct commit *commit;
+	struct author_date_slab author_date;
 
 	if (!orig)
 		return;
@@ -537,6 +585,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
 	init_indegree_slab(&indegree);
 	memset(&queue, '\0', sizeof(queue));
+
 	switch (sort_order) {
 	default: /* REV_SORT_IN_GRAPH_ORDER */
 		queue.compare = NULL;
@@ -544,12 +593,20 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	case REV_SORT_BY_COMMIT_DATE:
 		queue.compare = compare_commits_by_commit_date;
 		break;
+	case REV_SORT_BY_AUTHOR_DATE:
+		init_author_date_slab(&author_date);
+		queue.compare = compare_commits_by_author_date;
+		queue.cb_data = &author_date;
+		break;
 	}
 
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 		*(indegree_slab_at(&indegree, commit)) = 1;
+		/* also record the author dates, if needed */
+		if (sort_order == REV_SORT_BY_AUTHOR_DATE)
+			record_author_date(&author_date, commit);
 	}
 
 	/* update the indegree */
@@ -620,6 +677,8 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
 	clear_indegree_slab(&indegree);
 	clear_commit_queue(&queue);
+	if (sort_order == REV_SORT_BY_AUTHOR_DATE)
+		clear_author_date_slab(&author_date);
 }
 
 /* merge-base stuff */
diff --git a/commit.h b/commit.h
index 247e474..e43dfd0 100644
--- a/commit.h
+++ b/commit.h
@@ -142,7 +142,8 @@ void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark);
 
 enum rev_sort_order {
 	REV_SORT_IN_GRAPH_ORDER = 0,
-	REV_SORT_BY_COMMIT_DATE
+	REV_SORT_BY_COMMIT_DATE,
+	REV_SORT_BY_AUTHOR_DATE
 };
 
 /*
diff --git a/revision.c b/revision.c
index 966ebbc..12d9b64 100644
--- a/revision.c
+++ b/revision.c
@@ -1393,6 +1393,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
+	} else if (!strcmp(arg, "--author-date-order")) {
+		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
+		revs->topo_order = 1;
 	} else if (!prefixcmp(arg, "--early-output")) {
 		int count = 100;
 		switch (arg[14]) {
-- 
1.8.3-451-gb703ddf
