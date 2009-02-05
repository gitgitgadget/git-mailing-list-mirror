From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Article about "git bisect run" on LWN
Date: Thu, 5 Feb 2009 15:13:36 +0100
Message-ID: <20090205141336.GA28443@elte.hu>
References: <200902050747.50100.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 15:16:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV51a-0000c5-6O
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 15:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZBEOOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 09:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbZBEOOn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 09:14:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33594 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbZBEOOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 09:14:42 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LV4zA-0002Sq-MI
	from <mingo@elte.hu>; Thu, 05 Feb 2009 15:13:48 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 3BC973E21B0; Thu,  5 Feb 2009 15:13:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200902050747.50100.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108565>


* Christian Couder <chriscool@tuxfamily.org> wrote:

> Hi,
> 
> For information, an article from me, 'Fully automated bisecting with "git 
> bisect run"' has been published in today's edition of LWN on the 
> development page:
> 
> http://lwn.net/Articles/317154/

Nice article!

In terms of possible future enhancements of git bisect, here's a couple of 
random ideas that would help my auto-bisection efforts:

 - Feature: support "Bisection Redundancy"

   This feature helps developers realize if a bug is sporadic. This happens 
   quite often in the kernel space: a bug looks deterministic, but down the 
   line it becomes sporadic. Sometimes a boot crash only occurs with a 75% 
   probability - and if one is unlucky it can cause a _lot_ of wasted 
   bisection time. The wrong commit gets blamed and the wrong set of 
   developers start scratching their heads. It's a reoccuring theme on lkml.

   What git could do here is to allow testers to inject a bit of extra 
   "redundancy" automatically, and use the redundant test-points to detect 
   conflicts in good/bad constraints.

   It would work like this:

      git bisect start --redundancy=33%

   It would mean that for every third bisection points, Git would
   _not_ chose the ideal (estimated) 'middle point' from the set of "unknown 
   quality" changes that are still outstanding - but would intentionally 
   "weer outside" and select one commit from the _known_ set of commits.

   If such a redundant re-test of the known-good or known-bad set yields a 
   nonsensical result then Git aborts the bisection with a "logic
   inconsistency detected" kind of message - and people could at this point
   realize the non-determinism of the test.

   ( Git can do this when a "redundant" test point is marked as 'bad' - 
     despite an earlier bisection already categorizing that test point as 
     'good' - or if it's the other way around. Git will only continue with 
     the bisection if the test point has the expected quality. )

   This essentially means an automated re-test - but it's much better than 
   just a repeated bisection - i've often met non-deterministic bugs that 
   yield the _exact same_ nonsensical commit even on repeat bisections. That 
   happens when a timing bug depends on the exact kernel layout, or a 
   miscompilation or linker bug depends on the exact kernel layout, etc.

   It's also faster than a re-done bisection: 33% more testpoints is better 
   than twice as many test-points. Also, auto-bisection can deal with 
   redundancy just fine - it does not really matter whether i have to wait 
   20 or 30 minutes for a test result since there's no manual intervention 
   needed - but it _very_ much matters whether i can trust the validity of 
   the bisection result.

- Feature: better "git bisect next" support.

  Sometimes a commit wont build. In that case we have "git bisect next", but 
  last i checked that only jumps a single commit - and build breakages 
  often have a large scope - full trees that got merged upstream, etc. Most 
  of the time those build breakages are uninteresting and the build-broken 
  window does not contain the bad commit.

  So it would be nice to have a "git bisect next --left=20%" type of 
  feature. This would jump 20% commits to the "left" from the bisection 
  point, towards the 'known bad' set of commits, but still within the 
  bisection window.

  Similarly, "git bisect next --right=20%" would jump towards the known-good 
  edge of the bisection window (but still within the bisection window).

  Currently when i hit a build error during auto-bisection, it aborts and i 
  have to intervene manually. But with a bigger jump distance i could use
  git-bisect-next reliably in scripts too.

  Likewise, users too hit build breakages often, and find it hard to get out 
  of the window of breakage. With the high-order tree structure of the 
  kernel repository that is rather non-intuitive to do as well, and often 
  people make mistakes and test the wrong commit.

- Feature: detect "redundant" and "inconsistent" test points

  This is a variation of the redunant testing theme, but from a different 
  angle: often newbies when they bisect the kernel weer outside of the 
  bisection window without realizing it. It would be nice if Git printed a 
  friendly notifier that:

     git bisect good 12341234
     info: bisection point 12341234 was already in the 'good' range

  Or, if the redunant test point is conflicting, print:

     git bisect good 12341234
     fatal: bisection point 12341234 was already in the 'bad' range!

  And give an error return as well, so that scripts can abort.

  Currently Git seems to be very forgiving and accepts all bisection points 
  that we feed it, without checking them for consistency. (this might have 
  changed in current development versions, i dont know.)

- User friendliness: give an estimation about how many steps are remaining

  Right now git prints this when a bisection session begins:

     aldebaran:~/tip> git bisect start
     aldebaran:~/tip> git bisect bad linus
     aldebaran:~/tip> git bisect good v2.6.28
     Bisecting: 5449 revisions left to test after this
     [e0b685d39a0404e7f87fb7b7808c3b37a115fe11] Updated contact info for CREDITS file

  It would be nice if Git estimated the expected number of bisection points. 
  Something like this would be helpful:

     aldebaran:~/tip> git bisect good v2.6.28
     Bisecting: 5449 revisions left to test after this
                About ~16 test steps left [approximated]
     [e0b685d39a0404e7f87fb7b7808c3b37a115fe11] Updated contact info for CREDITS file

  The real number of test points might be higher than this, if the tree 
  layout is unlucky, or it might be less than this if the user manually 
  narrows the bisection window to a suspected set of commits - but that's 
  OK - most kernel testers use the default variant and the message is clear 
  enough that it's only an estimation.

	Ingo
