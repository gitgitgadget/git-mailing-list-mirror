Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69DC433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhKYW5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhKYWzl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:55:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B8C061574
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso9399601wmr.4
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlav0F9cohPAbBZ6paDFtzJpI+RP75eV2u6oDZ8ImEg=;
        b=PvoHVtVPDaPWcyI4HIcUSEcpa31mByl9m+QuCl7v8pgAK/K66Ad18qoW7IeBkyjLhf
         hhVbLx1oySYPh9G/Geot32yViT+RPnV67wPjxTFVn5XnMY0E0K4JYzYzLjyzsigb93d5
         7A9bMoI2sU0+1hREmAUPpP1muo9MF+M6cAa4j2kJZcAjDwGYGkUZmDb2kBuL/98F2JFi
         pRhyNAttSWB/47Y8xLFe7fu3FPbY7RXvVcg6hNMriERBIVAE40LPdl7sEW78lP8oFTx7
         lPiNRXL3oQUmbrcvIC+HPSZxq1MiWK0Mw49ugv69UGWscabrr7eXMJqy6JcQinv0+dEK
         b48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlav0F9cohPAbBZ6paDFtzJpI+RP75eV2u6oDZ8ImEg=;
        b=q1pYU/g2ygafrSXfXJRdTm0b7YCuERgpi820g9+JyrRFObXOOS4+kCnNwIa/zUMm0A
         5wtzcyMtfEPDAOsrueDFg2xUbmAiJibe3LrlDQg5c+mUE/F3ISmWJM5OsU0+mFmH+9fk
         /RYvSh1wzxg0fbgQSF6yRWHJnsr3HBUE+/055gNnw8fq3cgwa7TRa8cBP9BDm/TN2GAt
         fxGUXZftDktVK/9guZFtJW7Jxz+RIl/5AGAncRzPvNIKbPJyz0K08rfnlRramb6j0juq
         fmuZj1ndQWvXv7zclx2TuM6WgS3cm7TwyAFK3bP1jnvpTxJx5wbi6G9zRKy9HQ62sxNS
         tiTw==
X-Gm-Message-State: AOAM530MEpxi7sUyh6bg8OQIGT//iEuqMC9E3k6/7YFfCNpLp72THxQg
        FQD5L7m1kzjcbhKiq15bw536f5Fmk6Vamw==
X-Google-Smtp-Source: ABdhPJz6nt5xJ0F8FFAPY5hf2Tvw0g+QGet7eYxtLylx0cT/14wuV2AghY961g89o+kcPethWv+dCQ==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr11662040wml.135.1637880747618;
        Thu, 25 Nov 2021 14:52:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] run-command API: get rid of "argv" and "env"
Date:   Thu, 25 Nov 2021 23:52:15 +0100
Message-Id: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See v2[1] for the overall summary of this topic.

New since v2:

 * Ejected my old 1/9 in favor of Eric Sunshine's version at
   [2]. Thanks a lot Eric. And this time I ran the full tests for
   every commit with "rebase -x", so it all passes now.

 * Minor typo correction, also pointed out by Eric.

1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com/
2. https://lore.kernel.org/git/YZ3RUkGpixYAREcI@flurp.local/

Eric Sunshine (1):
  worktree: stop being overly intimate with run_command() internals

Ævar Arnfjörð Bjarmason (8):
  upload-archive: use regular "struct child_process" pattern
  run-command API users: use strvec_pushv(), not argv assignment
  run-command tests: use strvec_pushv(), not argv assignment
  run-command API users: use strvec_pushl(), not argv construction
  run-command API users: use strvec_push(), not argv construction
  run-command API: remove "argv" member, always use "args"
  difftool: use "env_array" to simplify memory management
  run-command API: remove "env" member, always use "env_array"

 add-patch.c                 |  4 +-
 archive-tar.c               |  9 ++---
 builtin/add.c               |  7 +---
 builtin/difftool.c          | 14 ++-----
 builtin/fsck.c              | 12 ++----
 builtin/help.c              |  3 +-
 builtin/merge.c             |  3 +-
 builtin/notes.c             |  5 +--
 builtin/receive-pack.c      | 80 ++++++++++++++-----------------------
 builtin/replace.c           |  3 +-
 builtin/upload-archive.c    |  5 ++-
 builtin/worktree.c          | 13 +++---
 connected.c                 |  3 +-
 daemon.c                    | 20 ++++------
 diff.c                      |  8 +---
 editor.c                    |  8 ++--
 http-backend.c              |  2 +-
 http.c                      |  5 ++-
 object-file.c               |  2 +-
 prompt.c                    |  7 +---
 remote-curl.c               |  2 +-
 run-command.c               | 62 +++++++++++++---------------
 run-command.h               | 54 ++++++++++++-------------
 sequencer.c                 | 10 ++---
 sub-process.c               |  2 +-
 t/helper/test-run-command.c |  9 +++--
 t/helper/test-subprocess.c  |  2 +-
 trace2/tr2_tgt_event.c      |  2 +-
 trace2/tr2_tgt_normal.c     |  2 +-
 trace2/tr2_tgt_perf.c       |  4 +-
 trailer.c                   |  2 +-
 transport.c                 | 11 +++--
 upload-pack.c               |  5 +--
 33 files changed, 157 insertions(+), 223 deletions(-)

Range-diff against v2:
 1:  9cc220ce5a3 !  1:  1c3f9de33ad worktree: remove redundant NULL-ing of "cp.argv
    @@
      ## Metadata ##
    -Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +Author: Eric Sunshine <sunshine@sunshineco.com>
     
      ## Commit message ##
    -    worktree: remove redundant NULL-ing of "cp.argv
    +    worktree: stop being overly intimate with run_command() internals
     
    -    The clearing of "argv" was added in 7f44e3d1de0 (worktree: make setup
    -    of new HEAD distinct from worktree population, 2015-07-17) when the
    -    "cp" variable wasn't initialized. It hasn't been needed since
    -    542aa25d974 (use CHILD_PROCESS_INIT to initialize automatic variables,
    -    2016-08-05).
    +    add_worktree() reuses a `child_process` for three run_command()
    +    invocations, but to do so, it has overly-intimate knowledge of
    +    run-command.c internals. In particular, it knows that it must reset
    +    child_process::argv to NULL for each subsequent invocation[*] in order
    +    for start_command() to latch the newly-populated child_process::args for
    +    each invocation, even though this behavior is not a part of the
    +    documented API. Beyond having overly-intimate knowledge of run-command.c
    +    internals, the reuse of one `child_process` for three run_command()
    +    invocations smells like an unnecessary micro-optimization. Therefore,
    +    stop sharing one `child_process` and instead use a new one for each
    +    run_command() call.
     
    -    Let's remove it to make a later change that gets rid of the "argv"
    -    member from "struct child_process" smaller.
    +    [*] If child_process::argv is not reset to NULL, then subsequent
    +    run_command() invocations will instead incorrectly access a dangling
    +    pointer to freed memory which had been allocated by child_process::args
    +    on the previous run. This is due to the following code in
    +    start_command():
     
    +        if (!cmd->argv)
    +            cmd->argv = cmd->args.v;
    +
    +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/worktree.c ##
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      
      	if (opts->checkout) {
     -		cp.argv = NULL;
    - 		strvec_clear(&cp.args);
    +-		strvec_clear(&cp.args);
    ++		struct child_process cp = CHILD_PROCESS_INIT;
    ++		cp.git_cmd = 1;
      		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
      		if (opts->quiet)
    + 			strvec_push(&cp.args, "--quiet");
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    + 		const char *hook = find_hook("post-checkout");
    + 		if (hook) {
    + 			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
    +-			cp.git_cmd = 0;
    ++			struct child_process cp = CHILD_PROCESS_INIT;
    + 			cp.no_stdin = 1;
      			cp.stdout_to_stderr = 1;
      			cp.dir = path;
      			cp.env = env;
 2:  bfa65e5afd7 =  2:  d3a418b3809 upload-archive: use regular "struct child_process" pattern
 3:  61e4eb8e173 =  3:  595ff9a775d run-command API users: use strvec_pushv(), not argv assignment
 4:  a2ee10e214c !  4:  764c9b813fb run-command tests: use strvec_pushv(), not argv assignment
    @@ Commit message
         run-command tests: use strvec_pushv(), not argv assignment
     
         As in the preceding commit change this API user to use strvec_pushv()
    -    instead of assigning to the "argv" member directly. This leaves is
    +    instead of assigning to the "argv" member directly. This leaves us
         without test coverage of how the "argv" assignment in this API works,
         but we'll be removing it in a subsequent commit.
     
 5:  2b446606eb9 =  5:  45803236764 run-command API users: use strvec_pushl(), not argv construction
 6:  fad420dc563 =  6:  7bdf963ed04 run-command API users: use strvec_push(), not argv construction
 7:  67ab5114ed7 =  7:  275535a447e run-command API: remove "argv" member, always use "args"
 8:  b8387a4a76d =  8:  203f44a91f4 difftool: use "env_array" to simplify memory management
 9:  6bd9f508a3d !  9:  4e4db79ea53 run-command API: remove "env" member, always use "env_array"
    @@ editor.c
     +#include "strvec.h"
      #include "run-command.h"
      #include "sigchain.h"
    - #include "compat/terminal.h"
    + 
     @@ editor.c: static int launch_specified_editor(const char *editor, const char *path,
      		strbuf_realpath(&realpath, path, 1);
      
    @@ editor.c: static int launch_specified_editor(const char *editor, const char *pat
     +			strvec_pushv(&p.env_array, (const char **)env);
      		p.use_shell = 1;
      		p.trace2_child_class = "editor";
    - 		term_fail = save_term(1);
    + 		if (start_command(&p) < 0) {
     
      ## object-file.c ##
     @@ object-file.c: static void fill_alternate_refs_command(struct child_process *cmd,
-- 
2.34.1.838.g779e9098efb

