From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 16:45:06 -0400
Message-ID: <20150618204505.GD14550@peff.net>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Patrick Palka <patrick@parcs.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ggU-0001WA-5M
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbFRUpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:45:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:48465 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751041AbbFRUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:45:08 -0400
Received: (qmail 26263 invoked by uid 102); 18 Jun 2015 20:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 15:45:08 -0500
Received: (qmail 8675 invoked by uid 107); 18 Jun 2015 20:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 16:45:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 16:45:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.8.1506181536070.4322@idea>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272071>

On Thu, Jun 18, 2015 at 04:14:19PM -0400, Patrick Palka wrote:

> >in a test script becomes more clear. But some of the output is not so
> >great. For instance, the very commit under discussion has a
> >confusing and useless highlight. Or take a documentation patch like
> >5c31acfb, where I find the highlights actively distracting. We are saved
> >a little by the "if the whole line is different, do not highlight at
> >all" behavior of 097128d1bc.
> 
> To fix the useless highlights for both evenly and unevenly sized hunks
> (like when all but a semicolon on a line changes), one can loosen the
> criterion for not highlighting from "do not highlight if 0% of the
> before and after lines are common between them" to, say, "do not
> highlight if less than 10% of the before and after lines are common
> between them".  Then most of these useless highlights are gone for both
> evenly and unevenly sized hunks.

Yeah, this is an idea I had considered but never actually experimented
with. It does make some things better, but it also makes some a little
worse. For example, in 8dbf3eb, the hunk:

-               const char *plain = diff_get_color(ecb->color_diff,
-                                                  DIFF_PLAIN);
+               const char *context = diff_get_color(ecb->color_diff,
+                                                    DIFF_CONTEXT);

currently gets the plain/context change in the first line highlighted,
as well as the DIFF_PLAIN/DIFF_CONTEXT in the second line. With a 10%
limit, the second line isn't highlighted. That's correct by the
heuristic, but it's a bit harder to read, because the highlight draws
your eye to the first change, and it is easy to miss the second.

Still, I think this is probably a minority case, and it may be
outweighed by the improvements. The "real" solution is to consider the
hunk as a whole and do an LCS diff on it, which would show that yes,
it's worth highlighting both of those spots, as they are a small
percentage of the total hunk.

> Here is a patch that changes the criterion as mentioned.  Testing this
> change on the documentation patch 5c31acfb, only two pairs of lines are
> highlighted instead of six.  On my original patch, the useless highlight
> is gone.  The useless semicolon-related highlights on e.g. commit
> 99a2cfb are gone.

Nice, the ones like 99a2cfb are definitely wrong (I had though to fix
them eventually by treating some punctuation as uninteresting, but I
suspect the percentage heuristic covers that reasonably well in
practice).

> Of course, these patches are both hacks but they seem to be surprisingly
> effective hacks especially when paired together.

The whole script is a (surprisingly effective) hack. ;)

> >So I dunno. IMHO this does more harm than good, and I would not want to
> >use it myself. But it is somewhat a matter of taste; I am not opposed to
> >making it a configurable option.
> 
> That is something I can do :)

Coupled with the 10%-threshold patch, I think it would be OK to include
it unconditionally. So far we've just been diffing the two outputs and
micro-analyzing them. The real test to me will be using it in practice
and seeing if it's helpful or annoying.

-Peff
