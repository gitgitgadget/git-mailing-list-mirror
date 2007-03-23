From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-mergetool about Apple's opendiff/FileMerge
Date: Thu, 22 Mar 2007 21:45:09 -0700
Message-ID: <7vbqiksh4a.fsf@assigned-by-dhcp.cox.net>
References: <20070322213728.GD3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, git@vger.kernel.org
To: arjen@yaph.org (Arjen Laarhoven)
X-From: git-owner@vger.kernel.org Fri Mar 23 05:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUbeO-0001cS-NV
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 05:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbXCWEpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 00:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbXCWEpM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 00:45:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55713 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422675AbXCWEpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 00:45:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323044510.HMKG321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Mar 2007 00:45:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e4l91W0081kojtg0000000; Fri, 23 Mar 2007 00:45:09 -0400
In-Reply-To: <20070322213728.GD3854@regex.yaph.org> (Arjen Laarhoven's message
	of "Thu, 22 Mar 2007 22:37:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42903>

arjen@yaph.org (Arjen Laarhoven) writes:

> Signed-off-by: Arjen Laarhoven <arjen@yaph.org>

I cannot comment on the calling interface of opendiff, as I do
not have access to an Apple.  Here are my first impressions.

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 7942fd0..58ae201 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -248,6 +248,30 @@ merge_file () {
>  		mv -- "$BACKUP" "$path.orig"
>  	    fi
>  	    ;;
> +	opendiff)
> +	    touch "$BACKUP"
> +	    if base_present; then
> +		opendiff $LOCAL $REMOTE -ancestor $BASE -merge $path | cat
> +            else
> +                opendiff $LOCAL $REMOTE -merge $path | cat
> +            fi

I sense inconsistent tabbing here.

More seriously, all of the above $variable references must be
dq'ed; see other case arms for good examples.

What's the purpose of this cat anyway?  It looks like an
expensive no-op to me.

> +	    if test "$path" -nt "$BACKUP" ; then
> +		status=0;
> +	    else
> +		while true; do
> +		    echo "$path seems unchanged."
> +		    echo -n "Was the merge successful? [y/n] "
> +		    read answer < /dev/tty
> +		    case "$answer" in
> +			y*|Y*) status=0; break ;;
> +			n*|N*) status=1; break ;;
> +		    esac
> +		done
> +	    fi
> +	    if test "$status" -eq 0; then
> +		mv -- "$BACKUP" "$path.orig"
> +	    fi
> +	    ;;
>      esac

This part is duplicated across meld|vimdiff and xxdiff arms; you
probably would want to have a patch that makes a shell function
to factor this out, and then another patch to add this opendiff
support.
