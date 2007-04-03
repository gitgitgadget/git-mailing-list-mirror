From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Bisect: teach "bisect start" to optionally use one bad and many good revs.
Date: Tue, 03 Apr 2007 13:02:13 -0700
Message-ID: <7vzm5pw7ju.fsf@assigned-by-dhcp.cox.net>
References: <20070401145723.27e17177.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:02:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpCs-0003MA-7y
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbXDCUCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbXDCUCP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:02:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61583 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422658AbXDCUCO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:02:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403200215.SZZV25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 16:02:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ik2C1W00h1kojtg0000000; Tue, 03 Apr 2007 16:02:13 -0400
In-Reply-To: <20070401145723.27e17177.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 1 Apr 2007 14:57:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43650>

Christian Couder <chriscool@tuxfamily.org> writes:

> In fact this patch implements:
>
>     git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
>
> I think this is more backward compatible because older script
> probably didn't used -- before <pathspec>...
>
> On the other hand, there may be some confusion between revs
> (<bad> and <good>...) and <pathspec>... if -- is not used
> and if an invalid rev or a pathspec that looks like a rev is
> given.

I think the intent of the check you have for '--' to cover the
above issue is good.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-bisect.sh         |  105 ++++++++++++++++++++++++++++++++++++++-----------
>  t/t6030-bisect-run.sh |   20 ++++++++-
>  2 files changed, 99 insertions(+), 26 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 11313a7..d5a13ee 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,15 +1,24 @@
>  #!/bin/sh
>  
>  USAGE='[start|bad|good|next|reset|visualize|replay|log|run]'
> -LONG_USAGE='git bisect start [<pathspec>]	reset bisect state and start bisection.
> -git bisect bad [<rev>]		mark <rev> a known-bad revision.
> -git bisect good [<rev>...]	mark <rev>... known-good revisions.
> -git bisect next			find next bisection to test and check it out.
> -git bisect reset [<branch>]	finish bisection search and go back to branch.
> -git bisect visualize            show bisect status in gitk.
> -git bisect replay <logfile>	replay bisection log.
> -git bisect log			show bisect log.
> -git bisect run <cmd>... 	use <cmd>... to automatically bisect.'
> +LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
> +        reset bisect state and start bisection.
> +git bisect bad [<rev>]
> +        mark <rev> a known-bad revision.
> +git bisect good [<rev>...]
> +        mark <rev>... known-good revisions.
> +git bisect next
> +        find next bisection to test and check it out.
> +git bisect reset [<branch>]
> +        finish bisection search and go back to branch.
> +git bisect visualize
> +        show bisect status in gitk.
> +git bisect replay <logfile>
> +        replay bisection log.
> +git bisect log
> +        show bisect log.
> +git bisect run <cmd>...
> +        use <cmd>... to automatically bisect.'

Much easier to read ;-).

>  	mkdir "$GIT_DIR/refs/bisect"
> +
> +	#
> +	# Check for one bad and then some good revisions.
> +	#
> +	has_double_dash=0
> +	for arg in "$@"; do
> +	    case "$arg" in --) has_double_dash=1; break ;; esac
> +	done

Style.  'in "$@"' is superfluous.

	for arg
        do
        	...
	done

> +	orig_args="$@"

Doesn't this defeat the whole point of later running 'sq' on it?
The reason we do sq is to protect whitespaces in pathspecs and
make the strings correctly split when evaled/sourced.

A simple test program:

        #!/bin/sh
        sq () {
                echo "** fake sq $* **"
                i=0
                for j
                do
                        echo "$i: <$j>"
                        i=$(( $i + 1 ))
                done
                echo
        }

        set x a 'b c' d
        shift
        # Now, $# = 3, $1 = 'a', $2 = 'b c' and $3 = 'd'
        orig_args="$@"
        sq "$@"
        sq "$orig_args"

> ...
> -	    sq "$@"
> -	} >"$GIT_DIR/BISECT_LOG"
> -	sq "$@" >"$GIT_DIR/BISECT_NAMES"
> +	    sq "$orig_args"
> +	} >>"$GIT_DIR/BISECT_LOG"
> +	bisect_auto_next
>  }
