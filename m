Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20731ADC97
	for <git@vger.kernel.org>; Fri, 15 May 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887830; cv=none; b=JDosZ6/vXgutcPYqDjc0YG0bHbLCl56PyubiQGMQSKTdgDGe6OaaD6FI2CUl72h28p8hroOO3mCXCwbq+6lOH4fhriIuI/Us5KBZ/FSUu97ZOiaVCI80io/1iDTD8rBmsaZ2pWXYZQ1wF0ivJIJ63n4ETsy4AfHE2dhYg/nUVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887830; c=relaxed/simple;
	bh=t/vahvXRb3lJtLX1HvEpPkESi0OaQyHo/1lUjLaJOJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIjnj8Vi55LWtoad+7RYSj4Y31I8VgQ0mJSzpkio90kAI3bx8uc7p9Tcgf5jC4e0SEB0Krijl36PD9GxlPLMx+IjBg3NgoKKlwy79/k6LC5ZCazHJ8PtADHHqru6Vk/Jvo3DmUGBs4AHnHt3bYm9ZJA0AewuARsl9iwxcqFRVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ndSmWr27; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ndSmWr27"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778887820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KL7JbTnmDpQ6/dhjh+ZISCtHiTX4uBF70ium5vZ+ofI=;
	b=ndSmWr27xyuEoM9hhUhXE872+5afsSvFsmnJ5PqSlfU9Fhjyq6Ga3VywCXF52YJstVlGIJ
	S64vwYYUFFaifrfqgZqJrb6Kkk1jH2HjBplZyBeSWRjuc6MAgXHMr+1GpTnxzy0skNGC1Q
	tYsOfA9WpWmBGCD0E1D80b8hGGoadSKETV+AU87Zkbvy4lYuiOCz94akc5enMa3TxyUExF
	5iL8RByTp4QsGmHEht084zZuxR6RDFw4WLQq6ziSHaCABQeIq1snmEPiTCG5FqQVn8F+f5
	3x9HHmnZikw6NKNRmmxq2yND1e3QNR+csXaT+WHsmvkB1YvsKRJmO9PtMFxSoQ==
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
Subject: [PATCH v7] revision.c: implement --max-count-oldest
Date: Sat, 16 May 2026 01:29:55 +0200
Message-ID: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
In-Reply-To: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
References: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7842; i=mroik@delayed.space; h=from:subject:message-id; bh=t/vahvXRb3lJtLX1HvEpPkESi0OaQyHo/1lUjLaJOJo=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqB6xz1d64NxrmeJsR5TsLz+W20RzD9PdrQkTgl qd2Bu5y0nmJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCagescwAKCRBIeX6hnBm+ 0Qs4D/99HmTXUwG9QCiOWLshJlYkxarGsrX2HJ7DTkoFdDd0GVx4Z1/lggivmpaEQmhJBl6ekJY qav9G7f4fw+Wt2SR/mcCx6XAvQ8f3S6nXOYiZnpl20Qbvmysc62SZemNup562YM8EGakAAdvUyz yKfDIE/3IoNk9mXzb4+iTahDQC2PS1KX8psRG870pzuYQTO6HUH3UrJ/uUPuoPyk6OcK5TfCOwc MKLlcBTeGvL6ZVcfGmkRtVrCBBYEXKq9iyWcLayynXJkeq4dP36/3WTlxWoIaa9SXQzwyZTyfmX DVhSMfW8uTQC6sgLHoC07fi7vz9M8AS3rpxIWHUmUiRMwhv2AGJdB9m0qxLbOpVq1ccaZaWONo3 +NVJ5RWPLr/zzHQhQlyrrSMeohSxvpzegWL54qNln/UE2tTR7kkbW3STBDndYDa3I8oT4jykc6r a+2jloQ/aBrW1po/Vm4vX8dw+dZv07grnnC/rRHmfJuQj388khswODtBfJxAAuQT7gqvAPuqPMe ipIzd+/f9UP+Hp6v2S1zbOq15fZIL46ZrPnbGI8q1VdNbmZODI7nfv4xELZ7jFfKk6DijCA8t6i cCCP5CAbLPGZGgfam33BOw10jeeF0BemCtmSf1CUX71h5hgWE1phXqQv4DZ/qK+RaYnBpiAV4h5 MXz8A0+rW
 +WPeNQ==
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
Since v6 I've simplified the docs, replaced die messages with
die_for_incompatible_opt2 and fixed graph output when used with
--boundary.

 Documentation/rev-list-options.adoc |   5 +-
 revision.c                          | 103 +++++++++++++++++++++++++++-
 revision.h                          |   2 +
 t/t4202-log.sh                      |  33 +++++++++
 4 files changed, 139 insertions(+), 4 deletions(-)

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
index 599b3a66c3..7fc79049b2 100644
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
@@ -4521,15 +4539,83 @@ static struct commit *get_revision_internal(struct rev_info *revs)
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
+		queuei_count++;
+		while (queuei_count + queueo_count > max_count) {
+			if (!queueo_count) {
+				while (queuei_count > 0) {
+					c = pop_commit(&queuei);
+					queuei_count--;
+					commit_list_insert(c, &queueo);
+					queueo_count++;
+				}
+			}
+			pop_commit(&queueo);
+			queueo_count--;
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
@@ -4543,7 +4629,18 @@ struct commit *get_revision(struct rev_info *revs)
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
index 05cee9e41b..8f2471e7e4 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1882,6 +1882,39 @@ test_expect_success 'log --graph with --name-status' '
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
 cat >expect <<-\EOF
 * reach
 |
-- 
2.54.0

