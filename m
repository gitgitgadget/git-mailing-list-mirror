Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23F51F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 00:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfJHA3I (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 20:29:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45271 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHA3I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 20:29:08 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CF55E20004;
        Tue,  8 Oct 2019 00:29:04 +0000 (UTC)
Date:   Tue, 8 Oct 2019 05:59:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Fix gitdir e.g. to respect core.hooksPath
Message-ID: <20191008002902.n4b3bhlvwzsxodsc@yadavpratyush.com>
References: <pull.361.v2.git.gitgitgadget@gmail.com>
 <pull.361.v3.git.gitgitgadget@gmail.com>
 <65c2fa33e1aeec03930921ee0ef562d3f9dc5ccf.1570225311.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c2fa33e1aeec03930921ee0ef562d3f9dc5ccf.1570225311.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Could you please change the commit subject to more clearly state that we 
are caching all paths. This is not something just related to hooks any 
more.

On 04/10/19 02:41PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Since v2.9.0, Git knows about the config variable core.hookspath
> that allows overriding the path to the directory containing the
> Git hooks.
> 
> Since v2.10.0, the `--git-path` option respects that config
> variable, too, so we may just as well use that command.
> 
> For Git versions older than v2.5.0 (which was the first version to
> support the `--git-path` option for the `rev-parse` command), we
> simply fall back to the previous code.
> 
> An original patch handled only the hooksPath setting, however, during
> the code submission it was deemed better to fix all call to the `gitdir`
> function.
> 
> To avoid spawning a gazillion `git rev-parse --git-path` instances, we
> cache the returned paths, priming the cache upon startup in a single
> `git rev-parse invocation` with the known entries.

I think it would also be a good idea to mention that we are fixing 
worktree paths not being correct.
 
> This fixes https://github.com/git-for-windows/git/issues/1755
> 
> Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index fd476b6999..8b72e59cd0 100755
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
> @@ -197,12 +198,57 @@ proc appname {} {
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

I think we should mention the source of the list of "magic" keys. A 
comment mentioning this list came from looking at the common calls to 
`gitdir` in the rest of the git-gui code would explain this function to 
a future reader better.

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

A call to the procedure 'git' is wrapped in a 'catch' in a lot of 
places. But it is also not wrapped in 'catch' in a lot of other places.

I'm not sure how something like this would fail, so I'm not sure if 
wrapping this call in a catch is a good idea. But it is something to 
consider.

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
> @@ -1242,7 +1288,7 @@ if {[catch {
>  	&& [catch {
>  		# beware that from the .git dir this sets _gitdir to .
>  		# and _prefix to the empty string
> -		set _gitdir [git rev-parse --git-dir]
> +		prime_gitdir_cache
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
>  	load_config 1

Can these paths we cache change while git-gui is running, say by a 
command run by the user in the terminal? In that case, we should refresh 
the list when the user rescans.

Other than some minor comments, looks good. Thanks.

-- 
Regards,
Pratyush Yadav
