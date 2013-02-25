From: Jeff King <peff@peff.net>
Subject: Re: Certificate validation vulnerability in Git
Date: Sun, 24 Feb 2013 22:16:48 -0500
Message-ID: <20130225031648.GA31988@sigill.intra.peff.net>
References: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Dhanesh K." <dhanesh1428@gmail.com>
To: Zubin Mithra <zubin.mithra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:17:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9oZD-0004YF-IX
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 04:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759567Ab3BYDQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 22:16:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59595 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759561Ab3BYDQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 22:16:52 -0500
Received: (qmail 12267 invoked by uid 107); 25 Feb 2013 03:18:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Feb 2013 22:18:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2013 22:16:48 -0500
Content-Disposition: inline
In-Reply-To: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217024>

On Sun, Feb 24, 2013 at 11:01:50PM +0530, Zubin Mithra wrote:

> There seems to be a security issue in the way git uses openssl for
> certificate validation. Similar occurrences have been found and
> documented in other open source projects, the research can be found at
> [1].
> 
> -=========]
> - imap-send.c
> 
> Line 307
> 
>  307   ret = SSL_connect(sock->ssl);
>  308   if (ret <= 0) {
>  309     socket_perror("SSL_connect", sock, ret);
>  310     return -1;
>  311   }
>  312
> 
> Certificate validation errors are signaled either through return
> values of SSL_connect or by setting internal flags. The internal flags
> need to be checked using the SSL_get_verify_result function. This is
> not performed.

I'm not sure what you mean. We use SSL_CTX_set_verify to turn on peer
certificate verification, which will cause SSL_connect to return
failure if the certificate signature cannot be traced back to a CA cert
from our local store.

Is there some case where this does not happen properly? If so, can you
give an example? The paper you referenced says only that there are some
special cases where SSL_connect does not notice the error, but then
gives an example where the application does not turn on SSL_VERIFY_PEER.
But git does. Are there are other cases that SSL_VERIFY_PEER does not
handle?

There is a _different_ problem not handled by the code you show above,
which is that SSL_connect does not verify that the hostname we connected
to matches the signed certificate. But that was fixed already by b62fb07
(imap-send: the subject of SSL certificate must match the host,
2013-02-15), which is in git v1.8.1.4.

-Peff
