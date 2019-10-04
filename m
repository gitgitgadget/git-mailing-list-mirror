Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2573E1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 16:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfJDQsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 12:48:15 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38055 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 12:48:15 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6E2F16000A;
        Fri,  4 Oct 2019 16:48:11 +0000 (UTC)
Date:   Fri, 4 Oct 2019 22:18:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
Message-ID: <20191004164809.txdiwf7fandxsbmq@yadavpratyush.com>
References: <pull.361.git.gitgitgadget@gmail.com>
 <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
 <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com>
 <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
 <20190927130539.52oir56byuedqmm3@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1909301139460.46@tvgsbejvaqbjf.bet>
 <20191001133112.3qh4aeoctkoz2wxy@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910011638580.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910011638580.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10/19 07:38PM, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 1 Oct 2019, Pratyush Yadav wrote:
> 
> > On 30/09/19 11:42AM, Johannes Schindelin wrote:
> > > On Fri, 27 Sep 2019, Pratyush Yadav wrote:
> > > > On 27/09/19 08:10AM, Bert Wesarg wrote:
> > > > > On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > > > > gitdir is used in a lot of places, and I think all those would
> > > > > > also
> > > > > > benefit from using --git-path. So I think it is a better idea to move
> > > > > > this to the procedure gitdir. It would have to be refactored to take any
> > > > > > number of arguments, instead of the two it takes here.
> > >
> > > The `gitdir` function is called 13 times during startup alone, and who
> > > knows how many more times later.
> > >
> > > So I am quite convinced that the original intention was to save on
> > > spawning processes left and right.
> > >
> > > But since you are the Git GUI maintainer, and this was your suggestion,
> > > I made it so.
> >
> > Yes, I am the maintainer, but I am not an all-knowing, all-seeing
> > entity. Your, and every other contributors, suggestions are very
> > valuable. And my suggestions aren't gospel. I would hate to see someone
> > send in a patch they weren't sure was the best thing to do just because
> > I suggested it. Please feel free to object my suggestions.
> >
> > In this case, I didn't expect gitdir to be called this many times.
> >
> > While I don't notice much of a performance difference on my system
> > (Linux), a quick measurement tells me that the time spent in gitdir is
> > about 16 ms. In contrast, the same measurement without the v2 patch
> > gives out 0 ms (IOW, very fast). 16 ms sounds a bit much for something
> > so simple. It might not be the same for everyone else. AFAIK, spawning a
> > process is much slower on Windows.
> >
> > So now I'm not so sure my suggestion was a good one. My original aim was
> > to be sure everything was correct, and no incorrect directories were
> > being used. But the current solution comes at a performance hit.
> >
> > > > > We could either maintain a blacklist, for what we cache the result
> > > > > too, or always call "git rev-parse --git-dir".
> > > > >
> > > > > This blacklist would need to be in sync with the one in Git's
> > > > > path.c::adjust_git_path() than.
> >
> > Bert's suggestion seems like a decent compromise. We run `git rev-parse
> > --git-path` for the paths in the blacklist, and for the rest we use the
> > cached value. This does run the risk of getting out of sync with
> > git.git's list, but it might be better than spawing a process every
> > time, and is very likely better than just doing it for hooks.
> 
> But what about this part of that function?
> 
> -- snip --
> else if (repo->different_commondir)
> 	update_common_dir(buf, git_dir_len, repo->commondir);
> -- snap --

I'm afraid I'm a bit out of my depth on this. I have no idea what a 
"common directory" is, and how is it different from the "git directory". 
I can't find anything useful on Google about it. My guess is that it is 
something related to separate worktrees.
 
> It might well turn out that this blacklist is neither easy to implement
> nor will it help much.

Am I correct in assuming that for other cases like "info", "grafts", 
"index", "objects", and "hooks" the blacklist would be simple to 
implement, and it is the "common directory" case that is problematic?
 
> So let's look at all the call sites:
> 
> -- snip --
> $ git grep -w gitdir | sed -ne 's|\].*||' -e 's|.*\[gitdir ||p' | sort | uniq
> $file
> $name
> CHERRY_PICK_HEAD
> FETCH_HEAD
> GITGUI_BCK
> GITGUI_EDITMSG
> GITGUI_MSG
> HEAD
> hooks $hook_name
> index.lock
> info exclude
> logs $name
> MERGE_HEAD
> MERGE_MSG
> MERGE_RR
> objects 4\[0-[expr {$ndirs-1}
> objects info
> objects info alternates
> objects pack
> packed-refs
> PREPARE_COMMIT_MSG
> rebase-merge head-name
> remotes
> remotes $r
> rr-cache
> rr-cache MERGE_RR
> SQUASH_MSG
> -- snap --
> 
> The `$file` call looks for messages (probably commit, merge, tag
> messages and the likes), the `$name` one looks for refs.

So they should always be inside the '.git' or GIT_DIR, correct?
 
> Some of those arguments strike me as very good candidates to require the
> common directory while others require the real gitdir (remember,
> commondir != gitdir in worktrees other than the main worktree).
> 
> What _could_ be done (but we're certainly threatening to enter the realm
> of the ridiculous here) is to call `git rev-parse --git-dir --git-path
> CHERRY_PICK_HEAD --git-path FETCH_HEAD [...]`, which will output one
> path per line, and then store the result in an associative array
> (https://tcl.tk/man/tcl8.5/tutorial/Tcl22.html), and use that to look up
> paths based on their first component, caching as we go.

Ah yes! That is certainly threatening to enter the realm of ridiculous. 
I'm not sure what benefit this will have. Right now, I don't think 
git-gui handles these cases. Have people complained? Is this a common 
problem?

I want to evaluate how much benefit we get doing something like this has 
over just using your original patch that works with hooks only.
 
> Something like this:
> 
> -- snipsnap --
> diff --git a/git-gui.sh b/git-gui.sh
> index fd476b6..9295c75 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {
> 
>  set _appname {Git Gui}
>  set _gitdir {}
> +array set _gitdir_cached {}
>  set _gitworktree {}
>  set _isbare {}
>  set _gitexec {}
> @@ -197,12 +198,50 @@ proc appname {} {
>  	return $_appname
>  }
> 
> +proc init_gitdir_cached {} {
> +	global _gitdir _gitdir_cached
> +
> +	set gitdir_keys [list \
> +		CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
> +		GITGUI_MSG HEAD hooks index.lock info logs MERGE_HEAD \
> +		MERGE_MSG MERGE_RR objects packed-refs PREPARE_COMMIT_MSG \
> +		rebase-merge head-name remotes rr-cache SQUASH_MSG \
> +		]
> +
> +	set gitdir_cmd [list git rev-parse --git-dir]
> +	foreach key $gitdir_keys {
> +		lappend gitdir_cmd --git-path $key
> +	}
> +
> +	set i -1
> +	foreach path [split [eval $gitdir_cmd] "\n"] {
> +		if {$i eq -1} {
> +			set _gitdir $path
> +		} else {
> +			set _gitdir_cached([lindex $gitdir_keys $i]) $path
> +		}
> +		incr i
> +	}
> +}
> +
>  proc gitdir {args} {
> -	global _gitdir
> +	global _gitdir _gitdir_cached
> +
>  	if {$args eq {}} {
>  		return $_gitdir
>  	}
> -	return [eval [list file join $_gitdir] $args]
> +
> +	set arg0 [lindex $args 0]
> +	set args [lrange $args 1 end]
> +	if {![info exists _gitdir_cached($arg0)]} {
> +		if {[package vcompare $::_git_version 2.5.0] >= 0} {
> +			set _gitdir_cached($arg0) [git rev-parse --git-path $arg0]
> +		} else {
> +			set _gitdir_cached($arg0) [file join $_gitdir $arg0]
> +		}
> +	}
> +
> +	return [eval [concat [list file join $_gitdir_cached($arg0)] $args]]
>  }
> 
>  proc gitexec {args} {
> @@ -1242,7 +1281,7 @@ if {[catch {
>  	&& [catch {
>  		# beware that from the .git dir this sets _gitdir to .
>  		# and _prefix to the empty string
> -		set _gitdir [git rev-parse --git-dir]
> +		init_gitdir_cached
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
>  	load_config 1

A nice way of tackling this problem overall considering the challenges, 
but I'm worried about whether all this is _actually_ needed for real use 
cases, and what breaks if we don't.

Honestly, I'm not too sure how to tackle this problem. That is also the 
reason I took so long in writing this response. What would your 
suggestion be?

Also, if some other people interested in git-gui could chime in, it 
would be great.

-- 
Regards,
Pratyush Yadav
