Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA4EE14C3
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbjIIUM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIUM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 16:12:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070B719C
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 13:12:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so3115723f8f.2
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694290370; x=1694895170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIzT2RhQx/fs2jz1KoCd0nEcjzBZyHYJ9uopmm/U13I=;
        b=HmqiqL9T2b19GV6rQYoEkqC+sTMdk8nf/SgsWAhSZ/KRyy4yBlQlDAeh1RMLhG/6NF
         HoE2SBZFWZFK66mMt1bj4fbx0WkTGAYsP6sl+KuUvm6szam7ETq44UICQsTAkyXtiAtw
         z8qbcCXqB70ahAtbl5wKefn6Leoi0Z/mVCJTUCptTk17bTxqodVULA+G6oxt8dhX7KuO
         A8GLsCwxfl7+IEAsendRYOVnEmeXslRBLBNm0PMkm9lxcyiA7WTiSxbjlQV5555Dhnof
         0bdsV9tMjZOJNN5yZ5A3yq2dTk0dw+2GmN0jJqgLPYXwa4W96adKJY3DullyM7BKxnT4
         1J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694290370; x=1694895170;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIzT2RhQx/fs2jz1KoCd0nEcjzBZyHYJ9uopmm/U13I=;
        b=eFrIvf8qvkQPCGKeVT9Hs+lVtVHvQuySqc/C5EfWap1Yu5a4cFKuRetxoJEjmO9jWx
         c+KnKYePjT1cf3ROttyrSsdaBOgoId2irDw2QocxUwYBQmxOH3BJEWHEYu97728jOMAr
         AAunJMmgHa5oZFObfd+HmNwfA/yIuOCFkrm/oyMC4vaY0FVmEwK5WjLmb4QA6VQOVy6g
         Q0TRoGNnwtzRIaAgqq5eaPhhjNvQyvfWOVgarYrz5YZuXQ18SXt6KW1lmi0r2KVOl7Jy
         6OqQBG/at99T6rb339GWJmgf9FiNNUVcALc2BYEMRtRuqRwki/C+JuSgmwyO9lxmjIbB
         mU6w==
X-Gm-Message-State: AOJu0Yw7On8jVPG7zu5hWZwT3VTLFpQSFBYjJrLieETcIrzQx2GY5e7L
        rG9+cRl9J4XeoPdkKdPSPQb0axx0msw=
X-Google-Smtp-Source: AGHT+IGMPKNd0AbXlqmmuDXcidmFaN13k1PkrDw8qiRj+NtYXu3m15oDbxl1wvJvfn4+jwUMM2705Q==
X-Received: by 2002:adf:dd89:0:b0:317:7b74:b9fb with SMTP id x9-20020adfdd89000000b003177b74b9fbmr4838628wrl.46.1694290370183;
        Sat, 09 Sep 2023 13:12:50 -0700 (PDT)
Received: from [192.168.2.52] (16.red-88-14-199.dynamicip.rima-tde.net. [88.14.199.16])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b0031f07d1edbcsm5613987wrx.77.2023.09.09.13.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 13:12:49 -0700 (PDT)
Subject: [PATCH v2] status: fix branch shown when not only bisecting
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
Message-ID: <2e24ca9b-9c5f-f4df-b9f8-6574a714dfb2@gmail.com>
Date:   Sat, 9 Sep 2023 22:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 83c750acde (wt-status.*: better advice for git status added,
2012-06-05), git-status received new informative messages to describe
the ongoing work in a worktree.

These messages were enhanced in 0722c805d6 (status: show the branch name
if possible in in-progress info, 2013-02-03), to show, if possible, the
branch where the operation was initiated.

Since then, we show incorrect information when several operations are in
progress and one of them is bisect:

   $ git checkout -b foo
   $ GIT_SEQUENCE_EDITOR='echo break >' git rebase -i HEAD~
   $ git checkout -b bar
   $ git bisect start
   $ git status
   ...

   You are currently editing a commit while rebasing branch 'bar' on '...'.

   You are currently bisecting, started from branch 'bar'.

   ...

Note that we erroneously say "while rebasing branch 'bar'" when we
should be referring to "foo".

This must have gone unnoticed for so long because it must be unusual to
start a bisection while another operation is in progress.  And even less
usual to involve different branches.

It caught my attention reviewing a leak introduced in 8b87cfd000
(wt-status: move strbuf into read_and_strip_branch(), 2013-03-16).

A simple change to deal with this situation can be to record in struct
wt_status_state, the branch where the bisect starts separately from the
branch related to other operations.

Let's do it and so we'll be able to display correct information and
we'll avoid the leak as well.

Signed-off-by: Rubén Justo <rjusto@gmail.com>

---

Let's try again.


 branch.c               |  4 ++--
 ref-filter.c           |  2 +-
 t/t7512-status-help.sh | 28 ++++++++++++++++++++++++++++
 worktree.c             |  4 ++--
 wt-status.c            |  7 ++++---
 wt-status.h            |  1 +
 6 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 06f7af9dd4..534594f7f8 100644
--- a/branch.c
+++ b/branch.c
@@ -420,9 +420,9 @@ static void prepare_checked_out_branches(void)
 		wt_status_state_free_buffers(&state);
 
 		if (wt_status_check_bisect(wt, &state) &&
-		    state.branch) {
+		    state.bisecting_from) {
 			struct strbuf ref = STRBUF_INIT;
-			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
 			old = strmap_put(&current_checked_out_branches,
 					 ref.buf,
 					 xstrdup(wt->path));
diff --git a/ref-filter.c b/ref-filter.c
index 1bfaf20fbf..7fd5548e93 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2124,7 +2124,7 @@ char *get_head_description(void)
 				    state.detached_from);
 	} else if (state.bisect_in_progress)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
-			    state.branch);
+			    state.bisecting_from);
 	else if (state.detached_from) {
 		if (state.detached_at)
 			strbuf_addf(&desc, _("(HEAD detached at %s)"),
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index c2ab8a444a..802f8f704c 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -692,6 +692,34 @@ EOF
 '
 
 
+test_expect_success 'status when bisecting while rebasing' '
+	git reset --hard main &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=$(git rev-parse --short HEAD^) &&
+	FAKE_LINES="break" git rebase -i HEAD^ &&
+	test_when_finished "git checkout -" &&
+	git checkout -b bisect_while_rebasing &&
+	test_when_finished "git bisect reset" &&
+	git bisect start &&
+	cat >expected <<EOF &&
+On branch bisect_while_rebasing
+Last command done (1 command done):
+   break
+No commands remaining.
+You are currently editing a commit while rebasing branch '\''bisect'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+You are currently bisecting, started from branch '\''bisect_while_rebasing'\''.
+  (use "git bisect reset" to get back to the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
 test_expect_success 'status when rebase --apply conflicts with statushints disabled' '
 	git reset --hard main &&
 	git checkout -b statushints_disabled &&
diff --git a/worktree.c b/worktree.c
index b8cf29e6a1..360e2b1866 100644
--- a/worktree.c
+++ b/worktree.c
@@ -395,9 +395,9 @@ int is_worktree_being_bisected(const struct worktree *wt,
 
 	memset(&state, 0, sizeof(state));
 	found_bisect = wt_status_check_bisect(wt, &state) &&
-		       state.branch &&
+		       state.bisecting_from &&
 		       skip_prefix(target, "refs/heads/", &target) &&
-		       !strcmp(state.branch, target);
+		       !strcmp(state.bisecting_from, target);
 	wt_status_state_free_buffers(&state);
 	return found_bisect;
 }
diff --git a/wt-status.c b/wt-status.c
index d03dfab9e4..dec28e8124 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -861,6 +861,7 @@ void wt_status_state_free_buffers(struct wt_status_state *state)
 	FREE_AND_NULL(state->branch);
 	FREE_AND_NULL(state->onto);
 	FREE_AND_NULL(state->detached_from);
+	FREE_AND_NULL(state->bisecting_from);
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
@@ -1569,10 +1570,10 @@ static void show_revert_in_progress(struct wt_status *s,
 static void show_bisect_in_progress(struct wt_status *s,
 				    const char *color)
 {
-	if (s->state.branch)
+	if (s->state.bisecting_from)
 		status_printf_ln(s, color,
 				 _("You are currently bisecting, started from branch '%s'."),
-				 s->state.branch);
+				 s->state.bisecting_from);
 	else
 		status_printf_ln(s, color,
 				 _("You are currently bisecting."));
@@ -1733,7 +1734,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 
 	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
-		state->branch = get_branch(wt, "BISECT_START");
+		state->bisecting_from = get_branch(wt, "BISECT_START");
 		return 1;
 	}
 	return 0;
diff --git a/wt-status.h b/wt-status.h
index ab9cc9d8f0..819dcad723 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -94,6 +94,7 @@ struct wt_status_state {
 	char *branch;
 	char *onto;
 	char *detached_from;
+	char *bisecting_from;
 	struct object_id detached_oid;
 	struct object_id revert_head_oid;
 	struct object_id cherry_pick_head_oid;
-- 
2.40.1

