Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD23A201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbdEKUAO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:00:14 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:60073 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbdEKUAN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:00:13 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 8uFudTsD1cpsk8uFudrFI2; Thu, 11 May 2017 21:00:11 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=CTBh9u9lPQxTe5zfA-gA:9 a=wPNLvfGTeEIA:10
Message-ID: <702FD1AB212642BA80B1ADF27D75916B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Brandon Williams" <bmwill@google.com>, <git@vger.kernel.org>
Cc:     <sbeller@google.com>, "Brandon Williams" <bmwill@google.com>
References: <20170511172437.96878-1-bmwill@google.com>
Subject: Re: [PATCH] pull: optionally rebase submodules
Date:   Thu, 11 May 2017 21:00:09 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKNVa5u+5/9+mspb/oWkGKlbwYqDdxyMj/9UqVtGj4Mk1O6Gyrs8GPE/IwajhOcsHthizekxHgyrqSHtZw6Pztp4dV5AN3CtIxrl0rysDTcVieTMXzwZ
 n17f/KLHdwQy35xvsmIt72E68yxIcQfJUPRPbHU8NGEpa44FR2Nbu/lAshakDd9q2NIw6kSlIfrYqua+/5IWXAJsIMKzVT5n7bui8HQas6MJ2nA45HrwAy+7
 LVQFIvgfFxkkPZB1A2dq3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Brandon Williams" <bmwill@google.com>
> Teach pull to optionally update submodules when '--recurse-submodules'
> is provided.  This will teach pull to run 'submodule update --rebase'
> when the '--recurse-submodules' and '--rebase' flags are given.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> Pull is already a shortcut for running fetch followed by a merge/rebase, 
> so why
> not have it be a shortcut for running 'submodule update --rebase' when the
> recurse flag is given!
>
> builtin/pull.c            | 30 ++++++++++++++-
> t/t5572-pull-submodule.sh | 97 
> +++++++++++++++++++++++++++++++++++++++++++++++

Shouldn't this also touch the documentation to say that this has been 
taught?
--
Philip


> 2 files changed, 125 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index dd1a4a94e..d73d654e6 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -77,6 +77,7 @@ static const char * const pull_usage[] = {
> /* Shared options */
> static int opt_verbosity;
> static char *opt_progress;
> +static int recurse_submodules;
>
> /* Options passed to git-merge or git-rebase */
> static enum rebase_type opt_rebase = -1;
> @@ -532,6 +533,17 @@ static int pull_into_void(const struct object_id 
> *merge_head,
>  return 0;
> }
>
> +static int  update_submodules(void)
> +{
> + struct child_process cp = CHILD_PROCESS_INIT;
> + cp.git_cmd = 1;
> +
> + argv_array_pushl(&cp.args, "submodule", "update", "--recursive", NULL);
> + argv_array_push(&cp.args, "--rebase");
> +
> + return run_command(&cp);
> +}
> +
> /**
>  * Runs git-merge, returning its exit status.
>  */
> @@ -816,6 +828,14 @@ int cmd_pull(int argc, const char **argv, const char 
> *prefix)
>  oidclr(&rebase_fork_point);
>  }
>
> + if (opt_recurse_submodules &&
> +     !strcmp(opt_recurse_submodules, "--recurse-submodules")) {
> + recurse_submodules = 1;
> +
> + if (!opt_rebase)
> + die(_("--recurse-submodules is only valid with --rebase"));
> + }
> +
>  if (run_fetch(repo, refspecs))
>  return 1;
>
> @@ -862,6 +882,7 @@ int cmd_pull(int argc, const char **argv, const char 
> *prefix)
>  die(_("Cannot rebase onto multiple branches."));
>
>  if (opt_rebase) {
> + int ret = 0;
>  struct commit_list *list = NULL;
>  struct commit *merge_head, *head;
>
> @@ -871,9 +892,14 @@ int cmd_pull(int argc, const char **argv, const char 
> *prefix)
>  if (is_descendant_of(merge_head, list)) {
>  /* we can fast-forward this without invoking rebase */
>  opt_ff = "--ff-only";
> - return run_merge();
> + ret = run_merge();
>  }
> - return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> + ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> +
> + if (!ret && recurse_submodules)
> + ret = update_submodules();
> +
> + return ret;
>  } else {
>  return run_merge();
>  }
> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index accfa5cc0..234a22315 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -42,4 +42,101 @@ 
> KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> test_submodule_switch "git_pull_noff"
>
> +test_expect_success 'pull --recurse-submodule setup' '
> + git init child &&
> + (
> + cd child &&
> + echo "bar" >file &&
> + git add file &&
> + git commit -m "initial commit"
> + ) &&
> + git init parent &&
> + (
> + cd parent &&
> + echo "foo" >file &&
> + git add file &&
> + git commit -m "Initial commit" &&
> + git submodule add ../child sub &&
> + git commit -m "add submodule"
> + ) &&
> + git clone --recurse-submodule parent super &&
> + git -C super/sub checkout master
> +'
> +
> +test_expect_success 'pull recursive fails without --rebase' '
> + test_must_fail git -C super pull --recurse-submodules 2>actual &&
> + test_i18ngrep "recurse-submodules is only valid with --rebase" actual
> +'
> +
> +test_expect_success 'pull basic recurse' '
> + (
> + cd child &&
> + echo "foobar" >>file &&
> + git add file &&
> + git commit -m "update file"
> + ) &&
> + (
> + cd parent &&
> + git -C sub pull &&
> + git add sub &&
> + git commit -m "update submodule"
> + ) &&
> +
> + git -C parent rev-parse master >expect_super &&
> + git -C child rev-parse master >expect_sub &&
> +
> + git -C super pull --rebase --recurse-submodules &&
> + git -C super rev-parse master >actual_super &&
> + git -C super/sub rev-parse master >actual_sub &&
> + test_cmp expect_super actual_super &&
> + test_cmp expect_sub actual_sub
> +'
> +
> +test_expect_success 'pull basic rebase recurse' '
> + (
> + cd child &&
> + echo "a" >file &&
> + git add file &&
> + git commit -m "update file"
> + ) &&
> + (
> + cd parent &&
> + git -C sub pull &&
> + git add sub &&
> + git commit -m "update submodule"
> + ) &&
> + (
> + cd super/sub &&
> + echo "b" >file2 &&
> + git add file2 &&
> + git commit -m "add file2"
> + ) &&
> +
> + git -C parent rev-parse master >expect_super &&
> + git -C child rev-parse master >expect_sub &&
> +
> + git -C super pull --rebase --recurse-submodules &&
> + git -C super rev-parse master >actual_super &&
> + git -C super/sub rev-parse master^ >actual_sub &&
> + test_cmp expect_super actual_super &&
> + test_cmp expect_sub actual_sub &&
> +
> + echo "a" >expect &&
> + test_cmp expect super/sub/file &&
> + echo "b" >expect &&
> + test_cmp expect super/sub/file2
> +'
> +
> +test_expect_success 'pull rebase recursing fails with conflicts' '
> + git -C super/sub reset --hard HEAD^^ &&
> + git -C super reset --hard HEAD^ &&
> + (
> + cd super/sub &&
> + echo "b" >file &&
> + git add file &&
> + git commit -m "update file"
> + ) &&
> + test_must_fail git -C super pull --rebase --recurse-submodules
> +'
> +
> test_done
> -- 
> 2.13.0.rc2.291.g57267f2277-goog
>
> 

