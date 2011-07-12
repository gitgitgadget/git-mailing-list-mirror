From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 23:07:16 +0200
Message-ID: <20110712210716.GB17322@toss.lan>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
 <20110712193844.GA17322@toss.lan>
 <20110712194540.GA21180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 23:07:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgkB9-0002QE-AI
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 23:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab1GLVH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 17:07:26 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:44519 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755613Ab1GLVHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 17:07:22 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 0F592130050;
	Tue, 12 Jul 2011 23:07:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110712194540.GA21180@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176980>

On Tue, Jul 12, 2011 at 03:45:40PM -0400, Jeff King wrote:
>
> It has been a long time since I've looked at darcs, but from my
> recollection, it will only work with specific patch types. That is, it
> works if B and C are commutative. For text patches that touch the same
> area, that is not the case. But if "B" were a token-renaming patch, for
> example, I think it might work.

If they were commutative, we would not have a problem in git
either.

> Anyway, that is not really relevant to git. I think we decided long ago
> that being simple and stupid about the content changes (i.e., blob A
> became blob B) is better in general, even when there are a few corner
> cases that might have been better off the other way.

Yes, but that only applies to git merge. When we talk about
rebasing we are looking at individual patches rather than a single
global merge. For rebase I think "patch algebra" is very relevant,
and we have already implemented a simple patch algebra with
patch-id's.

> > It does have better granularity when detecting changes. For
> > example, it will recognize the changes of B' in B, even if B
> > contains non-conflicting hunks on top of the changes in B'. Git
> > only recognizes identical commits, and this is something where we
> > could improve without too much difficulty (think per-hunk
> > patch-ids).
> 
> I'd be curious to see an example worked out. In my experience, even if
> something like patch-ids don't match, it's not a big deal for the hunks
> that do match, because when we get to the actual content merge, we will
> realize that both sides made the same change to that hunk.  So it's not
> like you are getting unrelated conflicts; whatever small part of the
> diff made the patch-id different will be the part where you get the
> conflict, and the should merge cleanly.

I am reading that last part as "they should not merge cleanly". And
in general I agree. We have to resolve the conflict manually and
it's just a question of how the conflict is presented and resolved.
This is already being discussed some in a different branch of this
thread.

> Having said something so general, I'm sure there is probably some corner
> case that proves me wrong.

Exactly. The case I am talking about is where the patch-id's are
different but there are no conflicts. I have worked out an example
for git and darcs. Below are two scripts to demonstrate. In the
example, the patch-id is different because upstream changes the
patch in a way that does not conflict with the original patch. It
simply adds another change that goes into a different hunk. Git
fails to merge cleanly because the patch-id's are different. It
presents the user with an awkward conflict that looks like a
revert. Darcs, on the other hand, merges cleanly. It recognizes the
fact that all changes from the original patch are contained
upstream and do not conflict with the upstream version. The fact
that more changes are added on top does not bother darcs.

Now, one might argue that this is a corner case. But it's actually
very common. In the example, the patch-id changes because of an
extra change in a different text area. That is indeed unlikely.
However, the same problem will occur in a much more common case.
Let's say we have a patch with 10 hunks. The patch is applied
upstream, with only one difference in one of the hunks.
Subsequently, text areas affected by any of the other hunks change
upstream. When the original patch is rebased on top of that, it
will conflict with the one hunk that was changed in the upstream
version of that patch. And that's ok. Git should not decide which
version is correct. But in addition to that conflict there will
also be conflicts for all the other hunks, which the upstream patch
did _not_ modify. And all of those conflicts will look like
reverts.

I believe that is the main reason why rebase is so painful all the
time.

But I am not saying that we necessarily need a finer granularity of
patch-id's. If we rebase the patch on top of its upstream version
before rebasing it to the upstream head, as was already suggested
elsewhere, the problem described here will also go away on its own.

Clemens

---

#!/bin/sh
#
# Darcs recognizes matching upstream changes
#

testdir=test-darcs

mkdir "$testdir" || exit 1

(
	cd "$testdir"
	mkdir master
	cd master
	darcs init

	for line in $(seq 20)
	do
		echo $line >>file
	done

	darcs add file
	darcs record -a -m initial

	cd ..
	darcs get master side
	cd side
	sed -i '5 s/^.*$/original change/' file
	darcs record -a -m 'original change'

	cd ../master
	sed -i '5 s/.*/original change/' file
	sed -i '15 s/^.*$/with an extra hunk/' file
	darcs record -a -m 'original change'

	sed -i '5 s/.*/modified change/' file
	darcs record -a -m 'modified change'

	darcs pull -a ../side
)

#!/bin/sh
#
# Git does not recognize matching upstream changes
#

testdir=test-darcs

mkdir "$testdir" || exit 1

(
	cd "$testdir"
	mkdir master
	cd master
	darcs init

	for line in $(seq 20)
	do
		echo $line >>file
	done

	darcs add file
	darcs record -a -m initial

	cd ..
	darcs get master side
	cd side
	sed -i '5 s/^.*$/original change/' file
	darcs record -a -m 'original change'

	cd ../master
	sed -i '5 s/.*/original change/' file
	sed -i '15 s/^.*$/with an extra hunk/' file
	darcs record -a -m 'original change'

	sed -i '5 s/.*/modified change/' file
	darcs record -a -m 'modified change'

	darcs pull -a ../side
)
