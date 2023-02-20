Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC509C61DA3
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 22:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjBTWxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 17:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjBTWxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 17:53:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C382129
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 14:53:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p8so2756207wrt.12
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 14:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t32XK3Vo/pZbsdQG9ihgoPMbadsex90uXyzzef2YSts=;
        b=Oh5wJLLZCp9XGLnY25Hviqo9CPBZK/q/BO4zy5PWiXHYap1HAtnSpqrEYA0pQX5GZ/
         wXQo9Q/6b1LCCJMcZ8Jd7cilpVpuXYiXTlDXunieWWSvQxBQncpDiAF008WrSL7gg7LX
         GQaAnSsnyv6wocEFyVRC3IccbD1Q7tnxi0i67yxWmmHNZ3c9zf2QK1kVKfI40NZiFjHI
         kEnfMFlaR4Dpwkpp1bFtikaHR78GaFblVMqica65YL9cBUZjLrhGjOuyuu1AZYmpn0TK
         heh4FKIDiPYOW3YNzXSYHXXG36Kl+xES+rJaqNf45s3LOslZ4a9gZ/JubKAxWIbXBglA
         30mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t32XK3Vo/pZbsdQG9ihgoPMbadsex90uXyzzef2YSts=;
        b=I2FBF1qqtmAiSz9xAD9ncKB1qRcfqHeHXhRGgfJfuy1zaV8/bSXVlPxyp/GPHjr4of
         rdz4z22XukAiCVLvs6yNYhrMTxMG1nln/8I/IbG2Gc6LT+T4Vm8knNgHWI+Vm6LZKAga
         mOsiM04NTg27aLu1P4lRg27e+PLs1CuEhcIKxiOEfbPggAOEBrRa+vE4Hg5BO6AL/Tf7
         SHCuUh4hpUUXRaHLFIcctp6MO3aHMFmHmBbaG64MaPfsmgpRxF3AV2ET8VzK5Zw+4cf0
         WzPvPqTEYSpfdaDDF9HafA52ixvKqSyjNvOIjVvF+Ze/ktbWs/lS159+UxynJTsSmL0W
         6qVQ==
X-Gm-Message-State: AO0yUKWs2BHY6xD2faGESSRlJfvCDVekDTpF5ZOlsZBKR22CrlO9Zahx
        BcRMTTaYlpge7YhQHU88cfeepAPf4YA=
X-Google-Smtp-Source: AK7set8mo3wsvxjFQheso+5RS0ACoQBgWfwLle4ogiZLuwkBGXBreqzQ4DYDuXDWpaC7lCZuIO7G7g==
X-Received: by 2002:a5d:6b4d:0:b0:2c6:67eb:a9d7 with SMTP id x13-20020a5d6b4d000000b002c667eba9d7mr2647935wrw.27.1676933587346;
        Mon, 20 Feb 2023 14:53:07 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id s5-20020adfeb05000000b002c54c0a5aa9sm13634716wrn.74.2023.02.20.14.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 14:53:06 -0800 (PST)
Subject: [PATCH v3] bisect: fix "reset" when branch is checked out elsewhere
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
Message-ID: <6d70ba66-11b1-d596-ab0a-8643d6fc23a4@gmail.com>
Date:   Mon, 20 Feb 2023 23:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user starts a bisection in a worktree, we save the branch
currently checked out in that worktree (BISECT_START) to allow the user
to go back to that branch later on.

From that moment and until the bisection ends, the branch is no longer
checked out in that worktree, but we give it the same consideration as
if it was checked out, which means that we prevent:
 - deleting that branch and
 - checking out that branch in another worktree, unless the user force
   the ckeck out.

"bisect" was introduced as a helper script in 8cc6a08 ([PATCH] Making it
easier to find which change introduced a bug, 2005-07-30), and
originally based its functioning in Git builtin commands.  Although
"bisect" is now itself a builtin command, it still spawns Git
sub-processes to use other builtin commands, like "checkout".

Since 1d0fa89 (checkout: add --ignore-other-worktrees, 2015-01-03) we
have a safety valve in "checkout" and "switch" commands to prevent the
user from normally checking out simultaneously the same branch in
multiple worktrees.

If the user, using "--ignore-other-worktrees", checks out a branch
before or while bisecting that same branch in another worktree, we may
fail when the user ends the bisection using "git bisect reset":

   $ git worktree add work ../work/
   $ git checkout --ignore-other-worktrees work
   $ git -C ../work bisect start HEAD HEAD~3
   ... the user inspects some commits ...
   $ git -C ../work bisect reset
   fatal: 'work' is already checked out at ...
   error: could not check out original HEAD 'work'. Try 'git bisect reset <commit>'.

Thanks to the special consideration we give to the branch while being
bisected, and the safety valve introduced in 1d0fa89, we can assume the
user is aware and responsible of the "multiple checked out branch"
situation.  This makes sensible to allow the user to go back to the
original branch using "git bisect reset" and avoid him a somewhat less
intuitive sequence like: "git bisect reset work~0 && git checkout
--ignore-other-worktree work".

Let's teach "bisect" to use the "--ignore-other-worktrees" when the user
wants to end the bisection.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Changes since v2

 - Reworded the message to be more descriptive.
 - Using "||:" to chain commands in the test_when_finished block,
   suggested by Eric.

This series started because of a bug, being fixed in another series,
allowed "git bisect reset" to work in certain cases where multiple
branches were checked out.  Once the bug is fixed, "git bisect reset"
will no longer work in those scenarios.  Which is not bad, but taking
into account the different scenarios and the fact that some users may
rely on this bug as a feature, I think that the current patch proposes a
sensible and convenient change for the user.

Range-diff against v2:
1:  0fe0bc70dd ! 1:  3b2ac1aa8f bisect: fix "reset" when branch is checked out elsewhere
    @@ Metadata
      ## Commit message ##
         bisect: fix "reset" when branch is checked out elsewhere
     
    -    Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
    -    have a safety valve in checkout/switch to prevent the same branch from
    -    being checked out simultaneously in multiple worktrees.
    +    When the user starts a bisection in a worktree, we save the branch
    +    currently checked out in that worktree (BISECT_START) to allow the user
    +    to go back to that branch later on.
     
    -    If a branch is bisected in a worktree while also being checked out in
    -    another worktree; when the bisection is finished, checking out the
    -    branch back in the current worktree may fail.
    +    From that moment and until the bisection ends, the branch is no longer
    +    checked out in that worktree, but we give it the same consideration as
    +    if it was checked out, which means that we prevent:
    +     - deleting that branch and
    +     - checking out that branch in another worktree, unless the user force
    +       the ckeck out.
     
    -    Let's teach bisect to use the "--ignore-other-worktrees" flag.
    +    "bisect" was introduced as a helper script in 8cc6a08 ([PATCH] Making it
    +    easier to find which change introduced a bug, 2005-07-30), and
    +    originally based its functioning in Git builtin commands.  Although
    +    "bisect" is now itself a builtin command, it still spawns Git
    +    sub-processes to use other builtin commands, like "checkout".
    +
    +    Since 1d0fa89 (checkout: add --ignore-other-worktrees, 2015-01-03) we
    +    have a safety valve in "checkout" and "switch" commands to prevent the
    +    user from normally checking out simultaneously the same branch in
    +    multiple worktrees.
    +
    +    If the user, using "--ignore-other-worktrees", checks out a branch
    +    before or while bisecting that same branch in another worktree, we may
    +    fail when the user ends the bisection using "git bisect reset":
    +
    +       $ git worktree add work ../work/
    +       $ git checkout --ignore-other-worktrees work
    +       $ git -C ../work bisect start HEAD HEAD~3
    +       ... the user inspects some commits ...
    +       $ git -C ../work bisect reset
    +       fatal: 'work' is already checked out at ...
    +       error: could not check out original HEAD 'work'. Try 'git bisect reset <commit>'.
    +
    +    Thanks to the special consideration we give to the branch while being
    +    bisected, and the safety valve introduced in 1d0fa89, we can assume the
    +    user is aware and responsible of the "multiple checked out branch"
    +    situation.  This makes sensible to allow the user to go back to the
    +    original branch using "git bisect reset" and avoid him a somewhat less
    +    intuitive sequence like: "git bisect reset work~0 && git checkout
    +    --ignore-other-worktree work".
    +
    +    Let's teach "bisect" to use the "--ignore-other-worktrees" when the user
    +    wants to end the bisection.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
    @@ builtin/bisect.c: static int bisect_reset(const char *commit)
     -		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
     +		strvec_pushl(&cmd.args, "checkout", NULL);
     +		if (!commit)
    -+			strvec_pushl(&cmd.args, "--ignore-other-worktrees", NULL);
    ++			strvec_pushl(&cmd.args, "--ignore-other-worktrees",
    ++				     NULL);
     +		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
      		if (run_command(&cmd)) {
      			error(_("could not check out original"
    @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect start without -- takes
     +		cmp branch.expect branch.output
     +	} &&
     +	test_when_finished "
    -+		git worktree remove wt1 &&
    -+		git worktree remove wt2 &&
    -+		git branch -d shared
    ++		git worktree remove wt1 ||:
    ++		git worktree remove wt2 ||:
    ++		git branch -d shared ||:
     +	" &&
     +	git worktree add wt1 -b shared &&
     +	git worktree add wt2 -f shared &&

 builtin/bisect.c            |  6 +++++-
 t/t6030-bisect-porcelain.sh | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 7301740267..011f674b08 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -244,7 +244,11 @@ static int bisect_reset(const char *commit)
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
+		strvec_pushl(&cmd.args, "checkout", NULL);
+		if (!commit)
+			strvec_pushl(&cmd.args, "--ignore-other-worktrees",
+				     NULL);
+		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
 		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3ba4fdf615..1d047f1c1a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -122,6 +122,29 @@ test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
 	grep bar ".git/BISECT_NAMES"
 '
 
+test_expect_success 'bisect reset: back in a branch checked out also elsewhere' '
+	echo "shared" > branch.expect &&
+	test_bisect_reset() {
+		git -C $1 bisect start &&
+		git -C $1 bisect good $HASH1 &&
+		git -C $1 bisect bad $HASH3 &&
+		git -C $1 bisect reset &&
+		git -C $1 branch --show-current > branch.output &&
+		cmp branch.expect branch.output
+	} &&
+	test_when_finished "
+		git worktree remove wt1 ||:
+		git worktree remove wt2 ||:
+		git branch -d shared ||:
+	" &&
+	git worktree add wt1 -b shared &&
+	git worktree add wt2 -f shared &&
+	# we test in both worktrees to ensure that works
+	# as expected with "first" and "next" worktrees
+	test_bisect_reset wt1 &&
+	test_bisect_reset wt2
+'
+
 test_expect_success 'bisect reset: back in the main branch' '
 	git bisect reset &&
 	echo "* main" > branch.expect &&
-- 
2.34.1
