From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Fri, 19 Jun 2015 01:32:23 -0400
Message-ID: <20150619053223.GA27241@peff.net>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea>
 <20150618204505.GD14550@peff.net>
 <20150618212356.GA20271@peff.net>
 <20150619035408.GA23679@peff.net>
 <xmqqmvzwb8vk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 07:32:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5oul-0000lB-Ld
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 07:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbbFSFc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 01:32:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:48616 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752089AbbFSFc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 01:32:26 -0400
Received: (qmail 24769 invoked by uid 102); 19 Jun 2015 05:32:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 00:32:26 -0500
Received: (qmail 12316 invoked by uid 107); 19 Jun 2015 05:32:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 01:32:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 01:32:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvzwb8vk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272103>

On Thu, Jun 18, 2015 at 09:49:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I think you could also argue that
> > because of whitespace-highlighting, colorized diffs are fundamentally
> > going to have colors intermingled with the content and should not be
> > parsed this way.
> 
> Painting of whitespace breakages is asymmetric [*1*].  If you change
> something on a badly indented line without fixing the indentation,
> e.g.
> 
> 	-<SP><TAB>hello-world
>         +<SP><TAB>hello-people
> 
> only the space-before-tab on the latter line is painted.
> 
> For the purpose of your diff highlighting, however, you would want
> to treat the leading "<SP><TAB>hello-" on preimage and postimage
> lines as unchanged.

I do strip it off, so it is OK for it to be different in both the
pre-image and post-image. But what I can't tolerate is the
intermingling with actual data:

  +\t\t\x1b[32m;foo
  +\t\x1b[32m;bar

Those are both post-image lines. I can strip off the "+" from each side
to compare their inner parts to the pre-image. But the intermingled
color gets in my way. I can simply strip all colors from the whole line,
but then information is lost; how do I know where to put them back
again? It is not just "add back the color at the beginning" (which is
what I do with the prefix).

I think the answer is that I must strip them out, retaining the colors
found in each line along with their offset into the line, and then as I
write out the lines, re-add them at the appropriate spots (taking care
to use the original offsets, not the ones with the highlighting added
in).

> > All the more reason to try to move this inside diff.c, I guess.
> 
> That too, probably.

Hmm, I thought that would solve all my problems by operating on the
pre-color version without much more work. But...

> If we were to do this, I think it may make sense to separate the
> logic to compute which span of the string need to be painted in what
> color and the routine to actually emit the colored output.  That is,
> instead of letting ws-check-emit to decide which part should be in
> what color _and_ emitting the result, we should have a helper that
> reads <line, len>, and give us an array of spans to flag as
> whitespace violation.  Then an optional diff-highlight code would
> scan the same <line, len> (or a collection of <line, len>) without
> getting confused by the whitespace errors and annotate the spans to
> be highlighted.  After all that happens, the output routine would
> coalesce the spans and produce colored output.
> 
> Or something like that ;-)

I think this "array of spans" is the only way to go. Otherwise whichever
markup scheme processes the hunk first ruins the data for the next
processor.

So it is a lot more work to make the two work together. The --word-diff
code would have the same issue, except that I imagine it just skips
whitespace-highlighting altogether.

The least-work thing may actually be teaching the separate
diff-highlight script to strip out the colorizing and re-add it by
offset.

-Peff
