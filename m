Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3E1DA0E1
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152716; cv=none; b=oP4N1m0ugwLDfQX2isuQpOCONJjLxXULbi1GU5o2s/kmqX/xIZJhAxJycmNEOrZ96yqBvbYWcMTVcGf2Jl2AHyFvBZKDVMdzKs84z/FKmmTPmsC4O19qKcSN8xiQUt06JwqQR7H34sT5ZPvvPOSRcshz9OozApmyH2yqVqrgvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152716; c=relaxed/simple;
	bh=yGv9s5/WXslTZNpBMmdfadyDsIO+AFaGs5s73Fy2eOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGe+GQhpim92z0hlI8PI4oIT+PIpc5fAHFiuhtLhoKeOIHqTGlDGTKQ+iI+LeZGMQ0xMyVmZlEIx3/oYhxrYYzFy4+XeCpRr161nD2hUwCmTHnFH9Bk4/sKVQJUr1LL83VTV6Kgp8rb+LgjIBaDE+ukiLeoW8eo9QcNp5F1oUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=CBfU8utp; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="CBfU8utp"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1779152156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/5sOIqL87vg9fFbGN3M15/Aiju/Tro35RfNVmqobvc=;
	b=CBfU8utpvWPYImzSet+FfeSCNfhvI5LbhqfKZdscW3FJQO2/AkcP2n1WDI4cIo/91sWRDU
	pMTZ5ipkyXJWCkGT5T1vli8rYb1Bp8Uu5FzFeOSAMIsAwvuFu3h2im9T8ymGRdyoGQAjJj
	lOaUo7LcPctjDefOt4W/m0ijzN2UFlOA2/HY0d7SrrJp6Hgqu1wUJIMS9sLI9KSpvTKGMq
	0r3uOQxlH2Y+MSs8jWmp/4qmc+AWsRKxQAJseR3fshD66WuUGbzaYMGSdNfFaB6X+GC6YG
	ZBHPG7v3Nwxozda3X68Bn2ULGvzTNVUZ9yhZOKepBXcmfez6x+OcM74euLPhGQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v8] revision.c: implement --max-count-oldest
Date: Tue, 19 May 2026 02:55:22 +0200
Message-ID: <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
In-Reply-To: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
References: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8353; i=mroik@delayed.space; h=from:subject:message-id; bh=yGv9s5/WXslTZNpBMmdfadyDsIO+AFaGs5s73Fy2eOk=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqC7T6UX19lPIwJZ39qahAlcQIeXuVHjhzzYbT0 kO8bAfJVuOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCagu0+gAKCRBIeX6hnBm+ 0S+eD/wIVuXcuqjuyIk6n6spDSDOvWdVfFNnUFIpH2rW8BlmhuGyX11z9tlsMEHu6RfZ2+k7p4Z wYONnNUu5rY0YV07rXQ2qc45y8oY1y9i2ACdnCOzQhIi+A0n81lfiKrWuBcUdsZ3M1feLY7WYOf Q+NebBhr5XXayKn8M9Z9t0m57RP+GmnGgVuQQiEqJF6CRB69J72W4KIx+VXFvUr886isqnXonVO K3vZBzmAitJagi6Rgk3mjOG3KNFNwHuEzSt3PaKHtP6YWzLX43jyOs1LocnW4TQJjd9gL4IVLMb aAkdzqZ8slZo2hS1g4G5cY9AtcbA8JSIBLLV81O/cxymB8+TiOz0GyJCTtjmEy/5kA3blgkEYVA 7kLAp+a6cLPj2l2bCw6sSO1viKCD3yjdDG48PGlQrbrMc/Gr5g+G4J3WC/H4JnJC8HUx9WFr3xO iPBGNQjECV177SGwHPZsx9LGm6hJBMrQxElo+6JOdEPGVaZXE7JkyJZGmr1ixTaUpXpwJtJFSMZ VpZYP6AuR8vF7oFG43longnDSg43LxjjmmsJMwlxjvtryhJElFq3yr+4LEqtJPpiazR38S8rAWX FcB7zW0xa1yRE+Jdv+63Z5lpHDfL3arnM/ma/oRjUBZbpoKYW+hZR4X4MEwQRGWle1uJMwxilvk p+VXdKIaH
 +4ixuw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

--max-count is a commit limiting option sets a maximum amount of commits
to be shown. If a user wants to see only the first N commits of the
history (the oldest commits) they'd have to do something like

    git log $(git rev-list HEAD | tail -n N | head -n 1)

This is not very user-friendly.

Teach get_revision() the --max-count-oldest option.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/rev-list-options.adoc |   5 +-
 revision.c                          | 111 +++++++++++++++++++++++++++-
 revision.h                          |   2 +
 t/t4202-log.sh                      |  41 ++++++++++
 4 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..e8c88d0f1c 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -16,7 +16,10 @@ ordering and formatting options, such as `--reverse`.
 `-<number>`::
 `-n <number>`::
 `--max-count=<number>`::
-	Limit the output to _<number>_ commits.
+	Limit the output to the first _<number>_ commits that would be shown.
+
+`--max-count-oldest=<number>`::
+	Limit the output to the last _<number>_ commits that would be shown.
 
 `--skip=<number>`::
 	Skip _<number>_ commits before starting to show the commit output.
diff --git a/revision.c b/revision.c
index 599b3a66c3..5d53db3152 100644
--- a/revision.c
+++ b/revision.c
@@ -2339,10 +2339,28 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	}
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
+		if (revs->max_count_type == 1)
+			die_for_incompatible_opt2(1, "--max-count", 1,
+						  "--max-count-oldest");
 		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
+		revs->max_count_type = 0;
 		return argcount;
+	} else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
+		if (revs->max_count_type == 0 && revs->max_count != -1)
+			die_for_incompatible_opt2(1, "--max-count", 1,
+						  "--max-count-oldest");
+		if (revs->skip_count > 0)
+			die_for_incompatible_opt2(1, "--skip", 1,
+						  "--max-count-oldest");
+		revs->max_count = parse_count(optarg);
+		revs->no_walk = 0;
+		revs->max_count_type = 1;
+		revs->max_count_stage = 0;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
+		if (revs->max_count_type == 1)
+			die_for_incompatible_opt2(1, "--skip", 1,
+						  "--max-count-oldest");
 		revs->skip_count = parse_count(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
@@ -4521,15 +4539,91 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	return c;
 }
 
+static void retrieve_oldest_commits(struct rev_info *revs,
+				    struct commit_list **queue)
+{
+	struct commit *c;
+	int max_count = revs->max_count;
+	int queuei_count = 0;
+	int queueo_count = 0;
+	struct commit_list *queueo = NULL;
+	struct commit_list *queuei = NULL;
+	struct commit_list *reversed_queue = NULL;
+	struct commit_list *p;
+
+	revs->max_count = -1;
+	while ((c = get_revision_internal(revs))) {
+		/*
+		 * We need to reset SHOWN status otherwise --graph breaks.
+		 * It is fine to do, get_revision_internal() doesn't consider
+		 * children commits as they have been already processed and the
+		 * traversal happens only child to parent.
+		 *
+		 * We do this because the --graph machinery relies on the status
+		 * of the parents to decide how the printing will happen.
+		 *
+		 * We can't simply replace this instruction with a
+		 * graph_update() as it doesn't do the actualy printing, we'd
+		 * have to remove any commit that goes over the
+		 * --max-count-oldest limit from revs->graph.
+		 */
+		c->object.flags &= ~(SHOWN | CHILD_SHOWN);
+		commit_list_insert(c, &queuei);
+		if (!(c->object.flags & BOUNDARY))
+			queuei_count++;
+		while (queuei_count + queueo_count > max_count) {
+			if (!queueo_count) {
+				while ((c = pop_commit(&queuei))) {
+					commit_list_insert(c, &queueo);
+					queueo_count++;
+				}
+				queuei_count = 0;
+			}
+			c = pop_commit(&queueo);
+			queueo_count--;
+			/* We need to do this otherwise we'll discard the
+			 * commits that go over the --max-count-oldest limit but
+			 * not their respective boundaries. This matters only if
+			 * we're discarding the commit right before the boundary.
+			 */
+			for (p = c->parents; p; p = p->next)
+				p->item->object.flags &= ~CHILD_SHOWN;
+		}
+	}
+
+	while ((c = pop_commit(&queueo)))
+		commit_list_insert(c, &reversed_queue);
+	while ((c = pop_commit(&queuei)))
+		commit_list_insert(c, &queueo);
+	while ((c = pop_commit(&queueo)))
+		commit_list_insert(c, &reversed_queue);
+
+	while ((c = pop_commit(&reversed_queue)))
+		commit_list_insert(c, queue);
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
 	struct commit_list *reversed;
+	struct commit_list *queue = NULL;
+	struct commit_list *p;
+
+	if (revs->max_count_type == 1 && !revs->max_count_stage) {
+		retrieve_oldest_commits(revs, &queue);
+		commit_list_free(revs->commits);
+		revs->commits = queue;
+		revs->max_count_stage = 1;
+	}
 
 	if (revs->reverse) {
 		reversed = NULL;
-		while ((c = get_revision_internal(revs)))
-			commit_list_insert(c, &reversed);
+		if (revs->max_count_type == 1)
+			while ((c = pop_commit(&revs->commits)))
+				commit_list_insert(c, &reversed);
+		else
+			while ((c = get_revision_internal(revs)))
+				commit_list_insert(c, &reversed);
 		commit_list_free(revs->commits);
 		revs->commits = reversed;
 		revs->reverse = 0;
@@ -4543,7 +4637,18 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	c = get_revision_internal(revs);
+	if (revs->max_count_stage) {
+		c = pop_commit(&revs->commits);
+		if (c) {
+			c->object.flags |= SHOWN;
+			if (!(c->object.flags & BOUNDARY))
+				for (p = c->parents; p; p = p->next)
+					p->item->object.flags |= CHILD_SHOWN;
+		}
+	} else {
+		c = get_revision_internal(revs);
+	}
+
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
 	if (!c) {
diff --git a/revision.h b/revision.h
index 584f1338b5..e157463cb1 100644
--- a/revision.h
+++ b/revision.h
@@ -309,6 +309,8 @@ struct rev_info {
 	/* special limits */
 	int skip_count;
 	int max_count;
+	unsigned int max_count_type:1;
+	unsigned int max_count_stage:1;
 	timestamp_t max_age;
 	timestamp_t max_age_as_filter;
 	timestamp_t min_age;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 05cee9e41b..c3c1b862d3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1882,6 +1882,47 @@ test_expect_success 'log --graph with --name-status' '
 	test_cmp_graph --name-status tangle..reach
 '
 
+test_expect_success 'log --max-count-oldest=3 --oneline' '
+	test_when_finished rm expect &&
+	git log --oneline | tail -n3 >expect &&
+	git log --oneline --max-count-oldest=3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
+	test_when_finished rm expect &&
+	git log --oneline --reverse | head -n3 >expect &&
+	git log --oneline --max-count-oldest=3 --reverse >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --max-count-oldest with --max-count' '
+	test_when_finished rm stderr &&
+	test_must_fail git log --max-count-oldest=3 --max-count=3 2>stderr &&
+	test_grep "cannot be used together" stderr
+'
+
+test_expect_success 'log --max-count-oldest with --skip' '
+	test_when_finished rm stderr &&
+	test_must_fail git log --max-count-oldest=3 --skip=1 2>stderr &&
+	test_grep "cannot be used together" stderr
+'
+
+test_expect_success 'log --max-count-oldest=1000 --graph --boundary' '
+	test_when_finished rm expect actual &&
+	git log --graph --boundary >expect &&
+	git log --max-count-oldest=1000 --graph --boundary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --oneline --graph --boundary --max-count-oldest=1' '
+	test_when_finished rm actual &&
+	echo 2 >expect &&
+	git log --oneline --graph --boundary --max-count-oldest=1 HEAD~1..HEAD \
+	| wc -l >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-\EOF
 * reach
 |
-- 
2.54.0

