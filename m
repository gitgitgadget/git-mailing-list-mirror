Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8AC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 18:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbhKXS1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:27:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58411 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhKXS1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 13:27:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD77CF9EA0;
        Wed, 24 Nov 2021 13:24:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f+378GxRRQVXgpJlzHlQPvR5z8kvVePMCp6isF
        mxEV0=; b=EQXOcR0koqQXDyQoPCDGXYLEszm+9+O+1/ZlN8q69IiT/XDCjI+/V0
        vu36lhpgxZgEJvgu0rAiVTSYHjkpBy/XcQgDdeQdd5tR0gz78/rxIO2AM9tTZYWw
        z244UAEhUMLByaI2fo71ohQLuoIcwMtfMOPZmORA+B9RKyP6Qoke8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77770F9E9F;
        Wed, 24 Nov 2021 13:24:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 997A7F9E9D;
        Wed, 24 Nov 2021 13:23:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
        <xmqq8rxe787g.fsf@gitster.g>
        <724abbd4-b9ee-3b3d-226c-b7999f138152@gmail.com>
Date:   Wed, 24 Nov 2021 10:23:58 -0800
In-Reply-To: <724abbd4-b9ee-3b3d-226c-b7999f138152@gmail.com> (Lessley
        Dennington's message of "Wed, 24 Nov 2021 06:41:26 -0800")
Message-ID: <xmqqzgpt2z0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1746752-4D53-11EC-91DF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

>>> @@ -1588,8 +1588,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>>>     	git_config(git_checkout_config, opts);
>>>   -	prepare_repo_settings(the_repository);
>>> -	the_repository->settings.command_requires_full_index = 0;
>>> +	if (startup_info->have_repository) {
>>> +		prepare_repo_settings(the_repository);
>>> +		the_repository->settings.command_requires_full_index = 0;
>>> +	}
>> I am kind-a surprised if the control reaches this deep if you are
>> not in a repository.  In git.c::commands[] list, all three primary
>> entry points that call checkout_main(), namely, cmd_checkout(),
>> cmd_restore(), and cmd_switch(), are marked with RUN_SETUP bit,
>> which makes us call setup_git_directory() even before we call the
>> cmd_X() function.  And setup_git_directory() dies with "not a git
>> repository (or any of the parent directories)" outside a repository.
>> So, how can startup_info->have_repository bit be false if the
>> control flow reaches here?  Or am I grossly misunderstanding what
>> you are trying to do?
>> 
> This was in reaction to the t0012-help.sh tests failing with the
> new BUG in prepare_repo_settings. However, Elijah pointed out that
> it's a better idea to move prepare_repo_settings farther down
> (after parse_options) instead. So I will be issuing that change as
> part of v5.

I forgot that "git foo -h" for a builtin command 'foo' calls
run_builtin() but bypasses the RUN_SETUP and NEED_WORK_TREE handling
before it in turn calls cmd_foo().  We expect a call in cmd_foo() to
parse_options() emit a short-help and exit.

So, yes, there is a way to reach this point in the codeflow without
being in a repository (or even when in a repository, we may have
chosen not to realize it).  Feels ugly.

Now a bit of tangent.

I wonder if it is a problem to completely bypass RUN_SETUP in such a
case.  In general, we read the configuration to tweak the hardcoded
default behaviour, and then further override it by parsing command
line options.  In order to read configuration fully, we'd need to
know where the repository is.  So the start-up sequence must be in
this order:

 - discover where the repository is (either gently or with a hard failure)
 - read the configuration files
 - call parse_options()

And by completly bypassing RUN_SETUP, we are not reading per-repo
settings from the configuration files.

Something along this line (note: there is an always-taken if block
to reduce the patch noise for this illustration), perhaps.




 git.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git i/git.c w/git.c
index 5ff21be21f..50e258508e 100644
--- i/git.c
+++ w/git.c
@@ -421,25 +421,30 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	int status, help;
 	struct stat st;
 	const char *prefix;
+	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
 
 	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
-	if (!help) {
-		if (p->option & RUN_SETUP)
+	if (help && (run_setup & RUN_SETUP))
+		/* demote to GENTLY to allow 'git cmd -h' outside repo */
+		run_setup = RUN_SETUP_GENTLY;
+
+	if (1) {
+		if (run_setup & RUN_SETUP)
 			prefix = setup_git_directory();
-		else if (p->option & RUN_SETUP_GENTLY) {
+		else if (run_setup & RUN_SETUP_GENTLY) {
 			int nongit_ok;
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 		precompose_argv_prefix(argc, argv, NULL);
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
+		if (use_pager == -1 && run_setup &&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
 
-		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
-		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
+		if (run_setup && startup_info->have_repository)
+			/* get_git_dir() may set up repo, avoid that */
 			trace_repo_setup(prefix);
 	}
 	commit_pager_choice();
