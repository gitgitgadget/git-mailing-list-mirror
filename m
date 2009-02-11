From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 16:24:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902111621490.13279@intel-tinevez-2-302>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:26:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXGyU-0004uK-40
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbZBKPYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757344AbZBKPYb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:24:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:42416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757826AbZBKPY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 10:24:29 -0500
Received: (qmail invoked by alias); 11 Feb 2009 15:24:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 11 Feb 2009 16:24:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uOrFTxsXuHi7gIomJZ++85addGjrkCGqEZPoRgL
	SpoLeO0QHDZof0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1234361365-63711-1-git-send-email-git@randomhacks.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109425>

Hi,

On Wed, 11 Feb 2009, Eric Kidd wrote:

> In commit 9273b56278e64dd47b1a96a705ddf46aeaf6afe3, I fixed an error 
> that had slipped by the test suites because of a missing check on 'git 
> read-tree -u -m HEAD'.
> 
> I mentioned to Johannes Schindelin that there were several bugs of this 
> type in git-filter-branch, and he suggested that I send a patch.
> 
> I've tested this patch using t/t7003-filter-branch.sh, and it passes all
> the existing tests.  But it's entirely possible that this patch contains
> errors, and I would love input from people who have more experience with
> sh and who know more about git-filter-branch.
> 
> In particular, the following hunk may change the public UI to
> git-filter-branch, although I'm not sure whether the change is for
> better or for worse.  As I understand it, this hunk would allow
> $filter_commit to abort the rewriting process by returning a non-0 exit
> status:
> 
>  	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
> -		$(git write-tree) $parentstr < ../message > ../map/$commit
> +		$(git write-tree) $parentstr < ../message > ../map/$commit ||
> +			die "could not write rewritten commit"
>  done <../revs
> 
> I'd be happy to add a test case for what happens when $filter_commit
> returns a non-0 exit status.  Is the old behavior preferable?
> ---

Thanks.  Although it lacks a Sign-off, and part of the commit message is 
actually a personal comment that belongs after the three dashes.

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 86eef56..9d50978 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -242,7 +242,7 @@ export GIT_DIR GIT_WORK_TREE
>  
>  # The refs should be updated if their heads were rewritten
>  git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD "$@" |
> -sed -e '/^^/d' >"$tempdir"/heads
> +sed -e '/^^/d' >"$tempdir"/heads || die "Can't make list of original refs"

This will catch errors in the sed invocation, but not in rev-parse.

> @@ -315,10 +315,11 @@ while read commit parents; do
>  			die "tree filter failed: $filter_tree"
>  
>  		(
> -			git diff-index -r --name-only $commit
> +			git diff-index -r --name-only $commit &&
>  			git ls-files --others
>  		) |
> -		git update-index --add --replace --remove --stdin
> +		git update-index --add --replace --remove --stdin ||
> +			die "unable to update index with results of tree filter"

This will catch errors in the update-index call, but neither in diff-index 
nor ls-files.

Otherwise, the patch looks good to me.

Ciao,
Dscho
