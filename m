From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] threeway_merge: if file will not be touched, leave it alone
Date: Sun, 22 Oct 2006 16:11:29 -0700
Message-ID: <7vlkn80wv2.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	<200610202047.11291.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
	<45391F1C.80100@utoronto.ca>
	<Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
	<4539318D.9040004@utoronto.ca>
	<Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
	<Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4ptyjttb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0610222301080.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbmTf-0002ep-MD
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJVXLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWJVXLc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:11:32 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10381 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750743AbWJVXLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:11:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022231130.DWJ22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 19:11:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dbBZ1V00h1kojtg0000000
	Sun, 22 Oct 2006 19:11:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610222301080.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 22 Oct 2006 23:04:07 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29802>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	How about this? It passes the testsuite, and I tested it with the 
> 	test case you did, and with the same test case with recursive 
> 	merge.
>
>  unpack-trees.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3ac0289..b4994c4 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -658,10 +658,9 @@ int threeway_merge(struct cache_entry **
>  	 * up-to-date to avoid the files getting overwritten with
>  	 * conflict resolution files.
>  	 */
> -	if (index) {
> +	if (index)
>  		verify_uptodate(index, o);
> -	}
> -	else if (path)
> +	else if (no_anc_exists)
>  		verify_absent(path, "overwritten", o);
>  
>  	o->nontrivial_merge = 1;

This feels wrong at the philosophical level.  unpack-trees and
read-tree do not know, and more importantly, do not want to
decide, the outcome of the merge, so it should not be doing
verify_absent because it does not know if the path will be
overwritten by the merge.

Complaining when no_anc_exists means that threeway_merge() is
deciding that the merge result should have the path in this
case.  It might be true for the current merge-recursive and
merge-resolve, but I do not think we should force that decision
on future merge strategies, since that is the whole point of
declaring the merge to be nontrivial and _not_ deciding the
outcome ourselves here.
