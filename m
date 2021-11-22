Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB6C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhKVWgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhKVWgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:36:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1AC061746
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso6533992pjf.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wno8FRWOoVSdU20IAC+7f3H30uVr5WbyvVEdvgNyFLY=;
        b=E9sxUfeQO1p69F3fjGi3cTLSIKy+gfp2V8sl24eZ4OAdxuUjpy/yxlRsAwgJpsz4wb
         J8J4O4g/D4u7qwDzs26PmgUrVmSgSoEa3R8yTZCNYB58DXq35syXQj5MxTxPBtn5YxSH
         WKKnzW6bAbaMCSiEjKSFn4fOvWDQhcwFBPaYrLilVA5hJvcgIxE5ZOT1AZYL2d+0hRzF
         lkyMpArOEHOxUF5G2Wp3L6Xan/+1LqblAYqZh5HLQxxhiE7KZPf1DFBoscg+0+b8cllQ
         fsU71xMyBchCD5o5D9gAfUJHC60OIdWznkmaK7D/Jfs/UPMTASuxijLjNciVK6WsYKbe
         FK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wno8FRWOoVSdU20IAC+7f3H30uVr5WbyvVEdvgNyFLY=;
        b=XSiFBOGEabv5+J0tyUSppcWdYzVXARPc+a0fC25K5ON/inzEVbmr0txWvGEooO/B66
         ZGLswvcPrOvuWUiDSwlTaZU6WCO89Oc85QyiNjKXJeX87j4+gq3zNU8TvOHzgbt7aV3c
         vN/aAfgluTd+BOWZauuQxnhSeGmzd1tlZWqCLxvlWfXq+vybfPGeVuURZiYuJBBTtWMY
         dEe1wlpTwLbYZMYsrDfc/QUPyc6qYhO1DQlOK4YJZJDsBMDR57ie67Xs67dg2KwT9xyM
         XCh7bqqrNfhd/tJJ8EzyoCQ6AuTvXuG+wwLs8femUnIKwQfkrMzae0Jx2C95hP1EO/jn
         hC8w==
X-Gm-Message-State: AOAM530LIM01JeeG5GKSQrXUp0Fh/O+zPlX37zp2+ZFo9n6YEEOJxAjp
        uFOXLlD4K4ZIOCd4/O9ECqCq+7HkObeUX35zbeE0xX2mz6++Od979NClm86Jfqq08dklBdwYlO9
        sN2vmIKnkBxtY/2OOPTpWxiF+KHiUGv0FwR9ciBe9zrs918K/uO2d68DxGEC8ZNw=
X-Google-Smtp-Source: ABdhPJxlniWIn1ykH1CAwk1TSRTOc+T2Hp7c5TW8M0bXQ37wQn4fs2HB2+PKc7DOV8WK7qbOyiZup3J1qwJOSQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:bb84:: with SMTP id
 v4mr36716760pjr.4.1637620389464; Mon, 22 Nov 2021 14:33:09 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:32:50 -0800
In-Reply-To: <20211122223252.19922-1-chooglen@google.com>
Message-Id: <20211122223252.19922-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/4] branch: refactor out branch validation from create_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we would like to be able to validate whether or
not a branch name is valid before we create it (--dry-run). This is
useful for `git branch --recurse-submodules topic` because it allows Git
to determine if the branch 'topic' can be created in all submodules
without creating the branch 'topic'.

A good starting point would be to refactor out the start point
validation and dwim logic in create_branch() in a
validate_branch_start() helper function. Once we do so, it becomes
clear that create_branch() is more complex than it needs to be -
create_branch() is also used to set tracking information when performing
`git branch --set-upstream-to`. This made more sense when
(the now unsupported) --set-upstream was first introduced in
4fc5006676 (Add branch --set-upstream, 2010-01-18), because
it would sometimes create a branch and sometimes update tracking
information without creating a branch.

Refactor out the branch validation and dwim logic from create_branch()
into validate_branch_start(), make it so that create_branch() always
tries to create a branch, and replace the now-incorrect create_branch()
call with setup_tracking(). Since there were none, add tests for
creating a branch with `--force`.

Signed-off-by: Glen Choo <chooglen@google.com>
---
In this refactor, I preserved the existing behavior by making
setup_tracking() call validate_branch_start(). setup_tracking() needs
the dwim behavior e.g. to expand 'origin/main' into
'refs/remotes/origin/main' but I'm doubtful that it needs the exact same
set of validation behavior as creating a new branch e.g. validating that
the object_id is a commit.

 branch.c          | 177 ++++++++++++++++++++++++----------------------
 branch.h          |  13 +++-
 builtin/branch.c  |   7 +-
 t/t3200-branch.sh |  17 +++++
 4 files changed, 121 insertions(+), 93 deletions(-)

diff --git a/branch.c b/branch.c
index 07a46430b3..f8b755513f 100644
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
@@ -243,33 +206,17 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track)
+static void validate_branch_start(struct repository *r, const char *start_name,
+				  enum branch_track track,
+				  struct object_id *oid, char **full_ref)
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
@@ -281,7 +228,8 @@ void create_branch(struct repository *r,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
+	switch (repo_dwim_ref(r, start_name, strlen(start_name), oid, full_ref,
+			      0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
@@ -289,12 +237,12 @@ void create_branch(struct repository *r,
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
-		if (!starts_with(real_ref, "refs/heads/") &&
-		    validate_remote_tracking_branch(real_ref)) {
+		if (!starts_with(*full_ref, "refs/heads/") &&
+		    validate_remote_tracking_branch(*full_ref)) {
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
 			else
-				FREE_AND_NULL(real_ref);
+				FREE_AND_NULL(*full_ref);
 		}
 		break;
 	default:
@@ -302,37 +250,96 @@ void create_branch(struct repository *r,
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
index 0b7ed82654..eb5c117a6e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -820,12 +820,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
index e575ffb4ff..6bf95a1707 100755
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

