From: Jeff King <peff@peff.net>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 17:34:14 -0400
Message-ID: <20130416213414.GA11229@sigill.intra.peff.net>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:34:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDW9-0003pV-Je
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403Ab3DPVeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 17:34:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48478 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965368Ab3DPVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 17:34:17 -0400
Received: (qmail 8839 invoked by uid 107); 16 Apr 2013 21:36:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 17:36:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 17:34:14 -0400
Content-Disposition: inline
In-Reply-To: <7v61zml0ow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221478>

On Tue, Apr 16, 2013 at 12:45:03PM -0700, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > Does this patch help?
> >
> >  pretty.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/pretty.c b/pretty.c
> > index d3a82d2..713eefc 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -405,8 +405,8 @@ void pp_user_info(const struct pretty_print_con=
text *pp,
> >  	const char *mailbuf, *namebuf;
> >  	size_t namelen, maillen;
> >  	int max_length =3D 78; /* per rfc2822 */
> > -	unsigned long time;
> > -	int tz;
> > +	unsigned long time =3D 0;
> > +	int tz =3D 0;
> > =20
> >  	if (pp->fmt =3D=3D CMIT_FMT_ONELINE)
> >  		return;
> > @@ -438,8 +438,10 @@ void pp_user_info(const struct pretty_print_co=
ntext *pp,
> >  	strbuf_add(&name, namebuf, namelen);
> > =20
> >  	namelen =3D name.len + mail.len + 3; /* ' ' + '<' + '>' */
> > -	time =3D strtoul(ident.date_begin, &date, 10);
> > -	tz =3D strtol(date, NULL, 10);
> > +	if (ident.date_begin) {
> > +		time =3D strtoul(ident.date_begin, &date, 10);
> > +		tz =3D strtol(date, NULL, 10);
> > +	}
> > =20
> >  	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
> >  		strbuf_addstr(sb, "From: ");
>=20
> Looks like a sensible change.  split_ident_line() decided that the
> given input was mangled and decided there is no valid date (the
> input had <> where the timestamp string was required), so the
> updated code leaves the time/tz unspecified.

Hmm. This seemed oddly familiar to me, and indeed:

  http://thread.gmane.org/gmane.comp.version-control.git/216870/focus=3D=
217077

We need to fix blame, too, and there is a question of how "cat-file -p"
behaves.

-Peff
