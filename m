From: martin f krafft <madduck@madduck.net>
Subject: [PATCH] translate bad characters in refnames during git-svn fetch
Date: Sun, 15 Jul 2007 15:05:48 +0200
Message-ID: <20070715130548.GA6144@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 15:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4ct-0004MJ-Dh
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 15:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXGON7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbXGON7D
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 09:59:03 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56897 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbXGON7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 09:59:00 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id D8435895D72
	for <git@vger.kernel.org>; Sun, 15 Jul 2007 15:58:58 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24305-04 for <git@vger.kernel.org>;
	Sun, 15 Jul 2007 15:58:58 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 63283895D71
	for <git@vger.kernel.org>; Sun, 15 Jul 2007 15:58:58 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 71A399F167
	for <git@vger.kernel.org>; Sun, 15 Jul 2007 15:05:48 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 4746443FC; Sun, 15 Jul 2007 15:05:48 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52555>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to track/convert the Debian pkg-mdadm repository with
git-svn:

  svn://svn.debian.org/svn/pkg-mdadm/mdadm/trunk

My problem is that the fetching fails:

  fatal: refs/remotes/tags/2.6.1-1~exp.1: cannot lock the ref
  update-ref -m r311 refs/remotes/tags/2.6.1-1~exp.1
  c6e351ea25dc90714048e33693099595c2d5dab8: command returned error:
  128

This is because the ~ character is an invalid character for
a refname (it's used to specify the nth parent).

So I figured that the best way to deal with this is to introduce
a conversion filter to git-svn, but I cannot figure out where it has
to go. My perl is rusty and even after an hour now with the code,
I could not find the right spot.

The following patch works, but I can't really explain why. Moreover,
it does not change the STDERR output, so you'll still get stuff like=20

  r340 =3D 0dc5693471af9dfdb712c1342071ba1040af8963
  (tags/2.6.1-1~exp.3)

which makes me think that it's translating the refname too late.
However, the end result looks sane.

Comments welcome,
m

---
git-check-ref-format(1) documents which characters may be contained in
a refname. Since Subversion has different rules, an import can result in
problems, such as:

  fatal: refs/remotes/tags/2.6.1-1~exp.1: cannot lock the ref
  update-ref -m r311 refs/remotes/tags/2.6.1-1~exp.1
  c6e351ea25dc90714048e33693099595c2d5dab8: command returned error: 128

This patch translates bad characters to valid substitutes to enable imports=
 of
tags/branches/whatever using characters that git does not allow in refnames.

Signed-off-by: martin f. krafft <madduck@piper.oerlikon.madduck.net>
---
 git-svn.perl |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 299b40f..de43697 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1239,7 +1239,29 @@ sub new {
 	$self;
 }
=20
-sub refname { "refs/remotes/$_[0]->{ref_id}" }
+sub refname {
+	my ($refname) =3D $_[0]->{ref_id};
+	## transform the refname as per rules in git-check-ref-format(1):
+	# no slash-separated omponent can begin with a dot .
+	# /.* becomes /,*
+	$refname =3D~ s|/\.|/,|g;
+	# It cannot have two consecutive dots .. anywhere
+	# .. becomes ,,
+	$refname =3D~ s|\.\.|,,|g;
+	# It cannot have ASCII control character space, tilde ~, caret ^,
+	# colon :, question-mark ?, asterisk *, or open bracket[ anywhere
+	# <space> becomes _
+	# ~ becomes =3D
+	# ^ becomes @
+	# : becomes %
+	# ? becomes $
+	# * becomes +
+	# [ becomes (
+	$refname =3D~ y| ~^:?*[|_=3D@%\$+(|;
+	# It cannot end with a slash /
+	$refname =3D~ s|/$||g;
+	"refs/remotes/$refname";
+}
=20
 sub svm_uuid {
 	my ($self) =3D @_;
--=20
1.5.3.rc1.27.ga5e40


--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"a warm bed in a house sounds a mite better
 than eating a hot dog on a stick
 with an old geezer traveling on a lawn mower."
                                -- alvin straight (the straight story)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmhusIgvIgzMMSnURAppqAJ9FC6MK+s5KrQ99SxegTfBAp5ab6ACcDHcQ
9iE9jxn5JU+lt4W394LQLRo=
=UaBF
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
