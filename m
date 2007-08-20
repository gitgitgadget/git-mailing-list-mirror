From: martin f krafft <madduck@madduck.net>
Subject: confused about preserved permissions
Date: Mon, 20 Aug 2007 18:44:11 +0200
Message-ID: <20070820164411.GA15637@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:44:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INAMV-0004v7-Vw
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 18:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759678AbXHTQoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXHTQoP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 12:44:15 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:59442 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbXHTQoO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 12:44:14 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id C3D01895F67
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 18:44:12 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06676-02 for <git@vger.kernel.org>;
	Mon, 20 Aug 2007 18:44:12 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 74579895D8F
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 18:44:12 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A8C919F16A
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 18:44:11 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 56ABE43F9; Mon, 20 Aug 2007 18:44:11 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56221>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I am a bit confused about how git stores and restores permissions.
I went to the web but found little other than this post from Linus
in 2005:

  http://www.gelato.unsw.edu.au/archives/git/0504/0870.html

where he basically says that git will *not* save permissions and
that it also does not save symlinks. I thus discarded the
information as being outdated. I have also looked into the source,
but the following question is more about git design than
implementation.

Let me illustrate the source of my confusion:

  $ git init
  Initialized empty Git repository in .git/
  $ umask
  002
  $ date > file1; ls -l file1
  -rw-rw-r-- 1 madduck madduck 30 2007-08-20 18:15 file1
  $ git add file1; git commit -m.
  Created initial commit 5762460: .
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 file1

file1 is mode 664, but gut says "create mode 100644 file1",
independently of whether I use --shared when initialising, or what
value I set it to. Why does it override the group write bit?

But it gets worse:

  $ git checkout -b t
  Switched to a new branch "t"
  $ git rm file1; git commit -m.
  rm 'file1'
  Created commit a813b4e: .
  1 files changed, 0 insertions(+), 1 deletions(-)
  delete mode 100644 file1
  $ umask 007
  $ git checkout master
  Switched to branch "master"
  $ ls -l file1
  -rw-rw----  1 madduck madduck    30 2007-08-20 18:15 file1

So git doesn't even restore 644 when I switch branches, nor on
initial clone, or on re-checkout after removing the local copy.

Am I doing something wrong?

Why does git bother saving a mode when later it never seems to use
it again?

And is there a way to tell git not to mess with the permissions in
the worktree when switching branches? I am not sure what's causing
it since the inode of files does not seem to change, so git
apparently explicitly fchmod()'s files.

I'd be grateful for any documentation to read in addition to the
code. I saw core.filemode, but that's only about the x bit, it
seems.

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"vista is evidentally latvian for "hen", and "perating system", that
 is, OS without the o, means "system for making eggs."  so vista is at
 least useful come breakfast time?"
                                                      -- kit la touche
=20
spamtraps: madduck.bogus@madduck.net

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGycTbIgvIgzMMSnURArvEAJ4rEptt6Jrpv0pC/nUcyxhRdqoI7QCfUICr
O3GwPZsnf0qtITLbuW7xJ0s=
=7nai
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
