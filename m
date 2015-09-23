From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 21:51:27 -0400
Message-ID: <20150923015127.GC21294@sigill.intra.peff.net>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
 <1442875159-13027-3-git-send-email-sbeller@google.com>
 <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
 <5600DF2D.9010202@web.de>
 <CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
 <xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
 <20150922194927.GA622@sigill.intra.peff.net>
 <xmqqlhby2pj0.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYKxNAXhbmXEtMeBYeGqu8i4bcUW_hpjLaPSF4p5O=uBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 03:51:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZDb-0005As-36
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759957AbbIWBvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:51:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:35033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759918AbbIWBva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:51:30 -0400
Received: (qmail 31393 invoked by uid 102); 23 Sep 2015 01:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Sep 2015 20:51:30 -0500
Received: (qmail 12791 invoked by uid 107); 23 Sep 2015 01:51:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Sep 2015 21:51:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Sep 2015 21:51:27 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYKxNAXhbmXEtMeBYeGqu8i4bcUW_hpjLaPSF4p5O=uBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278468>

On Tue, Sep 22, 2015 at 05:14:42PM -0700, Stefan Beller wrote:

> We should not care if the call to poll failed, as we're in an infinite loop and
> can only get out with the correct read(..). So maybe an implementation like this
> would already suffice:
> 
> ssize_t xread(int fd, void *buf, size_t len)
> {
>     ssize_t nr;
>     if (len > MAX_IO_SIZE)
>         len = MAX_IO_SIZE;
>     while (1) {
>         nr = read(fd, buf, len);
>         if (nr < 0) {
>             if (errno == EINTR)
>                 continue;
>             if (errno == EAGAIN || errno == EWOULDBLOCK) {
>                 struct pollfd pfd;
>                 pfd.events = POLLIN;
>                 pfd.fd = fd;
>                 /* We deliberately ignore the return value of poll. */
>                 poll(&pfd, 1, -1);
>                 continue;
>             }
>         }
>         return nr;
>     }
> }

FWIW, that is what I had imagined.

-Peff
