Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A837FF75
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984758; cv=none; b=joMNS1APxY/YkyXASh9EeSOywInObSQ+Awx88xb70JAK05yWk6kxLZFqFG34JJ7v1gJXPFlzwxy5r8yeI3OqBfwfl/z3wbetZKa0dr6rfdFcL+faiVt+I6RoJtX7KYpJjyPUOo4pjDaFIlt42cjBm//nIzrAI418aJewvEXIsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984758; c=relaxed/simple;
	bh=XLxqLT5POXRf7Ar/9HxlEBsZftQ2qd8flh7XG4WbfJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKo44pXCX+XAPS9CMCs71Krj9BTLWNIjf9GLGpI1E0a8p3emHmTySG8jOfSMrOR5Zrt3qZuGv83jr0JM9Xzis2YsG0MX/pctKpDRb+2RZ3uo5bmtr9ojkUDr5KqknyX9bcRYcbAxFU7k9zXjMJLoDlAj8YUFH0F9dlCEnJH0Gx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=lQNljhaV; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="lQNljhaV"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776984743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fybBiJYwVtkkCFuvomSGy4KTPk+Wi12/nhLDhBYnws=;
	b=lQNljhaVRkilE65GJd8avcyPtXUd7H0PAs5hGVPQVjlYkvuEjEmkOmegiNHvkvhm1vIJ5q
	8D56xzVes9jM0MTLcg31ka7LdA2Azz3Uqh8nHKiDJH2deEL6IlNG9KJA7bAgUVLfj7Ahcf
	z5uHCBWkfN5afdNuj8Q6OJ6qQH64m5teAb0DGdQHKGYjrYuneLH+6K50lyi6uwOtl0h3ZZ
	yTZ5f9bYvKpwEbUxNUn+MxmW2H8jqLP3h717fZLyKzW1vLdj63LPmmD0Sl+YfNrbAF37A8
	0zjZqN/GDhGJlkTR59Bsxic0xZkHoorihbbxYz3YyL5UVz4Zelc3rO792VImIQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v3 1/2] revision.c: implement --reverse=before for walks
Date: Fri, 24 Apr 2026 00:51:59 +0200
Message-ID: <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1776984666.git.mroik@delayed.space>
In-Reply-To: <cover.1776984666.git.mroik@delayed.space>
References: <20260422002840.303477-4-mroik@delayed.space> <cover.1776984666.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7205; i=mroik@delayed.space; h=from:subject:message-id; bh=XLxqLT5POXRf7Ar/9HxlEBsZftQ2qd8flh7XG4WbfJ0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6qKSbqQBoLSr862OxObfQDCR5TUZuZ/ke78gO g5hV3zGtECJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeqikgAKCRBIeX6hnBm+ 0XGSD/9lrHiAlVcUvqygyXYqVmg3aM0PYZjtODLoIKt4ivYrzPusuekURJZEM3KS/zEsGKze+Es wd8uua99Fk55Rd/EQNRMifAa7sCZ4CsUXy4bwPpL3GOQyFV7TbhT+hKigrPbnlJIfBHT5nQfsEF 4cZGyfsPkJZbzCWaT9FCSnUNXDVik4b3BZoduToRgX2vJ0dMwoEBIfimQ/sAszdae1Fp9PHhT/3 YLoNwgCaVBJYztBmKuI1lehFcU7fe8YCu6sG5zbzeqV7edcd7TLmHSKeCE5drod7ETUwhLCpkmv iJut/mOFlZGK9YkoucgAPQJQhNFhqk+eDslzq2lXXZlMCop/lboq3znAn6wRojWkfLoyth33SII AhJESjT259DrgL/O3H2J0S93j3GaPc9q5a9KtpPmJZR6PvIWcpPnMpEhpVDEa6tG2uNnbkkHJD9 wi76ezAMxJqPw6yXWiyJ2dAA103Fks7+AoYQcURzPbdRjD7poiduuzc4lxoey4pmBwfP8Fwp+oy ileImcnZ9iabyUPg2pyOTfMNES091J/QL5qaVvRnb6JVDzkNZDWjYVNMjsgF6RC5zWJJJFkdb0g EYNfSfaLTnnYZFkc6faHIPglYFMJXLzR+m6wC741Eebo5nMy47YQJ7ql/Fxim/syz6Cslwr8+MZ DlwyDL93C
 Ekt91Q==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----

In a revision walk `--reverse` can only be applied after any commit
limiting option. This makes getting a limited amount of commits from the
tail impossible. E.g.

    git log --reverse --max-count=3

Some would expect this to give back the first 3 commits of the project.
Instead it returns the last 3 but in reversed order.

Teach `get_revision()` to accpet an argument `(after|before)` from the
CLI, and apply the reversal before or after the commit limiting options
based on this argument. If no argument is provided default to the
current behaviour, applying `--reverse` after the commit limiting
options.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/rev-list-options.adoc | 16 +++++--
 revision.c                          | 31 ++++++++++++--
 revision.h                          |  8 +++-
 t/t4202-log.sh                      | 66 +++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..e97f6f2aff 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -914,10 +914,18 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
 avoid showing the commits from two parallel development track mixed
 together.
 
-`--reverse`::
-	Output the commits chosen to be shown (see 'Commit Limiting'
-	section above) in reverse order. Cannot be combined with
-	`--walk-reflogs`.
+`--[no-]reverse[=(after|before)]`::
+	Accepts `after` or `before`. Cannot be combined with
+	`--walk-reflogs`. If `after`, output the commits chosen to be
+	shown (see 'Commit Limiting' section above) in reverse order. If
+	`before`, reverse the commits before filtering with `Commit
+	Limiting` options. When multiple `--reverse=` options are given,
+	the final option overrides any previous options. The `--reverse`
+	option (with no specifier) behaves as `--reverse=after`, except
+	that, for historical reasons, it negates any previous reversed
+	state (so `--reverse --reverse` does nothing, nor does
+	`--reverse=before --reverse`. Note that `--reverse=before
+	--reverse --reverse` is the same as `--reverse=after`).
 endif::git-shortlog[]
 
 ifndef::git-shortlog[]
diff --git a/revision.c b/revision.c
index 599b3a66c3..d581f5e38e 100644
--- a/revision.c
+++ b/revision.c
@@ -2686,7 +2686,16 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			git_log_output_encoding = xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
-		revs->reverse ^= 1;
+		revs->reverse = !revs->reverse;
+	} else if (skip_prefix(arg, "--reverse=", &optarg)) {
+		if (!strcmp(optarg, "after"))
+			revs->reverse = REVERSE_AFTER;
+		else if(!strcmp(optarg, "before"))
+			revs->reverse = REVERSE_BEFORE;
+		else
+			die(_("unknown value for --reverse: %s"), optarg);
+	} else if (!strcmp(arg, "--no-reverse")) {
+		revs->reverse = NO_REVERSE;
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;
@@ -4525,19 +4534,35 @@ struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
 	struct commit_list *reversed;
+	int max_count = revs->max_count;
+
+	if (revs->reverse && !revs->reverse_output_stage) {
+		if (revs->reverse == 3) {
+			BUG("allowed values for reverse are 0, 1 and 2");
+			revs->reverse = 1;
+		}
+
+		if (revs->reverse == REVERSE_BEFORE)
+			revs->max_count = -1;
 
-	if (revs->reverse) {
 		reversed = NULL;
 		while ((c = get_revision_internal(revs)))
 			commit_list_insert(c, &reversed);
 		commit_list_free(revs->commits);
 		revs->commits = reversed;
-		revs->reverse = 0;
 		revs->reverse_output_stage = 1;
+
+		if (revs->reverse == REVERSE_BEFORE)
+			revs->max_count = max_count;
 	}
 
 	if (revs->reverse_output_stage) {
+		if (revs->reverse == REVERSE_BEFORE && revs->max_count == 0)
+			return NULL;
+
 		c = pop_commit(&revs->commits);
+		if (revs->reverse == REVERSE_BEFORE)
+			revs->max_count--;
 		if (revs->track_linear)
 			revs->linear = !!(c && c->object.flags & TRACK_LINEAR);
 		return c;
diff --git a/revision.h b/revision.h
index 584f1338b5..02881577dc 100644
--- a/revision.h
+++ b/revision.h
@@ -121,6 +121,12 @@ struct ref_exclusions {
 struct oidset;
 struct topo_walk_info;
 
+enum rev_reverse {
+	NO_REVERSE = 0,
+	REVERSE_AFTER = 1,
+	REVERSE_BEFORE = 2,
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -167,6 +173,7 @@ struct rev_info {
 			ignore_missing_links:1;
 
 	/* Traversal flags */
+	enum rev_reverse reverse:2;
 	unsigned int	dense:1,
 			prune:1,
 			no_walk:1,
@@ -196,7 +203,6 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			show_decorations:1,
-			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
 			cherry_mark:1,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 05cee9e41b..3bfe2c99b8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1882,6 +1882,72 @@ test_expect_success 'log --graph with --name-status' '
 	test_cmp_graph --name-status tangle..reach
 '
 
+cat >expect <<-\EOF
+c3f451c Merge tag 'reach'
+046b221 to remove
+EOF
+
+test_expect_success 'log --reverse --oneline --max-count=2' '
+	test_when_finished git reset --hard HEAD~1 &&
+	touch to_remove &&
+	git add to_remove &&
+	git commit -m "to remove" &&
+	git log --reverse --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --reverse --reverse --reverse --oneline --max-count=2' '
+	test_when_finished git reset --hard HEAD~1 &&
+	touch to_remove &&
+	git add to_remove &&
+	git commit -m "to remove" &&
+	git log --reverse --reverse --reverse --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --reverse=after --oneline --max-count=2' '
+	test_when_finished git reset --hard HEAD~1 &&
+	touch to_remove &&
+	git add to_remove &&
+	git commit -m "to remove" &&
+	git log --reverse=after --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<-\EOF
+3a2fdcb initial
+f7dab8e second
+EOF
+
+test_expect_success 'log --reverse=before --oneline --max-count=2' '
+	test_when_finished rm actual &&
+	git log --reverse=before --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<-\EOF
+046b221 to remove
+c3f451c Merge tag 'reach'
+EOF
+
+test_expect_success 'log --reverse --reverse --oneline --max-count=2' '
+	test_when_finished git reset --hard HEAD~1 &&
+	touch to_remove &&
+	git add to_remove &&
+	git commit -m "to remove" &&
+	git log --reverse --reverse --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --reverse --no-reverse --oneline --max-count=2' '
+	test_when_finished git reset --hard HEAD~1 &&
+	touch to_remove &&
+	git add to_remove &&
+	git commit -m "to remove" &&
+	git log --reverse --no-reverse --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-\EOF
 * reach
 |
-- 
2.54.0

