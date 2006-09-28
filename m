From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --stat: ensure at least one '-' for deletions, and one '+' for additions
Date: Thu, 28 Sep 2006 10:10:07 -0700
Message-ID: <7v1wpvvrww.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609281735040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 19:10:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSzOp-0007u8-Tt
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWI1RKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWI1RKK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 13:10:10 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12475 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751953AbWI1RKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 13:10:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928171008.XFCP12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 13:10:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TtAA1V00U1kojtg0000000
	Thu, 28 Sep 2006 13:10:11 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28021>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The number of '-' and '+' is still linear. The idea is that
> scaled-length := floor(a * length + b) with the following constraints: if 
> length == 1, scaled-length == 1, and the combined length of plusses 
> and minusses should not be larger than the width by a small margin. Thus,
>
> 	a + b == 1
>
> and
> 	a * max_plusses + b + a * max_minusses + b = width + 1
>
> The solution is
>
> 	a * x + b = ((width - 1) * (x - 1) + max_change - 1)
> 		 / (max_change - 1)
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Nice looking math in the log message aside,...

> diff --git a/diff.c b/diff.c
> index 98c29bf..53c30bd 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -640,9 +640,12 @@ const char mime_boundary_leader[] = "---
>  static int scale_linear(int it, int width, int max_change)
>  {
>  	/*
> -	 * round(width * it / max_change);
> +	 * make sure that at least one '-' is printed if there were deletions,
> +	 * and likewise for '+'.
>  	 */
> -	return (it * width * 2 + max_change) / (max_change * 2);
> +	if (max_change < 2)
> +		return it;
> +	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
>  }

This does not feel right.  Maybe the first conditional is to see 
if it is less than 2, not max_change?

>  static void show_name(const char *prefix, const char *name, int len,
> @@ -774,9 +777,9 @@ static void show_stats(struct diffstat_t
>  		dels += del;
>  
>  		if (width <= max_change) {
> -			total = scale_linear(total, width, max_change);
>  			add = scale_linear(add, width, max_change);
> -			del = total - add;
> +			del = scale_linear(del, width, max_change);
> +			total = add + del;
>  		}
>  		show_name(prefix, name, len, reset, set);
>  		printf("%5d ", added + deleted);

The original was written a bit differently because it used
round() not floor(), and avoided the case of both ends end up
rounding up.

This version of scale_linear() rounds down so you can get away
with this without busting the total width.

But think about the case where width=7, max_change=10, 5
lines are added and 5 lines are removed.

The original makes total 7 to use full width, and gives 4 pluses
and 3 minuses, which is not quite right when your eyes notice
that they are not of equal length, but it makes it to use the
full width.  I think this version gives 3 pluses and minuses,
and does not use the full width.  However, if you have a file
that adds 10 without removing, it will be drawn as 7 pluses.  In
other words, the line drawn for a new file that is 10 lines
long, and the line for a modified file that added 5 lines and
removed 5 lines, are drawn differently.

I _think_ the graph length is reasonably long enough that the
actual differences coming from rounding (3 vs 4 in the above
description for the current implementation) is less annoying
than the total number of pluses and minuses not lining up for
two files that had both 10 changes, one (add=10,del=0) and the
other (add=5,del=5).  Illustration.

Compute total and add, make del=total-add:

	foo |   10 ++++---
        bar |   10 +++++++

Compute add and del independently:

	foo |   10 +++---
        bar |   10 +++++++

So I'd suggest either force the width to even number (if odd
drop one), of keep the current del=total-add.

How about doing something like this instead?

 - first scale the total but make sure there is one column for
   each of non-zero add and delete;

 - scale add but make sure it is at least one if non-zero;

 - del is the remainder of total after add is taken, but if
   there are too many adds than dels, that can become zero.  In
   that case adjust by giving one column from add to del.

diff --git a/diff.c b/diff.c
index 3fd7a52..9b9a6d8 100644
--- a/diff.c
+++ b/diff.c
@@ -684,9 +684,15 @@ static void show_stats(struct diffstat_t
 		dels += del;
 
 		if (width <= max_change) {
-			total = scale_linear(total, width, max_change);
-			add = scale_linear(add, width, max_change);
+			int fl = !!add + !!del;
+			total = scale_linear(total, width-fl, max_change) + fl;
+			if (add)
+				add = scale_linear(add, width-fl, max_change) + 1;
 			del = total - add;
+			if (!del && deleted) {
+				add--;
+				del++;
+			}
 		}
 		show_name(prefix, name, len, reset, set);
 		printf("%5d ", added + deleted);
