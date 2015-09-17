From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 12:30:12 -0400
Message-ID: <20150917163012.GB25837@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com>
 <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:30:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcc4k-00014M-IO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbbIQQaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:30:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:60889 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751984AbbIQQaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:30:15 -0400
Received: (qmail 9475 invoked by uid 102); 17 Sep 2015 16:30:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 11:30:14 -0500
Received: (qmail 31742 invoked by uid 107); 17 Sep 2015 16:30:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:30:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 12:30:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278132>

On Thu, Sep 17, 2015 at 09:13:40AM -0700, Junio C Hamano wrote:

> And your new caller that does O_NONBLOCK wants to do more than
> looping upon EWOULDBLOCK.  It certainly would not want us to loop
> here.
> 
> So I wonder if you can just O_NONBLOCK the fd and use the usual
> strbuf_read(), i.e. without any change in this patch, and update
> xread() to _unconditionally_ return when read(2) says EAGAIN or
> EWOULDBLOCK.
> 
> What would that break?

Certainly anybody who does not realize their descriptor is O_NONBLOCK
and is using the spinning for correctness. I tend to think that such
sites are wrong, though, and would benefit from us realizing they are
spinning.

But I think you can't quite get away with leaving strbuf_read untouched
in this case. On error, it wants to restore the original value of the
strbuf before the strbuf_read call. Which means that we throw away
anything read into the strbuf before we get EAGAIN, and the caller never
gets to see it.

So I think we would probably want to treat EAGAIN specially: return -1
to signal to the caller but _don't_ truncate the strbuf.

Arguably we should actually return the number of bytes we _did_ read,
but then caller cannot easily tell the difference between EOF and
EAGAIN.

-Peff
