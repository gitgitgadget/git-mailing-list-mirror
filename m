From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive.perl: Permit word-based diff
Date: Tue, 18 Jun 2013 18:47:22 -0400
Message-ID: <20130618224720.GB14234@sigill.intra.peff.net>
References: <CAMNuMARruu+1=kny=g5O1MoxCXuoT3BHdSEEPSqvyn2t2JsAYg@mail.gmail.com>
 <20130618063144.GA6276@sigill.intra.peff.net>
 <87k3lrzxw7.fsf@hexa.v.cablecom.net>
 <20130618172300.GA3557@sigill.intra.peff.net>
 <CAMNuMATdbhgydx5R0+OgSECqxs9tYgwqEjMuXq-0LV8fNaRWZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Mark Abraham <mark.j.abraham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 00:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up4gX-0004Cc-MF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 00:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933821Ab3FRWr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 18:47:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:41209 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933741Ab3FRWrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 18:47:25 -0400
Received: (qmail 5878 invoked by uid 102); 18 Jun 2013 22:48:23 -0000
Received: from mobile-032-132-054-112.mycingular.net (HELO sigill.intra.peff.net) (32.132.54.112)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 17:48:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 18:47:22 -0400
Content-Disposition: inline
In-Reply-To: <CAMNuMATdbhgydx5R0+OgSECqxs9tYgwqEjMuXq-0LV8fNaRWZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228321>

On Tue, Jun 18, 2013 at 11:12:59PM +0200, Mark Abraham wrote:

> > In general, I think one can assume 1-to-1 correspondence between whole
> > regular diffs and whole word-diffs, but not below that (i.e., neither a
> > correspondence between hunks nor between lines).
> [...]
> My choice of "permit" in the description was not best. My
> implementation showed a word-based diff, but preserved the existing
> mechanism for actually applying the hunk. I understand the way
> colorization in git-add--interactive.perl works right now is to
> colorize one version to display and use another - I think I preserved
> that. I intended to permit the user to choose to show a word-based
> diff of a patch during interactive add.

Right. My point is that the colorized version always lines up with the
"real" to-apply version line-for-line. But the word diff version does
not.

If we assume that they line up hunk for hunk (that is, --color-words
comes up with the same number of hunks, but the contents of each hunk
may be different), then swapping "colorized line diff" for "word diff"
in the presentation version (i.e., your patch) is fine. I think this is
the case with the current --word-diff, so the only question would be one
of not wanting to paint ourselves into a corner with implementation
details. I think that is OK, as if we later wanted to change --word-diff
to coalesce hunks, we could continue to support a
"--hunk-based-word-diff" mode for this type of operation that cares
about matching the normal diff hunks.

If we assume that the presentation version lines up line for line within
each hunk, then it is safe to do hunk-level operations like splitting.
That works with the current colorized diffs, but not with word-diff. I
think you can construct a case where doing a hunk-split from the
selection menu causes us to display a word-diff that is not the
equivalent of what would be applied if it is selected.

For example:

	# make a file and add it to the index
	cat >file <<-\EOF
	a
	c
	d
	e
	f
	EOF
	git add file

	# now fix the missing letter, tweak the wrapping, and add some new
	# content
	cat >file <<\EOF
	a b c d e
	f
	g h i j k
	EOF

The regular diff has 7 lines:

	$ git diff
	diff --git a/file b/file
	index dffa0a4..3a7aeb4 100644
	--- a/file
	+++ b/file
	@@ -1,5 +1,3 @@ f
	-a
	-c
	-d
	-e
	+a b c d e
	 f
	+g h i j k

But the word diff has only 3:

	$ git diff --word-diff
	diff --git a/file b/file
	index dffa0a4..3a7aeb4 100644
	--- a/file
	+++ b/file
	@@ -1,5 +1,3 @@ f
	a {+b+} c d e
	f
	{+g h i j k+}

If I run "git add -p" with your patch and choose "s" to split the hunk,
I will still be shown:

	Stage this hunk [y,n,q,a,d,/,s,e,?]? s
	Split into 2 hunks.
	@@ -1,5 +1,2 @@
	a b c d e
	f
	g h i j k
	Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]?

If I say "yes" here, I get shown the next hunk, which has no lines at
all.  Let's imagine I say "no". What gets applied? Only the first change
(rewrapping and adding "b"). But not the addition of "g" through "k",
even though they were shown in the presentation of the hunk that I said
"yes" to.

So I think if we want to do a word-diff for the presentation, it would
probably make sense to shut off line-level manipulation like
hunk-splitting.

> Good point. What I think I really want is "git add
> --interactive=color" (with or without --patch) to permit the user to
> choose to see the (colorized) word-based diff when they want one. I
> now see that the config file approach in my proposed patch doesn't go
> close enough to that to be worth considering further.

I wonder if it should go even a step below there: always generate the
normal diff for presentation, and then have an interactive key to show
the --word-diff of it.

I find I often do not know until I get to a very ugly documentation diff
with paragraph rewrapping that I wanted word-diff (and I would _not_
want it for my code hunks, just for the documentation hunk).

And as a bonus, it is easier to implement, since the logic is all within
the hunk-selection menu.

-Peff
