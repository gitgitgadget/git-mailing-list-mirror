From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix up diffcore-rename scoring
Date: Tue, 11 Apr 2006 15:04:17 -0700
Message-ID: <7vmzer4vmm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
	<7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603122316160.3618@g5.osdl.org>
	<DFDDA9C5-D8D2-413F-8A06-4D727C8F9EED@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 00:04:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTQyH-0006HO-Tk
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 00:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWDKWET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWDKWET
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 18:04:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17381 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751135AbWDKWES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 18:04:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411220418.BAUP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Apr 2006 18:04:18 -0400
To: Geert Bosch <bosch@adacore.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18620>

Geert Bosch <bosch@adacore.com> writes:

> On Mar 13, 2006, at 02:44, Linus Torvalds wrote:
>
>> It might be that the fast delta thing is a good way to ask
>> "is this even worth considering", to cut down the O(m*n)
>> rename/copy detection to something much smaller, and then use
>> xdelta() to actually figure out what is a good rename and
>> what isn't from a much smaller set of potential targets.
>
>
> Here's a possible way to do that first cut. Basically,
> compute a short (256-bit) fingerprint for each file, such
> that the Hamming distance between two fingerprints is a measure
> for their similarity. I'll include a draft write up below.

Thanks for starting this.

There are a few things I need to talk about the way "similarity"
is _used_ in the current algorithms.

Rename/copy detection outputs "similarity" but I suspect what
the algorithm wants is slightly different from what humans think
of "similarity".  It is somewhere between "similarity" and
"commonness".  When you are grading a 130-page report a student
submitted, you would want to notice that last 30 pages are
almost verbatim copy from somebody else's report.  The student
in question added 100-page original contents so maybe this is
not too bad, but if the report were a 30-page one, and the
entier 30 pages were borrowed from somebody else's 130-page
report, you would _really_ want to notice.

While reorganizaing a program, a nontrivial amount of text is
often removed from an existing file and moved to a newly created
file.  Right now, the way similarity score is calculated has a
heuristical cap to reject two files whose sizes are very
different, but to detect and show this kind of file split, the
sizes of files should matter less.

On the other hand, taking this "commonness matters" to its
extreme is not what we want.  We are producing "diff", so if a
30-line new file was created by moving these 30 lines from
originally 130-line file (which is now 100 lines long), showing
it as "copy from the-130-line-file" with a diff to remove
100-lines is usually not what we want.  That's why the size cap
makes sense in rename similarity estimator.

Another place we use "similarity" is to break a file that got
modified too much.  This is done for two independent purposes.

One is to detect a case like this:

	mv B C
        mv A B
        small-edit B

File B's content is not related to what it had originally, but
is derived from what was originally in A.  Usually rename/copy
detection tries to find rename/copy into files that _disappear_
from the result, but with the above sequence, B never
disappears.  By looking at how dissimilar the preimage and
postimage of B are, we tell the rename/copy detector that B,
although it does not disappear, might have been renamed/copied
from somewhere else.

Another is to present the final diff output as a complete
rewrite.  When -B (break) is used without -M (rename) or -C
(copy), or a file that got a lot of edit and got "broken" turned
out to be purely a total edit (i.e. not renamed/copied from
somewhere else), we would present it as diff output that has
only one hunk, with bunch of '-' (removal) to remove all
original contents first and then '+' (addition) to add all the
new contents, which is often easier to read than ordinary
unidiff between two unrelated contents that matches up lines
that happen to be the same.  Empirically, it seems to give
better result if the "similarity" threshold to "break" a file
(i.e. to consider it might have been renamed/copied from
somewhere else) is set lower than the threashold to show the
diff as a complete rewrite patch.

Also we can make commonness matter even more in the similarlity
used to "break" a file than rename detector, because if we are
going to break it, we will not have to worry about the issue of
showing an annoying diff that removes 100 lines after copying a
130-line file.  This implies that the break algorithm needs to
use two different kinds of similarity, one for breaking and then
another for deciding how to show the broken pieces as a diff.

Sorry if this write-up does not make much sense.  It ended up
being a lot more incoherent than I hoped it to be.

Anyway, sometime this week I'll find time to play with your code
myself.
