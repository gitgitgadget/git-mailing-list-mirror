From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fix http deadlock on giant ref negotiations
Date: Fri, 15 May 2015 02:29:01 -0400
Message-ID: <20150515062901.GA30768@peff.net>
References: <20150513210436.GA7407@gmail.com>
 <20150514004724.GA3059@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 08:29:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt97O-0001WR-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 08:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbbEOG3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 02:29:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:59045 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753482AbbEOG3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 02:29:04 -0400
Received: (qmail 22775 invoked by uid 102); 15 May 2015 06:29:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 01:29:04 -0500
Received: (qmail 31449 invoked by uid 107); 15 May 2015 06:29:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 02:29:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 02:29:01 -0400
Content-Disposition: inline
In-Reply-To: <20150514004724.GA3059@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269128>

On Wed, May 13, 2015 at 08:47:24PM -0400, Jeff King wrote:

> The fundamental problem is the deadlock on the server side, which is
> producing bogus protocol output. And that's a mismatch between what
> Apache expects (that the CGI will read all of the input request and then
> generate an output request) and what the CGI wants to do (stream output
> as it reads the input).

At first I was irritated with Apache for this. But thinking on it more,
it's really due to our shoe-horning of a full-duplex protocol into the
half-duplex HTTP protocol. Even if we could convince Apache to work in a
full-duplex way here, and even if our client is full-duplex (since
otherwise we are just trading pipe buffers for TCP buffers), we still
may face arbitrary HTTP proxies or other infrastructure in the middle.

So here's a series to try to address the issue. The first patch is a
fixed version of the die-recursion fixup I posted earlier. The second is
the interesting one.

  [1/2]: http-backend: fix die recursion with custom handler
  [2/2]: http-backend: spool ref negotiation requests to buffer

I have no clue how to write a test that would trigger this reliably
without requiring a gigantic test fixture. However, I did confirm that
it fixes the problem on the chromium case you provided (which otherwise
deadlocks reliably for me).

-Peff
