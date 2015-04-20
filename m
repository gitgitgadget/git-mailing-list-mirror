From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Mon, 20 Apr 2015 14:51:22 -0400
Message-ID: <20150420185122.GA13718@peff.net>
References: <552E9816.6040502@gmail.com>
 <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
 <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
 <20150415221824.GB27566@peff.net>
 <20150417142310.GA12479@peff.net>
 <xmqqd232hgj8.fsf@gitster.dls.corp.google.com>
 <20150417205125.GA7067@peff.net>
 <xmqq4moepijp.fsf@gitster.dls.corp.google.com>
 <553548D2.7010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:51:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGn4-0007nX-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbDTSv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:51:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:47747 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751255AbbDTSvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:51:25 -0400
Received: (qmail 4204 invoked by uid 102); 20 Apr 2015 18:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 13:51:25 -0500
Received: (qmail 27531 invoked by uid 107); 20 Apr 2015 18:51:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 14:51:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 14:51:22 -0400
Content-Disposition: inline
In-Reply-To: <553548D2.7010904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267486>

On Tue, Apr 21, 2015 at 12:13:30AM +0530, karthik nayak wrote:

> +static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char
> *map,
> +                                       unsigned long mapsize, void *buffer,
> +                                       unsigned long bufsiz, struct strbuf
> *header)
> +{
> +       unsigned char *cp;
> +       int status;
> +       int i = 0;
> +
> +       status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);

I wonder if we would feel comfortable just running this NUL-check as
part of unpack_sha1_header (i.e., in all code paths). It _shouldn't_
trigger in normal use, but I wonder if there would be any downsides
(e.g., maliciously crafted objects getting us to allocate memory or
something; I think it is fairly easy to convince git to allocate memory,
though).

> +       for (cp = buffer; cp < stream->next_out; cp++)
> +               if (!*cp) {
> +                       /* Found the NUL at the end of the header */
> +                       return 0;
> +               }

I think we can spell this as:

  if (memchr(buffer, '\0', stream->next_out - buffer))
	return 0;

which is shorter and possibly more efficient.

In theory we could also just start trying to parse the type/size header,
and notice there when we don't find the NUL. That's probably not worth
doing, though. The parsing is separated from the unpacking here, so it
would require combining those two operations in a single function. And
the extra NUL search here is likely not very expensive.

-Peff
