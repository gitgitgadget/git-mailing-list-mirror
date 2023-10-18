Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4545F46
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2+4xM/zq"
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA611F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2b1af09c5so3008514b6e.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653955; x=1698258755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8pl6l6TKRmdNdLybEKpOArG9XEo7r0EaJDuqt7GaMfU=;
        b=2+4xM/zqjkUFLLVCBrQbf7eg6Jzxr6jSbgpg4Fn/t7H7fjSB9PorsNRnYX7tYo+Q35
         K4qKNBtrC6QCtmjt2tIl/3MjaHwvkb4dicd3VXreVE0o/lv64T6kmc+uvOHd2EFyehWl
         Glwfeht/61vlrctNJdm4a8uuO9YJqiwP/mfEyyK2GqmFPVXBV4r2/Xla9AflqRsfNkhr
         5n8CnWU1o4OeY4jNoH8NJb3MxqkR06PFzNbxFGedJAouzYtMkRXy8bERf77uJ9GdapSM
         oaQ3JID4mvIQq6ddU2Yu1ElWyp9nmulBnGlj4ui5uGpZG1cLIqyoVRvdjUNLitDpCgSH
         D9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653955; x=1698258755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pl6l6TKRmdNdLybEKpOArG9XEo7r0EaJDuqt7GaMfU=;
        b=dpCx28QRwl3OoWCEnntIsMl2ia75x1E9woJ1e6Ayw4BAhhixtaEG0DSONSZ0nLAzO9
         Y+lic0oXQqDcgxOtYV8kmR11Mckw1ZWQRlnhjTIhEQF5jBFe8gEETmE2R7Loi6KlGX6P
         lXfHpprmn6XD7BjUk+Dp4gJ+UpjqOITOuRMI51YrHajn+fbmptGu6/elykDUU2ac+dUf
         8bgKaW57g1dTE1xSzRPR6mHRmvs3ZheIea8kkf2Zvgz+2dx4RaIoV+liuMSD8bbHN+bH
         oMLE+afRrwm0o5SuMJoEbhtmCNKzXJMF2FpOP/OVxQyieaS00K1TKdq1NpHuBmnLTUNv
         gKfA==
X-Gm-Message-State: AOJu0YyaROl2LHI+226BCzLCpkX9pJMC1cUO0iSyHCKQRhiCW9AZKYCv
	km1IFpjGasN0+0yA1XFzixf2H0V29ecsBfXuesF9UA==
X-Google-Smtp-Source: AGHT+IG65nNmpeN2NnABfOMxbEUr7SIMyxQVOo09c3cnDhlIJXdpmrzFQjLgiDCPJkthwsEAKxMRCQ==
X-Received: by 2002:a05:6808:685:b0:3a9:e8e2:57a7 with SMTP id k5-20020a056808068500b003a9e8e257a7mr5689543oig.53.1697653954909;
        Wed, 18 Oct 2023 11:32:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u1-20020a0562140b0100b0065896b9fb15sm151390qvj.29.2023.10.18.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:34 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 02/17] revision.c: consult Bloom filters for root commits
Message-ID: <87b09e6266a01e7fa4480d37f22e1ac3f4be6bc3.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The commit-graph stores changed-path Bloom filters which represent the
set of paths included in a tree-level diff between a commit's root tree
and that of its parent.

When a commit has no parents, the tree-diff is computed against that
commit's root tree and the empty tree. In other words, every path in
that commit's tree is stored in the Bloom filter (since they all appear
in the diff).

Consult these filters during pathspec-limited traversals in the function
`rev_same_tree_as_empty()`. Doing so yields a performance improvement
where we can avoid enumerating the full set of paths in a parentless
commit's root tree when we know that the path(s) of interest were not
listed in that commit's changed-path Bloom filter.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-patch-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 revision.c           | 26 ++++++++++++++++++++++----
 t/t4216-log-bloom.sh |  8 ++++++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 219dc76716..6e9da518d9 100644
--- a/revision.c
+++ b/revision.c
@@ -834,17 +834,28 @@ static int rev_compare_tree(struct rev_info *revs,
 	return tree_difference;
 }
 
-static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
+static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
+				  int nth_parent)
 {
 	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
+	int bloom_ret = 1;
 
 	if (!t1)
 		return 0;
 
+	if (nth_parent == 1 && revs->bloom_keys_nr) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+		if (!bloom_ret)
+			return 1;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
+	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+		count_bloom_filter_false_positive++;
+
 	return tree_difference == REV_TREE_SAME;
 }
 
@@ -882,7 +893,7 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, nth_parent))
 			commit->object.flags |= TREESAME;
 		else
 			commit->object.flags &= ~TREESAME;
@@ -978,7 +989,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 
 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit))
+		/*
+		 * Pretend as if we are comparing ourselves to the
+		 * (non-existent) first parent of this commit object. Even
+		 * though no such parent exists, its changed-path Bloom filter
+		 * (if one exists) is relative to the empty tree, using Bloom
+		 * filters is allowed here.
+		 */
+		if (rev_same_tree_as_empty(revs, commit, 1))
 			commit->object.flags |= TREESAME;
 		return;
 	}
@@ -1059,7 +1077,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 
 		case REV_TREE_NEW:
 			if (revs->remove_empty_trees &&
-			    rev_same_tree_as_empty(revs, p)) {
+			    rev_same_tree_as_empty(revs, p, nth_parent)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
 				 * history beyond this parent is not
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 487fc3d6b9..322640feeb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -87,7 +87,11 @@ test_bloom_filters_not_used () {
 		# if the Bloom filter system is initialized, ensure that no
 		# filters were used
 		data="statistics:{"
-		data="$data\"filter_not_present\":0,"
+		# unusable filters (e.g., those computed with a
+		# different value of commitGraph.changedPathsVersion)
+		# are counted in the filter_not_present bucket, so any
+		# value is OK there.
+		data="$data\"filter_not_present\":[0-9][0-9]*,"
 		data="$data\"maybe\":0,"
 		data="$data\"definitely_not\":0,"
 		data="$data\"false_positive\":0}"
@@ -174,7 +178,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":10"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
-- 
2.42.0.415.g8942f205c8

