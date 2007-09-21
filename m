From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [SUPERSEDES PATCH 2/7] nfv?asprintf are broken without va_copy, workaround them.
Date: Fri, 21 Sep 2007 09:02:15 +0200
Message-ID: <20070921070215.GA5689@artemis.corp>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-2-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <7vwsumkll8.fsf@gitster.siamese.dyndns.org> <20070920082701.GA2053@artemis.corp> <20070920084311.GB2053@artemis.corp> <7vejgsk0ev.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SLDf9lqlvOQaIe6s";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 09:02:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYcWz-0002yl-44
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 09:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXIUHCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 03:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbXIUHCX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 03:02:23 -0400
Received: from pan.madism.org ([88.191.52.104]:34962 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbXIUHCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 03:02:22 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A529820EAD;
	Fri, 21 Sep 2007 09:02:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CC0884CA51; Fri, 21 Sep 2007 09:02:15 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejgsk0ev.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58830>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2007 at 06:17:12AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > This reinstates the trace_argv_printf API. The implementation is
> > stupid, but is rewritten in a latter commit. I didn't wanted to bother
> > optimizing it.
> > ...
> >  cache.h           |    2 -
> >  imap-send.c       |   13 ++++++++
> >  merge-recursive.c |   74 ++++++++++++++++++++-----------------------
> >  trace.c           |   90 ++++++++++++++++-----------------------------=
--------
> >  4 files changed, 74 insertions(+), 105 deletions(-)
> > ...
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 14b56c2..4e27549 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -85,63 +85,57 @@ struct stage_data
> > +static void flush_output(void)
> >  {
> > +	if (obuf.len) {
> > +		fputs(obuf.buf, stdout);
> > +		strbuf_reset(&obuf);
> >  	}
> >  }
>=20
> This assumes obuf.buf has necessary indentations and line
> breaks, which is sensible.  However...
>=20
> > +static void output(int v, const char *fmt, ...)
> >  {
> > +	if (show(v)) {
> > +		int len;
> > +		va_list ap;
>=20
> Yuck, this single if statement covers the entirety of the
> function.  Let's do
>=20
> 	if (!show(v))
> 	        return;
>=20
> > +		strbuf_grow(&obuf, call_depth);
> > +		memset(obuf.buf + obuf.len, ' ', call_depth);
> > +		strbuf_setlen(&obuf, obuf.len + call_depth);
>=20
> Per depth indentation used to be two whitespaces.
>=20
> > +		va_start(ap, fmt);
> > +		len =3D vsnprintf(obuf.buf, strbuf_avail(&obuf) + 1, fmt, ap);
> > +		va_end(ap);
>=20
> And you overwrite whatever used to be in the buffer, including
> the previous buffered message and indentation you added.  Not
> nice...

  ooops, I wrote it too quickly.

> I'll squash this on top of yours for now.

  works for me except the little remark in the end :)

>  merge-recursive.c |   45 +++++++++++++++++++++++----------------------
>  1 files changed, 23 insertions(+), 22 deletions(-)
>=20

> +	strbuf_setlen(&obuf, obuf.len + len);
> +	strbuf_add(&obuf, "\n", 1);

  rather use strbuf_addch(&obuf, '\n')

> +	if (!buffer_output)
> +		flush_output();
>  }
> =20
>  static void output_commit_title(struct commit *commit)
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG82x3vGr7W6HudhwRAlvoAJ0dYRf5K64iY6zcE9saeUKEmKqcBACfZBr2
CXIWzL/IBFVeJvqORwqZM98=
=+e5h
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
