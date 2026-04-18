Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4E25B2FA
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531422; cv=none; b=L9YyVhnupudh5sd3zDqGWPKwe4/R6PJZbALq5QLigU83ByUepwzXwnVKCoDublzuNHvAKI0oDK9vRWepviqGaSAJnYiXdIiFQlViplo9hjBq1LnEl2FngK8jiZY7cdmTASHNM08L5qwQhKKIvpOGqHTfN08I5VsSy2WJO63mljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531422; c=relaxed/simple;
	bh=BGq7eYOgorzRNbiH0auSgEP1aXqzIROypIWWBH4nTF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7gAz+OV2J1W0K+MZYiz2FfRVKwLwL3qqbgo+GU6PUJ0sxarr53g7a4pEtPVPena4YENsIgr7lozcZxhI2pD6x8oIQnTA3Osw86N4Y7NGcf+ZWJZo/B8RaVc+cptxNiRIl17EcfEGszE7NVf6e78Ej9TwX8cy6p2JF4o47LJC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=dRz9shaZ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="dRz9shaZ"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776530872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PZg6puCyA4G0mnqf7NwmZN1t0dflDi664DzHwO8zvUs=;
	b=dRz9shaZ3Rbi/1D7DOOiu+ipK4syfMAEDhelBkgdnuXUoOhpzo+RbTNOpzy3g8xn30cO/s
	ds2vOQNL6LLZSRTEoIWnnNbZW66c/5MUAgQVzfFvyFPf+FmoY80GtWAuQU+BWtbLo2J9N4
	+0AfUoQGcO1HlK+tw8wTTGTik9TTel1M+DEx3se8UDeR6yNocs5VhJzVslKrrLvJaluG+r
	DDfcqrckOqtzfZTJK25mGqsncP3q8BMZLa44DCmbIdHoell8ZxnypL98AqZkkOQ3w+xpH7
	M6r8EdCYqmO5bk8V/cJ47LM7XCqs1PsEfnRdj2UHhtoDnUoFSOxg/ugYVVU+yw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Jeff King <peff@peff.net>
Subject: [PATCH] revision.c: implement --reverse=before for walks
Date: Sat, 18 Apr 2026 18:47:35 +0200
Message-ID: <20260418164736.2367523-2-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5928; i=mroik@delayed.space; h=from:subject; bh=BGq7eYOgorzRNbiH0auSgEP1aXqzIROypIWWBH4nTF0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp47WoJSxTVOGKZOslHRwnzKtm1nrkcun/0G7/z JR8YM5zF5iJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeO1qAAKCRBIeX6hnBm+ 0W1aEACmDn038eIt8wNm/euWCPQFori3vkDPLjr1zQZJVebUEZ6mK6RE9LUY9xNCiW5kU33Ot9M +uB2ApwsHDNA9DnCzEEW4JigLp8OWGJitic2Dkcw511FdJcpu4Ddfv5Bds6bBTkRKeFMDyqQr0y 890MDRBdksNHf0zmSwc+sSJm/EUz38nhQG1zD8y9KRdO8PgqEBwpOJ+LM+J+1+reRhtrmzqEakF Gn4sN/teMMIdT+BLuyiKfTJCsqW1nXpVDwFUuSih2wqWcuklOV3bhiCJ032bXdRRQuqPrDql+Pf ox+s4YgdPDYMbxJXWhbnuyZ7Jnla+8UjBB5HoZ+KNWLeCnMvysotCvltktMTlhY/CeROaAkZVwd HLxASv0s5vKnUEko/ayf3DTreksKNEu7C4RWBTX3FzUa8RkfCfaZVZPFJnfZl6/7lamuMGQRe6L w97p8aat4JIo2ehyVWMkJpY5db78IQF8344BzFPszQp1/800HGvzOd4Q6fFua4h5nea797Jn3rg D75GFgjGSB3ob6m2LJOGrSSYkuthDCwyPPCgFOeIbzP5ahgzp2i5LQpBbE4rg8vzm0lda/kncL5 FaSjshGn+Zw5UZOAlDawTyyqjnMv0xhQtbW6uUcbcvpxjICk+bS9LOqZv5rGOqiXQQ33D8cYvlK NPHSWvO4FEy3lMg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

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
 Documentation/rev-list-options.adoc |  6 ++--
 revision.c                          | 42 ++++++++++++++++++++++---
 revision.h                          |  7 ++++-
 t/t4202-log.sh                      | 49 +++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..eed1813a92 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -914,10 +914,12 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
 avoid showing the commits from two parallel development track mixed
 together.
 
-`--reverse`::
+`--reverse[=(after|before)]`::
 	Output the commits chosen to be shown (see 'Commit Limiting'
 	section above) in reverse order. Cannot be combined with
-	`--walk-reflogs`.
+	`--walk-reflogs`. `when` can either be `after` or `before`, if
+	omitted it defaults to `after`. If `before` is chosen,
+	`--reverse` will be applied before any commit limiting options.
 endif::git-shortlog[]
 
 ifndef::git-shortlog[]
diff --git a/revision.c b/revision.c
index 599b3a66c3..8338ea7448 100644
--- a/revision.c
+++ b/revision.c
@@ -2685,8 +2685,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		else
 			git_log_output_encoding = xstrdup("");
 		return argcount;
-	} else if (!strcmp(arg, "--reverse")) {
-		revs->reverse ^= 1;
+	} else if (starts_with(arg, "--reverse")) {
+		if (!skip_prefix(arg, "--reverse=", &optarg)) {
+			if (argc < 2) {
+				revs->reverse = 1;
+				return 1;
+			} else {
+				optarg = argv[1];
+			}
+		}
+
+		if (!strcmp(optarg, "after")) {
+			revs->reverse = 1;
+		} else if (!strcmp(optarg, "before")) {
+			revs->reverse = 2;
+		} else {
+			revs->reverse = 1;
+			return 1;
+		}
+
+		return optarg == argv[1] ? 2 : 1;
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;
@@ -4525,19 +4543,35 @@ struct commit *get_revision(struct rev_info *revs)
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
+		if (revs->reverse == 2)
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
+		if (revs->reverse == 2)
+			revs->max_count = max_count;
 	}
 
 	if (revs->reverse_output_stage) {
+		if (revs->reverse == 2 && revs->max_count == 0)
+			return NULL;
+
 		c = pop_commit(&revs->commits);
+		if (revs->reverse == 2)
+			revs->max_count--;
 		if (revs->track_linear)
 			revs->linear = !!(c && c->object.flags & TRACK_LINEAR);
 		return c;
diff --git a/revision.h b/revision.h
index 584f1338b5..5b23343f17 100644
--- a/revision.h
+++ b/revision.h
@@ -196,7 +196,12 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			show_decorations:1,
-			reverse:1,
+			/*
+			 * 0 no reverse
+			 * 1 after
+			 * 2 before
+			 */
+			reverse:2,
 			reverse_output_stage:1,
 			cherry_pick:1,
 			cherry_mark:1,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 05cee9e41b..21e9a61994 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1882,6 +1882,55 @@ test_expect_success 'log --graph with --name-status' '
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
+test_expect_success 'log --reverse after --oneline --max-count=2' '
+	test_when_finished git reset --hard HEAD~1 &&
+	touch to_remove &&
+	git add to_remove &&
+	git commit -m "to remove" &&
+	git log --reverse after --oneline --max-count=2 >actual &&
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
+test_expect_success 'log --reverse before --oneline --max-count=2' '
+	test_when_finished rm actual &&
+	git log --reverse before --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --reverse=before --oneline --max-count=2' '
+	test_when_finished rm actual &&
+	git log --reverse=before --oneline --max-count=2 >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-\EOF
 * reach
 |

base-commit: e8955061076952cc5eab0300424fc48b601fe12d
-- 
2.54.0.rc2.9.ge895506107

