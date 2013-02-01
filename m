From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Fri, 1 Feb 2013 03:52:49 -0500
Message-ID: <20130201085248.GA30644@sigill.intra.peff.net>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1CN0-0008L7-KK
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 09:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab3BAIwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 03:52:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55303 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab3BAIww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 03:52:52 -0500
Received: (qmail 19516 invoked by uid 107); 1 Feb 2013 08:54:16 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 03:54:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 03:52:49 -0500
Content-Disposition: inline
In-Reply-To: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215219>

On Thu, Jan 31, 2013 at 02:09:40PM -0800, Junio C Hamano wrote:

> Before parsing a suspected smart-HTTP response verify the returned
> Content-Type matches the standard. This protects a client from
> attempting to process a payload that smells like a smart-HTTP
> server response.
> 
> JGit has been doing this check on all responses since the dawn of
> time. I mistakenly failed to include it in git-core when smart HTTP
> was introduced. At the time I didn't know how to get the Content-Type
> from libcurl. I punted, meant to circle back and fix this, and just
> plain forgot about it.
> 
> Signed-off-by: Shawn Pearce <spearce@spearce.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Should this be "From:" Shawn? The tone of the message and the S-O-B
order makes it look like it.

> @@ -133,16 +135,19 @@ static struct discovery* discover_refs(const char *service)
>  	last->buf = last->buf_alloc;
>  
>  	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
> -		/* smart HTTP response; validate that the service
> +		/*
> +		 * smart HTTP response; validate that the service
>  		 * pkt-line matches our request.
>  		 */
> -		struct strbuf exp = STRBUF_INIT;
> -
> +		strbuf_addf(&exp, "application/x-%s-advertisement", service);
> +		if (strbuf_cmp(&exp, &type))
> +			die("invalid content-type %s", type.buf);

Hmm. I wondered if it is possible for a non-smart server to send us down
this code path, which would now complain of the bogus content-type.
Something like an info/refs file with:

  # 1
  # the comment above is meaningless, but puts a "#" at position 4.

But I note that we would already die in the next line:

>  		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
>  			die("%s has invalid packet header", refs_url);

so I do not think the patch makes anything worse. However, should we
take this opportunity to make the "did we get a smart response" test
more robust? That is, should we actually be checking the content-type
in the outer conditional, and going down the smart code-path if it is
application/x-%s-advertisement, and otherwise treating the result as
dumb?

It's probably not a big deal, as the false positive example above is
quite specific and unlikely, but it just seems cleaner to me.

As a side note, should we (can we) care about the content-type for dumb
http? It should probably be text/plain or application/octet-stream, but
I would not be surprised if we get a variety of random junk in the real
world, though.

-Peff
