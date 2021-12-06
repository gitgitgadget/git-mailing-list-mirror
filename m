Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9CAC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356157AbhLFV7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356152AbhLFV73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:59:29 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA893C0613F8
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 13:56:00 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so754905pjl.5
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zUvBKjya9iTiiteRIcCh8Pb1jwLNIj4Q0fGNsZ2Ii18=;
        b=VC0cXQoshRy+/y/M8NHHBwkYQNdFkqm7nwTonXHGf0zkmGT+aK4pJIo/jwKvojAMg0
         1PD20cE9sZpp9wUNXbwvByEmT+GB4o+8R63S50y0VLy3n/OmPpIa3o/U78TfDhGS+fXK
         OxK8B1879kZlSY4KCL+3WSdYokSiCuTyk1PyQUX2LqfVEUM6hu1vOHQ8XTcS9E8FuxNc
         r8IW8NdpbNRm3CEn1q16m98iL8hlAVyYLUhn2B5PL2F1V572gnvqVKp7cOdwNJe2eSoR
         3Crbk54IFf95CkeWJqLWjQAN08kP037DMgm9KYzWxn16QssTGETFOs66yldNQYg5TqnW
         aKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zUvBKjya9iTiiteRIcCh8Pb1jwLNIj4Q0fGNsZ2Ii18=;
        b=qVEyhd5KAQ7P0Dz0eK6tUZVABdTkLuOjT7wrL8J0KVf4jhF0HsSUo2jSrxYVmcd2bK
         UBoflJ/Mm+0TszVGmTqG3KRxhzCIXQKF9VC8gAgv2bRHFZfoAkNkCuROWYqcWhPvYW9X
         BiWOfMOenUba+jvHqdcv2YLE5VmiURmhBOfE4ryU25jXvsqGxJWo0wjxrJAzGJCn911j
         0+A17/fwauQyeX50RuKxfQ7QLkxwMgehRDZ8BDOWkOs+FgroP4fkwx5WfLDXqLU0szrR
         fVJnKQE/Kt+s4OglrZn4pbmUIFNIf1umbLrwFi6nZ6rzIVnGZYHtBgpiThuWQtrQHORh
         LBlg==
X-Gm-Message-State: AOAM530JoGVkyH5RDIzFFs22No1HEvxeCqMJKRvhRWZrtpTNerrrLCIp
        dBeZ5/iynJHMdp+5+RAagPyMeBRHg/5RasGCk/Xqk1fMPyzo9V0raNKa2xKglK1IpsUkqgizBEK
        Js8WCIvL8IS4xcI+TxxoL1KdKAiqPiBDv2sX/q5wQRAj5QCgTuD/L74Ca1xuoeYw=
X-Google-Smtp-Source: ABdhPJxoVkYWb9SgCwG+aUkQMdAs27kUw9BJP1mVqNNg9U7M3V51GRm52/4FxvIJz6Ca9zbRFdUG64suNNsmwQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4b0e:: with SMTP id
 lx14mr1564736pjb.160.1638827760084; Mon, 06 Dec 2021 13:56:00 -0800 (PST)
Date:   Mon,  6 Dec 2021 13:55:26 -0800
In-Reply-To: <20211206215528.97050-1-chooglen@google.com>
Message-Id: <20211206215528.97050-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211206215528.97050-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 1/3] branch: move --set-upstream-to behavior to setup_tracking()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactor is motivated by a desire to add a "dry_run" parameter to
create_branch() that will validate whether or not a branch can be
created without actually creating it - this behavior be used in a
subsequent commit that adds `git branch --recurse-submodules topic`.

Adding "dry_run" is not obvious because create_branch() is also used to
set tracking information without creating a branch, i.e. when using
--set-upstream-to. This appears to be a leftover from 4fc5006676 (Add
branch --set-upstream, 2010-01-18), when --set-upstream would sometimes
create a branch and sometimes update tracking information without
creating a branch. However, we no longer support --set-upstream, so it
makes more sense to set tracking information with another function, like
setup_tracking(), and use create_branch() only to create branches. When
this is done, it will be trivial to add "dry_run".

Do this refactor by moving the branch validation and dwim logic from
create_branch() into a new function, validate_branch_start(), and call
it from setup_tracking(). Now that setup_tracking() can perform dwim and
tracking setup without creating a branch, use it in `git branch
--set-upstream-to` and remove unnecessary behavior from create_branch().

Since there were none, add tests for creating a branch with `--force`.

Signed-off-by: Glen Choo <chooglen@google.com>
---
As Jonathan noted in v1, the diff is quite large. I could shrink this
by forward-declaring setup_tracking() so that the function definitions
are in the same order; let me know if that would be preferred.

 branch.c          | 195 ++++++++++++++++++++++++++--------------------
 branch.h          |  13 +++-
 builtin/branch.c  |   7 +-
 t/t3200-branch.sh |  17 ++++
 4 files changed, 139 insertions(+), 93 deletions(-)

diff --git a/branch.c b/branch.c
index 07a46430b3..a635a60f8b 100644
--- a/branch.c
+++ b/branch.c
@@ -126,43 +126,6 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	return -1;
 }
 
-/*
- * This is called when new_ref is branched off of orig_ref, and tries
- * to infer the settings for branch.<new_ref>.{remote,merge} from the
- * config.
- */
-static void setup_tracking(const char *new_ref, const char *orig_ref,
-			   enum branch_track track, int quiet)
-{
-	struct tracking tracking;
-	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
-
-	memset(&tracking, 0, sizeof(tracking));
-	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking))
-		return;
-
-	if (!tracking.matches)
-		switch (track) {
-		case BRANCH_TRACK_ALWAYS:
-		case BRANCH_TRACK_EXPLICIT:
-		case BRANCH_TRACK_OVERRIDE:
-			break;
-		default:
-			return;
-		}
-
-	if (tracking.matches > 1)
-		die(_("Not tracking: ambiguous information for ref %s"),
-		    orig_ref);
-
-	if (install_branch_config(config_flags, new_ref, tracking.remote,
-			      tracking.src ? tracking.src : orig_ref) < 0)
-		exit(-1);
-
-	free(tracking.src);
-}
-
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
 {
 	char *v = NULL;
@@ -243,33 +206,35 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track)
+/**
+ * Validates whether a ref is a valid starting point for a branch, where:
+ *
+ *   - r is the repository to validate the branch for
+ *
+ *   - start_name is the ref that we would like to test. This is
+ *     expanded with DWIM and assigned to real_ref.
+ *
+ *   - track is the tracking mode of the new branch. If tracking is
+ *     explicitly requested, start_name must be a branch (because
+ *     otherwise start_name cannot be tracked)
+ *
+ *   - oid is an out parameter containing the object_id of start_name
+ *
+ *   - real_ref is an out parameter containing the full, 'real' form of
+ *     start_name e.g. refs/heads/main instead of main
+ *
+ */
+static void validate_branch_start(struct repository *r, const char *start_name,
+				  enum branch_track track,
+				  struct object_id *oid, char **real_ref)
 {
 	struct commit *commit;
-	struct object_id oid;
-	char *real_ref;
-	struct strbuf ref = STRBUF_INIT;
-	int forcing = 0;
-	int dont_change_ref = 0;
 	int explicit_tracking = 0;
 
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
-		if (!force)
-			dont_change_ref = 1;
-		else
-			forcing = 1;
-	}
-
-	real_ref = NULL;
-	if (get_oid_mb(start_name, &oid)) {
+	if (repo_get_oid_mb(r, start_name, oid)) {
 		if (explicit_tracking) {
 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
 				error(_(upstream_missing), start_name);
@@ -281,7 +246,8 @@ void create_branch(struct repository *r,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
+	switch (repo_dwim_ref(r, start_name, strlen(start_name), oid, real_ref,
+			      0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
@@ -289,12 +255,12 @@ void create_branch(struct repository *r,
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
-		if (!starts_with(real_ref, "refs/heads/") &&
-		    validate_remote_tracking_branch(real_ref)) {
+		if (!starts_with(*real_ref, "refs/heads/") &&
+		    validate_remote_tracking_branch(*real_ref)) {
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
 			else
-				FREE_AND_NULL(real_ref);
+				FREE_AND_NULL(*real_ref);
 		}
 		break;
 	default:
@@ -302,37 +268,96 @@ void create_branch(struct repository *r,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
+	if ((commit = lookup_commit_reference(r, oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
-	oidcpy(&oid, &commit->object.oid);
+	oidcpy(oid, &commit->object.oid);
+}
+
+void setup_tracking(const char *new_ref, const char *orig_ref,
+			   enum branch_track track, int quiet, int expand_orig)
+{
+	struct tracking tracking;
+	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	char *full_orig_ref;
+	struct object_id unused_oid;
+
+	memset(&tracking, 0, sizeof(tracking));
+	if (expand_orig)
+		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
+	else
+		full_orig_ref = xstrdup(orig_ref);
+
+	tracking.spec.dst = full_orig_ref;
+	if (for_each_remote(find_tracked_branch, &tracking))
+		goto cleanup;
+
+	if (!tracking.matches)
+		switch (track) {
+		case BRANCH_TRACK_ALWAYS:
+		case BRANCH_TRACK_EXPLICIT:
+		case BRANCH_TRACK_OVERRIDE:
+			break;
+		default:
+			goto cleanup;
+		}
+
+	if (tracking.matches > 1)
+		die(_("Not tracking: ambiguous information for ref %s"),
+		    full_orig_ref);
+
+	if (install_branch_config(config_flags, new_ref, tracking.remote,
+			      tracking.src ? tracking.src : full_orig_ref) < 0)
+		exit(-1);
+
+cleanup:
+	free(tracking.src);
+	free(full_orig_ref);
+}
+
+void create_branch(struct repository *r, const char *name,
+		   const char *start_name, int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track)
+{
+	struct object_id oid;
+	char *real_ref;
+	struct strbuf ref = STRBUF_INIT;
+	int forcing = 0;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	char *msg;
+
+	if (clobber_head_ok && !force)
+		BUG("'clobber_head_ok' can only be used with 'force'");
+
+	if (clobber_head_ok ?
+			  validate_branchname(name, &ref) :
+			  validate_new_branchname(name, &ref, force)) {
+		forcing = 1;
+	}
+
+	validate_branch_start(r, start_name, track, &oid, &real_ref);
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
 
-	if (!dont_change_ref) {
-		struct ref_transaction *transaction;
-		struct strbuf err = STRBUF_INIT;
-		char *msg;
-
-		if (forcing)
-			msg = xstrfmt("branch: Reset to %s", start_name);
-		else
-			msg = xstrfmt("branch: Created from %s", start_name);
-
-		transaction = ref_transaction_begin(&err);
-		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf,
-					   &oid, forcing ? NULL : null_oid(),
-					   0, msg, &err) ||
-		    ref_transaction_commit(transaction, &err))
-			die("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
-		free(msg);
-	}
+	if (forcing)
+		msg = xstrfmt("branch: Reset to %s", start_name);
+	else
+		msg = xstrfmt("branch: Created from %s", start_name);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+		ref_transaction_update(transaction, ref.buf,
+					&oid, forcing ? NULL : null_oid(),
+					0, msg, &err) ||
+		ref_transaction_commit(transaction, &err))
+		die("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	free(msg);
 
 	if (real_ref && track)
-		setup_tracking(ref.buf + 11, real_ref, track, quiet);
+		setup_tracking(ref.buf + 11, real_ref, track, quiet, 0);
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/branch.h b/branch.h
index df0be61506..75cefcdcbd 100644
--- a/branch.h
+++ b/branch.h
@@ -17,6 +17,15 @@ extern enum branch_track git_branch_track;
 
 /* Functions for acting on the information about branches. */
 
+/*
+ * This sets the branch.<new_ref>.{remote,merge} config settings so that
+ * branch 'new_ref' tracks 'orig_ref'. This is called when branches are
+ * created, or when branch configs are updated (e.g. with
+ * git branch --set-upstream-to).
+ */
+void setup_tracking(const char *new_ref, const char *orig_ref,
+		    enum branch_track track, int quiet, int expand_orig);
+
 /*
  * Creates a new branch, where:
  *
@@ -29,8 +38,8 @@ extern enum branch_track git_branch_track;
  *
  *   - force enables overwriting an existing (non-head) branch
  *
- *   - clobber_head_ok allows the currently checked out (hence existing)
- *     branch to be overwritten; without 'force', it has no effect.
+ *   - clobber_head_ok, when enabled with 'force', allows the currently
+ *     checked out (head) branch to be overwritten
  *
  *   - reflog creates a reflog for the branch
  *
diff --git a/builtin/branch.c b/builtin/branch.c
index 81b5c111cb..19f2845e7a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -821,12 +821,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
 
-		/*
-		 * create_branch takes care of setting up the tracking
-		 * info and making sure new_upstream is correct
-		 */
-		create_branch(the_repository, branch->name, new_upstream,
-			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		setup_tracking(branch->name, new_upstream, BRANCH_TRACK_OVERRIDE, quiet, 1);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8c5c1ccf33..f97cf495ab 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -42,6 +42,23 @@ test_expect_success 'git branch abc should create a branch' '
 	git branch abc && test_path_is_file .git/refs/heads/abc
 '
 
+test_expect_success 'git branch abc should fail when abc exists' '
+	test_must_fail git branch abc
+'
+
+test_expect_success 'git branch --force abc should fail when abc is checked out' '
+	test_when_finished git switch main &&
+	git switch abc &&
+	test_must_fail git branch --force abc HEAD~1
+'
+
+test_expect_success 'git branch --force abc should succeed when abc exists' '
+	git rev-parse HEAD~1 >expect &&
+	git branch --force abc HEAD~1 &&
+	git rev-parse abc >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
-- 
2.33.GIT

