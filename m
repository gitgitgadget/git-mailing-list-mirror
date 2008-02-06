From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for format-patch
Date: Wed, 06 Feb 2008 22:13:26 +0100
Message-ID: <20080206211326.GA9441@artemis.madism.org>
References: <alpine.LNX.1.00.0802061140360.13593@iabervon.org> <7vsl05vncj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SUOF0GtieIMvvwua";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMrb2-00047m-QQ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 22:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760193AbYBFVNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 16:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759825AbYBFVNa
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 16:13:30 -0500
Received: from pan.madism.org ([88.191.52.104]:44391 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879AbYBFVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 16:13:29 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B547F2E6BD;
	Wed,  6 Feb 2008 22:13:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 88FE66465; Wed,  6 Feb 2008 22:13:26 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vsl05vncj.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72856>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2008 at 08:31:08PM +0000, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
>=20
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  builtin-log.c |   29 ++++++++++++++---------------
> >  1 files changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/builtin-log.c b/builtin-log.c
> > index dcc9f81..1f74d66 100644
> > --- a/builtin-log.c
> > +++ b/builtin-log.c
> > @@ -576,16 +576,19 @@ static void get_patch_ids(struct rev_info *rev, s=
truct patch_ids *ids, const cha
> >  	o2->flags =3D flags2;
> >  }
> > =20
> > -static void gen_message_id(char *dest, unsigned int length, char *base)
> > +static void gen_message_id(struct rev_info *info, char *base)
> >  {
> >  	const char *committer =3D git_committer_info(IDENT_WARN_ON_NO_NAME);
> >  	const char *email_start =3D strrchr(committer, '<');
> >  	const char *email_end =3D strrchr(committer, '>');
> > -	if(!email_start || !email_end || email_start > email_end - 1)
> > +	struct strbuf buf;
> > +	if (!email_start || !email_end || email_start > email_end - 1)
> >  		die("Could not extract email from committer identity.");
> > -	snprintf(dest, length, "%s.%lu.git.%.*s", base,
> > -		 (unsigned long) time(NULL),
> > -		 (int)(email_end - email_start - 1), email_start + 1);
> > +	strbuf_init(&buf, 0);
> > +	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
> > +		    (unsigned long) time(NULL),
> > +		    (int)(email_end - email_start - 1), email_start + 1);
> > +	info->message_id =3D buf.buf;
>=20
> I wonder how the rule established by b315c5c (strbuf change: be
> sure ->buf is never ever NULL) and at the beginning of strbuf.h
> applies here.  I think the current implementation of strbuf
> happens to allow this, and it is very handy.  Perhaps the rule
> stated there should be loosened and allow copying the buf away
> when you know you have stuff in there (i.e. ->buf !=3D slopbuf).
> Pierre, what do you think?
>=20
> What the patch does itself is much nicer than the original.

  Why wouldn't you just use strbuf_detach ? I mean replacing:

+	info->message_id =3D buf.buf;

with:

+	info->message_id =3D strbuf_detach(&buf, NULL);

  isn't really hard to read, and has the nice side effect to prevent
errors that could happen in the future (like reusing buf and screwing
with info->message_id without noticing it). I'd rather stand on the safe
side here, it's more forward-compatible and idiot-proof[0].


  [0] Not that I believe git contributors are idiots, but I firmly
      believe in defensive programming when it doesn't impact
      performances. And I don't believe it would here.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHqiL2vGr7W6HudhwRAmo3AJ92BVc04wle2DC0yYu2B3A3WVjX3QCfays1
/PIhpjNtz7v/2Tq5PC/G9m0=
=Jo46
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
