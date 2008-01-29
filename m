From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Tue, 29 Jan 2008 20:08:45 +0100
Message-ID: <20080129190845.GC30093@artemis.madism.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="xo44VMWPx7vlQ2+2";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJvpj-0005eS-0H
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 20:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbYA2TIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 14:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbYA2TIs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 14:08:48 -0500
Received: from pan.madism.org ([88.191.52.104]:58781 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbYA2TIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 14:08:47 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 11EEB2BE49;
	Tue, 29 Jan 2008 20:08:45 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4EB68151263; Tue, 29 Jan 2008 20:08:45 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080129041000.GK24004@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71987>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2008 at 04:10:00AM +0000, Shawn O. Pearce wrote:
> * PGP public key storage:
>=20
>   Use a "hidden" ref called "refs/access-keys" to store a commit.
>   The access control change log is a normal Git commit chain.
>=20
>   The tree under this commit stores a file per <email> string.
>   Public keys for auth line validation are located by <email>,
>   from the tip of this branch.
>=20
>   This branch could be a symlink to another repository (e.g.
>   a site-wide "admin" repository) and the ODB for that other
>   repository could be an alternate for this repository.

  This won't work well, because I don't think GnuPG is able to check
some signature against an armored GPG public Key (at least I didn't
found a way to do that). You have to create one pubring per submitter,
wich is kind of a waste in fact, and the format is horribly binary.

  I don't even know if you really need the versionning of this
pseudo-keyring, and if a .git/keyring.gpg isn't enough.

  As a side note, you don't really need to use GIT_PUSH_*. It doesn't
make anything safer (as the UIDs of a given public key are public
information anyways), you just want to know which key signed that data,
and the signature holds that information. Hence if you still want to
have a flat-file based keyring (which I repeat I don't think gpg
supports directly -- and that's really a shame) you'd better index them
per key fingerprint than by author name.

  And then you just need to call gpg this way:

$ gpg --keyring path/to/the/keyring.gpg --quiet --batch --status-fd 1 --ver=
ify some-file.tar.gz.gpg 2>|/dev/null
[GNUPG:] SIG_ID dw0VliO0DFjOQA3HUSHijYekQYY 2008-01-29 1201633002
[GNUPG:] GOODSIG BC6AFB5BA1EE761C Pierre Habouzit <pierre.habouzit@polytech=
nique.edu>
[GNUPG:] VALIDSIG 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C 2008-01-29 12016=
33002 0 3 0 17 2 00 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C
[GNUPG:] TRUST_ULTIMATE

  And if the key is not in your keyring this looks like:
$ GNUPGHOME=3D/tmp gpg --verify --status-fd 1 some-file.tar.gz.gpg 2>/dev/n=
ull
[GNUPG:] ERRSIG BC6AFB5BA1EE761C 17 2 00 1201633002 9
[GNUPG:] NO_PUBKEY BC6AFB5BA1EE761C
                   ^^^^^^^^^^^^^^^^
            that's the key id you look for.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHn3m9vGr7W6HudhwRAp3eAJkBSeoQfLCVXBpImrXYXu9ljjvrYwCglP9O
efBHlHHvXiE0MPBKY89J6bI=
=+jEn
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
