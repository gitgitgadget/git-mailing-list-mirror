From: Jeff King <peff@peff.net>
Subject: Re: compile error in Git v2.7.0-rc0
Date: Mon, 14 Dec 2015 15:46:25 -0500
Message-ID: <20151214204624.GA14788@sigill.intra.peff.net>
References: <CALibRqFajuBuv9ooaBWL1kUzaVps2WfodqucyHni2ggv6JpwDg@mail.gmail.com>
 <xmqqvb80ix9u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johan defries <johandefries@gmail.com>, git@vger.kernel.org,
	gitter.spiros@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8a0u-0006de-CE
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbbLNUq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2015 15:46:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:41464 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753285AbbLNUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:46:28 -0500
Received: (qmail 16660 invoked by uid 102); 14 Dec 2015 20:46:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 14:46:27 -0600
Received: (qmail 31263 invoked by uid 107); 14 Dec 2015 20:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:46:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 15:46:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb80ix9u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282408>

On Mon, Dec 14, 2015 at 12:35:25PM -0800, Junio C Hamano wrote:

> johan defries <johandefries@gmail.com> writes:
>=20
> > Probably because I have NO_IPV6 defined.
> >
> > ident.c: In function =E2=80=98canonical_name=E2=80=99:
> > ident.c:89:37: error: =E2=80=98buf=E2=80=99 undeclared (first use i=
n this function)
> >   struct hostent *he =3D gethostbyname(buf);
> >                                      ^
> > ident.c:89:37: note: each undeclared identifier is reported only on=
ce
> > for each function it appears in
> > make: *** [ident.o] Fout 1
>=20
> Thanks.  This should perhaps do?
>=20
>  ident.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/ident.c b/ident.c
> index 4e7f99d..2900879 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -86,6 +86,7 @@ static int canonical_name(const char *host, struct =
strbuf *out)
>  		freeaddrinfo(ai);
>  	}
>  #else
> +	char buf[1024];
>  	struct hostent *he =3D gethostbyname(buf);
>  	if (he && strchr(he->h_name, '.')) {
>  		strbuf_addstr(out, he->h_name);

Whoops. Looks like we didn't test the NO_IPV6 code path.

I don't think that fix is right, though. We should be passing "host" to
gethostbyname.

-Peff
