From: Geert Bosch <bosch@adacore.com>
Subject: Re: Fix up diffcore-rename scoring
Date: Fri, 14 Apr 2006 13:46:56 -0400
Message-ID: <C7296176-E37E-4BD3-A33A-36B79BEC8B39@adacore.com>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org> <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org> <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org> <DFDDA9C5-D8D2-413F-8A06-4D727C8F9EED@adacore.com> <7vmzer4vmm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 19:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUSNs-0006kD-Qq
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 19:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDNRrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 13:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDNRrB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 13:47:01 -0400
Received: from nile.gnat.com ([205.232.38.5]:49834 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751325AbWDNRrA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 13:47:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 9918948CDD7;
	Fri, 14 Apr 2006 13:46:51 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 26890-01-8; Fri, 14 Apr 2006 13:46:51 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 7355D48CDC9;
	Fri, 14 Apr 2006 13:46:51 -0400 (EDT)
In-Reply-To: <7vmzer4vmm.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18693>


On Apr 11, 2006, at 18:04, Junio C Hamano wrote:
>> Here's a possible way to do that first cut. Basically,
>> compute a short (256-bit) fingerprint for each file, such
>> that the Hamming distance between two fingerprints is a measure
>> for their similarity. I'll include a draft write up below.
>
> Thanks for starting this.
>
> There are a few things I need to talk about the way "similarity"
> is _used_ in the current algorithms.
>
> Rename/copy detection outputs "similarity" but I suspect what
> the algorithm wants is slightly different from what humans think
> of "similarity".  It is somewhere between "similarity" and
> "commonness".  When you are grading a 130-page report a student
> submitted, you would want to notice that last 30 pages are
> almost verbatim copy from somebody else's report.  The student
> in question added 100-page original contents so maybe this is
> not too bad, but if the report were a 30-page one, and the
> entier 30 pages were borrowed from somebody else's 130-page
> report, you would _really_ want to notice.

There just isn't enough information in a 256-bit fingerprint
to be able to determine if two strings have a long common
substring. Also, when the input gets longer, like a few MB,
or when the input has little information content (compresses
very well), statistical bias will reduce reliability.

Still, I used the similarity test on large tar archives, such
as complete GCC releases, and it does give reasonable
similarity estimates. Non-related inputs rarely have scores
above 5.

potomac%../gsimm - 
rd026c470aab28a1086403768a428358f218bba049d47e7d49f8589c2c0baca0c *.tar
55746560 gcc-2.95.1.tar 123 3.1
55797760 gcc-2.95.2.tar 112 11.8
55787520 gcc-2.95.3.tar 112 11.8
87490560 gcc-3.0.1.tar 112 11.8
88156160 gcc-3.0.2.tar 78 38.6
86630400 gcc-3.0.tar 80 37.0
132495360 gcc-3.1.tar 0 100.0

I'm mostly interested in the data storage aspects of git,
looking bottom-up at the blobs stored and deriving information
from that. My similarity estimator allows one to look at thousands
of large checked in files and quickly identify similar files.
For example, in the above case, you'd find it makes sense
to store gcc-3.1.tar as a difference from gcc-3.0.tar.
Doing an actual diff between these two archives takes a few
seconds, while the fingerprints can be compared in microseconds.

> While reorganizaing a program, a nontrivial amount of text is
> often removed from an existing file and moved to a newly created
> file.  Right now, the way similarity score is calculated has a
> heuristical cap to reject two files whose sizes are very
> different, but to detect and show this kind of file split, the
> sizes of files should matter less.
The way to do this is to split a file at content-determined
breakpoints: check the last n bits of a cyclic checksum over
a sliding window, and break if they match a magic number.
This would split the file in blocks with expected size of 2^n.
Then you'd store a fingerprint per chunk.
> [...]
> Another place we use "similarity" is to break a file that got
> modified too much.  This is done for two independent purposes.
This could be done directly using the given algorithm.

> [...] Usually rename/copy
> detection tries to find rename/copy into files that _disappear_
> from the result, but with the above sequence, B never
> disappears.  By looking at how dissimilar the preimage and
> postimage of B are, we tell the rename/copy detector that B,
> although it does not disappear, might have been renamed/copied
> from somewhere else.
This could also be cheaply determined by my similarity estimator.
Almost always, you'd have a high similarity score. When there is
a low score, you could verify with a more precise and expensive
algorithm to have a consistent decision on what is considered
a break.

There is a -v option that gives more verbose output, including
estimated and actual average distances from the origin for the
random walks. For random input they'll be very close, but for
input with a lot of repetition the actual average will be far
larger. The ratio can be used as a measure of reliability of
the fingerprint: ratio's closer to 1 are better.
> Also we can make commonness matter even more in the similarlity
> used to "break" a file than rename detector, because if we are
> going to break it, we will not have to worry about the issue of
> showing an annoying diff that removes 100 lines after copying a
> 130-line file.  This implies that the break algorithm needs to
> use two different kinds of similarity, one for breaking and then
> another for deciding how to show the broken pieces as a diff.
>
> Sorry if this write-up does not make much sense.  It ended up
> being a lot more incoherent than I hoped it to be.
Regular diff algorithms will always give the most precise result.
What my similarity estimator does is give a probability that
two files have a lot of common substrings. Say, you'd have a
git archive with 10,000 blobs of about 1 MB, and you'd want
to determine how to pack this. You clearly can't use diff
programs to solve this, but you can use the estimates.

> Anyway, sometime this week I'll find time to play with your code
> myself.
Thanks, I'm looking forward to your comments.

   -Geert
