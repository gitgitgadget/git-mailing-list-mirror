Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6056BC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiBRUoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:44:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUoT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:44:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7F483B1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:44:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so16461047wrb.5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7MQwpYen9xDdy5vXM45r2vdosf1r67ji36tVaV2I24=;
        b=eGTct21r0Tby752K7Rq7VIHCpsNXhjAhf99cnDBRaW8kTqV/6OKHEkq+eUINQ5L6wm
         3iGskB3M53hSOiGAM4z+kkGPEZCevRV7SQgQgn6cRauKr0FNxre/ngMhqcFcWdwRN2AI
         odzGiUfl1paG+UIgdVI9dprvwPs7sItvz3Ad0ggZihS2TtWLMM5VhQ3FREPbNI8Ay7C0
         pWRy6DWzucCeWPc0GR8XH3uxbaalyt3somVmIxTDasx2mwqGTU3NM7Fh7II4+Xkeg5r4
         qgoKtHgXJdzRkaNruO0bNbWezZTuhMVJT03b5kuaWFQhAW0ESxpmuxCcG5umJ3NZDnGb
         Tzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7MQwpYen9xDdy5vXM45r2vdosf1r67ji36tVaV2I24=;
        b=2XDpPpfOsj7dpK84i8WUWoir9vWG6U72+TrwwbTNo00/Bk5YGwBujxI7xrdS7GpB6G
         lhrFStqpHwvHBY8wj/K/JlBRXF3Rtei+gywjTJHatoWQUDka9+uaVC9IFOw6bFAUwUte
         S69q4KbG+dzZkmHmGgpciXIY434MqhN3YU1nFpuEIk/tpy2Eu+JR8Zv5THkzkYiptvMQ
         SX2hPlVBXoUmdQ57z+/9PYTiolpArcmldJ7XE2NaK+NOxjQYGAR3Z6vYmkqTzem1TQNo
         DZt7aNMtSCLtB01ZzaqHVRXxM1O1Ad43WDINj2To/BHIHmCzDoytawJ39ObY9YGM3RkM
         msuQ==
X-Gm-Message-State: AOAM530ftpz/BDISLw8mvkd1N/n9oc/9vufCan0TY2lHlrgv2X2rHaZO
        ykOg0bUvtnw+zNQiwn8u1RZSNxPrihPx4Q==
X-Google-Smtp-Source: ABdhPJz9Z4XUT3OftlKn2D06UeEMXefL4ZoCy6t2vXRv60jJKJorYzPCDbexIYd07PJmHd7/LUBX+w==
X-Received: by 2002:adf:cc81:0:b0:1e4:ab98:74bd with SMTP id p1-20020adfcc81000000b001e4ab9874bdmr7588651wrj.131.1645217040159;
        Fri, 18 Feb 2022 12:44:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c14sm4680239wru.37.2022.02.18.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:43:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] hooks: fix a race in hook execution
Date:   Fri, 18 Feb 2022 21:43:50 +0100
Message-Id: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up on the recently landed c70bc338e9a (Merge branch
'ab/config-based-hooks-2', 2022-02-09). This fixes an obscure race
condition in how we execute a few hooks, because we'd run the hook,
and then check if the hook existed.

We could thus skip some post-hook logic if a hook was run, but we
raced with the hook being removed from the repository.

As 2/2 notes being worried about that isn't very realistic, but it
makes sense to have the hook API expose a "did I run it?" as part of
its API, so let's add such a flag, and use it in those cases.

The 2/2 has been on-list before as part of a much bigger hook topic
submission[1]. I fixed up a few things in it, and added 1/2. The
range-diff below is to that previous submission.

1. https://lore.kernel.org/git/patch-v5-36.36-fe056098534-20210902T125111Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  merge: don't run post-hook logic on --no-verify
  hooks: fix a TOCTOU in "did we run a hook?" heuristic

 builtin/commit.c       | 18 +++++++++++-------
 builtin/merge.c        | 28 +++++++++++++++++-----------
 builtin/receive-pack.c |  8 +++++---
 commit.c               |  2 +-
 commit.h               |  3 ++-
 hook.c                 |  7 +++++++
 hook.h                 |  9 +++++++++
 sequencer.c            |  4 ++--
 8 files changed, 54 insertions(+), 25 deletions(-)

Range-diff:
-:  ----------- > 1:  9b5144daee6 merge: don't run post-hook logic on --no-verify
1:  fe056098534 ! 2:  d01d088073b hooks: fix a TOCTOU in "did we run a hook?" heuristic
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
      	int old_display_comment_prefix;
      	int merge_contains_scissors = 0;
    -+	int invoked_hook = 0;
    ++	int invoked_hook;
      
      	/* This checks and barfs if author is badly specified */
      	determine_author_info(author_ident);
    @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    - {
    - 	struct strbuf msg = STRBUF_INIT;
      	const char *index_file = get_index_file();
    -+	int invoked_hook = 0;
      
    --	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
    -+	if (!no_verify && run_commit_hook(0 < option_edit, index_file,
    -+					  &invoked_hook, "pre-merge-commit",
    -+					  NULL))
    - 		abort_commit(remoteheads, NULL);
    - 	/*
    --	 * Re-read the index as pre-merge-commit hook could have updated it,
    --	 * and write it out as a tree.  We must do this before we invoke
    -+	 * Re-read the index as the pre-merge-commit hook was invoked
    -+	 * and could have updated it. We must do this before we invoke
    - 	 * the editor and after we invoke run_status above.
    - 	 */
    --	if (hook_exists("pre-merge-commit"))
    -+	if (invoked_hook)
    - 		discard_cache();
    + 	if (!no_verify) {
    +-		if (run_commit_hook(0 < option_edit, index_file,
    ++		int invoked_hook;
    ++
    ++		if (run_commit_hook(0 < option_edit, index_file, &invoked_hook,
    + 				    "pre-merge-commit", NULL))
    + 			abort_commit(remoteheads, NULL);
    + 		/*
    +@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    + 		 * and write it out as a tree.  We must do this before we invoke
    + 		 * the editor and after we invoke run_status above.
    + 		 */
    +-		if (hook_exists("pre-merge-commit"))
    ++		if (invoked_hook)
    + 			discard_cache();
    + 	}
      	read_cache_from(index_file);
    - 	strbuf_addbuf(&msg, &merge_msg);
     @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
      		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
      	write_merge_heads(remoteheads);
    @@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
      	strvec_pushv(&opt.env, env->v);
     @@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1, const struct worktree *w
      {
    - 	const char *retval, *work_tree, *git_dir = NULL;
    + 	const char *retval, *git_dir;
      	struct strvec env = STRVEC_INIT;
    -+	int invoked_hook = 0;
    ++	int invoked_hook;
      
    - 	if (worktree && worktree->path)
    - 		work_tree = worktree->path;
    + 	if (!worktree || !worktree->path)
    + 		BUG("worktree->path must be non-NULL");
     @@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1, const struct worktree *w
      
      	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
      
     -	if (!hook_exists(push_to_checkout_hook))
    -+	retval = push_to_checkout(sha1, &invoked_hook, &env, work_tree);
    ++	retval = push_to_checkout(sha1, &invoked_hook, &env, worktree->path);
     +	if (!invoked_hook)
    - 		retval = push_to_deploy(sha1, &env, work_tree);
    + 		retval = push_to_deploy(sha1, &env, worktree->path);
     -	else
    --		retval = push_to_checkout(sha1, &env, work_tree);
    +-		retval = push_to_checkout(sha1, &env, worktree->path);
      
      	strvec_clear(&env);
      	return retval;
    @@ commit.c: size_t ignore_non_trailer(const char *buf, size_t len)
      }
      
      int run_commit_hook(int editor_is_used, const char *index_file,
    -+		    int *invoked_hook,
    - 		    const char *name, ...)
    +-		    const char *name, ...)
    ++		    int *invoked_hook, const char *name, ...)
      {
      	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    + 	va_list args;
     
      ## commit.h ##
     @@ commit.h: int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
    @@ commit.h: int compare_commits_by_commit_date(const void *a_, const void *b_, voi
     
      ## hook.c ##
     @@ hook.c: static int notify_hook_finished(int result,
    + 				void *pp_task_cb)
    + {
    + 	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct run_hooks_opt *opt = hook_cb->options;
      
      	hook_cb->rc |= result;
      
    -+	if (hook_cb->invoked_hook)
    -+		*hook_cb->invoked_hook = 1;
    ++	if (opt->invoked_hook)
    ++		*opt->invoked_hook = 1;
     +
      	return 0;
      }
      
    -@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    - 		.rc = 0,
    - 		.hook_name = hook_name,
    - 		.options = options,
    -+		.invoked_hook = options->invoked_hook,
    - 	};
    - 	int jobs = 1;
    +@@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
    + 	if (!options)
    + 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    + 
    ++	if (options->invoked_hook)
    ++		*options->invoked_hook = 0;
    ++
    + 	if (!hook_path && !options->error_if_missing)
    + 		goto cleanup;
      
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    - 	 * for an example.
    + 	 * translates to "struct child_process"'s "dir" member.
      	 */
    - 	consume_sideband_fn consume_sideband;
    + 	const char *dir;
     +
    -+	/*
    ++	/**
     +	 * A pointer which if provided will be set to 1 or 0 depending
     +	 * on if a hook was invoked (i.e. existed), regardless of
     +	 * whether or not that was successful. Used for avoiding
    @@ hook.h: struct run_hooks_opt
      };
      
      #define RUN_HOOKS_OPT_INIT { \
    -@@ hook.h: struct hook_cb_data {
    - 	const char *hook_name;
    - 	struct hook *run_me;
    - 	struct run_hooks_opt *options;
    -+	int *invoked_hook;
    - };
    - 
    - /**
     
      ## sequencer.c ##
     @@ sequencer.c: static int run_prepare_commit_msg_hook(struct repository *r,
-- 
2.35.1.1031.g277d4562d2e

