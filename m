From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: feature suggestion: improve rerere
Date: Wed, 6 Mar 2013 11:16:40 +0100
Message-ID: <20130306101640.GA15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 11:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDBPO-0003J6-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 11:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab3CFKQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 05:16:48 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36066 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab3CFKQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 05:16:44 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDBOq-0004gE-Bx; Wed, 06 Mar 2013 11:16:40 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDBOq-00023N-Av; Wed, 06 Mar 2013 11:16:40 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217513>

Hello,

I think the following suggestion is sound. And it might even be easy to
implement but I don't know how rerere works, so I might be wrong here.

When applying a patch it's normal to hit a conflict. For me this just
happend:

	$ git diff
	diff --cc flash_otp_write.c
	index f360a3e,648e042..0000000
	--- a/flash_otp_write.c
	+++ b/flash_otp_write.c
	@@@ -15,8 -15,23 +15,29 @@@
	 =20
	  #include <mtd/mtd-user.h>
	 =20
	++<<<<<<< ours
	 +#include "common.h"
	 +
	++||||||| base
	++=3D=3D=3D=3D=3D=3D=3D
	+ ssize_t xread(int fd, void *buf, size_t count)
	+ {
	+ 	ssize_t ret, done =3D 0;
	+=20
	+ retry:
	+ 	ret =3D read(fd, buf + done, count - done);
	+ 	if (ret < 0)
	+ 		return ret;
	+=20
	+ 	done +=3D ret;
	+=20
	+ 	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
	+ 		return done;
	+ 	else
	+ 		goto retry;
	+ }
	+=20
	++>>>>>>> theirs
	  int main(int argc,char *argv[])
	  {
		int fd, val, ret, size, wrote, len;

easy to resolve to:

	$ git diff
	diff --cc flash_otp_write.c
	index f360a3e,648e042..0000000
	--- a/flash_otp_write.c
	+++ b/flash_otp_write.c
	@@@ -15,8 -15,23 +15,25 @@@
	 =20
	  #include <mtd/mtd-user.h>
	 =20
	 +#include "common.h"
	 +
	+ ssize_t xread(int fd, void *buf, size_t count)
	+ {
	+ 	ssize_t ret, done =3D 0;
	+=20
	+ retry:
	+ 	ret =3D read(fd, buf + done, count - done);
	+ 	if (ret < 0)
	+ 		return ret;
	+=20
	+ 	done +=3D ret;
	+=20
	+ 	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
	+ 		return done;
	+ 	else
	+ 		goto retry;
	+ }
	+=20
	  int main(int argc,char *argv[])
	  {
		int fd, val, ret, size, wrote, len;

Now if I shuffle patches and put the new patch before the conflicting
patch, I have to resolve first:

	$ git diff
	diff --cc flash_otp_write.c
	index d407ebb,31b963e..0000000
	--- a/flash_otp_write.c
	+++ b/flash_otp_write.c
	@@@ -15,6 -15,25 +15,31 @@@
	 =20
	  #include <mtd/mtd-user.h>
	 =20
	++<<<<<<< ours
	++||||||| base
	++#include "common.h"
	++
	++=3D=3D=3D=3D=3D=3D=3D
	+ #include "common.h"
	+=20
	+ ssize_t xread(int fd, void *buf, size_t count)
	+ {
	+ 	ssize_t ret, done =3D 0;
	+=20
	+ retry:
	+ 	ret =3D read(fd, buf + done, count - done);
	+ 	if (ret < 0)
	+ 		return ret;
	+=20
	+ 	done +=3D ret;
	+=20
	+ 	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
	+ 		return done;
	+ 	else
	+ 		goto retry;
	+ }
	+=20
	++>>>>>>> theirs
	  int main(int argc,char *argv[])
	  {
		int fd, val, ret, size, wrote, len;

which is resolved to just adding the function and dropping the #include=
=2E
But then readding the 2nd patch it conflicts again:

	$ git diff
	diff --cc flash_otp_write.c
	index 648e042,f360a3e..0000000
	--- a/flash_otp_write.c
	+++ b/flash_otp_write.c
	@@@ -15,23 -15,8 +15,29 @@@
	 =20
	  #include <mtd/mtd-user.h>
	 =20
	++<<<<<<< ours
	 +ssize_t xread(int fd, void *buf, size_t count)
	 +{
	 +	ssize_t ret, done =3D 0;
	 +
	 +retry:
	 +	ret =3D read(fd, buf + done, count - done);
	 +	if (ret < 0)
	 +		return ret;
	 +
	 +	done +=3D ret;
	 +
	 +	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
	 +		return done;
	 +	else
	 +		goto retry;
	 +}
	 +
	++||||||| base
	++=3D=3D=3D=3D=3D=3D=3D
	+ #include "common.h"
	+=20
	++>>>>>>> theirs
	  int main(int argc,char *argv[])
	  {
		int fd, val, ret, size, wrote, len;

This is the same conflict as the first one, just with ours and theirs
exchanged. So my suggestion is to make rerere use the resolution
recorded for the first conflict here.

Sounds sensible?

Best regards
Uwe

PS: I'm using Debian's git 1.8.2~rc2-1 and hope I didn't miss this
feature already implemented while looking through v1.8.2..junio/next.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
