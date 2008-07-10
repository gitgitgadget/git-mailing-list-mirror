From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] revisions: refactor handle_revision_opt into  parse_revision_opt.
Date: Thu, 10 Jul 2008 09:34:50 +0200
Message-ID: <20080710073450.GA24819@artemis.madism.org>
References: <1215639514-1612-1-git-send-email-madcoder@debian.org> <1215639514-1612-2-git-send-email-madcoder@debian.org> <20080710071418.GD3195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cNdxnHkX5QqsyA0e";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqh0-0002Rc-29
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYGJHey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbYGJHey
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:34:54 -0400
Received: from pan.madism.org ([88.191.52.104]:43333 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbYGJHex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:34:53 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7CEC21BA;
	Thu, 10 Jul 2008 09:34:52 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EA1DC4A8; Thu, 10 Jul 2008 09:34:50 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080710071418.GD3195@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87952>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2008 at 07:14:18AM +0000, Jeff King wrote:
> On Wed, Jul 09, 2008 at 11:38:34PM +0200, Pierre Habouzit wrote:
>=20
> > It seems we're using handle_revision_opt the same way each time, have a
> > wrapper around it that does the 9-liner we copy each time instead.
> >=20
> > handle_revision_opt can be static in the module for now, it's always
> > possible to make it public again if needed.
>=20
> I have been on the road, and I finally got the chance to read through
> your whole parseopt/blame refactoring. I think it looks good overall, as
> do these patches.
>=20
> I have one comment, though I am not sure it is worth implementing.
>=20
> I was happy to see this refactoring, which I think improves readability:
>=20
> > -		n =3D handle_revision_opt(&revs, ctx.argc, ctx.argv,
> > -					&ctx.cpidx, ctx.out);
> > -		if (n <=3D 0) {
> > -			error("unknown option `%s'", ctx.argv[0]);
> > -			usage_with_options(blame_opt_usage, options);
> > -		}
> > -		ctx.argv +=3D n;
> > -		ctx.argc -=3D n;
> > +		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
>=20
> but it also seems like the top bit of that for loop is boilerplate, too:
>=20
> >  	for (;;) {
> >  		switch (parse_options_step(&ctx, options, shortlog_usage)) {
> >  		case PARSE_OPT_HELP:
> >  			exit(129);
> >  		case PARSE_OPT_DONE:
> >  			goto parse_done;
> >  		}
>=20
> AFAICT, the main reason for not folding this into your refactored
> function is that after the parse_options_step, but before we handle the
> revision arg to parse_revision_opt, there needs to be an opportunity for
> the caller to intercept and do something based on revision opts (like
> blame does with --reverse):
>=20
> 	if (!strcmp(ctx.argv[0], "--reverse")) {
> 		ctx.argv[0] =3D "--children";
> 		reverse =3D 1;
> 	}

  The other thing I would like to do is remove the exit(129) and replace
it with proper documentation for the rev-list options, and this will
depend upon the fact that we parse revisions or something else inside
the loop. Of course this is boilerplate, but well, I wouldn't like to
hide it and prevent people from thinking they can hook other things in
there.

  And I'm not very keen on adding more options to parse-options like you
propose, our endgame is to get rid of parse_revision_opt in this form
and have a full parse-opt thing from top to bottom. the "--reverse" hack
could be done really differently, because we really know what
"--children" does and we could directly do what the revision option
parser does. But oh well... For now I'm more interested to see more
commands migrated thanks to this facility, and see what we can refactor
to get rid of the old parsers at once.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh1u5YACgkQvGr7W6HudhzAeQCghpxONsLUCSt/mClI0ttvzaP8
dQ4AnAumfAL1cDncifPERmndX+lxHiiO
=KLW1
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
