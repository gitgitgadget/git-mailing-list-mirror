From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-submodule: add support for --rebase.
Date: Tue, 7 Apr 2009 14:38:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904071428350.6897@intel-tinevez-2-302>
References: <20090407111445.GA11344@dingo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 14:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrAbG-0006TR-8k
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 14:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbZDGMik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 08:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZDGMik
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 08:38:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:41678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751159AbZDGMij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 08:38:39 -0400
Received: (qmail invoked by alias); 07 Apr 2009 12:38:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 07 Apr 2009 14:38:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198fxYUUId8M0Tbi1V37VkTf6PXEpRDE3PQDHzVvB
	7GI7DJJYDW3QJN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090407111445.GA11344@dingo>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115951>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to
answer with insults to the comments I offer, please stop reading this mail
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying
that I appreciate your work.

On Tue, 7 Apr 2009, Peter Hutterer wrote:

> 'git submodule update --rebase' rebases onto the current branch rather 
> than detaching the HEAD.

I know what you want to do, but this text is wrong: it should rather read 
something like this:

	'git submodule update --rebase' rebases your local branch on 
	top of what would have been checked out to a detached HEAD 
	otherwise.

Maybe some of these native English speakers on this list can come up with 
something even better ;-)

> I use git-submodule to keep track of repositories that I only 
> infrequently commit to. I keep them to have a set that is known to work.
> 
> git submodule update is annoying, as it (in my case needlessly) detaches the
> HEAD, making the workflow more complicated when I do have to commit (checkout
> master, rebase onto master, then commit).
> 
> This patch adds a "--rebase" flag to git submodule update that calls
> git-rebase instead of git-checkout.

Maybe a non-first person version of this comment could go into the commit 
message, too?  I found this highly informative.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 3b8df44..117ad3d 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -177,6 +178,12 @@ OPTIONS
>  	This option is only valid for the update command.
>  	Don't fetch new objects from the remote site.
>  
> +--rebase::
> +	This option is only valid for the update command.

This is unnecessary, it was mentioned in the synopsis.

> +	Forward-port local commits to the index of the containing repository.

This is a bit misleading/unclear.  I'd rather have it read like this:

	Instead of detaching the HEAD to the revision committed in the 
	superproject, rebase the current branch onto that revision.

> +	If a a merge failure prevents this process, you will have to resolve
> +	these failures with linkgit:git-rebase[1].
> +
>  <path>...::
>  	Paths to submodule(s). When specified this will restrict the command
>  	to only operate on the submodules found at the specified paths.
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 7c2e060..6180bf4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh

You might want to error out when --rebase was passed with another command 
than "update".

> @@ -367,11 +372,19 @@ cmd_update()
>  				die "Unable to fetch in submodule path '$path'"
>  			fi
>  
> -			(unset GIT_DIR; cd "$path" &&
> -				  git-checkout $force -q "$sha1") ||
> -			die "Unable to checkout '$sha1' in submodule path '$path'"
> +			if test -z "$rebase"
> +			then
> +				(unset GIT_DIR; cd "$path" &&
> +					  git-checkout $force -q "$sha1") ||
> +				die "Unable to checkout '$sha1' in submodule path '$path'"
> +				say "Submodule path '$path': checked out '$sha1'"
> +			else
> +				(unset GIT_DIR; cd "$path" &&
> +					git-rebase "$sha1") ||
> +					die "Unable to rebase onto '$sha1' in submodule path '$path'"
> +				say "Submodule path '$path': rebased onto '$sha1'"
> +			fi

I'd actually put the "(unset GIT_DIR; cd "$path" &&" in front of the "if" 
due to the DRY principle (Don't Repeat Yourself).

In the same spirit, I'd set a variable "action" to "checkout" or "rebase 
onto" and munge the error/info message to use $action.

Maybe you want to add a single primitive test case to make sure this 
feature will not get broken in the future?

Other than that: nice!  very nice!

Ciao,
Dscho

P.S.: the next patch is obvious, too: add support to specify desire to 
rebase the submodule in .gitmodules and .git/config.
