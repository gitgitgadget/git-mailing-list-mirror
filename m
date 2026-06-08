Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E43DDDB2
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943876; cv=none; b=SWeRhDPKWaCXEfirePdx2EAz/D3Hfw1ydP7FByVNxbgwIiH7PGbIUyiMKzv/ojE11Uw8SbR8H87C7mQEm9ECWXV0u6+QrehuEaVKhmgj+xkXfM0LXftpmp5WFSOYZg/VitgWNcRuPa7+egyehFgo3Wplg9y0ROFp0twzJhl4DHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943876; c=relaxed/simple;
	bh=98YV/DKbY8VU7UKtJcJL1V/wJMRMC6hOx1nl78gwu9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZbqC6X2dPzgqOEpIWmIZ41dR+s9sc7VJmNWUFpAKTaTFQtSLwZh/buUoSWQdmRksPC/u2EWA+J9DEe8wjK9SAZgcTdSSkiccTkJT1VQsD1/NX9eXstS0giXdeDq0puaIMT6UOxn5F4fIh8BXltWuxBjPCCHfMCHzuvWMkT8NoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QoYY9BAf; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QoYY9BAf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780943872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvS/o5bAQ+a3ozL+PC3TIvbLkcCGGmoDO2Dt93myzsQ=;
	b=QoYY9BAfvu47IKxEgpQp6fhp1EXQ4Svm0Jj7RPoL6Dl7GId+I3KHOqraqC/xk/g8QnA3Nf
	hpOTwgigw48aKq+6aZC4iwsQakc3I+6WtxV77Pa7yipVlehJDjF1LAUaaM2wR/wOHeMgWJ
	SGYFg95oen3VUoNoNnpySFgjH4V9Pl0=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 08 Jun 2026 20:37:19 +0200
Subject: [PATCH 1/3] replay: refactor enum replay_mode into a bool
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-toon-git-replay-drop-merges-v1-1-e3ee71fce7b4@iotcl.com>
References: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
In-Reply-To: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In 2760ee4983 (replay: add --revert mode to reverse commit changes,
2026-03-26) the enum `replay_mode` was introduced. This has two possible
values:

 - The value `REPLAY_MODE_REVERT` is used when option `--revert` is
   passed to git-replay(1). When using this value the commits are
   possible in reverse order and the inverse of the changes are applied.

 - The value `REPLAY_MODE_PICK` is used when either option `--onto` or
   `--advance` is used. In both cases the commits are pocessed in normal
   order, and the changes are applied as-is.

Since there are only two possible values of this enum, simplify the code
by converting the enum into a bool. This avoid adding code paths that
check for invalid vaues of the enum, and shortens code where the value
is checked with a ternary operator.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 replay.c | 59 +++++++++++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/replay.c b/replay.c
index 4ef8abb607..1f8e5b083b 100644
--- a/replay.c
+++ b/replay.c
@@ -18,11 +18,6 @@
  */
 #define the_repository DO_NOT_USE_THE_REPOSITORY
 
-enum replay_mode {
-	REPLAY_MODE_PICK,
-	REPLAY_MODE_REVERT,
-};
-
 static const char *short_commit_name(struct repository *repo,
 				     struct commit *commit)
 {
@@ -81,7 +76,7 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    bool reverse)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
@@ -98,15 +93,13 @@ static struct commit *create_commit(struct repository *repo,
 
 	commit_list_insert(parent, &parents);
 	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
-	if (mode == REPLAY_MODE_REVERT) {
+	if (reverse) {
 		generate_revert_message(&msg, based_on, repo);
 		/* For revert, use current user as author (NULL = use default) */
-	} else if (mode == REPLAY_MODE_PICK) {
+	} else {
 		find_commit_subject(message, &orig_message);
 		strbuf_addstr(&msg, orig_message);
 		author = get_author(message);
-	} else {
-		BUG("unexpected replay mode %d", mode);
 	}
 	reset_ident_date();
 	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
@@ -269,7 +262,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
-					  enum replay_mode mode,
+					  bool reverse,
 					  enum replay_empty_commit_action empty)
 {
 	struct commit *base, *replayed_base;
@@ -287,7 +280,21 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
-	if (mode == REPLAY_MODE_PICK) {
+	if (reverse) {
+		/* Revert: swap base and pickme to reverse the diff */
+		const char *pickme_name = short_commit_name(repo, pickme);
+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
+		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
+		merge_opt->ancestor = pickme_name;
+
+		merge_incore_nonrecursive(merge_opt,
+					  pickme_tree,
+					  replayed_base_tree,
+					  base_tree,
+					  result);
+
+		free((char *)merge_opt->branch2);
+	} else {
 		/* Cherry-pick: normal order */
 		merge_opt->branch1 = short_commit_name(repo, replayed_base);
 		merge_opt->branch2 = short_commit_name(repo, pickme);
@@ -303,22 +310,6 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  result);
 
 		free((char *)merge_opt->ancestor);
-	} else if (mode == REPLAY_MODE_REVERT) {
-		/* Revert: swap base and pickme to reverse the diff */
-		const char *pickme_name = short_commit_name(repo, pickme);
-		merge_opt->branch1 = short_commit_name(repo, replayed_base);
-		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
-		merge_opt->ancestor = pickme_name;
-
-		merge_incore_nonrecursive(merge_opt,
-					  pickme_tree,
-					  replayed_base_tree,
-					  base_tree,
-					  result);
-
-		free((char *)merge_opt->branch2);
-	} else {
-		BUG("unexpected replay mode %d", mode);
 	}
 	merge_opt->ancestor = NULL;
 	merge_opt->branch2 = NULL;
@@ -341,7 +332,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	return create_commit(repo, result->tree, pickme, replayed_base, reverse);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -381,13 +372,13 @@ int replay_revisions(struct rev_info *revs,
 	char *revert;
 	const char *ref;
 	struct object_id old_oid;
-	enum replay_mode mode = REPLAY_MODE_PICK;
+	bool reverse;
 	int ret;
 
 	advance = xstrdup_or_null(opts->advance);
 	revert = xstrdup_or_null(opts->revert);
-	if (revert)
-		mode = REPLAY_MODE_REVERT;
+	reverse = !!revert;
+
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 			   &detached_head, &advance, &revert, &onto, &update_refs);
 
@@ -430,8 +421,8 @@ int replay_revisions(struct rev_info *revs,
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
-						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
-						  &merge_opt, &result, mode, opts->empty);
+						  reverse ? last_commit : onto,
+						  &merge_opt, &result, reverse, opts->empty);
 		if (!last_commit)
 			break;
 

-- 
2.53.0.1323.g189a785ab5

