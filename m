From: Jeff King <peff@peff.net>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
 conflicts.
Date: Wed, 30 Dec 2015 02:13:20 -0500
Message-ID: <20151230071319.GC26964@sigill.intra.peff.net>
References: <20151221142953.GA12764@acm.fritz.box>
 <1450772258.7937.9.camel@kaarsemaker.net>
 <20151222093032.GA5173@sigill.intra.peff.net>
 <20151224092038.GA2397@acm.fritz.box>
 <20151229075329.GA9254@sigill.intra.peff.net>
 <xmqq37ulhya3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alan Mackenzie <acm@muc.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 08:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEAxL-0006Ok-TT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 08:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbbL3HNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 02:13:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:47052 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751093AbbL3HNW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 02:13:22 -0500
Received: (qmail 17446 invoked by uid 102); 30 Dec 2015 07:13:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 01:13:22 -0600
Received: (qmail 28500 invoked by uid 107); 30 Dec 2015 07:13:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 02:13:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2015 02:13:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37ulhya3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283167>

On Tue, Dec 29, 2015 at 11:04:20AM -0800, Junio C Hamano wrote:

> [...]
> In the above, I suggested to "git reset" when there is no conflict.
> I think this line of thinking can be followed even further to
> selectively reset the paths that were cleanly merged (which is added
> by the call to merge-recursive), leaving _only_ the conflicted paths.
> 
> Would that give us a better outcome?  I dunno.

Yes, I think that is the only sensible change to make. The only other
option (besides leaving it as-is) would be to unstage _everything_
leaving conflict-marker cruft in the working tree, but no conflicts in
the index. I think that's a mistake, but I won't repeat the arguments I
left elsewhere in the thread.

So it's probably something like:

  git ls-files -t |
  grep -v ^M |
  cut -d ' ' -f2- |
  xargs git reset --

(modulo some quoting robustness improvements). But I guess we'd want to
preserve any modifications that were originally in the index. So maybe
the intersection of the files above and the output of "git diff-tree
--name-only" on the stash commit.

There are probably some corner cases to look at (e.g., with "--index").

As I said, I'm not planning to work on it anytime soon, but the above
may give some clues to somebody who wants to pursue it.

-Peff
