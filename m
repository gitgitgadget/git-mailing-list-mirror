From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] merge-recursive: don't detect renames from empty
 files
Date: Thu, 22 Mar 2012 17:53:55 -0400
Message-ID: <20120322215355.GA750@sigill.intra.peff.net>
References: <20120322185246.GA27037@sigill.intra.peff.net>
 <20120322185349.GC32727@sigill.intra.peff.net>
 <20120322191851.GA23293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SApxW-00061V-9v
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 22:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031200Ab2CVVyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 17:54:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56963
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276Ab2CVVx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 17:53:57 -0400
Received: (qmail 6268 invoked by uid 107); 22 Mar 2012 21:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 17:54:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 17:53:55 -0400
Content-Disposition: inline
In-Reply-To: <20120322191851.GA23293@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193721>

On Thu, Mar 22, 2012 at 02:18:51PM -0500, Jonathan Nieder wrote:

> > We could do the same thing for general diff rename
> > detection. However, the stakes are much less high there, as
> > we are explicitly reporting the rename to the user. It's
> > only the automatic nature of merge-recursive that makes the
> > result confusing. So there's not as much need for caution
> > when just showing a diff.
> 
> The stakes may be different, but doesn't the same justification apply
> anyway?  If "git diff -M" chooses a random pairing to describe a
> renaming of multiple empty files, that seems just as confusing as
> merge-recursive making the same mistake.

Maybe "stakes" was not the best word. My thinking was something like the
following. Matching empty files is a heuristic. So sometimes it will be
right, and sometimes it will be wrong. We want to make sure that the
confusion caused by being wrong is less than the goodness caused by
being right.  When we find renames for a merge, the badness in being
wrong is quite high. And the lack of goodness in failing to be right is
not all that high; you'll get a conflict which will bring the issue to
the user's attention, and they can fall back to using "git diff" to
investigate the situation.

Whereas with a regular diff, the badness of being wrong is not very
high. The user sees the diff and says "Really? Stupid git, that wasn't a
rename". And the lack of goodness in failing to be right is somewhat
worse, because there is no way to fall back and ask git "what renames
would you have found if you relaxed the heuristics a bit more?"

Of course, one could make that fallback an option. And given that we
are, by definition, talking about trivial empty files, it's not like the
rename detection somehow makes the diff a whole lot nicer. It just says
"rename X to Y" instead of "deleted Y, added X". The real value in the
rename detection is seeing the interdiff between X and Y, but it would
always be empty in this case anyway.

So I could go either way.

> If adding this check in diffcore is more complicated, doing it in
> merge-recursive for now seems fine and prudent, but if we are doing it
> at the merge-recursive level just to be conservative then that seems
> like the wrong layer.

It's not really more complicated, and based on Junio's response, I think
we want to do it there anyway. Doing it unconditionally for diff and
merge actually would make the code even simpler, then.

-Peff
