From: Jeff King <peff@peff.net>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 22:00:15 -0500
Message-ID: <20131205030015.GB19376@sigill.intra.peff.net>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
 <CAJo=hJuzP=zYsEZvC5ugKaAWPLAcTzmFJxT5PNFKbBEv0ctnDw@mail.gmail.com>
 <20131204184842.GA11024@sigill.intra.peff.net>
 <20131204232800.GG29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 04:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoPAt-0000oh-4J
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 04:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab3LEDAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 22:00:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:50658 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753515Ab3LEDAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 22:00:17 -0500
Received: (qmail 14401 invoked by uid 102); 5 Dec 2013 03:00:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 21:00:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 22:00:15 -0500
Content-Disposition: inline
In-Reply-To: <20131204232800.GG29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238840>

On Wed, Dec 04, 2013 at 03:28:00PM -0800, Jonathan Nieder wrote:

> For what it's worth, when I build git and run tests I tend to be in an
> environment with apache available, but I'm too lazy to configure git's
> tests to pick the right port and make sure it is reserved and so on.
> Perhaps there's some way to help lazy people in the same boat?  (E.g.,
> picking a port randomly and skipping instead of failing a test when
> it's taken or something)

What level of magic do you need?

For most people, "apt-get install apache && make GIT_TEST_HTTPD=yes
test" is enough to run the tests. It uses ports in the 5000-range; this
_can_ conflict with other services the user is running, but it should
not usually (we don't match anything in a typical /etc/services file).
And each script uses its own port, so running the tests in parallel is
fine.

If you are planning on running "make test" from multiple git checkouts
at the same time, though, they will conflict.

The failure mode is reasonable. You should get something like:

  $ GIT_TEST_HTTPD=1 LIB_HTTPD_PORT=80 ./t5540-http-push.sh
  1..0 # SKIP skipping test, web server setup failed

We could do better by retrying with a range of ports, but unless
somebody really needs that, I'd prefer to avoid complicating it more.

The one thing I have occasionally run into is a stale apache hanging
around. But I think that only happens when I am abusing the test script
(e.g., sticking a test_pause in, poking around, and then not letting the
script complete and do its cleanup).

So is the current behavior good enough to meet your needs and you
didn't know it, or do we need more?

-Peff
