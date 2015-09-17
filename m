From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 12:57:24 -0400
Message-ID: <20150917165724.GA27102@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com>
 <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
 <20150917163012.GB25837@sigill.intra.peff.net>
 <CAPc5daVY=t27wkX2x7DSfObwxZuv37VYxi1XD-RKiS1mv4=6KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:57:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccV2-00030p-3r
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbbIQQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:57:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:60932 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750792AbbIQQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:57:27 -0400
Received: (qmail 11382 invoked by uid 102); 17 Sep 2015 16:57:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 11:57:27 -0500
Received: (qmail 32157 invoked by uid 107); 17 Sep 2015 16:57:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:57:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 12:57:24 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daVY=t27wkX2x7DSfObwxZuv37VYxi1XD-RKiS1mv4=6KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278140>

On Thu, Sep 17, 2015 at 09:44:19AM -0700, Junio C Hamano wrote:

> > Arguably we should actually return the number of bytes we _did_ read,
> > but then caller cannot easily tell the difference between EOF and
> > EAGAIN.
> 
> Why can't it check errno==EAGAIN/EWOULDBLOCK?

Is it trustworthy to check errno if read() has not actually ever
returned -1? E.g., consider this sequence:

  1. somebody (maybe even us calling strbuf_read) calls read() and it
     returns -1, setting errno to EAGAIN

  2. we call strbuf_read()

    2a. it calls read(), which returns N bytes

    2b. it calls read() again, which returns 0 for EOF

    2c. it returns N, because that's how many bytes it read

  3. we wonder if we hit EOF, or if we simply need to read again. We
     check errno == EAGAIN

I don't think the read calls in step 2 are guaranteed to clear errno,
and we might read the cruft from step 1.

-Peff
