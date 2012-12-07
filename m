From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] make repeated fetch faster on "read only" repos
Date: Fri, 7 Dec 2012 08:53:52 -0500
Message-ID: <20121207135351.GA10538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 14:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgyNY-0005GL-3y
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 14:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512Ab2LGNx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 08:53:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37066 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030510Ab2LGNxz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 08:53:55 -0500
Received: (qmail 8480 invoked by uid 107); 7 Dec 2012 13:54:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Dec 2012 08:54:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2012 08:53:52 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211176>

Like many dev shops, we run a CI server that basically does:

  git fetch $some_branch &&
  git checkout $some_branch &&
  make test

all day long. Sometimes the fetches would get very slow, and the problem
turned out to be a combination of:

  1. Never running "git gc". This means you can end up with a ton of
     loose objects, or even a bunch of small packs[1].

  2. One of the loops in fetch caused us to re-scan the entire
     objects/pack directory repeatedly, proportional to the number of
     refs on the remote.

I think the fundamental fix is to gc more often, as it makes the re-scans
less expensive, along with making general object lookup faster. But the
repeated re-scans strike me as kind of hacky. This series tries to
address both:

  [1/2]: fetch: run gc --auto after fetching
  [2/2]: fetch-pack: avoid repeatedly re-scanning pack directory

-Peff

[1] It turns out we had our transfer.unpacklimit set unreasonably low,
    leading to a large number of tiny packs, but even with the defaults,
    you will end up with a ton of loose objects if you do repeated small
    fetches.
