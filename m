From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 20:40:34 -0400
Message-ID: <20110716004034.GA32230@sigill.intra.peff.net>
References: <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net>
 <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
 <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 02:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhsvy-00020D-6a
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 02:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab1GPAkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 20:40:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45569
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab1GPAkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 20:40:37 -0400
Received: (qmail 29838 invoked by uid 107); 16 Jul 2011 00:41:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 20:41:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 20:40:34 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177246>

On Fri, Jul 15, 2011 at 04:10:23PM -0700, Linus Torvalds wrote:

> On Fri, Jul 15, 2011 at 2:17 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > For example, for the "git tag --contains" thing, what's the
> > performance effect of just skipping tags that are much older than the
> > commit we ask for?
> 
> Hmm.
> 
> Maybe there is something seriously wrong with this trivial patch, but
> it gave the right results for the test-cases I threw at it, and passes
> the tests.
> 
> Before:
> 
>    [torvalds@i5 linux]$ time git tag --contains v2.6.24 > correct
> 
>    real	0m7.548s
>    user	0m7.344s
>    sys	0m0.116s
> 
> After:
> 
>    [torvalds@i5 linux]$ time ~/git/git tag --contains v2.6.24 > date-cut-off
> 
>    real	0m0.161s
>    user	0m0.140s
>    sys	0m0.016s
> 
> and 'correct' and 'date-cut-off' both give the same answer.

Without even looking carefully at your patches for any minor mistakes, I
can tell you that the speedup you're seeing is approximately right.
Because it's almost exactly the same optimization I made in my
timestamp-based patches (links to which I sent you earlier today).

However, you can make it even faster. The "tag --contains" code will ask
"is_descendant_of" repeatedly for the same set of "want" commits. So you
end up traversing some parts of the graph over and over. My patches
share the marks over a set of contains traversals, so you only ever
touch each commit once. And that's what my patches do.

With yours, on my box:

  $ time git tag --contains HEAD~1000 >/dev/null
  real    0m0.113s
  user    0m0.104s
  sys     0m0.008s

and mine:

  $ time git tag --contains HEAD~1000 >/dev/null
  real    0m0.035s
  user    0m0.020s
  sys     0m0.012s

I suspect you can make the difference even more prominent by having more
tags, or by having multiple "want" commits.

-Peff
