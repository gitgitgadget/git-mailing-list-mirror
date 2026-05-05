Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C82F616A
	for <git@vger.kernel.org>; Tue,  5 May 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018136; cv=none; b=nZ98MiQI32fLx3ZRD0CDVWBEuBcuVWXrjDDXxYBIU/NZ31UQhml772olcoY+aWGsSUy2CzKceEcvRV/057V0I7fjl9+L2mPxkkLkjNEn5gWNqWee2nfLcEXFhmWETMW5tGf6R2OPQ0ioAfwT5NXofB8edyJv+t8vrcIwPgUAmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018136; c=relaxed/simple;
	bh=6tP45YZT5eOFHMPbnOf5AXk8sR6z0WJ1XGr1AAcd5V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLBZQkmd8pb820F8KFuC7QHmt3/9UM6YGDirMNctDpID21TIbj5CmUa0X80VJAIfLM2zQx9FZjbyDvWrxJWkcZ+izYhZGroUv+kNXpAuymmugg1V/ctykV3h07X0DP9HAOmmukvL+L6X4/yAlukOL2m7HQSK6nnE4nimuXmBh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Uops/tEa; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Uops/tEa"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778018124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8nWQX8wYqtEVMs4Gd0FE7+hwExVSoPBTU2At3jIVuw=;
	b=Uops/tEaWSNDX01FjdHilmPGPjBjA6z995HR8mVkue/u1+rnC7/4hSnJ+mSfo/nbxooR+Q
	O+DIYErf9FPuxhORFo0oTA1d3SwZHnkEufbPldlINI+GJPWzCQL422KCgtBh7SsKeioU2m
	o/yXSRCsLbxZ3YDqxM1/QbqtzWFQ7LLkySR/fxZ7mW23W+APQYvSwKvxjK04jfy5igFuR5
	STRXGs8gK+GBAJClqGPnlZ99ydx8EzOgkPHJi5vN7T19t5lWzfIjh56TJHtASK0wrJvIxq
	oqnIv84JkerYOBlthLb+M055K3YrdxNGn3sUMNljbi6ZvKWYJz0H2Cn/kFtg9w==
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
Subject: [PATCH v6] revision.c: implement --max-count-oldest
Date: Tue,  5 May 2026 23:54:56 +0200
Message-ID: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
In-Reply-To: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6672; i=mroik@delayed.space; h=from:subject:message-id; bh=6tP45YZT5eOFHMPbnOf5AXk8sR6z0WJ1XGr1AAcd5V0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp+mcxvM2KkFT53jeOo2iNegjq+q5qffTFOK/89 uLwLoGnJmuJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCafpnMQAKCRBIeX6hnBm+ 0W+QEAC/cdhgBkiNGla3IcEAJWlKxvvIKEXQuoidJAhIoqggRM0FdyRutySRM9AmKAcPxvNYDcn FahEsTKhhOS/z0W9ox2p3iRVJGqfshbTvJBCTGR4uoQcK/8fqPA7LZ79GxxNiSO5rKxph27K6Lu +dvEOZAMpRTbjKcfTl+gE1bRI04Xn5IAsII9PcAMK+o3SrrtCmhkfDH+SGDSfKjSFTsoS2EO+wS uNkjN874z26ieBporQL6QwS+S51Bbbs19aZgI99bw0Fu+FXqIc+wffq8eRNknrHWzec3sq9w+Lx EcplTpU6aGnwnrDvkYnN3id3ABY38fXTAfoNHfcRrcS9a/4Y5YrMBw+gMqrpWtFpJoE2xJyepph vTV4B9ux+7m638ITdRqKm1ss9uTtoPF6B/nNzo6PSnKSu2eP8PxlheVXBQTCEwpZT1zIHYJpaVW BE2hpmt+Mqu/AhsgylG2Id0z0YRCSr/GPHECucp0VOUnuh6YlhOJV3tLEN5oHhU5K/QUGg/Ua0w DyIH4oUQftJMCABiEaZ8qnBQNXZ+Ecome5V97mTaVjICsNvnTcBuoDXZ2w3XMGZBZy5AMuj6ZaN xMWID+dZd/uWw9nIPcUAcQxVm4yd7UcHbgr4x6wwy16atNfc4DYnJWpMUGFjGFFQVqFogj9XYUS noLXcyZhY
 3kVv8Q==
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
Since v5 I've reworded the commit message and rewrote the docs for
--max-count-oldest to be clearer on its functionality.

 Documentation/rev-list-options.adoc |  5 ++
 revision.c                          | 77 +++++++++++++++++++++++++++--
 revision.h                          |  2 +
 t/t4202-log.sh                      | 14 ++++++
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..9f857cabcc 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -18,6 +18,11 @@ ordering and formatting options, such as `--reverse`.
 `--max-count=<number>`::
    Limit the output to _<number>_ commits.
 
+`--max-count-oldest=<number>`::
+   Just like `--max-count=<number>`, it limits the output to _<number>_
+   commits. But instead of limiting to the first _<number>_ commits it
+   limits to the last _<number>_ commits.
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
+       if (revs->max_count_type == 1)
+           die(_("can't use --max-count with --max-count-oldest"));
        revs->max_count = parse_count(optarg);
        revs->no_walk = 0;
+       revs->max_count_type = 0;
        return argcount;
+   } else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
+       if (revs->max_count_type == 0 && revs->max_count != -1)
+           die(_("can't use --max-count with --max-count-oldest"));
+       if (revs->skip_count > 0)
+           die(_("con't use --max-count-oldest with --skip"));
+       revs->max_count = parse_count(optarg);
+       revs->no_walk = 0;
+       revs->max_count_type = 1;
+       revs->max_count_stage = 0;
    } else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
+       if (revs->max_count_type == 1)
+           die(_("con't use --max-count-oldest with --skip"));
        revs->skip_count = parse_count(optarg);
        return argcount;
    } else if ((*arg == '-') && isdigit(arg[1])) {
@@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct rev_info *revs)
    return c;
 }
 
+static void retrieve_oldest_commits(struct rev_info *revs,
+                   struct commit_list **queue)
+{
+   struct commit *c;
+   int max_count = revs->max_count;
+   int queuei_count = 0;
+   int queueo_count = 0;
+   struct commit_list *queueo = NULL;
+   struct commit_list *queuei = NULL;
+   struct commit_list *reversed_queue = NULL;
+
+   revs->max_count = -1;
+   while ((c = get_revision_internal(revs))) {
+       c->object.flags &= ~SHOWN;
+       commit_list_insert(c, &queuei);
+       queuei_count++;
+       while (queuei_count + queueo_count > max_count) {
+           if (!queueo_count) {
+               while (queuei_count > 0) {
+                   c = pop_commit(&queuei);
+                   queuei_count--;
+                   commit_list_insert(c, &queueo);
+                   queueo_count++;
+               }
+           }
+           pop_commit(&queueo);
+           queueo_count--;
+       }
+   }
+
+   while ((c = pop_commit(&queueo)))
+       commit_list_insert(c, &reversed_queue);
+   while ((c = pop_commit(&queuei)))
+       commit_list_insert(c, &queueo);
+   while ((c = pop_commit(&queueo)))
+       commit_list_insert(c, &reversed_queue);
+
+   while ((c = pop_commit(&reversed_queue)))
+       commit_list_insert(c, queue);
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
    struct commit *c;
    struct commit_list *reversed;
+   struct commit_list *queue = NULL;
+
+   if (revs->max_count_type == 1 && !revs->max_count_stage) {
+       retrieve_oldest_commits(revs, &queue);
+       commit_list_free(revs->commits);
+       revs->commits = queue;
+       revs->max_count_stage = 1;
+   }
 
    if (revs->reverse) {
        reversed = NULL;
-       while ((c = get_revision_internal(revs)))
-           commit_list_insert(c, &reversed);
+       if (revs->max_count_type == 1)
+           while ((c = pop_commit(&revs->commits)))
+               commit_list_insert(c, &reversed);
+       else
+           while ((c = get_revision_internal(revs)))
+               commit_list_insert(c, &reversed);
        commit_list_free(revs->commits);
        revs->commits = reversed;
        revs->reverse = 0;
@@ -4543,7 +4610,11 @@ struct commit *get_revision(struct rev_info *revs)
        return c;
    }
 
-   c = get_revision_internal(revs);
+   if (revs->max_count_stage)
+       c = pop_commit(&revs->commits);
+   else
+       c = get_revision_internal(revs);
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
+   unsigned int max_count_type:1;
+   unsigned int max_count_stage:1;
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
+   test_when_finished rm expect &&
+   git log --oneline | tail -n3 >expect &&
+   git log --oneline --max-count-oldest=3 >actual &&
+   test_cmp expect actual
+'
+
+test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
+   test_when_finished rm expect &&
+   git log --oneline | tail -n3 | tac >expect &&
+   git log --oneline --max-count-oldest=3 --reverse >actual &&
+   test_cmp expect actual
+'
+
 cat >expect <<-\EOF
 * reach
 |
-- 
2.54.0

