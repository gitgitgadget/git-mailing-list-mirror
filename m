From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 15:48:07 -0400
Message-ID: <20110715194807.GA356@sigill.intra.peff.net>
References: <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhoOD-0004Kb-M6
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab1GOTsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:48:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60961
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab1GOTsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:48:13 -0400
Received: (qmail 25786 invoked by uid 107); 15 Jul 2011 19:48:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 15:48:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 15:48:07 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177219>

On Fri, Jul 15, 2011 at 09:10:48AM -0700, Linus Torvalds wrote:

> I think it's much worse to have the same information in two different
> places where it can cause inconsistencies that are hard to see and may
> not be repeatable. If git ever finds the wrong merge base (because,
> say, the generation numbers are wrong), I want it to be a *repeatable*
> thing. I want to be able to repeat on the git mailing list "hey, guys,
> look at what happens when I try to merge commits ABC and XYZ". If you
> go "yeah, it works for me", then that is bad.

Having the information in two different places is my concern, too. And I
think the fundamental difference between putting it inside or outside
the commit sha1 (where outside encompasses putting it in a cache, in the
pack-index, or whatever), is that I see the commit sha1 as somehow more
"definitive". That is, it is the sole data we pass from repo to repo
during pushes and pulls, and it is the thing that is consistency-checked
by hashes.

So if there is an inconsistency between what the parent pointers
represent, and what the generation number in "outside" storage says,
then the outside storage is wrong, and the parent pointers are the right
answer. It becomes a lot more fuzzy to me if there is an inconsistency
between what the parent pointers represent, and what the generation
number says.

How should that situation be handled? Should fsck check for it and
complain? Should we just ignore it, even though it may cause our
traversal algorithms to be inaccurate? Like clock skew, there's not much
that can be done if the commits are published.

Those are serious questions that I think should be considered if we are
going to put a generation header into the commit object, and I haven't
seen answers for them yet.

> Partly for that reason, I do think that if the generation count was
> embedded in the pack-file, that would not be an "ugly" decision. The
> pack-files have definitely become "core git data structures", and are
> more than just a local filesystem representation of the objects:
> they're obviously also the data transport method, even if the rules
> there are slightly different (no index, thank god, and incomplete
> "thin" packs).
> 
> That said, I don't think a generation count necessarily "fits" in the
> pack-file. They are designed to be incremental, so it's not very
> natural there. But I do think it would be conceptually prettier to
> have the "depth of commit" be part of the "filesystem" data than to
> have it as a separate ad-hoc cache.

Sure, I would be fine with that. When you say "packfile", do you mean
the the general concept, as in it could go in the pack index as opposed
to the packfile itself? Or specifically in the packfile? The latter
seems a lot more problematic to me in terms of implementation.

> > Those things rely on the idea that the git DAG is a data model that we
> > present to the user, but that we're allowed to do things behind the
> > scenes to make things faster.
> 
> .. and that is relevant to this discussion exactly *how*?

Because keeping the generation information outside of the DAG keeps the
model we present to the user simple (and not just the user; the
information that we present to other programs), but lets git still use
the information without calculating it from scratch each time. Just like
we present the data as a DAG of loose objects via things like "git
cat-file", even though the underlying storage inside a packfile may be
very different. I just don't see those two ideas as fundamentally
different.

> It's not. It's totally irrelevant. I certainly would never walk away
> from the DAG model. It's a fundamental git decision, and it's the
> correct one.

Of course not. I never suggested we should.

> And that is what this discussion fundamentally boils down to for me.
> 
> If we should have fixed it in the original specification, we damn well
> should fix it today. It's been "ignorable" because it's just not been
> important enough. But if git now adds a fundamental cache for them,
> then that information is clearly no longer "not important enough".

OK, so let's say we add generation headers to each commit. What happens
next? Are we going to convert algorithms that use timestamps to use
commit generations? How are we going to handle performance issues when
dealing with older parts of history that don't have generations?

Again, those are serious questions that need answered. I respect that
you think the lack of a generation header is a design decision that
should be corrected. As I said before, I'm not 100% sure I agree, but
nor do I completely disagree (and I think it largely boils down to a
philosophical distinction, which I think you will agree should take a
backseat to real, practical concerns). But it's not 2005, and we have a
ton of history without generation numbers. So adding them now is only
one piece of the puzzle.

What's your solution for the rest of it?

-Peff
