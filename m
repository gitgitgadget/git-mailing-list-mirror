From: Florian Forster <octo@verplant.org>
Subject: Re: [PATCH] git-svnimport: Improved detection of merges.
Date: Thu, 1 Jun 2006 11:36:03 +0200
Message-ID: <20060601093603.GY2315@verplant.org>
References: <11490715283626-git-send-email-octo@verplant.org> <7vlkshs618.fsf@assigned-by-dhcp.cox.net> <20060601092238.GB9333@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KO6AnYnUdC9Z3rW+"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 11:36:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FljbD-0006PC-Qa
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 11:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWFAJgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 05:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWFAJgM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 05:36:12 -0400
Received: from verplant.org ([213.95.21.52]:38833 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1750817AbWFAJgL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 05:36:11 -0400
Received: from octo by huhu.verplant.org with local (Exim 4.50)
	id 1Fljb1-0005Tz-R7; Thu, 01 Jun 2006 11:36:03 +0200
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060601092238.GB9333@hand.yhbt.net>
X-Pgp-Fingerprint: E7F2 3FEC B693 9F6F 9B77  ACF6 8EF9 1EF5 9152 3C3D
X-Pgp-Public-Key: http://verplant.org/pubkey.txt
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21113>


--KO6AnYnUdC9Z3rW+
Content-Type: multipart/mixed; boundary="A2lxmwzFepEIu8KR"
Content-Disposition: inline


--A2lxmwzFepEIu8KR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 01, 2006 at 02:22:39AM -0700, Eric Wong wrote:
> Nope, I haven't seen that nor Florian's patch (assuming it was sent to
> the ml).  Ah, I just saw (part #2) pop up.

sorry, I'm new to the git development and didn't know that patches
should be sent to the ML. I've attached that patch I sent to Junio to
this mail.

Florian Forster <octo@verplant.org> writes:
> The regexes detecting merges (while still relying on the commit
> messages, though) have been improved to catch saner (and hopefully
> more) messages. The old regex was so generic that it often matched
> something else and missed the actual merge-message.

The assumption here is that merges are between branches or between a
branch and the trunk. The regexes therefore match things like
(parenthesis showing what is being used as the branch name if it
matches).
 - `branch/(name)'
 - `(trunk)'
 - `(name) branch'

Prior to the patch `git-svnimport' would match the message
  ``Merging from branch/foo to branch/bar''
and return `from' as the branch name.

Regards,
Florian Forster
--=20
Florian octo Forster
Hacker in training
GnuPG: 0x91523C3D
http://verplant.org/

--A2lxmwzFepEIu8KR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-git-svnimport-Improved-detection-of-merges.txt"
Content-Transfer-Encoding: quoted-printable

=46rom nobody Mon Sep 17 00:00:00 2001
=46rom: Florian Forster <octo@verplant.org>
Date: Wed, 31 May 2006 12:28:41 +0200
Subject: [PATCH] git-svnimport: Improved detection of merges.

The regexes detecting merges (while still relying on the commit messages,
though) have been improved to catch saner (and hopefully more) messages. The
old regex was so generic that it often matched something else and missed the
actual merge-message.
Also, the regex given with the `-M' commandline-option is checked first:
Explicitely given regexes should be considered better than the builtin ones,
and should therefore be given a chance to match a message first.

---

 git-svnimport.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

1075d5b0cd92dbb8dc77838b2da2d8190904b351
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 61f559f..38ac732 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -63,10 +63,17 @@ my $svn_dir =3D $ARGV[1];
=20
 our @mergerx =3D ();
 if ($opt_m) {
-	@mergerx =3D ( qr/\W(?:from|of|merge|merging|merged) (\w+)/i );
+	my $branch_esc =3D quotemeta ($branch_name);
+	my $trunk_esc  =3D quotemeta ($trunk_name);
+	@mergerx =3D
+	(
+		qr!\b(?:merg(?:ed?|ing))\b.*?\b((?:(?<=3D$branch_esc/)[\w\.\-]+)|(?:$tru=
nk_esc))\b!i,
+		qr!\b(?:from|of)\W+((?:(?<=3D$branch_esc/)[\w\.\-]+)|(?:$trunk_esc))\b!i,
+		qr!\b(?:from|of)\W+(?:the )?([\w\.\-]+)[-\s]branch\b!i
+	);
 }
 if ($opt_M) {
-	push (@mergerx, qr/$opt_M/);
+	unshift (@mergerx, qr/$opt_M/);
 }
=20
 # Absolutize filename now, since we will have chdir'ed by the time we
--=20
1.3.3


--A2lxmwzFepEIu8KR--

--KO6AnYnUdC9Z3rW+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEfrUDjvke9ZFSPD0RAmSUAJ9+BttTe78eNSrWg6crzthB7N6YZgCgi3Ar
YNRUUvWACdLonjKy6HM2f7A=
=85ds
-----END PGP SIGNATURE-----

--KO6AnYnUdC9Z3rW+--
