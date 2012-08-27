From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] fix password prompting for "half-auth" servers
Date: Mon, 27 Aug 2012 09:21:45 -0400
Message-ID: <20120827132145.GA17265@sigill.intra.peff.net>
References: <5037E1D0.6030900@gmail.com>
 <20120824212501.GA16285@sigill.intra.peff.net>
 <5038E781.1090008@gmail.com>
 <20120825203904.GA10470@sigill.intra.peff.net>
 <5039F327.9010003@gmail.com>
 <20120826101341.GA12566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zGi-0000Ny-MI
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891Ab2H0NVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:21:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39677 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab2H0NVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:21:48 -0400
Received: (qmail 12645 invoked by uid 107); 27 Aug 2012 13:22:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:22:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:21:45 -0400
Content-Disposition: inline
In-Reply-To: <20120826101341.GA12566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204333>

On Sun, Aug 26, 2012 at 06:13:41AM -0400, Jeff King wrote:

> No problem. I'll probably be a day or two on the patches, as the http
> tests are in need of some refactoring before adding more tests. But in
> the meantime, I think your config change is a sane work-around.

OK, here is the series.  For those just joining us, the problem is that
git will not correctly prompt for credentials when pushing to a
repository which allows the initial GET of
".../info/refs?service=git-receive-pack", but then gives a 401 when we
try to POST the pack. This has never worked for a plain URL, but used to
work if you put the username in the URL (because we would
unconditionally load the credentials before making any requests). That
was broken by 986bbc0, which does not do that proactive prompting for
smart-http, meaning such repositories cannot be pushed to at all.

Such a server-side setup is questionable in my opinion (because the
client will actually create the pack before failing), but we have been
advertising it for a long time in git-http-backend(1) as the right way
to make repositories that are anonymous for fetching but require auth
for pushing.

The fix is somewhat uglier than I would like, but I think it's practical
and the right thing to do (see the final patch for lots of discussion).
I built this on the current tip of "master".  It might make sense to
backport it directly on top of 986bbc0 for the maint track. There are
conflicts, but they are all textual. Another option would be to revert
986bbc0 for the maint track, as that commit is itself fixing a minor bug
that is of decreasing relevance (it fixed extra password prompting when
.netrc was in use, but one can work around it by dropping the username
from the URL).

The patches are:

  [1/8]: t5550: put auth-required repo in auth/dumb
  [2/8]: t5550: factor out http auth setup
  [3/8]: t/lib-httpd: only route auth/dumb to dumb repos
  [4/8]: t/lib-httpd: recognize */smart/* repos as smart-http
  [5/8]: t: test basic smart-http authentication

These are all refactoring of the test scripts in preparation for 6/8
(and are where all of the conflicts lie).

  [6/8]: t: test http access to "half-auth" repositories

This demonstrates the bug.

  [7/8]: http: factor out http error code handling

Refactoring to support 8/8.

  [8/8]: http: prompt for credentials on failed POST

And this one is the actual fix.

I'd like to have a 9/8 which tweaks the git-http-backend documentation
to provide better example apache config, but I haven't yet figured out
the right incantation. Suggestions from apache gurus are welcome.

-Peff
