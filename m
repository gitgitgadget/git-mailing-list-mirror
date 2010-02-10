From: Jeff King <peff@peff.net>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Wed, 10 Feb 2010 00:09:02 -0500
Message-ID: <20100210050902.GD28526@coredump.intra.peff.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
 <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
 <20100207193320.GB3185@coredump.intra.peff.net>
 <7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:10:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf4qZ-000513-0u
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab0BJFJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:09:01 -0500
Received: from peff.net ([208.65.91.99]:43342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab0BJFJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:09:01 -0500
Received: (qmail 29936 invoked by uid 107); 10 Feb 2010 05:09:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 00:09:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:09:02 -0500
Content-Disposition: inline
In-Reply-To: <7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139485>

On Sun, Feb 07, 2010 at 12:25:13PM -0800, Junio C Hamano wrote:

> Suppose Alice, Bob and I are involved in a project, and we annotate
> commits for some shared purpose (say, tracking regressions).  Alice and
> Bob may independently annotate overlapping set of commits (and hopefully
> they have shared root for their notes history as they are collaborating),
> and they may even be working together on the same issue, but I may not be
> involved in the area.  What happens when I pull from Alice and Bob and get
> conflicts in notes they produced, especially the only reason I was
> interested was because they have new things to say about commits that I am
> interested in?

Hmm. OK, I see the point of Jakub's message a bit more now. You want to
create a new view, inconsistent with that of either Alice or Bob (that
is, you have taken snippets of each's state, but you cannot in good
faith represent this as a history merge, because your state should not
supersede either of theirs).

The standard way to do such a thing in git is to create a new, alternate
history through cherry-picking or rebasing. So I suspect we could do
something like:

  1. git notes pull alice

     We fast-forward (or do the trivial merge) with Alice's work.

  2. git notes pull --ignore-conflicts bob

     We try to merge Bob's work and see that there are conflicts. So we
     iterate through refs/notes..bob/notes, cherry-picking each one that
     applies cleanly and ignoring the rest.

And then you're at a state inconsistent with Bob, and a superset of what
Alice has. And that's what your history represents, too: you've branched
but done some of the same things as Bob. At that point you can examine
your inconsistent state, and then when you're done, you can either:

  3a. Reset back to your pre-ignore-conflicts state.

  3b. Leave it. When you pull from Bob later, your shared changes will
      be ignored[1], and you will get the conflicts that you ignored
      earlier.

It is perhaps a hacky band-aid to handle notes this way, but it is the
"most git" way of doing it. That is, it uses our standard tools and
practices.  And when all you have is a hammer... :)  And I really expect
the "I am collaborating with these people, but I want an inconsistent
view of their history" to be the exception. Most people would _want_ to
resolve the conflicts (especially if there is a --cat-conflicts
option to do it automatically) in a collaboration scenario.

-Peff

[1] Actually because history has diverged, you have the usual cherry
pick problems with merging later. If some note is at state A, then I
cherry-pick Bob's change to B, then Bob changes it to C and I try to
merge with him, from the 3-way merge's perspective we have a conflict,
because nothing in the history says that Bob's change to C meant to
supersede my cherry-picked version of his history.
