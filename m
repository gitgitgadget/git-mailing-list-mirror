From: Thomas Rast <trast@student.ethz.ch>
Subject: [IRC/patches] Failed octopus merge does not clean up
Date: Tue, 16 Sep 2008 00:48:19 +0200
Message-ID: <200809160048.31443.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5919478.CYHEWEmoMj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMt5-00056k-Qk
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbYIOWsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbYIOWsf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:48:35 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21397 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbYIOWse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:48:34 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 00:48:33 +0200
Received: from [192.168.0.7] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 00:48:33 +0200
User-Agent: KMail/1.9.9
X-OriginalArrivalTime: 15 Sep 2008 22:48:33.0144 (UTC) FILETIME=[2E49AF80:01C91785]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95952>

--nextPart5919478.CYHEWEmoMj
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi *

James "jammyd" Mulcahy pointed out on IRC that the octopus merge
strategy doesn't properly clean up behind itself.  To wit:

  git init
  echo initial > foo
  git add foo
  git commit -m initial
  echo a > foo
  git commit -m a foo
  git checkout -b b HEAD^
  echo b > foo
  git commit -m b foo
  git checkout -b c HEAD^
  echo c > foo
  git commit -m c foo
  git checkout master
  git merge b c

The merge says

  Trying simple merge with 5b3e4bb1c2d88d6967fb575729fbfc86df5eaec9
  Simple merge did not work, trying automatic merge.
  Auto-merging foo
  ERROR: Merge conflict in foo
  fatal: merge program failed
  Automated merge did not work.
  Should not be doing an Octopus.
  Merge with strategy octopus failed.

So far so good.  However, 'git status' claims

  #       unmerged:   foo

and indeed the contents of 'foo' are the conflicted merge between
'master' and 'b', yet there is no .git/MERGE_HEAD.  This behaviour is
identical for 1.5.6 and 1.6.0.2, so it is not caused by the merge
rewrite as a builtin.  Shouldn't it either really clean up, or really
leave the repo in a conflicted merge state?  (I'm following up with a
patch that turns the above into a test.  Octopus doesn't really have
many tests, does it?)

On the code path to the "Merge with strategy %s failed" message,
builtin-merge.c:1134 runs restore_state() which runs reset_hard().
But (as Miklos pointed out) that cannot actually do 'git reset --hard'
because it is possible (though not recommended, see below) to start a
merge with a dirty index.

Jakub mentioned that there are only three index stages for a three-way
merge, so a conflicted n-way (simultaneous) merge is not really
possible.

The merge manpage should warn about merging with uncommitted changes.
It recommends 'git rebase --hard' to abort during conflicts, but does
not mention that this throws away said changes.  I'm following up with
a patch for this.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart5919478.CYHEWEmoMj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjO5j8ACgkQqUud07tmzP3r1QCfTdfbIjhN1Xspsi/mPFL+xAqn
M/cAoJhXEYh/dDqzUDW3o0oOG9J1tqlB
=V9tC
-----END PGP SIGNATURE-----

--nextPart5919478.CYHEWEmoMj--
