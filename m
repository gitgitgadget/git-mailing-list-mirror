From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: use strbuf for hostname info
Date: Fri, 6 Mar 2015 16:06:27 -0500
Message-ID: <20150306210627.GA24267@peff.net>
References: <54F96BF2.5000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 22:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTzS7-0002tr-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 22:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbbCFVGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 16:06:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:57476 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752542AbbCFVGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 16:06:30 -0500
Received: (qmail 2731 invoked by uid 102); 6 Mar 2015 21:06:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 15:06:30 -0600
Received: (qmail 22439 invoked by uid 107); 6 Mar 2015 21:06:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 16:06:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2015 16:06:27 -0500
Content-Disposition: inline
In-Reply-To: <54F96BF2.5000504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264962>

On Fri, Mar 06, 2015 at 09:57:22AM +0100, Ren=C3=A9 Scharfe wrote:

> Convert hostname, canon_hostname, ip_address and tcp_port to strbuf.
> This allows to get rid of the helpers strbuf_addstr_or_null() and STR=
ARG
> because a strbuf always represents a valid (initially empty) string.
> sanitize_client() becomes unused and is removed as well.

Makes sense. I had a feeling that we might have cared about NULL versus
the empty string somewhere, but I did not see it in the patch below, so
I think it is fine.

> -static char *sanitize_client(const char *in)
> -{
> -	struct strbuf out =3D STRBUF_INIT;
> -	sanitize_client_strbuf(&out, in);
> -	return strbuf_detach(&out, NULL);
> -}

Not a big deal, but do we want to rename sanitize_client_strbuf to
sanitize_client? It only had the unwieldy name to distinguish it from
this one.

>  				if (port) {
> -					free(tcp_port);
> -					tcp_port =3D sanitize_client(port);
> +					strbuf_reset(&tcp_port);
> +					sanitize_client_strbuf(&tcp_port, port);

The equivalent of free() is strbuf_release(). I think it is reasonable
to strbuf_reset here, since we are about to write into it again anyway
(though I doubt it happens much in practice, since that would imply
multiple `host=3D` segments sent by the client). But later...

> -	free(hostname);
> -	free(canon_hostname);
> -	free(ip_address);
> -	free(tcp_port);
> -	hostname =3D canon_hostname =3D ip_address =3D tcp_port =3D NULL;
> +	strbuf_reset(&hostname);
> +	strbuf_reset(&canon_hostname);
> +	strbuf_reset(&ip_address);
> +	strbuf_reset(&tcp_port);

These probably want to all be strbuf_release(). Again, I doubt it
matters much because this is a forked daemon serving only a single
request (so they'll get freed by the OS soon anyway), but I think
freeing the memory here follows the original intent.

-Peff
