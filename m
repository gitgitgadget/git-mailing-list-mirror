From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-diff -p :/anything" always segfaults
Date: Sun, 11 Mar 2007 13:58:18 -0700
Message-ID: <7vslcbv6ol.fsf@assigned-by-dhcp.cox.net>
References: <87d53fsjiz.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0703111322180.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQV7X-0002XA-1M
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbXCKU6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXCKU6T
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:58:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47717 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbXCKU6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:58:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311205817.BFGK2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 16:58:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZYyJ1W00B1kojtg0000000; Sun, 11 Mar 2007 16:58:18 -0400
In-Reply-To: <Pine.LNX.4.64.0703111322180.9690@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 11 Mar 2007 13:25:33 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41981>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 11 Mar 2007, Jim Meyering wrote:
>>
>> I like the idea of the new ':/<oneline prefix>' notation, and gave it
>> a try, but all I could get was a segfault.  It was dereferencing a NULL
>> commit list.  Fix below.  With it, this example now works:
>
> The fix is correct, but not complete.
>
>> -	while ((commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {
>> +	while (list && (commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {
>
> The old code was broken, but the new one isn't much better.
>
> "pop_most_recent_commit()" simply doesn't work that way. It *never* 
> returns NULL. So having it as part of a while-loop was buggy to begin 
> with, and you fixed the test, but the thing is, it should just look like
>
> 	while (list) {
> 		struct commit *commit;
>
> 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
> 		..
>
> and the "pop_most_recent_commit()" simply shouldn't be part of the 
> conditional at all.

That's what I did in my tentative commit based on Jim's patch
(except "commit" is also used to determine the return value from
the function).
