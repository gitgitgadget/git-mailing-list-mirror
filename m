From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Article about "git bisect run" on LWN
Date: Fri, 6 Feb 2009 02:46:55 +0100
Message-ID: <20090206014655.GA26807@elte.hu>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu> <alpine.DEB.1.10.0902051838180.5340@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Feb 06 02:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVFq8-00018p-2C
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 02:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbZBFBrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 20:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbZBFBrU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 20:47:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55033 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbZBFBrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 20:47:19 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LVFo4-0000Vv-OX
	from <mingo@elte.hu>; Fri, 06 Feb 2009 02:47:05 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 66F3C3E21B0; Fri,  6 Feb 2009 02:46:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902051838180.5340@asgard.lang.hm>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108647>


* david@lang.hm <david@lang.hm> wrote:

> On Thu, 5 Feb 2009, Ingo Molnar wrote:
>
>> * Christian Couder <chriscool@tuxfamily.org> wrote:
>>
>>> Hi,
>>>
>>> For information, an article from me, 'Fully automated bisecting with "git
>>> bisect run"' has been published in today's edition of LWN on the
>>> development page:
>>>
>>> http://lwn.net/Articles/317154/
>>
>> Nice article!
>>
>> In terms of possible future enhancements of git bisect, here's a couple of
>> random ideas that would help my auto-bisection efforts:
>>
>> - Feature: support "Bisection Redundancy"
>>
>>   This feature helps developers realize if a bug is sporadic. This happens
>>   quite often in the kernel space: a bug looks deterministic, but down the
>>   line it becomes sporadic. Sometimes a boot crash only occurs with a 75%
>>   probability - and if one is unlucky it can cause a _lot_ of wasted
>>   bisection time. The wrong commit gets blamed and the wrong set of
>>   developers start scratching their heads. It's a reoccuring theme on lkml.
>>
>>   What git could do here is to allow testers to inject a bit of extra
>>   "redundancy" automatically, and use the redundant test-points to detect
>>   conflicts in good/bad constraints.
>>
>>   It would work like this:
>>
>>      git bisect start --redundancy=33%
>>
>>   It would mean that for every third bisection points, Git would
>>   _not_ chose the ideal (estimated) 'middle point' from the set of "unknown
>>   quality" changes that are still outstanding - but would intentionally
>>   "weer outside" and select one commit from the _known_ set of commits.
>>
>>   If such a redundant re-test of the known-good or known-bad set yields a
>>   nonsensical result then Git aborts the bisection with a "logic
>>   inconsistency detected" kind of message - and people could at this point
>>   realize the non-determinism of the test.
>>
>>   ( Git can do this when a "redundant" test point is marked as 'bad' -
>>     despite an earlier bisection already categorizing that test point as
>>     'good' - or if it's the other way around. Git will only continue with
>>     the bisection if the test point has the expected quality. )
>>
>>   This essentially means an automated re-test - but it's much better than
>>   just a repeated bisection - i've often met non-deterministic bugs that
>>   yield the _exact same_ nonsensical commit even on repeat bisections. That
>>   happens when a timing bug depends on the exact kernel layout, or a
>>   miscompilation or linker bug depends on the exact kernel layout, etc.
>>
>>   It's also faster than a re-done bisection: 33% more testpoints is better
>>   than twice as many test-points. Also, auto-bisection can deal with
>>   redundancy just fine - it does not really matter whether i have to wait
>>   20 or 30 minutes for a test result since there's no manual intervention
>>   needed - but it _very_ much matters whether i can trust the validity of
>>   the bisection result.
>
> when you gave this the title of redundnancy and described the problem I  
> assumed that you would then propose running the test multiple times (so  
> "git bisect run X --redundancy 5" would run each test 5 times, it would  
> pass IFF it passed the test all 5 times. that would seem to be a better  
> match for the name, as well as being a better test

Yeah, but using 100%, 200%, 300%, etc. redundancy is a bit wasteful and not 
granular enough for my purposes.

Here's the math:

A typical kernel bisection takes 15 test steps. 30% of redundancy means that 
it takes only 30% longer, but for that we get +5 tests. Five extra test 
points are usually enough to establish whether a test method shows sporadic 
tendencies or not, with an ~90% confidence factor.

Repeating the test 5 times would bring a 15-steps kernel bisection from 30 
minutes [it's about 60 seconds to build a kernel, 60 seconds to boot it] to 
about 2.5 hours - that's very long. The confidence factor only goes from 
~90% to 99% - that extra 9% is not worth the cost.

The idea would be to insert 30% redunancy into my bisections automatically - 
so that i could trust _all_ bisections more - not just the ones i suspect to 
be non-deterministic. Hence the suggestion to enable lower levels of 
redundancy like 30%. (but even 10% or 20% might be enough to weed out the 
most obvious cases)

	Ingo
