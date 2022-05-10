Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D2C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 00:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiEJANK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 20:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiEJANJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 20:13:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676722A89D
        for <git@vger.kernel.org>; Mon,  9 May 2022 17:09:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86F9D136587;
        Mon,  9 May 2022 20:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5RiWIDFN835zrumsow927x9kOAY1pMg+UXEhu3
        LXwOA=; b=YzYyas35wwQ3xZEEAaQOTPKm0A6j81Y9JQTh5ZLZ763ujvHm3KeePI
        2offEnYC04HwdeTIgpr67rLC5KedxRP64WbdmkiDyobkKeGIdh4t3nFXUNyQgfDe
        Qg9q1hHwCRMZLYfVi1DrvLO2pv8PtDQdn8l1c8X1FHZvbxdt7aoAk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F4A2136586;
        Mon,  9 May 2022 20:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6B1F136585;
        Mon,  9 May 2022 20:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
Date:   Mon, 09 May 2022 17:09:09 -0700
In-Reply-To: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 09 May 2022 23:27:34 +0000")
Message-ID: <xmqqpmkm9rkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AEEA6EC-CFF5-11EC-976F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This patch fixes the original bug, but not in the 'obvious' way of
>     teaching "git pull" to parse fetch.recurseSubmodules. Instead, "git
>     pull" now propagates its value of "--recurse-submodules" to "git fetch"
>     (ignoring any config values), and leaves the config parsing to "git
>     fetch".

OK.  So the sub-git that is run in submodules will always see a
command line option, and what its configuration file says does not
matter?

>     I think this works better because we get a nice separation of "config
>     that git pull cares about" and "config that its subprocess care about",
>     and as a result:
>     
>      * We don't maintain two identical config-parsing implementations in
>        "git pull" and "git fetch".
>      * It works better with other commands invoked by "git pull" e.g. "git
>        merge" won't accidentally respect fetch.recurseSubmodules.
>     
>     PS I'm having a hard time writing today, let me know how the commit
>     message/cover letter can be improved :)

OK.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 4d667abc19d..01155ba67b2 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -72,6 +72,7 @@ static const char * const pull_usage[] = {
>  static int opt_verbosity;
>  static char *opt_progress;
>  static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;

This ...

>  /* Options passed to git-merge or git-rebase */
>  static enum rebase_type opt_rebase = -1;
> @@ -120,7 +121,7 @@ static struct option pull_options[] = {
>  		N_("force progress reporting"),
>  		PARSE_OPT_NOARG),
>  	OPT_CALLBACK_F(0, "recurse-submodules",
> -		   &recurse_submodules, N_("on-demand"),
> +		   &recurse_submodules_cli, N_("on-demand"),
>  		   N_("control for recursive fetching of submodules"),
>  		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),

... is where we keep track of what value we got from the command
line.  OK.

> @@ -536,8 +537,8 @@ static int run_fetch(const char *repo, const char **refspecs)
>  		strvec_push(&args, opt_tags);
>  	if (opt_prune)
>  		strvec_push(&args, opt_prune);
> -	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> -		switch (recurse_submodules) {
> +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)

The fact that the variable is different from _DEFAULT is a sure sign
that we got something from the command line, because there is no way
for the command line option to set the variable to _DEFAULT (in
other words, _DEFAULT is not really a default, it is a sign that it
is not yet set to any value).  OK.

> +		switch (recurse_submodules_cli) {
>  		case RECURSE_SUBMODULES_ON:
>  			strvec_push(&args, "--recurse-submodules=on");
>  			break;

OK, so the net effect is that we only strvec_push() a command line
option to underlying "fetch" when we got a command line option.  It
does not matter what "recurse_submodules" variable is set to.  The
variable can be set via the configuration mechanism.  _cli one is
different.

OK.  And they underying "git fetch" will read its configuration as
needed anyway (if we do not do these strvec_push() here).

Sounds very sensible.  FWIW, despite what you said earlier, I find
this "if we have command line override, pass it down, otherwise they
know how to read and interpret configuration on their own" a very
sensible and intuitive approach.

Very nicely done.

> @@ -1001,6 +1002,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
>  
> +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
> +		recurse_submodules = recurse_submodules_cli;

This is a small fallout from the separation of the variables.
Again, _DEFAULT is not "the default behaviour whatever it is", but
is a signal "This was not set at all", and that makes this addition
correct.  At some point, we may want to rename the _DEFAULT to
_UNSPECIFIED or something for readability, but it does not have to
be a part of this fix.

> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index fa6b4cca65c..65aaa7927fb 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -107,6 +107,20 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
>  	test_path_is_file super/sub/merge_strategy_4.t
>  '
>  
> +test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
> +	test_commit -C child merge_strategy_5 &&
> +	git -C parent submodule update --remote &&
> +	git -C parent add sub &&
> +	git -C parent commit -m "update submodule" &&
> +
> +	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
> +	# Check that the submodule commit was fetched
> +	sub_oid=$(git -C super rev-parse FETCH_HEAD:sub) &&
> +	git -C super/sub cat-file -e $sub_oid &&
> +	# Check that the submodule worktree did not update
> +	! test_path_is_file super/sub/merge_strategy_5.t
> +'
> +
>  test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
>  	# This tests the following scenario :
>  	# - local submodule has new commits
>
> base-commit: e8005e4871f130c4e402ddca2032c111252f070a

Thanks, will queue.
