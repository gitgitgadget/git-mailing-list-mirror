From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: BUG?: git-filter-branch removes mergetags
Date: Tue, 23 Sep 2014 21:13:17 +0200
Message-ID: <20140923191317.GA3755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 21:13:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWVWg-00054G-0R
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 21:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbaIWTNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Sep 2014 15:13:20 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46872 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbaIWTNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 15:13:18 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1XWVWX-0003mr-6n
	for git@vger.kernel.org; Tue, 23 Sep 2014 21:13:17 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1XWVWX-0003ps-4U
	for git@vger.kernel.org; Tue, 23 Sep 2014 21:13:17 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257433>

Hello,

I just noticed that git-filter-branch doesn't preserve mergetag
annotations in situations where it could. Here is an example (with
linux.git):

	$ git checkout -b test 6cd2f85413eef8fe7bcd7c25bf55e7b055fa257c
	$ git cat-file commit HEAD | grep mergetag
	mergetag object 954263938706bf62d36e81b6b49f313390f2ed35
	$ git filter-branch -f --msg-filter 'sed s/foo/bar/' HEAD^!
	Rewrite 6cd2f85413eef8fe7bcd7c25bf55e7b055fa257c (1/1)
	Ref 'refs/heads/test' was rewritten
	$ diff -u <(git cat-file commit refs/original/refs/heads/test) <(git c=
at-file commit HEAD)
	--- /dev/fd/63	2014-09-23 21:07:49.987065017 +0200
	+++ /dev/fd/62	2014-09-23 21:07:49.991064988 +0200
	@@ -3,32 +3,6 @@
	 parent 954263938706bf62d36e81b6b49f313390f2ed35
	 author Linus Torvalds <torvalds@linux-foundation.org> 1411488823 -070=
0
	 committer Linus Torvalds <torvalds@linux-foundation.org> 1411488823 -=
0700
	-mergetag object 954263938706bf62d36e81b6b49f313390f2ed35
	- type commit
	- tag for-linus
	- tagger Paolo Bonzini <pbonzini@redhat.com> 1411478481 +0200
	-=20
	- Another fix for 3.17 arrived at just the wrong time, after I had sen=
t
	- yesterday's pull request.  Normally I would have waited for
	- some other patches to pile up, but since 3.17 might be short
	- here it is.
	- -----BEGIN PGP SIGNATURE-----
	- Version: GnuPG v2.0.22 (GNU/Linux)
	-=20
	- iQIcBAABAgAGBQJUIXPRAAoJEBvWZb6bTYbyySEP/AkPjfNGYqwBbM8GUJ4tt4gR
	- C+xbiO+xPr2qCwfi36DQtL0UPwJHWSq7SXaDMvSqMo22FjnFcVaGuQcGAPno/8ZA
	- tLBe1km9HIPlEIV3vpoe8PPpj9cuZ86+YOCuPIqK5fC7l6Ops0dhCOjf88tmPVQ4
	- yhodpJ1Lt/sPBUWb6pNfk0iWD+qSbfUWtwzv89oudEvLcLiAcPSBdbvnxVS3bmGm
	- qbL8pvCOozK5GJbl0+cYWCoEPBP5ekqGvwvGdEBTx+4qv2S2htzUX30UA2VYy5IR
	- jMXVrJbvSW9FXQdBgr0Q4ql6evOVjL+5LpwgRUC6tuC6r1rMP+nXyHKS35HC1i8W
	- FYr62B/LZTm4vyDHsmsiEl43VLAcF7kmXufQT62vJg+ifeA1MAMIJra7ZDx8WbsD
	- HDqM+CeaZrF3p4okRrktbecQdeFFyg4wOasHRTO7SETkbP7i1cS0Mp8rRbX3CnJq
	- 0UM8STe+hViXR7uYZEbjlbGKkszDS49fstJIaNm9JPJm+S/V5/MZFelNWgPp/+kF
	- xpQUxtoSaFnqgBXpRZ7t2Y2zGeZkMWn/P84S23/7K1TfRPCsUpgFbiY26rGW9l4v
	- r8gz7v+V1gCzWYVRuEzolFrea6A1ik2sspzeDuZOrf+QYwMyyUdEQ/NfCm032wba
	- CYL0V2M/dJNmZnZRPP9/
	- =3DZkSE
	- -----END PGP SIGNATURE-----
	=20
	 Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
	=20
I expected the signature to not disappear such that in the example abov=
e
no change is introduced.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
