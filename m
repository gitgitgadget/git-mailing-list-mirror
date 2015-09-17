From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 13:50:08 -0400
Message-ID: <20150917175008.GA29601@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com>
 <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
 <20150917163012.GB25837@sigill.intra.peff.net>
 <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
 <20150917171308.GA28046@sigill.intra.peff.net>
 <CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
 <20150917173536.GA28987@sigill.intra.peff.net>
 <CAGZ79kYnZr3nb_5n-5J0vCMi7xb91y-OkrAEq8-uH2PvzmkSmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdK6-0000sW-F1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbbIQRuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:50:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:32783 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751976AbbIQRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:50:11 -0400
Received: (qmail 14718 invoked by uid 102); 17 Sep 2015 17:50:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:50:11 -0500
Received: (qmail 656 invoked by uid 107); 17 Sep 2015 17:50:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 13:50:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 13:50:08 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYnZr3nb_5n-5J0vCMi7xb91y-OkrAEq8-uH2PvzmkSmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278152>

On Thu, Sep 17, 2015 at 10:45:40AM -0700, Stefan Beller wrote:

> > You _can_ loop on read until you hit EAGAIN, but I think in general you
> > shouldn't; if you get a lot of input on this fd, you'll starve all of
> > the other descriptors you're polling.  You're better off to read a
> > finite amount from each descriptor, and then check again who is ready to
> > read.
> 
> That's what I do with the current implementation. Except it's not as clear and
> concise as I patched it into the strbuf_read.

Is it? I thought the implementation you posted bumped the existing
strbuf_read to strbuf_buf_internal, including the loop. So as long as we
are not getting EAGAIN, it will keep reading forever. Actually not quite
true, as any read shorter than 8192 bytes will cause us to jump out of
the loop, too, but if we assume that the caller is feeding us data
faster than we can read it, we'll never exit strbuf_read_nonblock() and
serve any of the other descriptors.

-Peff
