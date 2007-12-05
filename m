From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size limitation
Date: Wed, 05 Dec 2007 11:47:26 +0100
Message-ID: <85bq95wh8h.fsf@lola.goethe.zz>
References: <20071201160113.GA20849@nomad.office.altlinux.org>
	<7vlk8e42qb.fsf@gitster.siamese.dyndns.org>
	<20071203215007.GA14697@basalt.office.altlinux.org>
	<alpine.LFD.0.9999.0712031559480.8458@woody.linux-foundation.org>
	<Pine.LNX.4.64.0712040054280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Dmitry V. Levin" <ldv@altlinux.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izrmz-0004Wd-Fo
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbXLEKrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbXLEKrN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:47:13 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:53635 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbXLEKrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:47:11 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IzrmU-0005g6-Jl; Wed, 05 Dec 2007 05:47:06 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 68CD81C40B64; Wed,  5 Dec 2007 11:47:27 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0712040054280.27959@racer.site> (Johannes
	Schindelin's message of "Tue, 4 Dec 2007 01:00:39 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67135>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 3 Dec 2007, Linus Torvalds wrote:
>
>> On Tue, 4 Dec 2007, Dmitry V. Levin wrote:
>> >
>> > Average file size in the linux-2.6.23.9 kernel tree is 10944 bytes,
>> 
>> Don't do "average" sizes. That's an almost totally meaningless number.
>> 
>> "Average" makes sense if you have some kind of gaussian distribution or 
>> similar.
>
> To enhance on that: Gaussian is symmetric, which cannot be the proper 
> distribution for anything that is non-negative.

This reasoning is nonsense, since Gaussians are not necessarily
symmetric about zero, and for example the equally distributed
probability between 0 and 1 is both symmetric and non-negative.  And the
trivial distribution of "always zero" is even _both_ symmetric around
zero and non-negative.

What is true for Gaussians is that their probability is non-zero
everywhere.  But with a meaning of "non-zero" that should let the kind
of people using hashes for unique file identification sleep well.

> I see so many mis-applications of statistics/probability theory in my
> day job that I cannot resist pointing people to the Poisson
> distribution here (in whose context "average" actually makes kind of
> sense).

The main point of Gaussians is that they approximate a distribution
coming from a sum of independent random sources pretty well, even if the
individual sources are not Gaussians themselves.

Poisson distributions come about as the sum of independent exponential
distributions, and yes, when the number of summands grows, the result is
quite well modeled by a Gaussian: the impossible outliers predicted by
the Gaussian approximation take a negligible probability of the total.

If the distribution is more like coming from a product of independent
sources, the results will be better modeled by log-Gaussian
distributions (which happen to be non-negative).

The exponential distribution happens to be the log-distribution of the
(0,1) equal probability distribution, so for lower order Poisson
distributions, approximation with log-Gaussians may seem more
straightforward.

> But back to the problem: if you have a truly binary file, then _every_
> byte (absent further information, of course) has a probability of
> 1/256 of being 0.

Absent any information, there is no reason to assume equal probability
as more likely than other probabilities.

> Which means that if a file is binary,

is _random_ binary.  Few people version random binary files.  It is
rather pointless.

> but is unusual enough to have that property only for half of the first
> 8192 bytes, you get a probability of 1 - 1 / 256^4096 = 1 - 1 / 2 ^
> 32768 that the current test succeeds.

Rather

(1-1/256)^4096 ~= exp(-4096/256) = about 1 in 10 million

Which means that the test would yield a false negative (with regard to
the data being binary) about once in 10000000 times when done on 4096
bytes, even given your rather absurd assumption of random binary data
being versioned.

To make this somewhat more obvious: let's take a look at the probability
of 128 random bytes being all non-zero.  According to your model, that
should be (1-1/256^128)=1-1/32768.  According to mine, (1-1/256)^128 ~=
exp(-0.5) ~= 60%.  Why is this even more than 50%, which would be the
naive assumption?  Because it is likely that we will have duplicate
bytes among our 128 bytes, so the probability for an occurence of 0
becomes less.

> I fail to see how this test can possibly fail for the average case.

You start with a nonsensical mathematical model, and don't even do the
math right that would follow from it.

The "average case" is not random equidistributed uncorrelated data,
anyway.

> So if it fails only for special cases, we are probably (in the common,
> not the mathematical, sense) better off asking those people
> encountering them to add git-attributes for the files.
>
> IMHO that is not asking for too much.

That the problem has actually been encountered in real life does not
exactly do much to support your assumptions and your conclusions, does
it?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
