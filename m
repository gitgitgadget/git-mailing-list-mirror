From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 5/6] builtin-commit: resurrect behavior for multiple -m   options
Date: Sun, 11 Nov 2007 23:11:34 +0100
Message-ID: <20071111221134.GD13200@artemis.corp>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736310.4362@racer.site> <20071111194228.GC13200@artemis.corp> <Pine.LNX.4.64.0711112039130.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="76DTJ5CE0DCVQemd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrL21-0007q3-T3
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbXKKWLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754969AbXKKWLh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:11:37 -0500
Received: from pan.madism.org ([88.191.52.104]:48688 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbXKKWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:11:37 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 795FB2991B;
	Sun, 11 Nov 2007 23:11:35 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B91D5FEEE7; Sun, 11 Nov 2007 23:11:34 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711112039130.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64524>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2007 at 08:42:48PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 11 Nov 2007, Pierre Habouzit wrote:
>=20
> > On Sun, Nov 11, 2007 at 05:36:39PM +0000, Johannes Schindelin wrote:
> > >=20
> > > When more than one -m option is given, the message does not replace
> > > the previous, but is appended.
> > >=20
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  builtin-commit.c |   26 ++++++++++++++++++++------
> > >  1 files changed, 20 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/builtin-commit.c b/builtin-commit.c
> > > index 66d7e5e..069d180 100644
> > > --- a/builtin-commit.c
> > > +++ b/builtin-commit.c
> > > @@ -30,13 +30,27 @@ static char *use_message_buffer;
> > >  static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
> > >  static struct lock_file lock_file;
> > > =20
> > > -static char *logfile, *force_author, *message, *template_file;
> > > +static char *logfile, *force_author, *template_file;
> > >  static char *edit_message, *use_message;
> > >  static int all, edit_flag, also, interactive, only, amend, signoff;
> > >  static int quiet, verbose, untracked_files, no_verify;
> > > =20
> > >  static int no_edit, initial_commit, in_merge;
> > >  const char *only_include_assumed;
> > > +struct strbuf message;
> >=20
> >   Unless I'm mistaken `static` keywords are missign for`message` and
> > `only_include_assumed`.
>=20
> Oh yeah.  Will fix.
>=20
> >   And you _have_ to initialize message with STRBUF_INIT (remember of the
> > slop).
>=20
> Not in this case, since I do not use message.buf as long as message.len =
=3D=3D=20
> 0.  But I agree it would be cleaner to just use STRBUF_INIT.

  I know that you don't use it, but who knows where this code will be
headed in its future right ? :) It's just good practice.

> > > +static int opt_parse_m(const struct option *opt, const char *arg, in=
t unset)
> > > +{
> > > +	struct strbuf *buf =3D opt->value;
> > > +	if (unset)
> > > +		strbuf_setlen(buf, 0);
> > > +	else {
> > > +		strbuf_addstr(buf, arg);
> > > +		strbuf_addch(buf, '\n');
> > > +		strbuf_addch(buf, '\n');
> > > +	}
> > > +	return 0;
> > > +}
> >=20
> >   I believe such a callback could live in parse-options.[hc]. The need
> > to aggregate all string arguments into a strbuf looks generic enough to
> > me. Why are you adding two '\n' btw ? Isn't one enough ?
>=20
> Well, this empty line is needed to stay backwards compatible.  It was=20
> added to pass the test that Junio added to 'next'.  As such, this functio=
n=20
> is not really generic enough, right?

  Well, you can make it generic enough using the defval to point to a
delimiter to use between lines :) But it's probably an overkill, and yes
if the "\n\n" is to be kept, then it's not generic "enough".

> Well, I meant to mention it in the cover letter.  My preference is to do=
=20
> away with the extra empty line.  But this might break existing setups=20
> depending on that behaviour.

  Right.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHN34WvGr7W6HudhwRAvx9AKCAChjwPsf5Q8Un2n9GCb4ZBnWYVACfXhNs
EqmvhBcDXg9rdN+c9TFvIy4=
=ulPY
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
