From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Bisect: implement "git bisect run <cmd>..." to automatically bisect.
Date: Thu, 22 Mar 2007 00:14:05 -0700
Message-ID: <7vejnhwy0y.fsf@assigned-by-dhcp.cox.net>
References: <20070322070859.a86c0cb4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 08:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUHVa-0001jh-2a
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 08:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965786AbXCVHOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 03:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbXCVHOI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 03:14:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37504 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933151AbXCVHOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 03:14:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322071404.RMLJ1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 03:14:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id djE51W00T1kojtg0000000; Thu, 22 Mar 2007 03:14:05 -0400
In-Reply-To: <20070322070859.a86c0cb4.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 22 Mar 2007 07:08:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42843>

Christian Couder <chriscool@tuxfamily.org> writes:

> This idea was suggested by Bill Lear
> (Message-ID: <17920.38942.364466.642979@lisa.zopyra.com>)
> and I think it is a very good one.

Nicely done.

People often find that during bisect they want to have a
near-constant tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/
in a header file, or "revision that does not have this commit
needs this patch applied to work around other problem this
bisection is not interested in") applied to the revision being
tested.  

To cope with such a situation, after the inner git-bisect finds
the next revision to test, with the "run" script, the user can
apply that tweak before compiling, run the real test, and after
the test decides if the revision (possibly with the needed
tweaks) passed the test, rewind the tree to the pristine state.
Finally the "run" script can exit with the status of the real
test to let "git-bisect run" command loop to know the outcome.

When you write a documentation for this patch, the above issue
should be addressed, as this is often asked on and off the list.

> @@ -220,6 +222,50 @@ bisect_replay () {
>  	bisect_auto_next
>  }
>  
> +bisect_run () {
> +    while true
> +    do
> +      echo "running $@"
> +      "$@"
> +      res=$?
> +
> +      # Check for really bad run error.
> +      if [ $res -lt 0 -o $res -ge 128 ]; then
> +	  echo >&2 "bisect run failed:"
> +	  echo >&2 "exit code $res from '$@' is < 0 or >= 128"
> +	  exit $res
> +      fi

I am not sure if this flexibility/leniency is desirable.  It
certainly allows a sloppily written shell script that exits with
any random small-positive values to report a badness, which may
be handy, but allowing sloppiness might lead to wasted time
after all.  I dunno.  A more strict convention that says the run
script should exit 1 to signal "bad, please continue", 0 for
"good, please continue" and other values for "no good, abort"
might be less error prone.

In any case, the exit status convention needs documentation.

A program that does "exit(-1)" leaves $? = 255 (see exit(3)
manual page, the value is chopped with "& 0377"), so the test
for -ge 128 is certainly good; I do not know if any system gives
negative values, but the check shouldn't hurt.  As a style, I
would have written that as:

	if test $res -lt 0 || test $res -ge 128
        then
        	...

but that is probably a bit old-fashioned.  

> +      # Use "git-bisect good" or "git-bisect bad"
> +      # depending on run success or failure.
> +      # We cannot use bisect_good or bisect_bad functions
> +      # because they can exit.
> +      if [ $res -gt 0 ]; then
> +	  next_bisect='git-bisect bad'
> +      else
> +	  next_bisect='git-bisect good'
> +      fi
> +
> +      $next_bisect > "$GIT_DIR/BISECT_RUN"


If their exiting, and possibly variable assignments, are the
only problem, you can run that in subshell, can't you?  Like:

	( $next_bisect >"$GIT_DIR/BISECT_RUN" )

> +      res=$?
