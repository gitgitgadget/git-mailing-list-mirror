From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] upload-pack keepalive
Date: Sun, 8 Sep 2013 04:59:15 -0400
Message-ID: <20130908085915.GA4097@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaq4-0002Dh-Ad
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab3IHI7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:59:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:43938 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3IHI7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:59:19 -0400
Received: (qmail 12813 invoked by uid 102); 8 Sep 2013 08:59:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:59:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:59:15 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234228>

I've gotten complaints that cloning from github.com with "-q" will
sometimes abort before sending any data. The problem is that during a
quiet clone, upload-pack may be silent for a long time while preparing
the pack (i.e., the "counting objects" and "compressing" phases).

We have load balancers and reverse proxies sitting in front of the git
machines, and these machines may sometimes think the connection has hung
and drop it, even though if they had waited a few more seconds, the pack
would have started coming.

We mitigated it somewhat by bumping the timeouts on our side, but that's
only one piece of the puzzle. Clients may be going through http proxies
or stateful firewalls on their end, and neither we nor they have any
control.

This series teaches upload-pack to periodically send an empty sideband
data packet when pack-objects is being quiet. That keeps a small amount
of data flowing, and should be backwards compatible. I hand-tested it
against JGit, dulwich (via the mercurial git plugin), libgit2, and old
versions of git, and all worked fine.  It has also been running on
github.com for about a week and a half, and nobody has reported any
problems.

  [1/2]: upload-pack: send keepalive packets during pack computation
  [2/2]: upload-pack: bump keepalive default to 5 seconds

-Peff
