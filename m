From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 02:28:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711090225110.4362@racer.site>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
 <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJbr-0006ZO-V5
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 03:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686AbXKIC2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 21:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758416AbXKIC2Y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 21:28:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:57601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754203AbXKIC2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 21:28:24 -0500
Received: (qmail invoked by alias); 09 Nov 2007 02:28:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 09 Nov 2007 03:28:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M6bYqKKgMFRgRxXKYN0ehoOXnpsWkJQ5oYlkr4a
	LsELMbio7/x6OS
X-X-Sender: gene099@racer.site
In-Reply-To: <7v640cxitc.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64117>

Hi,

On Thu, 8 Nov 2007, Junio C Hamano wrote:

> I wonder if this is a sensible thing to do, regardless of the issue of 
> commit log message that contains anything.
> 
> The patch replaces git-rebase with git-rebase--interactive.  The only 
> difference from the existing "git-rebase -i" is if the command is called 
> without "-i" the initial "here is the to-do list. please rearrange the 
> lines, modify 'pick' to 'edit' or whatever as appropriate" step is done 
> without letting the user edit the list.

Hmm.  I don't know, really.  I had the impression that the "git 
format-patch | git am" pipeline would be faster.

But if we were to do this, we'd get a progress meter for free.  And bugs 
exposed, no doubt.

>  Makefile                                    |    2 +-
>  git-rebase--interactive.sh => git-rebase.sh |   14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)

What about the existing git-rebase.sh?

> diff --git a/git-rebase--interactive.sh b/git-rebase.sh
> similarity index 98%
> rename from git-rebase--interactive.sh
> rename to git-rebase.sh
> index 76dc679..1dd6f6d 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase.sh
> @@ -346,6 +347,9 @@ do_rest () {
>  while test $# != 0
>  do
>  	case "$1" in
> +	--interactive|-i)
> +		INTERACTIVE=t
> +		;;

There is already a case for that, further down.

> @@ -504,9 +508,11 @@ EOF
>  			die_abort "Nothing to do"
>  
>  		cp "$TODO" "$TODO".backup
> -		git_editor "$TODO" ||
> -			die "Could not execute editor"
> -
> +		case "$INTERACTIVE" in
> +		t)
> +			git_editor "$TODO" || die "Could not execute editor"
> +			;;
> +		esac


Would that not be easier to read as

		test t = "$INTERACTIVE" &&
			git_editor "$TODO" || die "Could not execute editor"

Hmm?

Ciao,
Dscho
