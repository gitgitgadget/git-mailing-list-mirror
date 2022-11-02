Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F795C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKBTpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 15:45:22 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566812BDE
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 12:45:20 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8CDF1CA1249;
        Wed,  2 Nov 2022 15:45:19 -0400 (EDT)
Received: from [10.0.0.26] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 573D5CC83D0;
        Wed,  2 Nov 2022 15:45:19 -0400 (EDT)
Message-ID: <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
Date:   Wed, 2 Nov 2022 15:45:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2] status: long status advice adapted to recent
 capabilities
Content-Language: en-US
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Rudy Rigot <rudy.rigot@gmail.com>
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/28/22 8:06 PM, Rudy Rigot via GitGitGadget wrote:
> From: Rudy Rigot <rudy.rigot@gmail.com>
> 
> Currently, if git-status takes more than 2 seconds for enumerating untracked
> files, a piece of advice is given to the user to consider ignoring untracked
> files. But Git now offers more possibilities to resolve that situation
> (untracked cache, fsmonitor) with different downsides.
> 
> This change is about refreshing that advice message. A new section in the
> documentation is introduced to present the possibilities, and the advice
> message links to it. I'm also introducing tests for this advice message,
> which was untested so far.
> 
> One of the downsides of untracked cache / fsmonitor, is that the first call
> may be long in order to generate the cache, but the user may not know what
> their current configuration is. When collecting feedback from users of our
> very large repo, that's the most common point of confusion that keeps coming
> back: people complain about git status being slow, but are satisfied when
> we inform them that it's being cached and they should run it again to check.
> As a result, the advice message tries to keep them informed of their current
> configuration.

Let me suggest an alternative commit message.  We want to lead with a
"command" -- as in: "make Git do this" or "teach Git to do this".  Then
explain why.  Maybe something like:

     Improve the advice displayed when `git status` is slow because
     of excessive numbers of untracked files.  Update the `git status`
     man page to explain the various configuration options.

     `git status` can be slow when there are a large number of untracked
     files and directories, because Git must search the entire worktree
     to enumerate them.  Previously, Git would print an advice message
     with the elapsed search time and a suggestion to disable the search
     using the `-uno` option.  This suggestion also carried a warning
     that might scare off some users.

     Git can reduce the size and time of the untracked file search when
     the `core.untrackedCache` and `core.fsmonitor` features are enabled
     by caching results from previous `git status` invocations.

     Update the advice to explain the various combinations of additional
     configuration options and refer to (new) documentation in the man
     page that explains it in more detail than what can be printed in an
     advice message.

     Finally, add new tests to verify the new functionality.

Or something like that. :-)


[...]
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 54a4b29b473..3d92e5fd018 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -457,6 +457,33 @@ during the write may conflict with other simultaneous processes, causing
>   them to fail. Scripts running `status` in the background should consider
>   using `git --no-optional-locks status` (see linkgit:git[1] for details).
>   
> +UNTRACKED FILES AND STATUS SPEED
> +--------------------------------
> +
> +If your untracked files take an unusual amount of time to enumerate, your
> +repository certainly has a lot of them, and an advice message will display
> +about it. Here are some configurations to consider in order to improve the
> +situation:
> +
> +* Setting the `core.untrackedCache` configuration as `true` will allow for
> +`git status` to keep track of the mtime of folders, in order to cache past
> +`status` results and be sure to only browse folders that changed on subsequent
> +runs, for filesystems that can support it (see linkgit:git-update-index[1]
> +for details).
> +* Used in conjonction with `core.untrackedCache`, setting the `core.fsmonitor`
> +configuration as `true` will allow for `git status` to keep track of what
> +files recently changed, in order to cache past `status` results and be sure
> +to only focus on those files on subsequent runs (see linkgit:git-update-index[1]
> +for details).
> +* If none of the above options are satisfactory, setting the
> +`status.showUntrackedFiles` configuration as `no` will cause `git status`
> +to not attempt to list untracked files anymore, in which case you have to be
> +careful not to forget to add new files yourself.
> +
> +If none of the above solutions are satisfactory, and you are bothered with
> +the advice message, you can disable it by setting the `advice.statusUoption`
> +configuration to `false`.
> +

I hate to suggest a complete rewrite as I myself struggle with
how to phrase things all toooooo often, but let me offer another
starting point and see what you think:

     `git status` can be very slow in large worktrees if/when it
     needs to search for untracked files and directories.  There are
     many configuration options available to speed this up by either
     avoiding the work or making use of cached results from previous
     Git commands.  Since we all work in different ways, there is no
     single optimum set of settings right for everyone.  Here is a
     brief summary of the relevant options to help you choose which
     is right for you.  Each of these settings is independently
     documented elsewhere in more detail, so please refer to them
     for complete details.

     * `-uno` or `status.showUntrackedFiles=false` : just don't search
         and don't report on untracked files.  This is the fastest.
         `git status` will not list the untracked files, so you need
         to be careful to remember if you create any new files and
         manually `git add` them.

     * `advice.statusUoption=false` : search, but don't complain if it
         takes too long.

     * `core.untrackedCache=true` : enable the untracked cache feature
         and only search directories that have been modified since the
         previous `git status` command.  Git remembers the set of
         untracked files within each directory and assumes that if a
         directory has not been modified, then the set of untracked
         file within has not changed.  This is much faster than
         enumerating the contents of every directory, but still not
         without cost, because Git still has to search for the set of
         modified directories.

     * `core.untrackedCache=true` and `core.fsmonitor=true` or
         `core.fsmonitor=<hook_command_pathname>` : enable both the
         untracked cache and FSMonitor features and only search
         directories that have been modified since the previous
         `git status` command.  This is faster than using just the
         untracked cache alone because Git can also avoid searching
         for modified directories.  Git only has to enumerate the
         exact set of directories that have changed recently.

     Note that after you turn on the untracked cache and/or FSMonitor
     features it may take a few `git status` commands for the various
     caches to warm up before you see improved command times.  This is
     normal.

Something like that.  Hope this helps.  (And again, sorry for the
rewrite.)


[...]
> diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
> new file mode 100755
> index 00000000000..92c053eaa64
> --- /dev/null
> +++ b/t/t7065-wtstatus-slow.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
[...]
> +
> +test_done
> \ No newline at end of file

small nit: we should have a final LF at the end of the file.

I'm going to skip over the test cases because I'm running
short on time this afternoon.


[...]
> diff --git a/wt-status.c b/wt-status.c
[...]
>   static void show_merge_in_progress(struct wt_status *s,
>   				   const char *color)
>   {
> @@ -1814,6 +1827,7 @@ static void wt_longstatus_print(struct wt_status *s)
>   {
>   	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
>   	const char *branch_status_color = color(WT_STATUS_HEADER, s);
> +	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
>   
>   	if (s->branch) {
>   		const char *on_what = _("On branch ");
> @@ -1870,13 +1884,25 @@ static void wt_longstatus_print(struct wt_status *s)
>   		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
>   		if (s->show_ignored_mode)
>   			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
> -		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> -			status_printf_ln(s, GIT_COLOR_NORMAL,
> -					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
> -					   "may speed it up, but you have to be careful not to forget to add\n"
> -					   "new files yourself (see 'git help status')."),
> -					 s->untracked_in_ms / 1000.0);
> +		if (uf_was_slow(s->untracked_in_ms)) {
> +			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
> +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +				if (s->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE) {
> +					status_printf_ln(s, GIT_COLOR_NORMAL,
> +							_("It took %.2f seconds to enumerate untracked files,\n"
> +							"but this is currently being cached, with fsmonitor %s."),
> +							s->untracked_in_ms / 1000.0,
> +							(fsm_mode > FSMONITOR_MODE_DISABLED) ? "ON" : "OFF");
> +				} else {
> +					status_printf_ln(s, GIT_COLOR_NORMAL,
> +							_("It took %.2f seconds to enumerate untracked files."),
> +							s->untracked_in_ms / 1000.0);
> +				}
> +				status_printf_ln(s, GIT_COLOR_NORMAL,
> +						_("See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed\n"
> +						"for configuration options that may improve that time."));
> +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +			}

I'm not sure I like the various mixture of messages here.  Maybe
it would be better with a single simple message:

     _("It took %.2f seconds to enumerate untracked files.\n"
       "See 'git help status' for information on how to improve this.")

This keeps all of the information in the documentation rather
than having part of it here in the code.

Also, we should refer to the documentation via `git help` rather
than as a link to the website.


Thanks,
Jeff



