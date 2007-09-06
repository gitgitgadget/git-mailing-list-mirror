From: martin f krafft <madduck@madduck.net>
Subject: inconsistent use of worktree?
Date: Thu, 6 Sep 2007 15:29:06 +0200
Message-ID: <20070906132906.GA7791@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 15:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITHQ6-0007IF-6D
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 15:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbXIFN3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756614AbXIFN3M
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 09:29:12 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51955 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447AbXIFN3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 09:29:11 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 557D7BEBC
	for <git@vger.kernel.org>; Thu,  6 Sep 2007 15:29:07 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A93ED9F161
	for <git@vger.kernel.org>; Thu,  6 Sep 2007 15:29:06 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 63DD443F4; Thu,  6 Sep 2007 15:29:06 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57877>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

I have a $GIT_DIR in ~/.bin/colgit.git, which is bare=3Dfalse and has
worktree=3D.. (the parent). This relates back to a suggestion by
Johannes Schindelin [0] for maintaining files like ~/.vimrc and
~/.zshrc in separate repos sharing the same worktree. In short:
while ~/.bin/colgit.git holds all of colgit's objects, refs, and the
index, the repository's files are in ~/.bin (and thus in $PATH).

0. http://marc.info/?l=3Dgit&m=3D118418927823760&w=3D2

I am trying to figure out a sensible way to work with this, ideally
one which does not require me to set $GIT_DIR (which works):

  GIT_DIR=3D~/.bin/colgit.git git status
  GIT_DIR=3D~/.bin/colgit.git git add ...
  GIT_DIR=3D~/.bin/colgit.git git commit ...
  (or one export GIT_DIR)

but that's a lot of typing and thus error-prone.

So in a flash of utter genius, I found this to work:

  piper:~/.bin/colgit.git> git status
  # On branch master
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #
  #       modified:   colgit
  #
  no changes added to commit (use "git add" and/or "git commit -a")

  piper:~/.bin/colgit.git> git add ../colgit

  piper:~/.bin/colgit.git> git status
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #       modified:   colgit

and I rejoiced, because that's really pretty cool. But then, trying
to commit, reality hit back:

  piper:~/.bin/colgit.git> git commit -m'initial commit'
  nothing to commit (use "git add file1 file2" to include for commit)

So I had to revert to using GIT_DIR for this:

  piper:~/.bin> GIT_DIR=3Dcolgit.git git commit -m'initial commit'
  Created initial commit 008594d: initial commit
   1 files changed, 104 insertions(+), 0 deletions(-)
   create mode 100755 colgit

And then things got really weird, after I accidentally tried the
direct commit (without GIT_DIR) again, following some touchups
I made to the colgit file:

  piper:~/.bin/colgit.git> git commit -m'repairing registration and other t=
ouchups'
  Created commit acd86b9: Merge branch 'vimplate'

Huh, vimplate? What happened to the commit? Why vimplate?

  piper:~/.bin/colgit.git> git log
  commit 0ad26b00c31617bf3e31a052e3c3af9ef661407b
  Author: martin f. krafft <madduck@madduck.net>
  Date:   Thu Sep 6 11:45:38 2007 +0200

      repairing registration and other touchups

  [...]

But the commit appears alright, acd86b9 is the tip of ~/.git,
further up, and the output of git-rev-parse HEAD in ~/.bin, the
parent directory and worktree of ~/.bin/colgit.git.

What is git doing? Could it be that it's getting utterly confused
and inconsistently uses the worktree? I'd be happy to investigate
this, but want to make sure I am not doing anything wrong!

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"there are more things in heaven and earth, horatio,
 than are dreamt of in your philosophy."
                                                             -- hamlet
=20
spamtraps: madduck.bogus@madduck.net

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG4ACiIgvIgzMMSnURAi7+AJ9f7AYKLBx+7dORFelvjKbcvaMOKgCdHBHN
5bBRqZZ+YScQjnoleMMLiDg=
=47m0
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
