From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 02:47:07 -0700
Message-ID: <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 11:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K75tT-0002RP-E2
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 11:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761407AbYFMJrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 05:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbYFMJrd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 05:47:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761407AbYFMJrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 05:47:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 84EBB2BAC;
	Fri, 13 Jun 2008 05:47:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2AFCD2BAB; Fri, 13 Jun 2008 05:47:19 -0400 (EDT)
In-Reply-To: <20080613074257.GA513@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 13 Jun 2008 03:42:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCD4318E-392D-11DD-B560-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84857>

Jeff King <peff@peff.net> writes:

> Reading your (and others') responses, it seems like there are two
> things:
>
>   1. Stashing is about saying "save everything about where I am now with
>      no hassle". IOW, it's one command, you don't have to decide what
>      goes and what stays, and you can pull it back out with one command.
>      And maybe there is a psychological component that you are not ready
>      to "commit" such a work-in-progress (I am extrapolating here, but I
>      know that when I first started with git, I was hesitant to commit
>      because of my experience with other systems).
>
>   2. Branches tend to get shared, and you don't want people to see your
>      stashes, because they are messy works in progress.
>
> To deal with '2', I wonder if it would be worth making some branches
> inaccessible to pushing/pulling (either via config, or through a special
> naming convention).

I personally do not find the example that Andreas gave unconvincing, not
because I doubt it happens in practice, but because I think it shows a bad
inter-developer communication.

It is natural to have branches that are private and/or not meant to be
built on top of by others.  We all have them --- heck, I have one that is
called 'pu' (not private but it is meant to be "only look, never touch"
and advertised as such).  But if we need a strong mechanism to enforce
that "never touch" policy by not allowing fetch, there is something wrong
with the inter-developer communication.

While digging the original thread earlier today (eh, it is already
yesterday here), I was thinking about what other alternative design and
implementation would have been sensible.  Here are some thoughts.

 * We _did not have to_ make stashes into refs/stash@{$N}.  We could have
   implemented them as individual refs under "refs/stash/$N" hierarchy.
   E.g. refs/stashes/1, refs/stash/2, etc.

   As a side note, we also could have implemented per-branch stash as
   refs/stashes/master@{$N} or refs/stashes/$branch/$N (and we still can.
   Perhaps we can have "git stash save -B" option that tells the command
   to send the resulting stash to the per-branch namespace).

 * We however chose to take advantage of the auto reclamation behaviour of
   reflog, and for most practical purposes, it is a good thing.

 * We later introduced "drop" because even as a volatile and short-lived
   collection of local modifications, you can tell that some stashes are
   utter crap immediately while deciding that some are worth keeping, even
   for a short term.

   This mechanism was however meant for uncluttering the set of stashes.
   "drop" names what you want to discard right now, and by doing so,
   implicitly names what you want to keep for a bit longer (by not naming
   them).  It's a reverse operation -- to make your gems easier to find,
   you discard garbage stash entries.  It is a useful work element.

 * We could add "keep" which is a complementary operation to "drop".  This
   would mark a stash as a gem in a more direct way, excempt even from the
   usual auto pruning.

   We probably implement this by marking the entry with a magic timestamp
   value, and teach reflog expiry machinery to keep it indefinitely.  You
   can still explicitly "drop" it.

I do not want to conflate two possibly independent issues, but I wonder if
there is a correlation between a change that people would want to stash to
a per-branch stash (if such a thing existed) and a change the people would
want to "keep" (if such a feature existed).

If there is a strong correlation between the two, one possible solution
would be to introduce refs/stashes/$branch/ namespace that holds each
stash as an individual, numbered ref under it.  They will live forever
until the user explicitly asks for their removal.  If we go this route, we
would need a few niceties such as a way to move a "quick stash" that is
represented as a reflog entry into a "longlived stash" that is represented
as an individual ref under refs/stashes/$branch/.

But let's not talk nor think about per-branch stash for now.  How does the
"keep" thing sound to people?
