From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
	after svn dcommit
Date: Fri, 5 Oct 2007 10:21:10 +0200
Message-ID: <20071005082110.GA4797@xp.machine.xx>
References: <20071005001528.GA13029@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdiRA-0007rl-QS
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbXJEIVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbXJEIVP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:21:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:49367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbXJEIVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:21:13 -0400
Received: (qmail invoked by alias); 05 Oct 2007 08:21:11 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp001) with SMTP; 05 Oct 2007 10:21:11 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/+dIleggn+3Aebp3BZvZZTK2eHrjxHfo+vvcgM5h
	Bz5/Edu3bGr7Pm
Content-Disposition: inline
In-Reply-To: <20071005001528.GA13029@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60047>

On Thu, Oct 04, 2007 at 05:15:28PM -0700, Steven Grimm wrote:
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
> 

I don't like the automatic prune. What if someone has other objects in
there which shouldn't be pruned? Making git svn dcommit doing the prune
would be at least suprising, because how is one supposed to know that
doing a commit into svn will prune all your precious objects?

Sure, I can unterstand from where you are coming from, but I'd prefere
if this could be specified on a case by case basis, e.g. from the
cmdline or as a config option.

-Peter


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
> -- 
> 1.5.3.4.203.gcc61a
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
