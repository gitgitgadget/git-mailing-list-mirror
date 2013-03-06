From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 6 Mar 2013 16:05:48 +0100
Message-ID: <20130306150548.GC15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 16:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDFv8-00039Y-9t
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 16:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715Ab3CFPFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 10:05:52 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60083 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab3CFPFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 10:05:52 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDFuf-00015D-85; Wed, 06 Mar 2013 16:05:49 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDFue-0004Cg-Au; Wed, 06 Mar 2013 16:05:48 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217529>

Hello,

Here comes another recipe for a different suggestion:

	git init
	echo 1 > file
	git add file
	git commit -m 'base'
	git branch branch
	seq 1 30 | grep -v 15 > file
	git commit -m 'add 2-30 without 15' file
	git checkout branch
	seq 1 30 | grep -v 16 > file
	git commit -m 'add 2-30 without 16' file
	git merge master
	git diff

This yields:

	diff --cc file
	index a07e697,5080129..0000000
	--- a/file
	+++ b/file
	@@@ -12,7 -12,7 +12,11 @@@
	  12
	  13
	  14
	++<<<<<<< HEAD
	 +15
	++=3D=3D=3D=3D=3D=3D=3D
	+ 16
	++>>>>>>> master
	  17
	  18
	  19

as expected; nice and sweet. After

	git checkout --conflict=3Ddiff3 file

however the difference isn't that easy to spot any more. I expected

	diff --cc file
	index a07e697,5080129..0000000
	--- a/file
	+++ b/file
	@@@ -12,7 -12,7 +12,12 @@@
	  12
	  13
	  14
	++<<<<<<< ours
	 +15
	++||||||| base
	++=3D=3D=3D=3D=3D=3D=3D
	+ 16
	++>>>>>>> theirs
	  17
	  18
	  19

But instead I get

	diff --cc file
	index a07e697,5080129..0000000
	--- a/file
	+++ b/file
	@@@ -1,29 -1,29 +1,61 @@@
	  1
	++<<<<<<< ours
	 +2
	 +3
	 +4
	 +5
	 +6
	 +7
	 +8
	 +9
	 +10
	 +11
	 +12
	 +13
	 +14
	 +15
	 +17
	 +18
	 +19
	 +20
	 +21
	 +22
	 +23
	 +24
	 +25
	 +26
	 +27
	 +28
	 +29
	 +30
	++||||||| base
	++=3D=3D=3D=3D=3D=3D=3D
	+ 2
	+ 3
	+ 4
	+ 5
	+ 6
	+ 7
	+ 8
	+ 9
	+ 10
	+ 11
	+ 12
	+ 13
	+ 14
	+ 16
	+ 17
	+ 18
	+ 19
	+ 20
	+ 21
	+ 22
	+ 23
	+ 24
	+ 25
	+ 26
	+ 27
	+ 28
	+ 29
	+ 30
	++>>>>>>> theirs

Of course this is technically correct, just not maximally helpful.

Is this a missing optimisation for the diff3 case or did I miss a detai=
l
that makes my expectation wrong?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
