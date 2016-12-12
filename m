Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8731FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 09:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbcLLJgX (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 04:36:23 -0500
Received: from ozlabs.org ([103.22.144.67]:48681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbcLLJgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 04:36:23 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcd512GjNz9vF4; Mon, 12 Dec 2016 20:36:21 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 20:36:13 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     =?iso-8859-1?Q?Ux=EDo?= Prego <uprego@madiva.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposal for an increased `gitk` cohesion with `git stash`.
Message-ID: <20161212093613.GD20934@fergus.ozlabs.ibm.com>
References: <CANidDKZRisodpQgqyYaG_tCi0+EyxYv+t8+Entp0joMSetd3oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANidDKZRisodpQgqyYaG_tCi0+EyxYv+t8+Entp0joMSetd3oA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Uxio,

On Thu, Sep 08, 2016 at 03:41:29PM +0200, Uxío Prego wrote:
> Hello, please forgive me for not introducing me.
> 
> +-----------+
> |Description|
> +-----------+
> 
> Patch for showing all stashes in `gitk`.
> 
> +-----------+
> |The problem|
> +-----------+
> 
> Being `gitk` one of the best tools for navigating and understanding graphs
> of git repo revs, I got used to have it for home use, some years ago, soon
> for office use too.
> 
> At some point I got used to invoke always `gitk --all` in order to keep
> tracking of tags when using the program for building, when possible, stable
> versions of any GNU/Linux software I would want to use.
> 
> It seems `gitk --all` uses `git show-ref` for showing remotes information.
> A side effect of this is that the most recent stash gets shown in `gitk
> --all`. After learning what the stash was, I got used to it.
> 
> Later, when at jobs, I got used to have a stash on all working branch tips.
> So I often would have several stashes in `git stash list` but only the last
> one in `gitk --all`. That annoyed me for about a year, finally I got
> working in `gitk` to show a stash status more similar to what `git stash
> list` shows.
> 
> +-----------+
> |The feature|
> +-----------+
> 
> Show all stashes in `gitk` instead of only the last one.

This seems like a good feature, although I don't use stashes myself.

> +------------------+
> |Why it's desirable|
> +------------------+
> 
> In order to have better visual control when working on repos that have
> several active branches and there are needed quick context changes between
> them with the features that `git stash [apply [STASHNAME]| list | pop
> [STASHNAME]| push | save | show [[-p] STASHNAME]]`.
> 
> In order to have a better cohesion between the mentioned features and `gitk
> --all`.
> 
> +------------------------+
> |Caveats and side effects|
> +------------------------+
> 
> With this patch several side effects happen:
> 
> * Stashes are shown even invoking `gitk`, not only when running `gitk
> --all`. If this is a problem, I can keep working in the patch to avoid this.
> 
> * The most recent stash, which was previously shown as 'stash' because its
> corresponding `git show-ref` output line reads 'refs/stash', gets shown as
> 'stash@{0}'. Not removing lines with 'stash' when calling `git show-ref`
> gets it shown both as 'stash' as usual and as 'stash@{0}'.
> 
> +--------------------------+
> |Non-obvious design choices|
> +--------------------------+
> 
> There are many improvable things consequence of never having edited
> anything Tcl before this. Besides, its working for me as a proof of
> concept, both in Debian 7 Wheezy and 8 Jessie.
> 
> The origin document of the following diff is `gitk` as it ships in Debian 8
> Jessie. I have not tried yet but if required I would be willing to rework
> it for the repo master.

A patch against the latest version in my git repo at
git://ozlabs.org/~paulus/gitk would be better.

> `gitk-stash-list-ids.sh` is a shell script that performs `git stash list
> --pretty=format:"%H"`, i.e. show rev hashes for all stashes in the fashion
> that `git rev-list --all` does its default output. I did this because I
> could not work out a better pure Tcl solution.

Hmmm, I don't want gitk to have to depend on an external script.
It should be possible to make Tcl execute the git command directly,
though (see below).

> +--------------------+
> |Unified diff follows|
> +--------------------+
> 
> 0:10:1473338052:uprego@uxio:~$ diff -u /usr/bin/gitk-deb8-vanilla
> /usr/bin/gitk-deb8-multistash
> --- /usr/bin/gitk-deb8-vanilla  2016-08-29 10:07:06.507344629 +0200
> +++ /usr/bin/gitk-deb8-multistash       2016-09-08 14:36:35.382476634 +0200
> @@ -401,6 +401,10 @@
> 
>      if {$vcanopt($view)} {
>         set revs [parseviewrevs $view $vrevs($view)]
> +    set stashesfd [open [concat | gitk-stash-list-ids.sh] r]

set stashesfd [open [list | git stash list {--pretty=format:%H}] r]

> +    while {[gets $stashesfd stashline] >= 0} {
> +        set revs [lappend revs $stashline]
> +    }

Could this ever take a long time?  The UI is unresponsive while we're
in this loop.  If this is always quick (even on large repos), OK.  If
it could take a long time then we'll need a file event handler.

>         if {$revs eq {}} {
>             return 0
>         }
> @@ -1778,7 +1782,7 @@
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
>         catch {unset $v}
>      }
> -    set refd [open [list | git show-ref -d] r]
> +    set refd [open [list | git show-ref -d | grep -v stash] r]

If I had a branch called "dont-use-a-stash-for-this", would it get
filtered out by this grep?  It seems like it would, and we don't want
it to.  So the filtering needs to be more exact here.

>      while {[gets $refd line] >= 0} {
>         if {[string index $line 40] ne " "} continue
>         set id [string range $line 0 39]
> @@ -1811,6 +1815,16 @@
>         }
>      }
>      catch {close $refd}
> +    set stashesidsrefsd [open [list | gitk-stash-list-ids-refs.sh] r]

set stashesidsrefsd [open [list | \
	git stash list {--pretty=format:%H %gD}] r]

Paul.
