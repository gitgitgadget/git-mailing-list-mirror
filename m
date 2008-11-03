From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git send-email: allow any rev-list option as an  argument.
Date: Mon, 03 Nov 2008 10:15:13 +0100
Message-ID: <20081103091513.GC13930@artemis.corp>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225471925-2750-1-git-send-email-madcoder@debian.org> <20081102043523.GE5261@coredump.intra.peff.net> <20081102093907.GF4066@artemis> <20081102180220.GA5726@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yLVHuoLXiP9kZBkt";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:16:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwvXz-0007Dk-Fb
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbYKCJPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbYKCJPR
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:15:17 -0500
Received: from pan.madism.org ([88.191.52.104]:37568 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbYKCJPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:15:15 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 57D463BBB1;
	Mon,  3 Nov 2008 10:15:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0D84455AC1C; Mon,  3 Nov 2008 10:15:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081102180220.GA5726@sigio.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99916>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 06:02:21PM +0000, Jeff King wrote:
> On Sun, Nov 02, 2008 at 10:39:07AM +0100, Pierre Habouzit wrote:
>=20
> > Well it still messes the file/reference name conflict with no way to
> > prevent it because of the backward compatibility, and even if unlikely
> > it's still possible.
>=20
> Hmm. As Junio mentioned, this is really an easier way of doing:
>=20
>   git format-patch -o tmp "$@"
>   $EDITOR tmp/*
>   git send-email tmp
>=20
> So I guess a wrapper program would suffice, that just called send-email.
> But of course then you would have to think of a new name, and explain
> the confusion between it and send-email.

Well that defeats the purpose of fixing send-email to me. I really would
like to see this fixed properly like it should. I mean it makes sense to
me to use _three_ commands where one should be enough. Not to mention
that introducing a new command is just completely against the spirit of
*simplifying* the current UI ;)

Actually I see a few possibilities.

(1) The first one is to pass a --[no]-format-patch flag to
    git-send-email which says that it should understand arguments as
    format-patch arguments.  You add to that a sendemail.format-patch
    setting that would default to false for backward compatibility sake,
    that would allow the user to force --format-patch as a default.

    This would e.g. cleanly allow:  git send-email --format-patch -3 HEAD.

    I would understand if people dislike the setting: it basically
    modifies the behaviour of a git command a lot, which has been
    frowned upon in the past. Even though I would argue than using
    git-send-email in scripting is quite bad, for something that you can
    probably replace with:

    while read patchname; do mail some@where.org < $patchname; done < git f=
ormat-patch "$@"

    But if people think it's too dangerous, replacing it with a short
    switch so that it's not too painful to use would fly for me,
    something like -F or whatever.


(2) Another way is to add a --pass-to-format-patch kind of option that
    would take its arguments and pass it to git-format-patch. Like in:
    git send-email --pass-to-format-patch "-3 HEAD". (Of course a short
    switch would help ;p).

(3) Use -- for mandatory separating <format-patch> arguments like this:

	git send-email [send-email options] -- -3 HEAD

    or if you want to send patches that would modify only a given path:

        git send-email [s-e options] -- origin/next.. -- git-gui

    that would run internally:

        git format-patch origin/next.. -- git-gui


I would say that I dislike (2) a LOT because it's a pain to use: needs a
lot of quoting, and it gets worse if you want to pass things with spaces
in it to format-patch.

(2) has the small drawback of not being 100% backward compatible: with
the current use of perl Getoptions, -- is used to stop options
processing, and people _may_ have used it to do `git s-e -- --my.patch`
and such a use would break. However this is highly unlikely to cause
issues in real life I think (unlike the problem of refs against filename
clashes).

In (1) people may dislike the idea of a setting, I've not strong
feelings about it, I won't mind if it gets rejected, a short switch will
do just fine then.


As a summary, I'd say that I like both (1) and (3) because those are
handy, short, and either completely or mostly backward compatible. My
way would be to go down (1) and add a alias.s-e =3D !git send-email -F in
my .gitconfig.

What do you think ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOwSEACgkQvGr7W6Hudhx8BgCeI4ww6g5URQXw0dXDZOpFJm0M
xuMAn0NQ18EEvWGIAVhGAOyS8AGskNse
=PriI
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
