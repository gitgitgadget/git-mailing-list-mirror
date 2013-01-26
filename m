From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Sat, 26 Jan 2013 17:40:11 -0500
Message-ID: <20130126224011.GA20675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 23:40:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzEQP-0008Cy-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 23:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab3AZWkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 17:40:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51673 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab3AZWkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 17:40:13 -0500
Received: (qmail 25244 invoked by uid 107); 26 Jan 2013 22:41:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 17:41:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 17:40:11 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214641>

This is a repost from here:

  http://thread.gmane.org/gmane.comp.version-control.git/211176

which got no response initially. Basically the issue is that read-only
repos (e.g., a CI server) whose workflow is something like:

  git fetch $some_branch &&
  git checkout -f $some_branch &&
  make test

will never run git-gc, and will accumulate a bunch of small packs and
loose objects, leading to poor performance.

Patch 1 runs "gc --auto" on fetch, which I think is sane to do.

Patch 2 optimizes our pack dir re-scanning for fetch-pack (which, unlike
the rest of git, should expect to be missing lots of objects, since we
are deciding what to fetch).

I think 1 is a no-brainer. If your repo is packed, patch 2 matters less,
but it still seems like a sensible optimization to me.

  [1/2]: fetch: run gc --auto after fetching
  [2/2]: fetch-pack: avoid repeatedly re-scanning pack directory

-Peff
