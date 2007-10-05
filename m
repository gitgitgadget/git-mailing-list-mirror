From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning after svn dcommit
Date: Fri, 5 Oct 2007 16:54:53 -0700
Message-ID: <20071005235453.GB16849@untitled>
References: <20071005001528.GA13029@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 01:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idx0a-0002lD-RR
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 01:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761615AbXJEXy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761528AbXJEXy4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 19:54:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38076 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761346AbXJEXyz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 19:54:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 418992DC032;
	Fri,  5 Oct 2007 16:54:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071005001528.GA13029@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60137>

Steven Grimm <koreth@midwinter.com> wrote:
> git-svn dcommit, by virtue of rewriting history to insert svn revision IDs,
> leaves old commits dangling.  Since dcommit is already unsafe to run
> concurrently with other git commands, no additional risk is introduced
> by making it prune those old objects as needed.
> 
> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
> 
> This is in response to a colleague who complained that, after I
> installed the latest git release, he was getting lots of "too many
> unreachable loose objects" errors from the new "git gc --auto" run.
> Those objects turned out to be dangling commits from a year's worth of
> git-svn usage, since every git-svn commit will abandon at least one
> existing commit in order to rewrite it with the svn version data.

I'm not a fan of automatic gc in general, but I understand it can
help new users.  So as long as clueful users can easily disable it,
then it's fine by me...

>  git-svn.perl |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 777e436..be62ee1 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -441,6 +441,12 @@ sub cmd_dcommit {
>  			}
>  			command_noisy(@finish, $gs->refname);
>  			$last_rev = $cmt_rev;
> +
> +			# rebase will have made the just-committed revisions
> +			# unreachable; over time that can build up lots of
> +			# loose objects in the repo. prune is unsafe to run
> +			# concurrently but so is dcommit.
> +			command_noisy(qw/gc --auto --prune/);
>  		}
>  	}
>  }

This is better called outside of this loop.  We now do a rebase after
every revision committed (which gets us even more dangling commits);
but we only want to call git-gc after everything is committed.

It'll be faster since git-gc is only invoked once, and if git-gc takes a
very long time to repack, we won't have to worry about timing out a SVN
network connection.  It'll also reduce the window for somebody else to
commit a conflicting change that'll cause dcommit to fail midway
through.


As far as Peter's concerns for shared repositories go, I'm not sure...

I've never been comfortable with shared repositories myself (even in a
pure git environment without git-svn) and always just preferred using
full clones or copies[1] myself so I could rm -r any working directory
and not worry about any other repositories relying on it.

[1] - I usually go about using cp -al + libflcow :)

-- 
Eric Wong
