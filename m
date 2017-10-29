Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A64202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 18:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdJ2Sef (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 14:34:35 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:58341 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdJ2See (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 14:34:34 -0400
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id 8sPmePZZXlmqO8sPneHiuP; Sun, 29 Oct 2017 18:34:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509302071; bh=eTWl35vtV0JVVJOXCDJ041/qvqaJjRyhfnCSmhzYEhY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m2l2Q3UBwuJX7g4gaFnKXVGOgJ5+6hyAsAczvUIf4QZqc3reXejhOkm1/VAoznNTG
         rvnIcgY7aaIGNGY22AyuSccYSAU0K57R58yY/nQjPYMVAYx7mk1i29D03XvsEtOLmM
         OcGBQUeQLIZNwaEmWO3JeFB1l/KpCDhqICQCUkC0=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=AAE7Xxt5GYeag_mNVSQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
 <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
Date:   Sun, 29 Oct 2017 18:34:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLsM5s1ZLwUAfEscBzVFC2x1nALoNC1j3Geq3r4FeJ5kqsA8Vj2qM3lKzRq9q9MVM7BqJgw2u5yhShi9D9/ltDSY3MDbKJmnMRQ3zU5zWHrR8tw0LXaz
 1/NYntB4C/zJQFySbgCUEl9G7QJ+O/DpKYw7NNbDhK13UB0jDWKyrc9XCmDUiGEhlJW6NOq62ecbvDDKSWyf/aUloWFUclX4Xtb9FbHDoA+iMk4LzVGjIZAe
 xez1crrirYj1UxhJlCEjvYKhHAoDuP78O1Q+MOpu+wg14rpXjtFVoF/XGPzqvaXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/17 17:00, Johannes Schindelin wrote:
> 
> Hi Jake,
> 
> On Fri, 27 Oct 2017, Jacob Keller wrote:
> 
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> I noticed a failure with git rebase interactive mode which causes "exec"
>> commands to be run with GIT_DIR set. When GIT_DIR is in the environment,
>> then any command which results in running a git command in
>> a subdirectory will fail because GIT_DIR=".git".
>>
>> This unfortunately breaks one of my project's Makefiles, which uses
>> git-describe to find the version information, but does so from within
>> a sub directory.
>>
>> I'm in the process of running a bisect to find where this got
>> introduced, but I suspect it's part of the rebase--helper changes that
>> happened a while ago.
> 
> A safe assumption. I do not know how the shell code managed that GIT_DIR
> reset, though:
> 
> -- snip from v2.12.0's git-rebase--interactive.sh --
>         x|"exec")
>                 read -r command rest < "$todo"
>                 mark_action_done
>                 eval_gettextln "Executing: \$rest"
>                 "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
> -- snap --
> 
> Maybe you can spot it?
> 
> The fix should be as easy as
> 
> -- snip --
> diff --git a/sequencer.c b/sequencer.c
> index f2c84c2fa62..018ba8d27e2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1859,11 +1859,13 @@ static int error_failed_squash(struct commit *commit,
>  static int do_exec(const char *command_line)
>  {
>  	const char *child_argv[] = { NULL, NULL };
> +	const char *child_env[] = { "GIT_DIR", NULL };
>  	int dirty, status;
>  
>  	fprintf(stderr, "Executing: %s\n", command_line);
>  	child_argv[0] = command_line;
> -	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
> +	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
> +					  child_env);
>  
>  	/* force re-reading of the cache */
>  	if (discard_cache() < 0 || read_cache() < 0)
> -- snap --

Just clearing GIT_DIR does not match the behavior of the shell version
(tested by passing -p to avoid rebase--helper) as that passes GIT_DIR to
exec commands if it has been explicitly set. I think that users that set
GIT_DIR on the command line would expect it to be propagated to exec
commands.

$ git rebase -px'echo $GIT_DIR' @

                                                            Merge commit
'7c2f1abd64' into phil
Executing: echo $GIT_DIR

Successfully rebased and updated refs/heads/phil.

$ env GIT_DIR=.git git rebase -px'echo $GIT_DIR' @

                                                            Merge commit
'7c2f1abd64' into phil
Executing: echo $GIT_DIR
/home/phil/Documents/src/git/.git/worktrees/git-next
Successfully rebased and updated refs/heads/phil.

> *However*, your test still fails with this, as
> 
> - your added test tries to remove the directory with -ff instead of -rf
> 
> - it tries to run `git rebase --abort` afterwards, which fails with my fix
>   because there is no rebase in progress
> 
> - instead of `cd subdir && ...`, it calls `>cd subdir && ...`, which
>   causes it to abort with a "subdir: not fonud"
> 
> So I need this, too, to make it all work:
> 
> -- snip --
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 60ab5136f70..967caab222a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -108,13 +108,13 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
>  	rm -fr subdir
>  '
>  
> -test_expect_failure 'rebase -i with the exec git commands in subdirs still work' '
> -	test_when_finished "rm -ff subdir" &&
> -	test_when_finished "git rebase --abort" &&
> +test_expect_success 'rebase -i with the exec git commands in subdirs still work' '
> +	test_when_finished "rm -rf subdir" &&
> +	test_when_finished "git rebase --abort || :" &&
>  	git checkout master &&
>  	mkdir subdir && (cd subdir &&
>  	set_fake_editor &&
> -	FAKE_LINES="1 exec_>cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
> +	FAKE_LINES="1 exec_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
>  		git rebase -i HEAD^
>  	)
>  '
> -- snap --
> 
> I only had time to write these two patches, and to verify that t3404
> passes now, but not that anything else passes, neither to write a proper
> commit message.
> 
> Maybe you can take it from there?
> 
> Ciao,
> Dscho
> 

