Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXy2W/dh"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA96D67
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c87acba73bso23530221fa.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824276; x=1701429076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wsrjDMcSnAcyviOTBQQYyl4K0j2WZ4jTvG4W9U3ZQ4=;
        b=jXy2W/dhv4ya9Y0kZhrRaunKHRYa7XJtvisXI3RQ0rrC+2HjfImiCYy9BKfRFAL/26
         g4k374n7O2qSPwiQvonNlDL/XpQ2hN88OemFB1ZXIuS91un5CS6o+1od9QyK5dPStapd
         sCLjZ+Do19cKSwKnvOeCgFOBzIJ/pZGehhVE7eG1Zj4GsMIbIcZAEfdwLr6JjBqjUVle
         62yKt1OibjgJHRivXSQB6FOjNddlb3HkJjJ/L9bdNtcFpzIVYbX+T8JuRgQl1ZertxUJ
         QiclvqVai80mwuM/5hjteF8QNpuEKtyC8l2Xk0cMql0brRgEXZQphQtvYrM+wEg3v8Aj
         NjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824276; x=1701429076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wsrjDMcSnAcyviOTBQQYyl4K0j2WZ4jTvG4W9U3ZQ4=;
        b=eKinMdGYKiXCXuxSAJeDcXIxjgNCABDmAR7zi8rYoJPwGrjB3TShVa13AAZP9t7bu8
         s4iWlVK7CRbIKC2hSGzZE8ahEDlS/qUyVlhS5Ic+OjRjzQVCSn4pX5ymu76kdiy03AEW
         Rg4AEeO0Zm3wh/+RehQxFeWfih4UINVADiJG6bfSisBa8QxR+jTqKjHzvlYN+Rib7JMK
         AL60HIDcez032icKgo1qGaP87SR4CstH+is5TvXDUMtkPDeK/v9FKUtd/33wEC8ZRsrI
         KYgHyaOICpAFMsDbcHVgDBJi4afXLxrJdACi6t3KuycFM0koU9X+YHeTcj6xyI5hsMIA
         mMgQ==
X-Gm-Message-State: AOJu0YyQJdrJrx9euWMzuAYvOshEUeRAVAdWVILTE7r6pngDACfEenfd
	bBBKwLM5MLyZ8YSlbLhYHRcdzKhtATg=
X-Google-Smtp-Source: AGHT+IEftGIp+C+09NM7vTuTg1GAXsnGv008zyZl1JAD4UpIzw21Wm9Li7l4NcjbVwYyXzgjtA+/Cg==
X-Received: by 2002:a2e:938b:0:b0:2c8:732e:28d7 with SMTP id g11-20020a2e938b000000b002c8732e28d7mr1968818ljh.23.1700824276157;
        Fri, 24 Nov 2023 03:11:16 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:14 -0800 (PST)
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
Subject: [PATCH v8 10/14] replay: make it a minimal server side command
Date: Fri, 24 Nov 2023 12:10:39 +0100
Message-ID: <20231124111044.3426007-11-christian.couder@gmail.com>
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

We want this command to be a minimal command that just does server side
picking of commits, displaying the results on stdout for higher level
scripts to consume.

So let's simplify it:
  * remove the worktree and index reading/writing,
  * remove the ref (and reflog) updating,
  * remove the assumptions tying us to HEAD, since (a) this is not a
    rebase and (b) we want to be able to pick commits in a bare repo,
    i.e. to/from branches that are not checked out and not the main
    branch,
  * remove unneeded includes,
  * handle rebasing multiple branches by printing on stdout the update
    ref commands that should be performed.

The output can be piped into `git update-ref --stdin` for the ref
updates to happen.

In the future to make it easier for users to use this command
directly maybe an option can be added to automatically pipe its output
into `git update-ref`.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt             |  5 +-
 builtin/replay.c                         | 78 ++++++++----------------
 t/t3650-replay-basics.sh                 | 19 +++++-
 t/t6429-merge-sequence-rename-caching.sh | 39 +++++++-----
 4 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 2ca7ca5fd8..267282d92a 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -15,7 +15,10 @@ DESCRIPTION
 -----------
 
 Takes a range of commits, specified by <oldbase> and <branch>, and
-replays them onto a new location (see `--onto` option below).
+replays them onto a new location (see `--onto` option below). Leaves
+the working tree and the index untouched, and updates no references.
+The output of this command is meant to be used as input to
+`git update-ref --stdin`, which would update the relevant branches.
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
diff --git a/builtin/replay.c b/builtin/replay.c
index bdec2f2b97..bfccbbbfea 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -6,11 +6,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
-#include "cache-tree.h"
-#include "commit.h"
 #include "environment.h"
-#include "gettext.h"
-#include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
@@ -18,8 +14,6 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
-#include "sequencer.h"
-#include "setup.h"
 #include "strvec.h"
 #include <oidset.h>
 #include <tree.h>
@@ -102,6 +96,7 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	pickme_tree = repo_get_commit_tree(the_repository, pickme);
 	base_tree = repo_get_commit_tree(the_repository, base);
 
+	merge_opt->branch1 = short_commit_name(last_commit);
 	merge_opt->branch2 = short_commit_name(pickme);
 	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
@@ -122,15 +117,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
 	const char *onto_name = NULL;
-	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct lock_file lock = LOCK_INIT;
+	struct commit *last_commit = NULL;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *head_tree;
 	struct merge_result result;
-	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
@@ -161,10 +153,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-	if (repo_read_index(the_repository) < 0)
-		BUG("Could not read index");
-
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
@@ -227,58 +215,44 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
-	merge_opt.branch1 = "HEAD";
-	head_tree = repo_get_commit_tree(the_repository, onto);
-	result.tree = head_tree;
+	result.tree = repo_get_commit_tree(the_repository, onto);
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *pick;
+		const struct name_decoration *decoration;
 
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		pick = pick_regular_commit(commit, last_commit, &merge_opt, &result);
-		if (!pick)
+		last_commit = pick_regular_commit(commit, last_commit, &merge_opt, &result);
+		if (!last_commit)
 			break;
-		last_commit = pick;
-		last_picked_commit = commit;
+
+		decoration = get_name_decoration(&commit->object);
+		if (!decoration)
+			continue;
+
+		while (decoration) {
+			if (decoration->type == DECORATION_REF_LOCAL) {
+				printf("update %s %s %s\n",
+				       decoration->name,
+				       oid_to_hex(&last_commit->object.oid),
+				       oid_to_hex(&commit->object.oid));
+			}
+			decoration = decoration->next;
+		}
 	}
 
 	merge_finalize(&merge_opt, &result);
+	ret = result.clean;
 
-	if (result.clean < 0)
-		exit(128);
-
-	if (result.clean) {
-		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
-			    oid_to_hex(&last_picked_commit->object.oid),
-			    oid_to_hex(&last_commit->object.oid));
-		if (update_ref(reflog_msg.buf, branch_name.buf,
-			       &last_commit->object.oid,
-			       &last_picked_commit->object.oid,
-			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[2]);
-			die("Failed to update %s", argv[2]);
-		}
-		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
-			die(_("unable to update HEAD"));
-	} else {
-		strbuf_addf(&reflog_msg, "rebase progress up to %s",
-			    oid_to_hex(&last_picked_commit->object.oid));
-		if (update_ref(reflog_msg.buf, "HEAD",
-			       &last_commit->object.oid,
-			       &onto->object.oid,
-			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[2]);
-			die("Failed to update %s", argv[2]);
-		}
-	}
-	ret = (result.clean == 0);
 cleanup:
-	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_name);
 	release_revisions(&revs);
-	return ret;
+
+	/* Return */
+	if (ret < 0)
+		exit(128);
+	return ret ? 0 : 1;
 }
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index b5b9f9ade2..3567c98362 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -47,12 +47,29 @@ test_expect_success 'setup' '
 	test_commit C.conflict C.t conflict
 '
 
+test_expect_success 'setup bare' '
+	git clone --bare . bare
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1 topic2 >result &&
 
+	test_line_count = 1 result &&
+
 	git log --format=%s $(cut -f 3 -d " " result) >actual &&
 	test_write_lines E D M L B A >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse topic2 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
+	git -C bare replay --onto main topic1 topic2 >result-bare &&
+	test_cmp expect result-bare
 '
 
 test_done
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 7670b72008..099aefeffc 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,8 +71,9 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		git ls-files >tracked-files &&
 		test_line_count = 2 tracked-files &&
@@ -140,7 +141,9 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls
@@ -198,8 +201,9 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 2 tracked &&
@@ -275,8 +279,9 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 4 tracked &&
@@ -451,8 +456,9 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
@@ -517,8 +523,9 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 3 calls &&
@@ -619,8 +626,9 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls &&
@@ -677,8 +685,9 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic &&
-		git reset --hard topic &&
+		git replay --onto HEAD upstream~1 topic >out &&
+		git update-ref --stdin <out &&
+		git checkout topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
-- 
2.43.0.14.g93e034faee

