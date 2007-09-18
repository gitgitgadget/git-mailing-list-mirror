From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Wed, 19 Sep 2007 00:51:34 +0200
Message-ID: <20070918225134.GA5906@xp.machine.xx>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com> <11900461843997-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlv4-0001jv-0E
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264AbXIRWvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbXIRWvo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:51:44 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:37168 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756783AbXIRWvn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2007 18:51:43 -0400
Received: (qmail 23661 invoked by uid 0); 18 Sep 2007 22:51:35 -0000
Received: from p54aabe18.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.190.24)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Sep 2007 22:51:35 -0000
Content-Disposition: inline
In-Reply-To: <11900461843997-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58654>

On Mon, Sep 17, 2007 at 06:23:04PM +0200, Lars Hjemli wrote:
> This option forces fast-forward merges to create a "true" merge commit,
> i.e. a commit with multiple parents.
> 
> Although a fast-forward merge would normally be the right thing to do with
> git branches, it is suboptimal when operating on git-svn branches since it
> makes 'git-svn dcommit' fail to recognize the correct upstream subversion
> branch. But performing such a merge with --no-ff specified will both make
> git-svn dcommit recognize the correct upstream and create the logically
> correct history in subversion (the merge performed in git will be recorded
> as a single revision in subversion, not as a series of revisions seemingly
> cherry-picked from the merged branch).
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
> 
> When updating git-svn.txt, I noticed that we might want to update the 
> section "DESIGN PHILOSOPHY". Eric?
> 
> 
>  Documentation/git-svn.txt       |   13 +++++++++++++
>  Documentation/merge-options.txt |    5 +++++
>  git-merge.sh                    |   13 +++++++++++--
>  t/t6028-merge-up-to-date.sh     |   25 +++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index be2e34e..c510c21 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -475,6 +475,19 @@ use 'git-svn rebase' to update your work branch instead of 'git pull' or
>  when committing into SVN, which can lead to merge commits reversing
>  previous commits in SVN.
>  
> +If you use 'git-svn dcommit' to commit your local work to the upstream
> +subversion branch, merge commits are usually handled correctly, i.e.
> +git-svn will only follow the first parent of each merge commit and create
> +a single subversion revision for each of them. An exception is when two
> +subversion branches has been merged locally and the merge ended up as a
> +fast-forward operation. This will make git-svn belive that there are no
> +local changes to dcommit. To work around this issue, one can redo the
> +merge using the --no-ff option:
> +
> +       $ git reset --hard HEAD@{1}   ## undo the fast-forward merge
> +       $ git merge --no-ff <branch>
> +
> +
>  DESIGN PHILOSOPHY
>  -----------------
>  Merge tracking in Subversion is lacking and doing branched development
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index d64c259..b34b888 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -25,3 +25,8 @@
>  	If there is no `-s` option, a built-in list of strategies
>  	is used instead (`git-merge-recursive` when merging a single
>  	head, `git-merge-octopus` otherwise).
> +
> +--no-ff::
> +	Force the creation of a merge commit even when the merge would
> +	have resolved as a fast-forward operation. See gitlink:git-svn[1]
> +	for a use-case for this option.
> diff --git a/git-merge.sh b/git-merge.sh
> index 3a01db0..13b98e6 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -3,7 +3,7 @@
>  # Copyright (c) 2005 Junio C Hamano
>  #
>  
> -USAGE='[-n] [--summary] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
> +USAGE='[-n] [--summary] [--no-commit] [--no-ff] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
>  
>  SUBDIRECTORY_OK=Yes
>  . git-sh-setup
> @@ -165,6 +165,10 @@ do
>  		merge_msg="$1"
>  		have_message=t
>  		;;
> +	--no-ff)
> +		no_ff=t
> +		no_fast_forward_strategies=$all_strategies
> +		;;
>  	-*)	usage ;;
>  	*)	break ;;
>  	esac
> @@ -444,7 +448,12 @@ done
>  # auto resolved the merge cleanly.
>  if test '' != "$result_tree"
>  then
> -    parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
> +    if test $no_ff = 't'
This should be quoted, e.g.
  +    if test "$no_ff" = 't'

Otherwise I get an error like the following:

  xp:/tmp/va (a)$ git merge b
  Renamed msg.cc->common/msg.cc
  Auto-merged common/msg.cc
  Renamed msg.h->common/msg.h
  Auto-merged common/msg.h
  Renamed sampler/ConcurrentQueue.h->common/ConcurrentQueue.h
  Auto-merged common/ConcurrentQueue.h
  Renamed sampler/TimeoutSemaphore.h->common/TimeoutSemaphore.h
  Auto-merged common/TimeoutSemaphore.h
  /home/peter/usr/bin/git-merge: line 451: test: =: unary operator expected
  Merge made by recursive.


> +    then
> +        parents=$(git rev-parse "$head" "$@" | sed -e 's/^/-p /')
> +    else
> +        parents=$(git show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
> +    fi
>      result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree $result_tree $parents) || exit
>      finish "$result_commit" "Merge made by $wt_strategy."
>      dropsave

-Peter
