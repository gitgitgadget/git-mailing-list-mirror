From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git bisect not finding the right commit
Date: Thu, 19 Jan 2012 00:20:08 -0800
Message-ID: <7vlip4je87.fsf@alter.siamese.dyndns.org>
References: <87r4yw8j4i.fsf@franz.ak.mind.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig)
X-From: git-owner@vger.kernel.org Thu Jan 19 09:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnnEH-0007YP-VB
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 09:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab2ASIUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 03:20:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2ASIUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 03:20:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D724A41AD;
	Thu, 19 Jan 2012 03:20:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALrRpD/hCWHWuCqwJkEsO2eYg3Y=; b=aLgur7
	Wex/OltIm/bE6UXdeua1sxUF88sFwiT+InldyX/6JLo8BKMSCo2R6yqPaWjL88LY
	Vd/dKxHowZdQWFTdJjD+7asq1Y7MnprQFwzzqGrqr5KJ1IiTvmG9qPH23l9GIjW/
	c8C9SQcGNHRTE41dnL349yLWrLOZxfel2C8A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQhGRprDnD+hK4MmK2Nhecwsx4XkTlPm
	JerO90EWK3Y3LUS84aDo3sdZLHB2QQgQbxB03MS/orxIbQx7kEy6KZeRePSkJb4A
	lzczoGmgqOzPMyN32wGZG7hlO5oMorOhU6zK9OunpbAss48Hi8Y4ZNCGBQ/pB7y9
	M3Lg+Z1jR/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE83141AC;
	Thu, 19 Jan 2012 03:20:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1812141AB; Thu, 19 Jan 2012
 03:20:10 -0500 (EST)
In-Reply-To: <87r4yw8j4i.fsf@franz.ak.mind.de> (Andreas J. Koenig's message
 of "Thu, 19 Jan 2012 04:29:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67191FF6-4276-11E1-90F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188793>

andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig) writes:

> A v5.15.5
> B v5.15.5-20-gfd76d40
> C v5.15.5-81-gcfe287a
> D v5.15.5-159-ga71d67b
> E v5.15.4-110-g27b29ec
> F v5.15.4-169-g3582575
>
> The change in perl I tried to locate was v5.15.5-13-gff0cf12, between A
> and B. Bisect did not find it, it returned me E instead. Here the wrong
> bisect output:

Just for the sake of simplicity, I'll call ff0cf12 "Q" (the Questionable
one).

> % git bisect start v5.15.5-159-ga71d67b v5.15.5

You start by telling Git that D is bad and A is good.

I can see that D does contain Q (i.e. "git log D..Q" gives nothing), which
you should read as "D is _contaminated_ by the breakage Q introduced", so
D is indeed bad.

On the other hand, A does _not_ contain Q (i.e. "git log A..Q" gives
output), which you should read as "A is _not_ contaminated by the breakage
Q introduced", so A is indeed good.

So far so good...

> Already on 'blead'
> Bisecting: 77 revisions left to test after this (roughly 6 steps)
> [cfe287a06b2ed98c25aebb477f6b400409f1fc85] Merge remote-tracking branch 'p5p/smoke-me/gsoc-pod' into blead
> % git describe
> v5.15.5-81-gcfe287a

This is your "C", and "git log C..Q" does not give anything. C is
contaminated by Q, hence it is bad.

> % git bisect bad
> Bisecting: 40 revisions left to test after this (roughly 5 steps)
> [baf7658bacfa659cdab08050470b20ebd5973384] Update htmlview.t for new Pod::Html
> % git describe
> v5.15.4-149-gbaf7658

Here, baf7658 does not contain Q, so you are supposed to answer it is
GOOD.

> % git bisect bad

But you answered that it is BAD.

Why?

What caused you to say "bad" here to a commit that could not possibly have
inherited the breakage Q introduced?

One plausible explanation is that whatever symptom you are seeing in Perl
at version Q that you call "bad" may not be caused by a single root cause,
and a similar (or the same) symptom somehow appears at this version that
is _NOT_ contaminated by Q.

Another plausible scenario is that the symptom you are chasing may not be
reliably reproducible.

"bisection" by nature is an optimization technique applicable only when
you are chasing a reliably reproducible symptom that is caused by a single
cause, a breakage that existed in a single old version that is inherited
to all its descendants, and the "bad" symptom did not appear in any
version that does not inherit the breakage from that single problematic
commit.  If you have a history A--B--C--D--E, in which B breaks something,
C fixes its breakage and then D reintroduces another breakage that shows
the same symptom, you can not optimize the search for a problem using
bisect. You need to check each and every version.

Of course, people sometimes simply get confused and mistakenly say BAD
when they wanted to say GOOD. That may be a simpler explanation of what
happened to your bisection.

Anyway, the remainder of your bisect sequence is GiGo, so I'll snip them
and will not quote.
