Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE9C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhLTXfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:35:13 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A72C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:13 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s22-20020a63d056000000b0033b09af4d13so7758139pgi.13
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wEZDsjW7G+dAlIflpqswtN1JStAgNnAwmvEWLOp+A4g=;
        b=smsNoc9T3sogsc7gfOwfXvemCktDaYJ6cxlxRGIGTqQSN+L86cn5a64Wh7/2gMsBFz
         ds5OZwWIffDZB58OWI4zbd0bYAJfYP1FPeurDhL0KEez47O+IRZBWtCxJ9/fwvPXC5Rn
         LQ6lNDGKVRxEMXt7TfBwl02hmKlhploq/Tp0dlJxN1MH7J09xKRohQ480pirrycT+YYY
         Ua+maGBSfE+Tv2xm9X7oKcollbIm9zsvsjkUv6YSkYPi+ddgJJrSnzUjTTJQ2jYAZtlT
         rug7SyGRjALBYMi0mg6O3WB6tSvhQkt5wZDCyRIa4NMF4mAoE+7ndhR+DY8vWqcluX4E
         B7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wEZDsjW7G+dAlIflpqswtN1JStAgNnAwmvEWLOp+A4g=;
        b=KAgOEBtwaIRUYmqRaWr12XeFP25cjhm8rFqdnOsV0XeunMj43VmQ0LVWdkuOgPxAbq
         4PyNQ95cpO1bnvc8Xjqz1nWaTk59IKXyQkH3JkGD8ooJn/OfGAKv/HvmLEySKXHj9fs1
         IP2HrNoxyJ1IZT45q4iWgMjwFlbnQ7b0xYIkh/+LlUbOLN7+TslxbJ7N2lUGe2Rat+FG
         21E+53CUlVs4lkyXdI1Gquh3IgWJkj57oB6O5LN94deuBYnh1RfG/h6cAyX11v2Ew+D6
         aHjLgsqLHNXKApJuVbgHhxkvzPRN3KF0LLzhKAf4Y1TeRPxDYc+FbVlLzTo9WM6wlPG5
         4OEQ==
X-Gm-Message-State: AOAM53256dK5z2va1BuMUrzpJsnKuOe0p0QDy0LbA1TrI52vyVHCZok+
        p20O5Cn11gKze6jUemOnbnTYZ9mhE5hdwp14ByaC3EIvZie3CgEsarTwOiRLx8awqCf0UVgzTS5
        /B6rFmgktAzGyoCgNf6SRd9tUdMva53Rz/bGX5zqRuFHXglewzXK7/o1wS3wR2lc=
X-Google-Smtp-Source: ABdhPJz+bw8DOkH+jpXV0VvjsGhm5NVkXf+cS7EeQWLMInrhs/lRV+BZblIXAKk48SaBtowZ0mirkWbrX5X9LQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:17cc:: with SMTP id
 me12mr466878pjb.179.1640043313188; Mon, 20 Dec 2021 15:35:13 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:34:55 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com>
Message-Id: <20211220233459.45739-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com> <20211220233459.45739-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v6 1/5] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactor is motivated by a desire to add a "dry_run" parameter to
create_branch() that will validate whether or not a branch can be
created without actually creating it - this behavior will be used in a
subsequent commit that adds `git branch --recurse-submodules topic`.

Adding "dry_run" is not obvious because create_branch() is also used to
set tracking information without creating a branch, i.e. when using
--set-upstream-to. This appears to be a leftover from 4fc5006676 (Add
branch --set-upstream, 2010-01-18), when --set-upstream would sometimes
create a branch and sometimes update tracking information without
creating a branch. However, we no longer support --set-upstream, so it
makes more sense to set tracking information with another function and
use create_branch() only to create branches. In a later commit, we will
remove the now-unnecessary logic from create_branch() so that "dry_run"
becomes trivial to implement.

Introduce dwim_and_setup_tracking(), which replaces create_branch()
in `git branch --set-upstream-to`. Ensure correctness by moving the DWIM
and branch validation logic from create_branch() into a helper function,
dwim_branch_start(), so that the logic is shared by both functions.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c         | 87 ++++++++++++++++++++++++++++++++++++------------
 branch.h         | 22 ++++++++++++
 builtin/branch.c |  9 ++---
 3 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/branch.c b/branch.c
index fa339b64e2..e271a4e0a7 100644
--- a/branch.c
+++ b/branch.c
@@ -217,9 +217,11 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 }
 
 /*
- * This is called when new_ref is branched off of orig_ref, and tries
- * to infer the settings for branch.<new_ref>.{remote,merge} from the
- * config.
+ * Used internally to set the branch.<new_ref>.{remote,merge} config
+ * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
+ * dwim_and_setup_tracking(), this does not do DWIM, i.e. "origin/main"
+ * will not be expanded to "refs/remotes/origin/main", so it is not safe
+ * for 'orig_ref' to be raw user input.
  */
 static void setup_tracking(const char *new_ref, const char *orig_ref,
 			   enum branch_track track, int quiet)
@@ -244,7 +246,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		case BRANCH_TRACK_INHERIT:
 			break;
 		default:
-			return;
+			goto cleanup;
 		}
 
 	if (tracking.matches > 1)
@@ -257,6 +259,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 				tracking.remote, tracking.srcs) < 0)
 		exit(-1);
 
+cleanup:
 	string_list_clear(tracking.srcs, 0);
 }
 
@@ -340,31 +343,37 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track)
+/**
+ * DWIMs a user-provided ref to determine the starting point for a
+ * branch and validates it, where:
+ *
+ *   - r is the repository to validate the branch for
+ *
+ *   - start_name is the ref that we would like to test. This is
+ *     expanded with DWIM and assigned to out_real_ref.
+ *
+ *   - track is the tracking mode of the new branch. If tracking is
+ *     explicitly requested, start_name must be a branch (because
+ *     otherwise start_name cannot be tracked)
+ *
+ *   - out_oid is an out parameter containing the object_id of start_name
+ *
+ *   - out_real_ref is an out parameter containing the full, 'real' form
+ *     of start_name e.g. refs/heads/main instead of main
+ *
+ */
+static void dwim_branch_start(struct repository *r, const char *start_name,
+			   enum branch_track track, char **out_real_ref,
+			   struct object_id *out_oid)
 {
 	struct commit *commit;
 	struct object_id oid;
 	char *real_ref;
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
 	real_ref = NULL;
 	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
@@ -401,7 +410,34 @@ void create_branch(struct repository *r,
 
 	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
-	oidcpy(&oid, &commit->object.oid);
+	if (out_real_ref)
+		*out_real_ref = real_ref ? xstrdup(real_ref) : NULL;
+	if (out_oid)
+		oidcpy(out_oid, &commit->object.oid);
+
+	FREE_AND_NULL(real_ref);
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
+	int dont_change_ref = 0;
+
+	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
+	    ? validate_branchname(name, &ref)
+	    : validate_new_branchname(name, &ref, force)) {
+		if (!force)
+			dont_change_ref = 1;
+		else
+			forcing = 1;
+	}
+
+	dwim_branch_start(r, start_name, track, &real_ref, &oid);
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
@@ -435,6 +471,15 @@ void create_branch(struct repository *r,
 	free(real_ref);
 }
 
+void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
+			     const char *orig_ref, enum branch_track track,
+			     int quiet)
+{
+	char *real_orig_ref;
+	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
+	setup_tracking(new_ref, real_orig_ref, track, quiet);
+}
+
 void remove_merge_branch_state(struct repository *r)
 {
 	unlink(git_path_merge_head(r));
diff --git a/branch.h b/branch.h
index 815dcd40c0..ab2315c611 100644
--- a/branch.h
+++ b/branch.h
@@ -18,6 +18,28 @@ extern enum branch_track git_branch_track;
 
 /* Functions for acting on the information about branches. */
 
+/**
+ * Sets branch.<new_ref>.{remote,merge} config settings such that
+ * new_ref tracks orig_ref according to the specified tracking mode.
+ *
+ *   - new_ref is the name of the branch that we are setting tracking
+ *     for.
+ *
+ *   - orig_ref is the name of the ref that is 'upstream' of new_ref.
+ *     orig_ref will be expanded with DWIM so that the config settings
+ *     are in the correct format e.g. "refs/remotes/origin/main" instead
+ *     of "origin/main".
+ *
+ *   - track is the tracking mode e.g. BRANCH_TRACK_REMOTE causes
+ *     new_ref to track orig_ref directly, whereas BRANCH_TRACK_INHERIT
+ *     causes new_ref to track whatever orig_ref tracks.
+ *
+ *   - quiet suppresses tracking information.
+ */
+void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
+			     const char *orig_ref, enum branch_track track,
+			     int quiet);
+
 /*
  * Creates a new branch, where:
  *
diff --git a/builtin/branch.c b/builtin/branch.c
index 81a29edb4a..16a7e80df5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -823,12 +823,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch->refname))
 			die(_("branch '%s' does not exist"), branch->name);
 
-		/*
-		 * create_branch takes care of setting up the tracking
-		 * info and making sure new_upstream is correct
-		 */
-		create_branch(the_repository, branch->name, new_upstream,
-			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		dwim_and_setup_tracking(the_repository, branch->name,
+					new_upstream, BRANCH_TRACK_OVERRIDE,
+					quiet);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
-- 
2.33.GIT

