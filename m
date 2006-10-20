From: linux@horizon.com
Subject: Re: VCS comparison table
Date: 20 Oct 2006 04:43:18 -0400
Message-ID: <20061020084318.9705.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Oct 20 10:43:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapyN-00018z-Pb
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 10:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992594AbWJTInU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 04:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992595AbWJTInU
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 04:43:20 -0400
Received: from science.horizon.com ([192.35.100.1]:43319 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S2992594AbWJTInU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 04:43:20 -0400
Received: (qmail 9706 invoked by uid 1000); 20 Oct 2006 04:43:18 -0400
To: loki@research.canon.com.au
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29421>

> I've been following the git-vs-bzr discussion, and I'd like to ask a
> question (being new to both bzr and git). How does git disambiguate SHA1
> hash collisions? I think git has an alternative way to name revisions
> (can someone please explain it in more detail, I've seen <ref>~<n>
> mentioned only in passing in this thread). It seems to me collisions are
> a good argument in favour of having two independent naming schemes, so
> that you're not solely relying on hashes being unique.
> 
> A strong argument is that a global namespace based on hashes of data is
> ideal because the names are generated from the data being named, and
> therefore are immutable. Same data => same name for that data, always
> and forever, which is desirable when merging named data from many
> sources. But the converse isn't true: one name does not necessarily map
> to only that data. Have I misunderstood? Is this a problem?

Git avoids the problem by using a very large gryptographic hash.
While recent cryptographic advances mean that it will soon be barely
possible to deliberately construct two files with the same SHA hash,
absent massivecomputational investment, it can be considered a truly
random hash function.

That means that, given N objects in the repository, there are N * (N-1)
/ 2 pairs, each of which is a chance to collide.  The probability of
having a collision is thus roughly N * (N-1) / 2^161.  Which doesn't
reach 1/2 until N == 2^80.

Suppose a git repository has 100 objects added per second, continuously,
until the Sun turns into a red giant and swallows the Earth in 5-6
billion years' time (thus halting development).

That will generate 2^64 objects in the repository, and the probability
of there being a collison at that time is 2^128/2^161 = 2^-33, or 1 in
8 billion, small enough to be negligible.

For slightly more plausible repository sizes, the odds of having a
problem are even more miniscule.

And the benefits gained from having a completely deterministic
data => name mapping are considerable, well worth running such
a minisule risk of major problems.

(There is a road map for conversion to the even larger SHA-256 if
that ever proves necessary, but it's not likely to.)



As for the <ref>~<n> syntax, see "man git-rev-parse".  The parent of <rev>
is <rev>^.  If it has multiple parents, the othersare <rev>^2, <rev>^3, etc.

<rev>^^^^ is the great-great-grandparent of the named rev, and may also
be written <rev>~4.
