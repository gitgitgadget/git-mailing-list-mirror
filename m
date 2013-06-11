From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] log: --author-date-order
Date: Tue, 11 Jun 2013 15:19:09 -0700
Message-ID: <1370989149-28538-5-git-send-email-gitster@pobox.com>
References: <20130611063648.GB23650@sigill.intra.peff.net>
 <1370989149-28538-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:19:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWuf-0007YZ-7K
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab3FKWTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 18:19:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757001Ab3FKWTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:19:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2B3527952;
	Tue, 11 Jun 2013 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KGgZ
	ZOJCXBBj0HiP+7kUQcTYOkY=; b=Pg2n05Is8bEB+E434aYTlFIQpHZLqKYYmS/J
	eTsuWWSlHSodybGJso2VaCCJZyFmvi/aQZJPHtZvM7pGyybYfNFwYH5oGChMib4i
	nsVY9qYCfbgzwl8BMsI7Y+wKVoZrmZBHsc3lFiQwAYcfxAwn49PLRgjI5uOdOzoG
	nl5YAdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	h5fzhnd4h7kCIiJ/0MxQG84PT3QxNnfBIfO0otNzhgVEulpiiKHRZMx1KrRb5tZ+
	TZBFGWjp5j/sf4bjxflNOW919JQ6Vwn/XUgX3vbIxitDjX7dotn/mNauS+cFZWIw
	YtdDvru2iHmzCpBvXnmIN7FRCY+0MPpUd/MqHHWlkTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF9327951;
	Tue, 11 Jun 2013 22:19:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F412927950;
	Tue, 11 Jun 2013 22:19:18 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-494-g51b8af5
In-Reply-To: <1370989149-28538-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F5A3D694-D2E4-11E2-8D39-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227549>

Sometimes people would want to view the commits in parallel
histories in the order of author dates, not committer dates.

Teach "topo-order" sort machinery to do so, using a commit-info slab
to record the author dates of each commit, and prio-queue to sort
them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This re-reads the commit object when commit->buf has already been
   freed, which is necessary to sort by the author date.

 Documentation/rev-list-options.txt |  4 +++
 commit.c                           | 74 ++++++++++++++++++++++++++++++++++++++
 commit.h                           |  3 +-
 revision.c                         |  3 ++
 4 files changed, 83 insertions(+), 1 deletion(-)

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
index 8b84ebf..076c1fa 100644
--- a/commit.c
+++ b/commit.c
@@ -510,6 +510,68 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
+/* record author-date for each commit object */
+define_commit_slab(author_date_slab, unsigned long);
+
+static void record_author_date(struct author_date_slab *author_date,
+			       struct commit *commit)
+{
+	const char *buf, *line_end;
+	char *buffer = NULL;
+	struct ident_split ident;
+	char *date_end;
+	unsigned long date;
+
+	if (!commit->buffer) {
+		unsigned long size;
+		enum object_type type;
+		buffer = read_sha1_file(commit->object.sha1, &type, &size);
+		if (!buffer)
+			return;
+	}
+
+	for (buf = commit->buffer ? commit->buffer : buffer;
+	     buf;
+	     buf = line_end + 1) {
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
+			goto fail_exit; /* malformed "author" line */
+		break;
+	}
+
+	date = strtoul(ident.date_begin, &date_end, 10);
+	if (date_end != ident.date_end)
+		goto fail_exit; /* malformed date */
+	*(author_date_slab_at(author_date, commit)) = date;
+
+fail_exit:
+	free(buffer);
+}
+
+static int compare_commits_by_author_date(const void *a_, const void *b_,
+					  void *cb_data)
+{
+	const struct commit *a = a_, *b = b_;
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
 static int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
@@ -531,6 +593,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	struct indegree_slab indegree;
 	struct prio_queue queue;
 	struct commit *commit;
+	struct author_date_slab author_date;
 
 	if (!orig)
 		return;
@@ -538,6 +601,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
 	init_indegree_slab(&indegree);
 	memset(&queue, '\0', sizeof(queue));
+
 	switch (sort_order) {
 	default: /* REV_SORT_IN_GRAPH_ORDER */
 		queue.compare = NULL;
@@ -545,12 +609,20 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
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
@@ -621,6 +693,8 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
 	clear_indegree_slab(&indegree);
 	clear_prio_queue(&queue);
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
1.8.3.1-494-g51b8af5
