From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 11:32:30 -0700
Message-ID: <7vfxdocgg1.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
	<7veit9m8cs.fsf@alter.siamese.dyndns.org>
	<863a9oz8lh.fsf@blue.stonehenge.com> <4A43A6B3.5020407@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtkQ-0005RK-VO
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbZFYSca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 14:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbZFYSc2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:32:28 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51692 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZFYSc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:32:28 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625183230.RFV20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Thu, 25 Jun 2009 14:32:30 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 8JYW1c00J4aMwMQ04JYWKB; Thu, 25 Jun 2009 14:32:30 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=YjxVEfEYJ9cA:10 a=7F2WDEu3UXN4eMTeP9wA:9
 a=ShuQO_CTz5TGZBCRjrIA:7 a=NDjQFNsl70t1FQvved2hvgZmf0YA:4 a=_RhRFcbxBZMA:10
 a=7GKGpSW4UZtGKo4B:21 a=J5f_SzffpmV9_2sl:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122230>

Matthias Andree <matthias.andree@gmx.de> writes:

> And if I may be so bold: Please rewrite before somebody starts polishing the
> bisect facilities WRT octopus merges. These seem unrelated, as in: you don't
> need to make bisect more convenient to be able to fix the description of
> git-pull --append...

Let's have a refresher course of how bisection works with a history with
merges.

Assume that you have this history (time flows from left to right, recent
commits are known to be bad, old commits are known to be good).

                       o---o---o---o---A
                      /                 \
  ---o---o---o---o---F---o---o---o---B---M

In real life, you would start from a history with more commits on top of M
and only know that the tip of that sequence is bad, but for brevity, let's
assume we bisected and already know M is bad.

If B is good, the breakage was either introduced at M, or was on the side
branch leading to A, but not older than F where A and B forked from.

    Side note.  As in all other discussion in this message, remember
    that bisect is for finding a _single_ breakage that was left
    unfixed til the tip of the history being bisected.  "B is good"
    means "the _single_ breakage is not in the commit that would
    affect B, i.e. in B's ancestors",

If B is bad, on the other hand, the branch leading to A since the fork
point F is exonerated and we do not have to look at the side branch that
leads to A.

Which means that by seeing one the tip of a merged branch is good, you
can see that everything before the merge base is good and you need to only
look at _the other_ branch.

What happens if M is an Octopus?

                       o---o---o---o---A
                      /                 \
  ---o---o---o---o---F---o---o---o---B---M
                  \       \             /|
                   \       o---o---o---C |
                    \                    |
                     o---o---o---o---o---D

If B is good, you still need to look at histories leading to A, C, and D
individually.  Of course if B is bad, then you do not have to look at 
the histrories leading to A, C and D from their respective fork points,
but you still do have to look at the shared past.

But we could optimize further.  After knowing M, an Octopus merge, is bad,
when we are tempted to test one of the tips of the branches that was
merged (say B), we can instead give a tree that is a result of merging
only A and B (i.e. excluding C and D) for testing.  If it is good, then
the histories leading to both A and B are good, and we only need to check
side branches leading C and D since they forked from the shared common
history.  If combination of A and B is bad, on the other hand, then we do
not have to check branch histories leading to C nor D.

Doing so essentially shifts the balance between what happens if a single
test turns out to be good or bad.  If we test the tip of the branch, and
if it is bad, we will eliminate other forks (but still need to test the
shared history).  If it is good, we only eliminate that particular branch
and shared history, but all the other forks remain suspect.  So it is a
tradeoff between:

 - the size of all the other side branches since they forked == number of
   commits we do not have to test if this round says "bad";

 - the size of this side branch and the shared history == number of
   commits we do not have to test if this round says "good";

The current bisect algorithm makes this tradeoff, by computing the above
two numbers and finding the point that makes them closest to each other.
It however does not let you test two commits at the same time (i.e.
testing the merge of A and B in the above example) which could make the
tradeoff even more efficient.

I see there is another window for optimization we could make from the
above observation.  Making the number of commits eliminated when the test
is "good" and "bad" as close to equal as possible is the best strategy
when the tested commit has a 50-50 chance of being "good" or "bad".  If we
somehow know that the tested commit is likely to be "bad", we would want
to maximize the number of commits eliminated when the commit is indeed
"bad" (and vice versa).

I do not see an easy way to exploit this window offhand, though...
