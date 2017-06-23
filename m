Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817262082E
	for <e@80x24.org>; Fri, 23 Jun 2017 19:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbdFWTNT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:13:19 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36579 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdFWTNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:13:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id u62so24714024pgb.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owwUE8A/lXsHlVsbkeBW/GWjVcO/RSwngQKgH1hVNvk=;
        b=TNOkMdUPKQNLq/Xlqy4WC6RXxcKLIEPedVE1XYnSRIB4RWGSbDo/ko3/tu7X2K35Yo
         BK10DFPGoLec556Q1JIiS20EDBUwFoDP87euC/xuqlvJreHHtVGxERwLQ2XTpLv6XmBJ
         5EsVHO+0w35fFurMqq7rhMZHH5E2LDk0Vr/jWcMXEqQrhKW9ZntWJFTeSLybJjrnp6L+
         jIG4jg0Yf0JQ0SjPu7KdmJ6htZRvV/5DfsqR0i0D+tklR3Iz30zM7CeAOnQS4uIVJOlV
         Xs90ZfiN5hHhOwAG40cKBSubU2BiyJbFRwalTHUySYMas08TSV+ZJC7pYE9vj/ZXYuv3
         mswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owwUE8A/lXsHlVsbkeBW/GWjVcO/RSwngQKgH1hVNvk=;
        b=EqA8Uc8BL+w5JW6X1D340cXb6mPhF97yjxpmeOxM55Ma8uVTBKN4gVemex9eeVXqQ/
         SiA4n27+gHGCMjyi7Pu3+F/FXemTNccZtVx03A838acirYHB/tfRtSatiC5Ko5hcuydb
         NCjnnHjWQ2V5mGEaJoyyoMCuFGmyVjlLsbVABq39VvCEBncX2Fg1xchfq++bM3qM1cxO
         Pk45YFGmR9OftehgXbSOWQkKs7xETosavKady5WC67Lp3vrJ/h7J45IpI3wHgN79beJF
         A4PWasqJJACYBrwcs90ek2YHiXo08LmqCf2C2fuejDZ/5QLeVGd02khJfssVFmXJgGxH
         9qdQ==
X-Gm-Message-State: AKS2vOwtwP9AKkDekvRHwi37fXJI3xT9ZNA0tfXBdu7AMJ+tDhsFNYDH
        bE/9hFSvquPE4TnU
X-Received: by 10.98.214.195 with SMTP id a64mr9779292pfl.40.1498245195534;
        Fri, 23 Jun 2017 12:13:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1530:f035:a8be:c887])
        by smtp.gmail.com with ESMTPSA id g10sm12179606pfc.38.2017.06.23.12.13.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:13:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        philipoakley@iee.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] pull: optionally rebase submodules (remote submodule changes only)
Date:   Fri, 23 Jun 2017 12:13:02 -0700
Message-Id: <20170623191302.16053-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623191302.16053-1-sbeller@google.com>
References: <20170623191302.16053-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach pull to optionally update submodules when '--recurse-submodules'
is provided.  This will teach pull to run 'submodule update --rebase'
when the '--recurse-submodules' and '--rebase' flags are given under
specific circumstances.

On a rebase workflow:
=====================

1. Both sides change the submodule
 ------------------------------
Let's assume the following history in a submodule:

  H---I---J---K---L local branch
       \
        M---N---O---P remote branch

and the following in the superproject (recorded submodule in parens):

  A(H)---B(I)---F(K)---G(L)  local branch
          \
           C(N)---D(N)---E(P) remote branch

In an ideal world this would rebase the submodule and rewrite
the submodule pointers that the superproject points at such that
the superproject looks like

  A(H)---B(I)              F(K')---G(L')  rebased branch
           \                /
           C(N)---D(N)---E(P) remote branch

and the submodule as:

        J---K---L (old dangeling tip)
       /
  H---I               J'---K'---L' rebased branch
       \             /
        M---N---O---P remote branch

And if a conflict arises in the submodule the superproject rebase
would stop at that commit at which the submodule conflict occurs.

Currently a "pull --rebase" in the superproject produces
a merge conflict as the submodule pointer changes are
conflicting and cannot be resolved.

2. Local submodule changes only
 -----------------------
Assuming histories as above, except that the remote branch
would not contain submodule changes, then a result as

  A(H)---B(I)               F(K)---G(L)  rebased branch
           \                /
           C(I)---D(I)---E(I) remote branch

is desire-able. This is what currently happens in rebase.

If the recursive flag is given, the ideal git would
produce a superproject as:

  A(H)---B(I)              F(K')---G(L')  rebased branch (incl. sub rebase!)
           \                /
           C(I)---D(I)---E(I) remote branch

and the submodule as:

        J---K---L (old dangeling tip)
       /
  H---I               J'---K'---L' locally rebased branch
       \             /
        M---N---O---P advanced branch

This patch doesn't address this issue, however
a test is added that this fails up front.

3. Remote submodule changes only
 ----------------------
Assuming histories as in (1) except that the local superproject branch
would not have touched the submodule the rebase already works out in the
superproject with no conflicts:

  A(H)---B(I)               F(P)---G(P)  rebased branch (no sub changes)
           \                 /
           C(N)---D(N)---E(P) remote branch

The recurse flag as presented in this patch would additionally
update the submodule as:

  H---I              J'---K'---L' rebased branch
       \            /
        M---N---O---P remote branch

As neither J, K, L nor J', K', L' are referred to from the superproject,
no rewriting of the superproject commits is required.

Conclusion for 'pull --rebase --recursive'
 -----------------------------------------
If there are no local superproject changes it is sufficient to call
"submodule update --rebase" as this produces the desired results. In case
of conflicts, the behavior is the same as in 'submodule update --recursive'
which is assumed to be sane.

This patch implements (3) only.

On a merge workflow:
====================

We'll start off with the same underlying DAG as in (1) in the rebase
workflow. So in an ideal world a 'pull --merge --recursive' would
produce this:

  H---I---J---K---L----X
       \              /
        M---N---O---P

with X as the new merge-commit in the submodule and the superproject
as:

  A(H)---B(I)---F(K)---G(L)---Y(X)
          \                  /
           C(N)---D(N)---E(P)

However modifying the submodules on the fly is not supported in git-merge
such that Y(X) is not easy to produce in a single patch. In fact git-merge
doesn't know about submodules at all.

However when at least one side does not contain commits touching the
submodule at all, then we do not need to perform the merge for the
submodule but a fast-forward can be done via checking out either L or P
in the submodule.  This strategy is implemented in 68d03e4a6e (Implement
automatic fast-forward merge for submodules, 2010-07-07) already, so
to align with the rebase behavior we need to also update the worktree
of the submodule.

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-pull.txt | 12 ++++----
 builtin/pull.c             | 73 +++++++++++++++++++++++++++++++++++++++-------
 submodule.c                | 26 +++++++++++++++++
 submodule.h                |  4 +++
 t/t5572-pull-submodule.sh  | 58 ++++++++++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e414185f5a..b201af6f19 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -86,12 +86,12 @@ OPTIONS
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
 	This option controls if new commits of all populated submodules should
-	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
-	That might be necessary to get the data needed for merging submodule
-	commits, a feature Git learned in 1.7.3. Notice that the result of a
-	merge will not be checked out in the submodule, "git submodule update"
-	has to be called afterwards to bring the work tree up to date with the
-	merge result.
+	be fetched and updated, too (see linkgit:git-config[1] and
+	linkgit:gitmodules[5]).
++
+If the checkout is done via rebase, local submodule commits are rebased as well.
++
+If the update is done via merge, the submodule conflicts are resolved and checked out.
 
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index 69417e4f36..7048fdf005 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -15,6 +15,8 @@
 #include "dir.h"
 #include "refs.h"
 #include "revision.h"
+#include "submodule.h"
+#include "submodule-config.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "wt-status.h"
@@ -77,6 +79,7 @@ static const char * const pull_usage[] = {
 /* Shared options */
 static int opt_verbosity;
 static char *opt_progress;
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
@@ -101,7 +104,6 @@ static char *opt_upload_pack;
 static int opt_force;
 static char *opt_tags;
 static char *opt_prune;
-static char *opt_recurse_submodules;
 static char *max_children;
 static int opt_dry_run;
 static char *opt_keep;
@@ -116,6 +118,10 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "progress", &opt_progress, NULL,
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
+	{ OPTION_CALLBACK, 0, "recurse-submodules",
+		   &recurse_submodules, N_("on-demand"),
+		   N_("control for recursive fetching of submodules"),
+		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
 
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
@@ -187,10 +193,6 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU('p', "prune", &opt_prune, NULL,
 		N_("prune remote-tracking branches no longer on remote"),
 		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "recurse-submodules", &opt_recurse_submodules,
-		N_("on-demand"),
-		N_("control recursive fetching of submodules"),
-		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
 		N_("number of submodules pulled in parallel"),
 		PARSE_OPT_OPTARG),
@@ -483,8 +485,20 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_tags);
 	if (opt_prune)
 		argv_array_push(&args, opt_prune);
-	if (opt_recurse_submodules)
-		argv_array_push(&args, opt_recurse_submodules);
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+		switch (recurse_submodules) {
+		case RECURSE_SUBMODULES_ON:
+			argv_array_push(&args, "--recurse-submodules=on");
+			break;
+		case RECURSE_SUBMODULES_OFF:
+			argv_array_push(&args, "--recurse-submodules=no");
+			break;
+		case RECURSE_SUBMODULES_ON_DEMAND:
+			argv_array_push(&args, "--recurse-submodules=on-demand");
+			break;
+		default:
+			BUG("submodule recursion option not understood");
+		}
 	if (max_children)
 		argv_array_push(&args, max_children);
 	if (opt_dry_run)
@@ -531,6 +545,30 @@ static int pull_into_void(const struct object_id *merge_head,
 	return 0;
 }
 
+static int rebase_submodules(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	argv_array_pushl(&cp.args, "submodule", "update",
+				   "--recursive", "--rebase", NULL);
+
+	return run_command(&cp);
+}
+
+static int update_submodules(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	argv_array_pushl(&cp.args, "submodule", "update",
+				   "--recursive", "--checkout", NULL);
+
+	return run_command(&cp);
+}
+
 /**
  * Runs git-merge, returning its exit status.
  */
@@ -862,6 +900,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		die(_("Cannot rebase onto multiple branches."));
 
 	if (opt_rebase) {
+		int ret = 0;
+		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
+		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
+		    submodule_touches_in_range(&rebase_fork_point, &curr_head))
+			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
 			struct commit *merge_head, *head;
@@ -872,11 +915,21 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			if (is_descendant_of(merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
-				return run_merge();
+				ret = run_merge();
 			}
 		}
-		return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+
+		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
+			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
+			ret = rebase_submodules();
+
+		return ret;
 	} else {
-		return run_merge();
+		int ret = run_merge();
+		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
+			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
+			ret = update_submodules();
+		return ret;
 	}
 }
diff --git a/submodule.c b/submodule.c
index 1b8a3b575d..6e2e35a7fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1126,6 +1126,32 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
+int submodule_touches_in_range(struct object_id *excl_oid,
+			       struct object_id *incl_oid)
+{
+	struct string_list subs = STRING_LIST_INIT_DUP;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+
+	gitmodules_config();
+	/* No need to check if there are no submodules configured */
+	if (!submodule_from_path(NULL, NULL))
+		return 0;
+
+	argv_array_push(&args, "--"); /* args[0] program name */
+	argv_array_push(&args, oid_to_hex(incl_oid));
+	argv_array_push(&args, "--not");
+	argv_array_push(&args, oid_to_hex(excl_oid));
+
+	collect_changed_submodules(&subs, &args);
+	ret = subs.nr;
+
+	argv_array_clear(&args);
+
+	free_submodules_oids(&subs);
+	return ret;
+}
+
 struct submodule_parallel_fetch {
 	int count;
 	struct argv_array args;
diff --git a/submodule.h b/submodule.h
index cbe5c1726f..ab1f01b3ce 100644
--- a/submodule.h
+++ b/submodule.h
@@ -97,6 +97,10 @@ extern int merge_submodule(struct object_id *result, const char *path,
 			   const struct object_id *base,
 			   const struct object_id *a,
 			   const struct object_id *b, int search);
+
+/* Checks if there are submodule changes in a..b. */
+extern int submodule_touches_in_range(struct object_id *a,
+				      struct object_id *b);
 extern int find_unpushed_submodules(struct oid_array *commits,
 				    const char *remotes_name,
 				    struct string_list *needs_pushing);
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index accfa5cc0c..077eb07e11 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -42,4 +42,62 @@ KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "git_pull_noff"
 
+test_expect_success 'pull --recurse-submodule setup' '
+	test_create_repo child &&
+	test_commit -C child bar &&
+
+	test_create_repo parent &&
+	test_commit -C child foo &&
+
+	git -C parent submodule add ../child sub &&
+	git -C parent commit -m "add submodule" &&
+
+	git clone --recurse-submodules parent super
+'
+
+test_expect_success 'recursive pull updates working tree' '
+	test_commit -C child merge_strategy &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super pull --no-rebase --recurse-submodules &&
+	test_path_is_file super/sub/merge_strategy.t
+'
+
+test_expect_success 'recursive rebasing pull' '
+	# change upstream
+	test_commit -C child rebase_strategy &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	# also have local commits
+	test_commit -C super/sub local_stuff &&
+
+	git -C super pull --rebase --recurse-submodules &&
+	test_path_is_file super/sub/rebase_strategy.t &&
+	test_path_is_file super/sub/local_stuff.t
+'
+
+test_expect_success 'pull rebase recursing fails with conflicts' '
+
+	# local changes in submodule recorded in superproject:
+	test_commit -C super/sub local_stuff_2 &&
+	git -C super add sub &&
+	git -C super commit -m "local update submodule" &&
+
+	# and in the remote as well:
+	test_commit -C child important_upstream_work &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "remote update submodule" &&
+
+	# Unfortunately we fail here, despite no conflict in the
+	# submodule itself, but the merge strategy in submodules
+	# does not support rebase:
+	test_must_fail git -C super pull --rebase --recurse-submodules 2>err &&
+	test_i18ngrep "locally recorded submodule modifications" err
+'
+
 test_done
-- 
2.12.2.575.gb14f27f917

