From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 12:22:23 +0200
Message-ID: <20080731102223.GD12867@artemis.madism.org>
References: <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org> <20080731090348.GB20691@sigill.intra.peff.net> <20080731091515.GC12867@artemis.madism.org> <20080731093410.GA21396@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NklN7DEeGtkPCoo3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 12:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOVJg-0002RR-Pm
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 12:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYGaKW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 06:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYGaKW0
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 06:22:26 -0400
Received: from pan.madism.org ([88.191.52.104]:50839 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbYGaKW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 06:22:26 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 92DE73C5FA;
	Thu, 31 Jul 2008 12:22:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6705B3338; Thu, 31 Jul 2008 12:22:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080731093410.GA21396@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90920>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [Pierre, you have the bogus MFT header that people are often complaining
> about. Either I have to do extra work to fix the headers, or more people
> end up in the To: field. I don't personally care about the latter, but
> it seems that others organize their mail based on To versus Cc]

  [  err if you do a list reply, nobody ends up in To:... but oh well I
     can probably remove it, it'll just make my own mutt git folder
     awkwardly colorized.  ]

On Thu, Jul 31, 2008 at 09:34:10AM +0000, Jeff King wrote:
> On Thu, Jul 31, 2008 at 11:15:15AM +0200, Pierre Habouzit wrote:
> > --no-walk alters how add_pending_object_with_mode works, which is called
> > by handle_revision_arg. IOW, <ref1> --no-walk <ref2> is not the same as
> > --no-walk <ref1> <ref2>. IOW reference arguments and --no-walk ordering
> > must be preserved, IOW --no-walk is a pseudo-argument like --all --tags
> > or --remote are.
>=20
> Ah, OK. Then that makes sense, then. And I definitely feel that the
> patch I posted is the right thing to do,

  Yeah I was convinced the first time I saw it already :)

-- >8 --
allow "non-option" revision options in parse_option-enabled commands

Commands which use parse_options but also call
setup_revisions must do their parsing in a two step process:

  1. first, they parse all options. Anything unknown goes to
     parse_revision_opt (which calls handle_revision_opt),
     which may claim the option or say "I don't recognize
     this"

  2. the non-option remainder goes to setup_revisions to
     actually get turned into revisions

Some revision options are "non-options" in that they must be
parsed in order with their revision counterparts in
setup_revisions. For example, "--all" functions as a
pseudo-option expanding to all refs, and "--no-walk" affects
refs after it on the command line, but not before. The
revision option parser in step 1 recognizes such options and
sets them aside for later parsing by setup_revisions.

However, the return value used from handle_revision_opt
indicated "I didn't recognize this", which was wrong. It
did, and it took appropriate action (even though that action
was just deferring it for later parsing). Thus it should
return "yes, I recognized this."

Previously, these pseudo-options generated an error when
used with parse_options parsers (currently just blame and
shortlog). With this patch, they should work fine, enabling
things like "git shortlog --all".

Signed-off-by: Jeff King <peff@peff.net>
Acked-By: Pierre Habouzit <madcoder@debian.org>
---
 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index a843c42..eaa5572 100644
--- a/revision.c
+++ b/revision.c
@@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info *revs,=
 int argc, const char **arg
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
 	{
 		unkv[(*unkc)++] =3D arg;
-		return 0;
+		return 1;
 	}
=20
 	if (!prefixcmp(arg, "--max-count=3D")) {
--=20
1.6.0.rc1.197.gc57ac6

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiRkl8ACgkQvGr7W6HudhxVrACZAR0Jb8OMkz+JU1G7Dz6M2W2S
zeMAnAzEYmHR6uWDjNMk9qKWwvS/QmZf
=smDr
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
