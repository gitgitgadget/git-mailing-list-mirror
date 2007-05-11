From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel cherry UN-picking?
Date: Fri, 11 May 2007 15:09:14 -0700
Message-ID: <7vbqgr9fn9.fsf@assigned-by-dhcp.cox.net>
References: <4644E0A2.90008@garzik.org>
	<7vhcqj9g8r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat May 12 00:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmdIf-0007Ow-Sq
	for gcvg-git@gmane.org; Sat, 12 May 2007 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793AbXEKWJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758728AbXEKWJR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 18:09:17 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48940 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758487AbXEKWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 18:09:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511220916.EXCZ24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 18:09:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xy9F1W00g1kojtg0000000; Fri, 11 May 2007 18:09:16 -0400
In-Reply-To: <7vhcqj9g8r.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 11 May 2007 14:56:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46991>

Junio C Hamano <junkio@cox.net> writes:

> Jeff Garzik <jeff@garzik.org> writes:
>
>> So, I merge the next batch of net driver patches.  After I merge a PPP
>> patch, deep in the pile-o-patches, Andrew says "I shouldn't have sent
>> that to you, don't apply it"  ;-)
>>
>> Right now, my process for reversing this damage is to start over:
>> create a new branch, manually double-click the mouse on each commit in
>> the "damaged" branch, and git-cherrypick it.  Very, very time
>> consuming when you have more than a couple commits.
>
> Do the commits on the branch being rebuilt form a single strand
> of pearls without any merges?  If that is the case, what I would
> do is:
>
> 	git heckout thatbranch
> 	git format-patch -o ./+outdir linus
>         rm ./+outdir/0XXX-that-unwanted-patch.patch
>         git reset --hard linus
>         git am ./+outdir/????-*.patch

Ok, you answered that your branch involves a merge from Linville
tree.

You would need to segment things then.

Suppose you have something like this (you may have more than one
such merge but the principle is the same):

  U---o---o---o---M---x---o---o---o---T
                 /
   Linville o---o

Up to 'U' you have already sent upstream and no need for
resending.  'M' is merge with Linville tree.  'x' is the bad
one, and 'o' are good ones.  'T' is the tip of your net driver
branch.

First find out 'x'.  Then

        git format-patch -o ./outdir x..T

would format everything starting from (but excluding) 'x' up to
'T'.

Then

        git reset --hard x^
        git am ./outdir/*.patch

would rebuild:

  U---o---o---o---M---x---o'--o'--o'--T'
                 /
   Linville o---o


A variant that needs "segmenting" is if the bad one is before
the merge, like this:

  U---o---x---b---M---o---o---o---o---T
                 /
   Linville o---a

First you need to note 'a' (tip of Linville you pulled) and 'b'
(tip of you before you pulled from Linville).  Then:

        git format-patch -o ./outdir-1 x..b
        git format-patch -o ./outdir-2 M..T
        git reset --hard x^
        git am ./outdir-1/*.patch

would give you this:


  U---o-------b'
                 
   Linville o---a

and leave you at b (rebased not to contain the bad one).  Then
you redo the Linville merge:

  U---o-------b'--M'
                 /
   Linville o---a

And finally apply the rest:

        git am ./outdir-2/*.patch

to arrive at:

  U---o-------b'--M'--o'--o'--o'--o'--T'
                 /
   Linville o---a
