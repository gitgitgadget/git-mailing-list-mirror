Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B333374F
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578812; cv=none; b=FJOQ17HYJv8uEfDs4PKD042JKLXS8/gBhCFHW2lq8AznljcXgJgM6jUfBg3o3Kkx462qBdtCfEBXAjd0CjUXheVAgMMrBRdyxqeL8YpIW0mgZsOR8f9ujI2dOwnsl9hJwncmrp6CbzcykY2Y2ibd21pCMdnCl+ZaAjE6gRvJq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578812; c=relaxed/simple;
	bh=j5WC300Mptmwcu19MD603tCCVFiYgEr67k2UwJtMjm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApmxK3Tz/qZyc/f1+iYNWYz775iFHfZdyDe6pOpDq1yajd166nxCSy6vGCZ+zS/Hp0O7O4p+m59HY8Q1NBAAzX3Qa0EIz3ReVL1LZYQtiTP+Q5hIC2IBl21HjW7S2/HcpVL9vK/GGyxUVagY5XuudA4kQ+4/UGdegYJzj44PNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ZDA+UDTn; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ZDA+UDTn"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1777578800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90LB6azF2+xNtH5HRrcYFGaD0L7SsdH9hOwqQEVlSTs=;
	b=ZDA+UDTnKf2T/cIV1+l1kv1qejohqHFo28suQtRuNNAWv+6Ww0W735I48s6M9yEv9p4kT0
	mnnGGwvqqSN1UO3xPc+9ZTCXj2+aXUxUtYA66X83XrpnIuQ7M2XadKpIBMy3sA2RVTWzy7
	8xRa8Yw/nQDXSV2BhIb7LFElX7Xy4Km2b03zwgTcs6jJiaSxBnRhEFY90/gYupgLDgqFf8
	8YDZ5INW7EHtqQufT+6R1sAstKDeVax056SYGyrCrQ3oU+oLeX1L19TUtkaxXczYC+QJli
	jIswYmplvpIIQsuzCvgsGmfeeRxheI9rYlCtof65osfmDgHMOd0OjKCJbYQzSQ==
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
Subject: [PATCH v5] revision.c: implement --max-count-oldest
Date: Thu, 30 Apr 2026 21:52:45 +0200
Message-ID: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
In-Reply-To: <cover.1777249165.git.mroik@delayed.space>
References: <cover.1777249165.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5870; i=mroik@delayed.space; h=from:subject:message-id; bh=j5WC300Mptmwcu19MD603tCCVFiYgEr67k2UwJtMjm0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp87MNMCS1/PJLuaypQgduwdT4JG/wjJgjuE6FS kozdUADnq2JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCafOzDQAKCRBIeX6hnBm+ 0XMDD/sEI++X4hYIc1yVN8t74lhd0o3VtyZ3JoCJRYsmuQrfQEDRXAc5lput1L2L5BJaS4STndE 2FkT05CmTSWoXYfC2qdiGra/2PwiWNxJL8Rb2gekVRqk6Sa23TZfQ8rxosnlgrxGi1BDZw5aDZG aoyaUeClU+kC68HiVlHzZENNDyRT5JjSNTpbL1UgU7AdosEGxep/NHVQ30EhfR+qJUdxlB38i81 XBxL5erzqf9B6+2RbnYO+YxPogLz8YDrvr75QIOesyGdsxnNXCoz2KNQZXFFxlWmLGomiq1Mn5T Qx39YGT2VdzyGuGi6jriRjJuUZrEqnpw6AKPZJMALu1ZL2UTmiPIGLprFMexO2z7/9GGz1J1W9T oo2SAwKzrfz1++cDg0gz4GKEMRrCSgU5vIDKxhnAsOV4UrMFHwwgTLOHvzKVgXUrdZ/7fwK1Nhd ZYfwuPZAbsKQF7vVqFJCxTC7GvlyMPsUn9MHr4ayKfx5K0H9H1W+2BwA0knmsTCv86ublILlkTc jBYth5y837H32QZpdeVdtELRd4fiGyYx48eODmLAJuViW5ljEfWFTkokjQZRrYTI+IyqLQoA53e eVCQvohkWdS2rC2m52juBg3JyEbYKPqUlKNO6OO3dRqhv//aQH9VT3UOELFbnaGOeVzsekvrDha qQwwCC4hg
 KkNFiQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

--max-count is a commit limiting option sets a maximum amount of commits
to be shown. If a user wants to see only the first N commits of the
history (the oldest commits) they'd have to combine --max-count with
--skip. This is not very user-friendly.

Teach get_revision() the --max-count-oldest option.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/rev-list-options.adoc |  3 ++
 revision.c                          | 77 +++++++++++++++++++++++++++--
 revision.h                          |  2 +
 t/t4202-log.sh                      | 14 ++++++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..736f34efab 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -18,6 +18,9 @@ ordering and formatting options, such as `--reverse`.
 `--max-count=<number>`::
 	Limit the output to _<number>_ commits.
 
+`--max-count-oldest=<number>`::
+	Limit the output to the _<number>_ oldest commits.
+
 `--skip=<number>`::
 	Skip _<number>_ commits before starting to show the commit output.
 
diff --git a/revision.c b/revision.c
index 599b3a66c3..3aaa77ced5 100644
--- a/revision.c
+++ b/revision.c
@@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	}
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
+		if (revs->max_count_type == 1)
+			die(_("can't use --max-count with --max-count-oldest"));
 		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
+		revs->max_count_type = 0;
 		return argcount;
+	} else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
+		if (revs->max_count_type == 0 && revs->max_count != -1)
+			die(_("can't use --max-count with --max-count-oldest"));
+		if (revs->skip_count > 0)
+			die(_("con't use --max-count-oldest with --skip"));
+		revs->max_count = parse_count(optarg);
+		revs->no_walk = 0;
+		revs->max_count_type = 1;
+		revs->max_count_stage = 0;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
+		if (revs->max_count_type == 1)
+			die(_("con't use --max-count-oldest with --skip"));
 		revs->skip_count = parse_count(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
@@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct rev_info *revs)
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
+		c->object.flags &= ~SHOWN;
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
@@ -4543,7 +4610,11 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	c = get_revision_internal(revs);
+	if (revs->max_count_stage)
+		c = pop_commit(&revs->commits);
+	else
+		c = get_revision_internal(revs);
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
index 05cee9e41b..668c231cf1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1882,6 +1882,20 @@ test_expect_success 'log --graph with --name-status' '
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
+	git log --oneline | tail -n3 | tac >expect &&
+	git log --oneline --max-count-oldest=3 --reverse >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-\EOF
 * reach
 |
-- 
2.54.0

