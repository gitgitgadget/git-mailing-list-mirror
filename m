Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3FC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 22:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDVWTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 18:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVWTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 18:19:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AD126BE
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:19:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so31471765e9.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682201948; x=1684793948;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MAXPguIYG550wI+/5xI9tvNvJ0ttQc/qw6ldMv4KD4=;
        b=NEhuePwFjWRTsZk8TbxQV16v48kbC03JWhuTvjOB5vu5kf0W7fLGH/EfCOlYCg11sZ
         1Mb8aRW/kkQgjjr6h3iglYVFSBvyqVEsJQCab8ofCBAHcPzwxcqrNrNJd7FA1S99DqC7
         OJW1T7GT5mw01x31KwEUwiPbE4XUk4bzC1G8GYhouUtUqWCtywx3Bt0kai5VAmi8HDX4
         /12WOa+kw1wmEUL82WuAZiWKE8isXDrDTgbNBHlEdpRiFiLokNXkaerpUA0NOkrsnHHr
         sy16VMp3BaSwuGY470a4Q6f8QnjyyyVv21lgy1Bwnz2vuHdrHXDiihUyTdSYh/4X8hrW
         XSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682201948; x=1684793948;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MAXPguIYG550wI+/5xI9tvNvJ0ttQc/qw6ldMv4KD4=;
        b=JgCOz9PDZwK0A/U7BV8/nU3k15fj2XmRpfZgFjDhQLkgmOdx5i2sC1o6VDnbt4JFzq
         gImzfXvmlNuoHH56mtxAaf+WxpuugMhs9XCiGGd0p9jvHWN3MnVisGoHzzsdg4w1cLg0
         xSxQGwFzu5pFyenzyLxf4DXCmc5hK4Fr9ZHoRlya1aM74z7g5uUiKInWdlqIIF0bwj+t
         P/X7jx4jp9LT9VrGZs9+xh1A3fHNsO0bdGT3znxXXW6cWvcVzxrmbig6uV8BOHUdT6cy
         alNbGX6+788LpuPihHb0f+t9vOZQ+bHUvSkD77EaGTz+w2W6vF1lsywtz7VjWNSGQejc
         R9hg==
X-Gm-Message-State: AAQBX9cz/mSqnfJFIy5uPgfFP7y/7XRH5iqx7jwnIRUl5YdKekHloVQM
        B9KaRur/yVePznBIKkO55Yk=
X-Google-Smtp-Source: AKy350bRWJXMborPk54fWm4dFbiHBy3JM3ofUkYZqhU15ZsimoA1SvJrI3sikMbWARxaMgGIM92/Qg==
X-Received: by 2002:a5d:4149:0:b0:2fe:61b0:d7a2 with SMTP id c9-20020a5d4149000000b002fe61b0d7a2mr6743885wrq.12.1682201947734;
        Sat, 22 Apr 2023 15:19:07 -0700 (PDT)
Received: from [192.168.2.52] (32.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.32])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d6e01000000b002fa834e1c69sm7372251wrz.52.2023.04.22.15.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 15:19:07 -0700 (PDT)
Subject: [PATCH 1/3] checkout: move orphaned_commit_warning()
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Message-ID: <bf4835ac-4d39-8bfa-47e9-057d97fa0fff@gmail.com>
Date:   Sun, 23 Apr 2023 00:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8e2dc6ac06 (commit: give final warning when reattaching HEAD to leave
commits behind, 2011-02-18) we introduced orphaned_commit_warning() in
builtin/checkout.c.

In subsequent commits we're going to use orphaned_commit_warning() not
only from builtin/checkout.c, but from other builtin commands too.

Let's move the function and its helpers to checkout.c and make it an
API callable not just from builtin/checkout.c.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/checkout.c | 124 -------------------------------------------
 checkout.c         | 129 +++++++++++++++++++++++++++++++++++++++++++++
 checkout.h         |   9 ++++
 3 files changed, 138 insertions(+), 124 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6f5d82ed3d..991413ef1a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -656,24 +656,6 @@ static void show_local_changes(struct object *head,
 	release_revisions(&rev);
 }
 
-static void describe_detached_head(const char *msg, struct commit *commit)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	if (!repo_parse_commit(the_repository, commit))
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	if (print_sha1_ellipsis()) {
-		fprintf(stderr, "%s %s... %s\n", msg,
-			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
-			sb.buf);
-	} else {
-		fprintf(stderr, "%s %s %s\n", msg,
-			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
-			sb.buf);
-	}
-	strbuf_release(&sb);
-}
-
 static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 		      int worktree, int *writeout_error,
 		      struct branch_info *info)
@@ -1016,112 +998,6 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		report_tracking(new_branch_info);
 }
 
-static int add_pending_uninteresting_ref(const char *refname,
-					 const struct object_id *oid,
-					 int flags UNUSED, void *cb_data)
-{
-	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
-	return 0;
-}
-
-static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
-{
-	strbuf_addstr(sb, "  ");
-	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
-	strbuf_addch(sb, ' ');
-	if (!repo_parse_commit(the_repository, commit))
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
-	strbuf_addch(sb, '\n');
-}
-
-#define ORPHAN_CUTOFF 4
-static void suggest_reattach(struct commit *commit, struct rev_info *revs)
-{
-	struct commit *c, *last = NULL;
-	struct strbuf sb = STRBUF_INIT;
-	int lost = 0;
-	while ((c = get_revision(revs)) != NULL) {
-		if (lost < ORPHAN_CUTOFF)
-			describe_one_orphan(&sb, c);
-		last = c;
-		lost++;
-	}
-	if (ORPHAN_CUTOFF < lost) {
-		int more = lost - ORPHAN_CUTOFF;
-		if (more == 1)
-			describe_one_orphan(&sb, last);
-		else
-			strbuf_addf(&sb, _(" ... and %d more.\n"), more);
-	}
-
-	fprintf(stderr,
-		Q_(
-		/* The singular version */
-		"Warning: you are leaving %d commit behind, "
-		"not connected to\n"
-		"any of your branches:\n\n"
-		"%s\n",
-		/* The plural version */
-		"Warning: you are leaving %d commits behind, "
-		"not connected to\n"
-		"any of your branches:\n\n"
-		"%s\n",
-		/* Give ngettext() the count */
-		lost),
-		lost,
-		sb.buf);
-	strbuf_release(&sb);
-
-	if (advice_enabled(ADVICE_DETACHED_HEAD))
-		fprintf(stderr,
-			Q_(
-			/* The singular version */
-			"If you want to keep it by creating a new branch, "
-			"this may be a good time\nto do so with:\n\n"
-			" git branch <new-branch-name> %s\n\n",
-			/* The plural version */
-			"If you want to keep them by creating a new branch, "
-			"this may be a good time\nto do so with:\n\n"
-			" git branch <new-branch-name> %s\n\n",
-			/* Give ngettext() the count */
-			lost),
-			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
-}
-
-/*
- * We are about to leave commit that was at the tip of a detached
- * HEAD.  If it is not reachable from any ref, this is the last chance
- * for the user to do so without resorting to reflog.
- */
-static void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
-{
-	struct rev_info revs;
-	struct object *object = &old_commit->object;
-
-	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(0, NULL, &revs, NULL);
-
-	object->flags &= ~UNINTERESTING;
-	add_pending_object(&revs, object, oid_to_hex(&object->oid));
-
-	for_each_ref(add_pending_uninteresting_ref, &revs);
-	if (new_commit)
-		add_pending_oid(&revs, "HEAD",
-				&new_commit->object.oid,
-				UNINTERESTING);
-
-	if (prepare_revision_walk(&revs))
-		die(_("internal error in revision walk"));
-	if (!(old_commit->object.flags & UNINTERESTING))
-		suggest_reattach(old_commit, &revs);
-	else
-		describe_detached_head(_("Previous HEAD position was"), old_commit);
-
-	/* Clean up objects used, as they will be reused. */
-	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
-	release_revisions(&revs);
-}
-
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
diff --git a/checkout.c b/checkout.c
index 04238b2713..18e7362043 100644
--- a/checkout.c
+++ b/checkout.c
@@ -5,6 +5,11 @@
 #include "checkout.h"
 #include "config.h"
 #include "strbuf.h"
+#include "environment.h"
+#include "revision.h"
+#include "advice.h"
+#include "hex.h"
+#include "refs.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
@@ -70,3 +75,127 @@ const char *unique_tracking_name(const char *name, struct object_id *oid,
 	}
 	return NULL;
 }
+
+void describe_detached_head(const char *msg, struct commit *commit)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!repo_parse_commit(the_repository, commit))
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+	if (print_sha1_ellipsis()) {
+		fprintf(stderr, "%s %s... %s\n", msg,
+			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
+			sb.buf);
+	} else {
+		fprintf(stderr, "%s %s %s\n", msg,
+			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
+			sb.buf);
+	}
+	strbuf_release(&sb);
+}
+
+static int add_pending_uninteresting_ref(const char *refname,
+					 const struct object_id *oid,
+					 int flags UNUSED, void *cb_data)
+{
+	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
+	return 0;
+}
+
+static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
+{
+	strbuf_addstr(sb, "  ");
+	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
+	strbuf_addch(sb, ' ');
+	if (!repo_parse_commit(the_repository, commit))
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
+	strbuf_addch(sb, '\n');
+}
+
+#define ORPHAN_CUTOFF 4
+static void suggest_reattach(struct commit *commit, struct rev_info *revs)
+{
+	struct commit *c, *last = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	int lost = 0;
+	while ((c = get_revision(revs)) != NULL) {
+		if (lost < ORPHAN_CUTOFF)
+			describe_one_orphan(&sb, c);
+		last = c;
+		lost++;
+	}
+	if (ORPHAN_CUTOFF < lost) {
+		int more = lost - ORPHAN_CUTOFF;
+		if (more == 1)
+			describe_one_orphan(&sb, last);
+		else
+			strbuf_addf(&sb, _(" ... and %d more.\n"), more);
+	}
+
+	fprintf(stderr,
+		Q_(
+		/* The singular version */
+		"Warning: you are leaving %d commit behind, "
+		"not connected to\n"
+		"any of your branches:\n\n"
+		"%s\n",
+		/* The plural version */
+		"Warning: you are leaving %d commits behind, "
+		"not connected to\n"
+		"any of your branches:\n\n"
+		"%s\n",
+		/* Give ngettext() the count */
+		lost),
+		lost,
+		sb.buf);
+	strbuf_release(&sb);
+
+	if (advice_enabled(ADVICE_DETACHED_HEAD))
+		fprintf(stderr,
+			Q_(
+			/* The singular version */
+			"If you want to keep it by creating a new branch, "
+			"this may be a good time\nto do so with:\n\n"
+			" git branch <new-branch-name> %s\n\n",
+			/* The plural version */
+			"If you want to keep them by creating a new branch, "
+			"this may be a good time\nto do so with:\n\n"
+			" git branch <new-branch-name> %s\n\n",
+			/* Give ngettext() the count */
+			lost),
+			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
+}
+
+/*
+ * We are about to leave commit that was at the tip of a detached
+ * HEAD.  If it is not reachable from any ref, this is the last chance
+ * for the user to do so without resorting to reflog.
+ */
+void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
+{
+	struct rev_info revs;
+	struct object *object = &old_commit->object;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	setup_revisions(0, NULL, &revs, NULL);
+
+	object->flags &= ~UNINTERESTING;
+	add_pending_object(&revs, object, oid_to_hex(&object->oid));
+
+	for_each_ref(add_pending_uninteresting_ref, &revs);
+	if (new_commit)
+		add_pending_oid(&revs, "HEAD",
+				&new_commit->object.oid,
+				UNINTERESTING);
+
+	if (prepare_revision_walk(&revs))
+		die(_("internal error in revision walk"));
+	if (!(old_commit->object.flags & UNINTERESTING))
+		suggest_reattach(old_commit, &revs);
+	else
+		describe_detached_head(_("Previous HEAD position was"), old_commit);
+
+	/* Clean up objects used, as they will be reused. */
+	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
+	release_revisions(&revs);
+}
diff --git a/checkout.h b/checkout.h
index 1917f3b323..c7dc056544 100644
--- a/checkout.h
+++ b/checkout.h
@@ -2,6 +2,7 @@
 #define CHECKOUT_H
 
 #include "hash.h"
+#include "commit.h"
 
 /*
  * Check if the branch name uniquely matches a branch name on a remote
@@ -12,4 +13,12 @@ const char *unique_tracking_name(const char *name,
 				 struct object_id *oid,
 				 int *dwim_remotes_matched);
 
+/*
+ * We are about to leave commit that was at the tip of a detached
+ * HEAD.  If it is not reachable from any ref, this is the last chance
+ * for the user to do so without resorting to reflog.
+ */
+void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit);
+
+void describe_detached_head(const char *msg, struct commit *commit);
 #endif /* CHECKOUT_H */
-- 
2.39.2
