Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F00191F94
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817760; cv=none; b=folTWSzjYBujjK9dKCLtlNXhwVcf0qsqI++8+f9Z8PXmtfrGEJt9ltlLlfnEhgWl4aB5oP4m6aU2IljgYDBIpZzMZr/JRRMb64iV1nbS6Sgwbz2ZZMT/VcdWYdm4mYFx3tHskQe+Po9JG03hjKdRmVH0pQaTuTe1J+h4AFm9ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817760; c=relaxed/simple;
	bh=cotyybTWOaOoCxTJHde5YUSKUHs4Rlnd/xyBdCf5EZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onfjkwTcSl0hTiHuxlANAwU7bLgM2f46U9n3K9T0ag/uhcqLMZGJjQzNooMKbEBSdG2cfgcDcmq8IEshxJc+P8KytH4vjiRtlEc5nHlLfoBkk0fWu65g8LKWcLkFWpRVPz+upXxcze1B3mD//Xi09C3JciYiPp8l9Rf2uHD+92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=QKR3SW3f; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="QKR3SW3f"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776817751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOOu3jVcNWnjIoUYR9DPOJWexcDTRzmGZbNCvajLVCw=;
	b=QKR3SW3fab5E5ghGJW44fjb0I0FlX5KobQqhn20hKWEuySwom6+2OWjKAwCaOxLjpxdtKx
	YQDFfPmCCRR8O0yWzRHtSY7CGbdNk9sVLXduAYTRBfD6oHIZDE86wCcumjc2yXTGRUo0d5
	lscdKvnJIWWTgmG+nCVW/lqU+o43kRLlWUJgZgOpOGPrFCX1WuL93pyMQEzAHcWcUZ5L6a
	Bct9StuRa1lx/XJLDL6pxIocG/iPCdF+Kn1AoGpGRBG3E9aGWlXnS8eD9hCXlzgk6j9yCf
	YDrKznzuuT82WC9C+qHQMYT5HgTzZMHOoZ4Gr+j0BZ00Op1VpYcix3nVJXz2cw==
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
Subject: [PATCH v2 1/2] revision.c: implement --reverse=before for walks
Date: Wed, 22 Apr 2026 02:28:40 +0200
Message-ID: <20260422002840.303477-5-mroik@delayed.space>
In-Reply-To: <20260418164736.2367523-2-mroik@delayed.space>
References: <20260418164736.2367523-2-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7058; i=mroik@delayed.space; h=from:subject; bh=cotyybTWOaOoCxTJHde5YUSKUHs4Rlnd/xyBdCf5EZI=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6BY58oo1yqtIAB0t5+KbJMobqgtUikg68aM8n lT93sAPyoOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaegWOQAKCRBIeX6hnBm+ 0QVnEACcDEr4SwOSB0GlNMX9zrWYkusyZjdZgYpc81FCm2n0IjDg08E/gyYzrmwDwwc9DEbLLUK djLaUtzU2yYueGgJu08pT7nPP2ogPd0WL2AEHqxQFmWNAnSw0xU+xBkkCzNSJWzX/cP6QH4RVnZ 7VqLU5WXV7RwIan/03NKKY3hNeGg8bVe82PbPRuzRgUBcWAO2vGEKhPUlXb7aNFMwhJjfD2DPdL p56nd+rWm4fatNSqfr9b62fe2agj9StCmVmBNvNK4VL9Qkm8y089AArLQGQA54DYJ+jvWBIqNfN lBZyxFqvmdy3kPDgDsM65UGVsTSQm2vI3x+db/XvwDTRYT7KTBkDt8rZLFc2EsrXi+X6aCq6sH1 4F2X0QjRb6c4h2GDBy58YWeHXPQovHBOgKSsoWenz9CxTZRFw/oWwRpeI+5n+o8qPz8ebuykvy+ vYyFlVum/pGiU98/9QTKuqhPnSRjphyVv/EKNsgQKVKNt/uS5BSGoPRTxzRNLllYsYGsGUV12ce Zq+rI9ZH0i8hWh4qVMmw+hxfJogA8+o3VVhZSl9PUpvmfVYzYFw88edl8p3vx2HTmsw2hJqsnUe /ia5r5dg1Ll99K0iPhKdiPcxh4BofHkDkMCdCS3/NLuKvAhsFHB7keVNb7GdMOGQkqxZYDZCs6A zXKEcDu+RQF7rpg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

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
 Documentation/rev-list-options.adoc | 14 ++++--
 revision.c                          | 31 ++++++++++++--
 revision.h                          |  8 +++-
 t/t4202-log.sh                      | 66 +++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..7244e85108 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -914,10 +914,16 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
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
+	Limiting` options. This option can be used multiple times, last
+	one is applied. When the argument for `--reverse` is omitted, if
+	the current state is in no reverse, it defaults to `after`. If
+	it is in any reversed state, it restores the original ordering
+	by removing the reverse state.
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

