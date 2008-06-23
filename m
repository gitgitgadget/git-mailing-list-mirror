From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 23:09:35 +0200
Message-ID: <20080623210935.GC13395@artemis.madism.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VywGB/WGlW4DM4P8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtJJ-0005fK-HW
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbYFWVJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYFWVJw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:09:52 -0400
Received: from pan.madism.org ([88.191.52.104]:49131 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbYFWVJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:09:52 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D187B37DCA;
	Mon, 23 Jun 2008 23:09:45 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 43C971BC167; Mon, 23 Jun 2008 23:09:35 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85923>


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 07:16:17PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Mon, 23 Jun 2008, Linus Torvalds wrote:
> >=20
> > Or are we going to sit around discussing this for another five months?
>=20
> So the gauntlet is thrown.

  Let's see if I can catch it elegantly.

  Following is a series split into incremental patches to migrate the
parse_options API to an incremental one. Only the last step provides a
functional incremental API.

  With that, you write parsers this way:



{
    struct parse_opt_ctx_t ctx;

    parse_options_start(&ctx, argc, argv, 0);

    for (;;) {
        const char *arg;

        switch (parse_options_step(&ctx, options, usagestr)) {
        case PARSE_OPT_HELP:
            /* dump your help here, the one for options/usagestr is already=
 dumped */
            exit(129);
        case PARSE_OPT_DONE:
            goto done;
        }

        arg =3D *ctx->argv++;
        ctx->argc--;

        if (strcmp(arg, "-")) {
            /* you're on baby ! */
        } else if ....
        } else {
            error("unknown option %s", arg);
            parse_options_usage(options, usagestr);
            /* dump your help here */
            exit(129);
        }
    }

done:
    argc =3D parse_options_end(&ctx);
}


It's slightly more involved than what Linus handwaved, but I believe
it's usable this way.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgEQ8ACgkQvGr7W6HudhzZygCfbciNt0YrtaAtHnKH3CGv7fIc
NFgAoIyak9fLyKx+xLxWrVQ75KuQ2bxf
=D+eN
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
