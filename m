From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 22:07:53 -0500
Message-ID: <20151218030752.GA8432@sigill.intra.peff.net>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9lOi-00080D-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 04:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbbLRDH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 22:07:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:44062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751533AbbLRDHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 22:07:55 -0500
Received: (qmail 9999 invoked by uid 102); 18 Dec 2015 03:07:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 21:07:55 -0600
Received: (qmail 20645 invoked by uid 107); 18 Dec 2015 03:08:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 22:08:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 22:07:53 -0500
Content-Disposition: inline
In-Reply-To: <1450224252-16833-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282693>

On Tue, Dec 15, 2015 at 04:04:07PM -0800, Stefan Beller wrote:

> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
> As the intent of xread is to read as much as possible either until the
> fd is EOF or an actual error occurs, we can ease the feeder of the fd
> by not spinning the whole time, but rather wait for it politely by not
> busy waiting.

I'm not sure this second sentence is true. The point of xread() is to do
a single read that makes forward progress (or returns a real error), not
to read as much as we can.

The rationale seems more to me like:

  The point of xread() is to perform read() until we either get some
  data, or encounter a "real" error. We do not count EINTR or EAGAIN as
  "real" errors, as a reader trying to make forward progress would
  generally just repeat the read, so we loop for them as a convenience.

  In the case of EINTR, trying the read() again immediately is fine; a
  signal interrupted us, but there is no reason to think the read()
  would not succeed if we tried it again.

  For EAGAIN, however, we know that the fd must have set O_NONBLOCK. In
  this case reading again immediately is not likely to produce results,
  and we will chew up CPU spinning on read() calls. Instead, let's
  insert a poll() to block until we actually get data.

I also don't know that this patch necessarily needs to be part of the
parallel-fetch series anymore. We are not setting O_NONBLOCK ourselves,
and I don't think the correctness of the new strbuf_read_once() is
impacted by this. I.e., I think this optimization applies equally well
to the hundreds of existing xread() calls, should they unexpectedly be
fed an O_NONBLOCK descriptor.

That said, I do not mind it here, but I think it could be its own
separate topic if you wanted to reduce the complexity of the
parallel-fetch topic.

> We should not care if the call to poll failed, as we're in an infinite
> loop and can only get out with the correct read().

You might want to expand on "correct" here. I think you mean "can only
get out with a read() that returns data or a "real" error" (I am reusing
the terminology I introduced above; I am fine with other terminology,
depending on how you word the rest of it).

-Peff
