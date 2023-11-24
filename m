Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPWsAFXP"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF9010F9
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b358f216dso11486875e9.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824279; x=1701429079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ha7zEa9uQ91vOj74UCgI8FCHP97gsxGbih7g4o63Lw=;
        b=jPWsAFXP56W6hQfkOhIoSbGRyLgVA8EQ9rp0qkrlIjCHx6oNZI6bazAVReuomH+96u
         vrVotIoHWfNmNa8JCdDlQysMhhMdRSzwRBnOYLr6XvYWJ9/K8mxDWO27lYGOx/gdIcgc
         RnznHErJwkP6qn3R5+EEVLzbOTZRDc4hb9AR/F28TZDcUPdbRM/0WN5s3VLGe8ebulF3
         iCawipXt3oVkHpAzxWVeGLrl3hLrC72VWHhWvHaEoktZ0O4lIRln2frWGrqhTaCfszOo
         e0jDYcYnMcA8IfMNE0eOVBXb8GwYjWbq92ogpUwz1YXrKDUi5g3WiVu2C950ZXECT3VY
         ZbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824279; x=1701429079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ha7zEa9uQ91vOj74UCgI8FCHP97gsxGbih7g4o63Lw=;
        b=TR6GHRjZhFJA6M4PRUjWv/fLF4n8d5o94vYHsCRRFm4Ss1ACKGa34fQp5nH0wAZdLH
         hNAc1ny3ICuJsJ+acupzFF6CzJNRxyVVnJasA4M7I+MHn+rLrOg2xOfWGzyhwm6V9c1k
         rA+nCWovL1iiAWevb75IO+TBDxd19f6OaBrV0LWijojwHY4LcgDmBe9dlbrpBswugLve
         NTV/2rnJxpmEtwsGewCSL10woLbyHXHHhpJ6zxRTy1BFFOqjf0X1b8ioxWta8WalNS10
         9MqBPfBcEHhIN6Q6gMntQKqT8u8A5eRjjxKLSLAGLqIJLrA1pZFg9loDNzeR4fLSga5t
         Tcag==
X-Gm-Message-State: AOJu0Yx3gm/gCpQjpBEQeSe+6wxAeXlmyMhp/HnChNP1X5nB5Q0IU+Ex
	e5vLL97JqK+cIJGe1uVntAO5kAcTKQ4=
X-Google-Smtp-Source: AGHT+IFTWfyMoOniJ0M72Ol4RwGT8vbYa6xm8vlJvOf19JcbBMnaRu/mYNK7z/9zR/WHQTqh8DSOdg==
X-Received: by 2002:a05:600c:450b:b0:409:79cb:81a3 with SMTP id t11-20020a05600c450b00b0040979cb81a3mr2116014wmo.30.1700824279214;
        Fri, 24 Nov 2023 03:11:19 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:18 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 12/14] replay: add --advance or 'cherry-pick' mode
Date: Fri, 24 Nov 2023 12:10:41 +0100
Message-ID: <20231124111044.3426007-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
 <20231124111044.3426007-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

There is already a 'rebase' mode with `--onto`. Let's add an 'advance' or
'cherry-pick' mode with `--advance`. This new mode will make the target
branch advance as we replay commits onto it.

The replayed commits should have a single tip, so that it's clear where
the target branch should be advanced. If they have more than one tip,
this new mode will error out.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt |  41 ++++++--
 builtin/replay.c             | 185 +++++++++++++++++++++++++++++++++--
 t/t3650-replay-basics.sh     |  34 +++++++
 3 files changed, 243 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index f7b232caa2..c4c64f955a 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' --onto <newbase> <revision-range>...
+(EXPERIMENTAL!) 'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
 
 DESCRIPTION
 -----------
@@ -29,14 +29,25 @@ OPTIONS
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-The update-ref command(s) in the output will update the branch(es) in
-the revision range to point at the new commits, similar to the way how
-`git rebase --update-refs` updates multiple branches in the affected
-range.
+When `--onto` is specified, the update-ref command(s) in the output will
+update the branch(es) in the revision range to point at the new
+commits, similar to the way how `git rebase --update-refs` updates
+multiple branches in the affected range.
+
+--advance <branch>::
+	Starting point at which to create the new commits; must be a
+	branch name.
++
+When `--advance` is specified, the update-ref command(s) in the output
+will update the branch passed as an argument to `--advance` to point at
+the new commits (in other words, this mimics a cherry-pick operation).
 
 <revision-range>::
-	Range of commits to replay; see "Specifying Ranges" in
-	linkgit:git-rev-parse and the "Commit Limiting" options below.
+	Range of commits to replay. More than one <revision-range> can
+	be passed, but in `--advance <branch>` mode, they should have
+	a single tip, so that it's clear where <branch> should point
+	to. See "Specifying Ranges" in linkgit:git-rev-parse and the
+	"Commit Limiting" options below.
 
 include::rev-list-options.txt[]
 
@@ -51,7 +62,9 @@ input to `git update-ref --stdin`.  It is of the form:
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
 where the number of refs updated depends on the arguments passed and
-the shape of the history being replayed.
+the shape of the history being replayed.  When using `--advance`, the
+number of refs updated is always one, but for `--onto`, it can be one
+or more (rebasing multiple branches simultaneously is supported).
 
 EXIT STATUS
 -----------
@@ -71,6 +84,18 @@ $ git replay --onto target origin/main..mybranch
 update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
 ------------
 
+To cherry-pick the commits from mybranch onto target:
+
+------------
+$ git replay --advance target origin/main..mybranch
+update refs/heads/target ${NEW_target_HASH} ${OLD_target_HASH}
+------------
+
+Note that the first two examples replay the exact same commits and on
+top of the exact same new base, they only differ in that the first
+provides instructions to make mybranch point at the new commits and
+the second provides instructions to make target point at them.
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index 3d5e00147b..f26806d7e2 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
+#include "strmap.h"
 #include <oidset.h>
 #include <tree.h>
 
@@ -82,6 +83,146 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
+struct ref_info {
+	struct commit *onto;
+	struct strset positive_refs;
+	struct strset negative_refs;
+	int positive_refexprs;
+	int negative_refexprs;
+};
+
+static void get_ref_information(struct rev_cmdline_info *cmd_info,
+				struct ref_info *ref_info)
+{
+	int i;
+
+	ref_info->onto = NULL;
+	strset_init(&ref_info->positive_refs);
+	strset_init(&ref_info->negative_refs);
+	ref_info->positive_refexprs = 0;
+	ref_info->negative_refexprs = 0;
+
+	/*
+	 * When the user specifies e.g.
+	 *   git replay origin/main..mybranch
+	 *   git replay ^origin/next mybranch1 mybranch2
+	 * we want to be able to determine where to replay the commits.  In
+	 * these examples, the branches are probably based on an old version
+	 * of either origin/main or origin/next, so we want to replay on the
+	 * newest version of that branch.  In contrast we would want to error
+	 * out if they ran
+	 *   git replay ^origin/master ^origin/next mybranch
+	 *   git replay mybranch~2..mybranch
+	 * the first of those because there's no unique base to choose, and
+	 * the second because they'd likely just be replaying commits on top
+	 * of the same commit and not making any difference.
+	 */
+	for (i = 0; i < cmd_info->nr; i++) {
+		struct rev_cmdline_entry *e = cmd_info->rev + i;
+		struct object_id oid;
+		const char *refexpr = e->name;
+		char *fullname = NULL;
+		int can_uniquely_dwim = 1;
+
+		if (*refexpr == '^')
+			refexpr++;
+		if (repo_dwim_ref(the_repository, refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
+			can_uniquely_dwim = 0;
+
+		if (e->flags & BOTTOM) {
+			if (can_uniquely_dwim)
+				strset_add(&ref_info->negative_refs, fullname);
+			if (!ref_info->negative_refexprs)
+				ref_info->onto = lookup_commit_reference_gently(the_repository,
+										&e->item->oid, 1);
+			ref_info->negative_refexprs++;
+		} else {
+			if (can_uniquely_dwim)
+				strset_add(&ref_info->positive_refs, fullname);
+			ref_info->positive_refexprs++;
+		}
+
+		free(fullname);
+	}
+}
+
+static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
+				  const char *onto_name,
+				  const char **advance_name,
+				  struct commit **onto,
+				  struct strset **update_refs)
+{
+	struct ref_info rinfo;
+
+	get_ref_information(cmd_info, &rinfo);
+	if (!rinfo.positive_refexprs)
+		die(_("need some commits to replay"));
+	if (onto_name && *advance_name)
+		die(_("--onto and --advance are incompatible"));
+	else if (onto_name) {
+		*onto = peel_committish(onto_name);
+		if (rinfo.positive_refexprs <
+		    strset_get_size(&rinfo.positive_refs))
+			die(_("all positive revisions given must be references"));
+	} else if (*advance_name) {
+		struct object_id oid;
+		char *fullname = NULL;
+
+		*onto = peel_committish(*advance_name);
+		if (repo_dwim_ref(the_repository, *advance_name, strlen(*advance_name),
+			     &oid, &fullname, 0) == 1) {
+			*advance_name = fullname;
+		} else {
+			die(_("argument to --advance must be a reference"));
+		}
+		if (rinfo.positive_refexprs > 1)
+			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
+	} else {
+		int positive_refs_complete = (
+			rinfo.positive_refexprs ==
+			strset_get_size(&rinfo.positive_refs));
+		int negative_refs_complete = (
+			rinfo.negative_refexprs ==
+			strset_get_size(&rinfo.negative_refs));
+		/*
+		 * We need either positive_refs_complete or
+		 * negative_refs_complete, but not both.
+		 */
+		if (rinfo.negative_refexprs > 0 &&
+		    positive_refs_complete == negative_refs_complete)
+			die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
+		if (negative_refs_complete) {
+			struct hashmap_iter iter;
+			struct strmap_entry *entry;
+
+			if (rinfo.negative_refexprs == 0)
+				die(_("all positive revisions given must be references"));
+			else if (rinfo.negative_refexprs > 1)
+				die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
+			else if (rinfo.positive_refexprs > 1)
+				die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));
+
+			/* Only one entry, but we have to loop to get it */
+			strset_for_each_entry(&rinfo.negative_refs,
+					      &iter, entry) {
+				*advance_name = entry->key;
+			}
+		} else { /* positive_refs_complete */
+			if (rinfo.negative_refexprs > 1)
+				die(_("cannot implicitly determine correct base for --onto"));
+			if (rinfo.negative_refexprs == 1)
+				*onto = rinfo.onto;
+		}
+	}
+	if (!*advance_name) {
+		*update_refs = xcalloc(1, sizeof(**update_refs));
+		**update_refs = rinfo.positive_refs;
+		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	}
+	strset_clear(&rinfo.negative_refs);
+	strset_clear(&rinfo.positive_refs);
+}
+
 static struct commit *pick_regular_commit(struct commit *pickme,
 					  struct commit *last_commit,
 					  struct merge_options *merge_opt,
@@ -114,20 +255,26 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
-	struct commit *onto;
+	const char *advance_name = NULL;
+	struct commit *onto = NULL;
 	const char *onto_name = NULL;
-	struct commit *last_commit = NULL;
+
 	struct rev_info revs;
+	struct commit *last_commit = NULL;
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
+	struct strset *update_refs = NULL;
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("(EXPERIMENTAL!) git replay --onto <newbase> <revision-range>..."),
+		N_("(EXPERIMENTAL!) git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
+		OPT_STRING(0, "advance", &advance_name,
+			   N_("branch"),
+			   N_("make replay advance given branch")),
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
@@ -137,13 +284,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	if (!onto_name) {
-		error(_("option --onto is mandatory"));
+	if (!onto_name && !advance_name) {
+		error(_("option --onto or --advance is mandatory"));
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	onto = peel_committish(onto_name);
-
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	/*
@@ -195,6 +340,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		revs.simplify_history = 0;
 	}
 
+	determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
+			      &onto, &update_refs);
+
+	if (!onto) /* FIXME: Should handle replaying down to root commit */
+		die("Replaying down to root commit is not supported yet!");
+
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
@@ -203,6 +354,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
+
 	result.tree = repo_get_commit_tree(the_repository, onto);
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
@@ -217,12 +369,15 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (!last_commit)
 			break;
 
+		/* Update any necessary branches */
+		if (advance_name)
+			continue;
 		decoration = get_name_decoration(&commit->object);
 		if (!decoration)
 			continue;
-
 		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL) {
+			if (decoration->type == DECORATION_REF_LOCAL &&
+			    strset_contains(update_refs, decoration->name)) {
 				printf("update %s %s %s\n",
 				       decoration->name,
 				       oid_to_hex(&last_commit->object.oid),
@@ -232,10 +387,22 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	/* In --advance mode, advance the target ref */
+	if (result.clean == 1 && advance_name) {
+		printf("update %s %s %s\n",
+		       advance_name,
+		       oid_to_hex(&last_commit->object.oid),
+		       oid_to_hex(&onto->object.oid));
+	}
+
 	merge_finalize(&merge_opt, &result);
 	ret = result.clean;
 
 cleanup:
+	if (update_refs) {
+		strset_clear(update_refs);
+		free(update_refs);
+	}
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index a1da4f9ef9..68a87e7803 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -80,4 +80,38 @@ test_expect_success 'using replay on bare repo to rebase with a conflict' '
 	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
 '
 
+test_expect_success 'using replay to perform basic cherry-pick' '
+	# The differences between this test and previous ones are:
+	#   --advance vs --onto
+	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
+	# 4th field of result is hash for main instead of hash for topic2
+
+	git replay --advance main topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/main " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse main >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
+	git -C bare replay --advance main topic1..topic2 >result-bare &&
+	test_cmp expect result-bare
+'
+
+test_expect_success 'replay on bare repo fails with both --advance and --onto' '
+	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
+'
+
+test_expect_success 'replay fails when both --advance and --onto are omitted' '
+	test_must_fail git replay topic1..topic2 >result
+'
+
 test_done
-- 
2.43.0.14.g93e034faee

