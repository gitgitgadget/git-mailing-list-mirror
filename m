From: Jeff King <peff@peff.net>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 21:49:38 -0500
Message-ID: <20131205024938.GA19376@sigill.intra.peff.net>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
 <xmqqa9ggl6oq.fsf@gitster.dls.corp.google.com>
 <20131204222522.GA16706@sigill.intra.peff.net>
 <xmqq38m8jkiu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 03:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoP0a-0002wU-I4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 03:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209Ab3LECtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 21:49:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:50650 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756255Ab3LECtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 21:49:40 -0500
Received: (qmail 13944 invoked by uid 102); 5 Dec 2013 02:49:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 20:49:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 21:49:38 -0500
Content-Disposition: inline
In-Reply-To: <xmqq38m8jkiu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238838>

On Wed, Dec 04, 2013 at 02:53:13PM -0800, Junio C Hamano wrote:

> If it involves making things not tested with apache, I'd actually be
> less supportive for the whole plan.

I hadn't really considered that angle. Apache is a much more realistic
real-world deployment. We give advice for it in git-http-backend(1), and
the tests do check that that advice works (OTOH, we also give advice for
lighttpd, but that is not checked in the test scripts).

> I thought the primary objective was to encourage people who currently
> are _not_ running httpd tests by making a lightweight server available
> out of the box, robbing an excuse "my box does not have apache
> installed" from them.

Whether we get rid of apache or not, I think a new lightweight server
would fulfill that goal. I just did not want the maintenance burden of
managing multiple configs (and our test harness apache config has grown
non-trivial).

> As long as a server supports bog standard CGI interface, smart-http
> should work the same way with any such server.  For that reason, it
> should be theoretically sufficient to test with one non-apache
> server (i.e. mongoose) for the purpose of making sure _our_ end of
> the set-up works, but still...

There are definitely subtleties between servers. For example, when I
worked on fetching bundles over http a while back, there was a big
difference between lighttpd and apache. A request for
"http://example.com/foo.bundle/info/refs" would return the bundle under
lighttpd, but not under apache (for an apache server, we would have to
make a fallback request). The client needs to be able to handle both
scenarios gracefully.

That's a case where it would be nice to be able to test _both_ cases,
and that may be an argument for having multiple (or trying to configure
apache to do both behaviors). But it shows that there may be subtle
differences between a fake test server and a real deployment.

So thinking on it more, I'm somewhat less enthusiastic about mongoose.

-Peff
