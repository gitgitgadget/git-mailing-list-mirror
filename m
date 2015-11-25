From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] wt-status: use strncmp() for length-limited string
 comparison
Date: Wed, 25 Nov 2015 04:15:03 -0500
Message-ID: <20151125091503.GA1779@sigill.intra.peff.net>
References: <563D2DE7.1030005@web.de>
 <20151124213601.GB29185@sigill.intra.peff.net>
 <56551A11.9030809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 10:15:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1WAY-0002MF-TG
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbbKYJPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 04:15:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:33772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755310AbbKYJPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:15:07 -0500
Received: (qmail 28488 invoked by uid 102); 25 Nov 2015 09:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 03:15:05 -0600
Received: (qmail 24475 invoked by uid 107); 25 Nov 2015 09:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 04:15:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 04:15:03 -0500
Content-Disposition: inline
In-Reply-To: <56551A11.9030809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281691>

On Wed, Nov 25, 2015 at 03:16:49AM +0100, Ren=C3=A9 Scharfe wrote:

> > Hmm. I think this is mostly harmless, as a comparison like:
> >=20
> >    memcmp("HEAD and more", "HEAD", strlen("HEAD"))
> [...]
>=20
> Yes, except it should be strlen("HEAD and more") in your example code=
;
> with strlen("HEAD") it would compare just 4 bytes and return 0.

Whoops, yeah. Thank you for figuring out what I meant. :)

> Using one more variable isn't that bad, as long as it gets a fitting
> name.  Or we could reuse "end" (I'm not worrying about scanning "HEAD=
"
> twice very much):
>=20
> diff --git a/wt-status.c b/wt-status.c
> index 435fc28..96a731e 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1317,14 +1317,14 @@ static int grab_1st_switch(unsigned char *osh=
a1, unsigned char *nsha1,
>  	target +=3D strlen(" to ");
>  	strbuf_reset(&cb->buf);
>  	hashcpy(cb->nsha1, nsha1);
> -	for (end =3D target; *end && *end !=3D '\n'; end++)
> -		;
> -	if (!memcmp(target, "HEAD", end - target)) {
> +	if (skip_prefix(target, "HEAD", &end) && (!*end || *end =3D=3D '\n'=
)) {
>  		/* HEAD is relative. Resolve it to the right reflog entry. */
>  		strbuf_addstr(&cb->buf,
>  			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
>  		return 1;
>  	}

Yeah, I think parsing left-to-right like this makes things much more
obvious. And regarding scanning HEAD twice, I think we already do that
(we find the trailing newline first in the current code). Though I agre=
e
that is absurd premature optimization.

> +	for (end =3D target; *end && *end !=3D '\n'; end++)
> +		;

This loop (which I know you just moved, not wrote) is basically
strchrnul, isn't it? That might be more readable.

-Peff
