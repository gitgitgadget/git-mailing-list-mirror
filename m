From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-sh-setup: fix parseopt `eval`.
Date: Thu, 08 Nov 2007 10:35:15 +0100
Message-ID: <20071108093515.GC7391@artemis.corp>
References: <7vr6j15i3a.fsf@gitster.siamese.dyndns.org> <20071108091402.GA7391@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="69pVuxX8awAiJ7fD";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 10:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3nd-0003bI-Et
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165AbXKHJfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758112AbXKHJfT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:35:19 -0500
Received: from pan.madism.org ([88.191.52.104]:38785 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757904AbXKHJfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:35:17 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 52D3C2914E;
	Thu,  8 Nov 2007 10:35:16 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id EBC30F9B6; Thu,  8 Nov 2007 10:35:15 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071108091402.GA7391@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63978>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 09:14:02AM +0000, Pierre Habouzit wrote:
> On Thu, Nov 08, 2007 at 07:09:29AM +0000, Junio C Hamano wrote:
> > The 'automagic parseopt' support corrupted non option parameters
> > that had IFS characters in them.  The worst case can be seen
> > when it has a non option parameter like this:
> >=20
> > 	$1=3D" * some string   blech"
> >=20
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> > -	parseopt_extra=3D
> > -	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
> > -		parseopt_extra=3D"$parseopt_extra --keep-dashdash"
> > +	[ -n "$OPTIONS_KEEPDASHDASH" ] && parseopt_extra=3D"--keep-dashdash"
>=20
>   oh and this part is wrong because you're affected by $parseopt_extra
> environment poisonning. And you have to fix git-clone.sh that uses
> git-rev-parse --parsopt directly with the same call too (as it doesn't
> use git-sh-setup).

  Here is a patch that should fix all those issues at once, replace
yours.  I tested it with this minimal test:

    $ cat parseopt.sh
    #!/bin/sh

    OPTIONS_KEEPDASHDASH=3D
    OPTIONS_SPEC=3D"\
    foo
    --
    "
    . git-sh-setup
    for i in "$@"; do echo "$i"; done
    $ ./parseopt.sh " * hahahah	bleh"
    --
     * hahahah     bleh
    $ ./parseopt.sh -asd " * hahahah     bleh"
    error: unknown switch `a'
    usage: foo


    $ echo $?
    129

which fix your bug, and still behaves as advertised.


=46rom 3c2095533094ff6d82272dc36d9f576b0e81d135 Mon Sep 17 00:00:00 2001
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Thu, 8 Nov 2007 10:32:11 +0100
Subject: [PATCH] Prevent eval of $(git-rev-parse --parseopt) output to be s=
hell-expansed.

Thanks to Junio for having spotted this.
Use the preferred $(...) form rather than ``

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-clone.sh    |    2 +-
 git-sh-setup.sh |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index f216f03..24ad179 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -36,7 +36,7 @@ usage() {
 	exec "$0" -h
 }
=20
-eval `echo "$OPTIONS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit=
 $?`
+eval "$(echo "$OPTIONS_SPEC" | git rev-parse --parseopt -- "$@" || echo ex=
it $?)"
=20
 get_repo_base() {
 	(
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index e1cf885..5aa62dd 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -23,9 +23,13 @@ if test -n "$OPTIONS_SPEC"; then
=20
 	parseopt_extra=3D
 	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
-		parseopt_extra=3D"$parseopt_extra --keep-dashdash"
+		parseopt_extra=3D"--keep-dashdash"
=20
-	eval `echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- =
"$@" || echo exit $?`
+	eval "$(
+		echo "$OPTIONS_SPEC" |
+			git rev-parse --parseopt $parseopt_extra -- "$@" ||
+		echo exit $?
+	)"
 else
 	usage() {
 		die "Usage: $0 $USAGE"
--=20
1.5.3.5.1598.gdef4e-dirty


--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMthTvGr7W6HudhwRAjTyAKChMHT5dh5BVgXlp/VezTRgcCF8KACgkFhR
7y3eSKoSznhlo+6exNGvX9k=
=j+1G
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
