From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Make rebase--interactive use OPTIONS_SPEC
Date: Fri, 20 Jun 2008 14:15:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201407230.6439@racer>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net> <1213929935-15093-4-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gVD-0000DY-GZ
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYFTNRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYFTNRP
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:17:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:37873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753906AbYFTNRN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:17:13 -0400
Received: (qmail invoked by alias); 20 Jun 2008 13:17:12 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp029) with SMTP; 20 Jun 2008 15:17:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/46Roxl7H4BVxMNHhtbAuYTfha5e6kdKI/GN4wWF
	BoCfLbXk6p0+w9
X-X-Sender: gene099@racer
In-Reply-To: <1213929935-15093-4-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85642>

Hi,

I like the patch.  Just a couple comments:

On Fri, 20 Jun 2008, Stephan Beyer wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index e8ac2ae..aeb9628 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -10,10 +10,25 @@
>  # The original idea comes from Eric W. Biederman, in
>  # http://article.gmane.org/gmane.comp.version-control.git/22407
>  
> -USAGE='(--continue | --abort | --skip | [--preserve-merges] [--first-parent]
> -	[--preserve-tags] [--verbose] [--onto <branch>] <upstream> [<branch>])'
> +OPTIONS_KEEPDASHDASH=
> +OPTIONS_SPEC='
> +git-rebase -i [options] <upstream> [<branch>]
> +git-rebase (--continue | --abort | --skip)

Here, "-i" is not an error, but not required either, so it should be

+git-rebase [-i] (--continue | --abort | --skip)

> +--
> +continue           Continue rebasing process
> +abort              Abort rebasing process and restore original branch
> +skip               Skip current patch and continue rebasing process

I wonder if these options (which really should be subcommands) should not 
go below the options, for chronological reasons: you are likely to need 
the other options before --continue and friends.

> +p,preserve-merges  Try to recreate merges instead of ignoring

s/$/ them/

> +t,preserve-tags    Update tags to the new commit object
> +m,merge            Used anyways (no-op)
> +i,interactive      Used anyways (no-op)

s/anyways/always/

Hmm?

> +onto=              Rebase onto given branch instead of upstream
> +v,verbose          Display a diffstat of what changed upstream
> + When preserving merges:
> +f,first-parent     Show only commits following the first parent of each commit
> +s,strategy=        Use the given merge strategy
> +'
>  
> -OPTIONS_SPEC=
>  . git-sh-setup
>  require_work_tree
>  
> @@ -595,32 +611,36 @@ do
>
> [...]
>
> +	--onto)
> +		shift
> +		ONTO=$(git rev-parse --verify "$1") ||
> +			die "Does not point to a valid commit: $1"
> +		;;

You probably need to introduce checks against "git rebase --continue 
--onto blabla", then.

>  	''|-h)
>  		usage
>  		;;
> -	*)
> +	--)
> +		shift
> +		test $# -eq 1 -o $# -eq 2 || usage

I consider this a bugfix.  Thanks.

> @@ -720,6 +731,7 @@ EOF
>  			die_abort "Nothing to do"
>  
>  		output git checkout $ONTO && do_rest
> +		exit 0
>  		;;
>  	esac
>  	shift

This exit is not really necessary, is it?  Besides, a simple "exit" would 
be more correct: it reuses the exit status of the most recently executed 
command, which is what we want here.

Thanks,
Dscho
