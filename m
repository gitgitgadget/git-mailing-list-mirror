Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C191F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfJKW0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:26:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50649 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbfJKW0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:26:18 -0400
X-Originating-IP: 1.186.12.63
Received: from localhost (unknown [1.186.12.63])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 401CA60006;
        Fri, 11 Oct 2019 22:26:14 +0000 (UTC)
Date:   Sat, 12 Oct 2019 03:56:12 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
Message-ID: <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com>
References: <pull.361.v3.git.gitgitgadget@gmail.com>
 <pull.361.v4.git.gitgitgadget@gmail.com>
 <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the re-roll. Some comments below...

On 08/10/19 04:33AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Since v2.9.0, Git knows about the config variable core.hookspath that
> allows overriding the path to the directory containing the Git hooks.
> 
> Since v2.10.0, the `--git-path` option respects that config variable,
> too, so we may just as well use that command.
> 
> Other paths inside `.git` are equally subject to differ from
> `<gitdir>/<path>`, i.e. inside worktrees, where _some_ paths live in the
> "gitdir" and some live in the "commondir" (i.e. the "gitdir" of the main
> worktree).
> 
> For Git versions older than v2.5.0 (which was the first version to
> support the `--git-path` option for the `rev-parse` command), we simply
> fall back to the previous code.
> 
> An original patch handled only the hooksPath setting, however, during
> the code submission it was deemed better to fix all call to the `gitdir`
> function.
> 
> To avoid spawning a gazillion `git rev-parse --git-path` instances, we
> cache the returned paths, priming the cache upon startup in a single
> `git rev-parse invocation` with some paths (that have been
> determined via a typical startup and via grepping the source code for
> calls to the `gitdir` function).
> 
> This fixes https://github.com/git-for-windows/git/issues/1755
> 
> Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index fd476b6999..c684dc7ae1 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {
>  
>  set _appname {Git Gui}
>  set _gitdir {}
> +array set _gitdir_cache {}
>  set _gitworktree {}
>  set _isbare {}
>  set _gitexec {}
> @@ -197,12 +198,59 @@ proc appname {} {
>  	return $_appname
>  }
>  
> +proc prime_gitdir_cache {} {
> +	global _gitdir _gitdir_cache
> +
> +	set gitdir_cmd [list git rev-parse --git-dir]
> +
> +	# `--git-path` is only supported since Git v2.5.0
> +	if {[package vcompare $::_git_version 2.5.0] >= 0} {
> +		# This list was generated from a typical startup as well as from
> +		# grepping through Git GUI's source code.
> +		set gitdir_keys [list \
> +			CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
> +			GITGUI_MSG HEAD hooks hooks/prepare-commit-msg \
> +			index.lock info info/exclude logs MERGE_HEAD MERGE_MSG \
> +			MERGE_RR objects "objects/4\[0-1\]/*" \
> +			"objects/4\[0-3\]/*" objects/info \
> +			objects/info/alternates objects/pack packed-refs \
> +			PREPARE_COMMIT_MSG rebase-merge/head-name remotes \
> +			rr-cache rr-cache/MERGE_RR SQUASH_MSG \
> +		]
> +
> +		foreach key $gitdir_keys {
> +			lappend gitdir_cmd --git-path $key
> +		}
> +	}
> +
> +	set i -1
> +	foreach path [split [eval $gitdir_cmd] "\n"] {
> +		if {$i eq -1} {
> +			set _gitdir $path
> +		} else {
> +			set _gitdir_cache([lindex $gitdir_keys $i]) $path
> +		}
> +		incr i
> +	}
> +}
> +
>  proc gitdir {args} {
> -	global _gitdir
> +	global _gitdir _gitdir_cache
> +
>  	if {$args eq {}} {
>  		return $_gitdir
>  	}
> -	return [eval [list file join $_gitdir] $args]
> +
> +	set args [eval [list file join] $args]
> +	if {![info exists _gitdir_cache($args)]} {
> +		if {[package vcompare $::_git_version 2.5.0] >= 0} {
> +			set _gitdir_cache($args) [git rev-parse --git-path $args]
> +		} else {
> +			set _gitdir_cache($args) [file join $_gitdir $args]
> +		}
> +	}
> +
> +	return $_gitdir_cache($args)
>  }
>  
>  proc gitexec {args} {
> @@ -1242,7 +1290,7 @@ if {[catch {
>  	&& [catch {
>  		# beware that from the .git dir this sets _gitdir to .
>  		# and _prefix to the empty string
> -		set _gitdir [git rev-parse --git-dir]
> +		prime_gitdir_cache
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
>  	load_config 1

Looks good till here.

> @@ -1453,10 +1501,16 @@ proc rescan {after {honor_trustmtime 1}} {
>  	global HEAD PARENT MERGE_HEAD commit_type
>  	global ui_index ui_workdir ui_comm
>  	global rescan_active file_states
> -	global repo_config
> +	global repo_config _gitdir_cache
>  
>  	if {$rescan_active > 0 || ![lock_index read]} return
>  
> +	# Only re-prime gitdir cache on a full rescan
> +	if {$after ne "ui_ready"} {

What do you mean by a "full rescan"? I assume you use it as the 
differentiator between `ui_do_rescan` (called when you hit F5 or choose 
rescan from the menu) and `do_rescan` (called when you revert a line or 
hunk), and a "full rescan" refers to `ui_do_rescan`.

Well in that case, this check is incorrect. `do_rescan` passes only 
"ui_ready" and `ui_do_rescan` passes "force_first_diff ui_ready".

But either way, I'm not a big fan of this. This check makes assumptions 
about the behaviour of its callers based on what they pass to $after. 
The way I see it, $after should be a black box to `rescan`, and it 
should make absolutely no assumptions about it.

Doing it this way is really brittle, and would break as soon as someone 
changes the behaviour of `ui_do_rescan`. If someone in the future passes 
a different value in $after, this would stop working as intended and 
would not refresh the cached list on a rescan.

So, I think a better place for this if statement would be in 
`ui_do_rescan`. This would mean adding a new function that does this. 
But if we unset _gitdir_cache in prime_gitdir_cache (I see no reason not 
to), we can get away with just something like:

  proc ui_do_rescan {} {
  	rescan {prime_gitdir_cache; ui_ready}
  }

Though since `prime_gitdir_cache` does not really depend on the rescan 
being finished, something like this would also work fine:

  proc ui_do_rescan {} {
  	rescan ui_ready
  	prime_gitdir_cache
  }

This would allow us to do these two things in parallel since `rescan` is 
asynchronous. But that would also mean it is possible that the status 
bar would show "Ready" while `prime_gitdir_cache` is still executing.

I can't really make up my mind on what is better. I'm inclining on using 
the latter way, effectively trading a bit of UI inconsistency for 
performance (at least in theory).

Thoughts?

> +		array unset _gitdir_cache
> +		prime_gitdir_cache
> +	}
> +
>  	repository_state newType newHEAD newMERGE_HEAD
>  	if {[string match amend* $commit_type]
>  		&& $newType eq {normal}

-- 
Regards,
Pratyush Yadav
