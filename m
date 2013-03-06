From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: feature suggestion: improve rerere
Date: Wed, 6 Mar 2013 15:42:25 +0100
Message-ID: <20130306144225.GB15375@pengutronix.de>
References: <20130306101640.GA15375@pengutronix.de>
 <51374382.6050101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 15:42:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDFYZ-0000Pk-5C
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 15:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758442Ab3CFOme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 09:42:34 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43640 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273Ab3CFOmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 09:42:32 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDFY2-000052-9f; Wed, 06 Mar 2013 15:42:26 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDFY1-0003tS-F1; Wed, 06 Mar 2013 15:42:25 +0100
Content-Disposition: inline
In-Reply-To: <51374382.6050101@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217528>

On Wed, Mar 06, 2013 at 02:24:18PM +0100, Johannes Sixt wrote:
> Am 3/6/2013 11:16, schrieb Uwe Kleine-K=F6nig:
> > 	++<<<<<<< ours
> > 	 +ssize_t xread(int fd, void *buf, size_t count)
> > 	 +{
> > 	 +	ssize_t ret, done =3D 0;
> > 	 +
> > 	 +retry:
> > 	 +	ret =3D read(fd, buf + done, count - done);
> > 	 +	if (ret < 0)
> > 	 +		return ret;
> > 	 +
> > 	 +	done +=3D ret;
> > 	 +
> > 	 +	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
> > 	 +		return done;
> > 	 +	else
> > 	 +		goto retry;
> > 	 +}
> > 	 +
> > 	++||||||| base
> > 	++=3D=3D=3D=3D=3D=3D=3D
> > 	+ #include "common.h"
> > 	+=20
> > 	++>>>>>>> theirs
> > 	  int main(int argc,char *argv[])
> > 	  {
> > 		int fd, val, ret, size, wrote, len;
> >=20
> > This is the same conflict as the first one, just with ours and thei=
rs
> > exchanged. So my suggestion is to make rerere use the resolution
> > recorded for the first conflict here.
> >=20
> > Sounds sensible?
>=20
> Of course, and rerere already does it. But only when you use git's de=
fault
> conflict markers rather than diff3 style markers that have this extra
> ||||| line.
I only did git checkout --conflict=3Ddiff3 after the merge conflict
happend. So I cannot confirm that git already does it.

So here is a reproduction receipe:

	git clone git://git.infradead.org/mtd-utils.git
	cd mtd-utils
	git checkout ca39eb1
	wget -O patch1 http://article.gmane.org/gmane.linux.drivers.mtd/45779/=
raw
	wget -O patch2 http://article.gmane.org/gmane.linux.drivers.mtd/45591/=
raw
	for p in patch1 patch2; do perl -p -i -e 'print "From tralala Mon Sep =
17 00:00:00 2001\n" if $. =3D=3D 1' $p; done
	git am patch1
	git am -3 patch2 # first merge conflict
	perl -n -i -e 's/=3D=3D=3D=3D=3D=3D=3D//; print unless /^[<>]{7} /;' f=
lash_otp_write.c # resolve
	git add flash_otp_write.c
	git am --resolved
	git rebase -i ca39eb1 # swap order of the two patches

results in

	$ git ls-files -u
	100644 f360a3e025deaf7acfb7b20c9fad90f498ae4430 1	flash_otp_write.c
	100644 d407ebbf400e630dc00ee004ecb44be8af51b25d 2	flash_otp_write.c
	100644 31b963e2d6cf0016ca542529886e1ee71a22664e 3	flash_otp_write.c

and resolving yields:

	$ git ls-files -s flash_otp_write.c
	100644 648e0422d21c0ffa7621f82b86c02a065e488293 0	flash_otp_write.c

Then
	git rebase --continue=20

gives the 2nd rebase conflict:

	$ git ls-files -u
	100644 d407ebbf400e630dc00ee004ecb44be8af51b25d 1	flash_otp_write.c
	100644 648e0422d21c0ffa7621f82b86c02a065e488293 2	flash_otp_write.c
	100644 f360a3e025deaf7acfb7b20c9fad90f498ae4430 3	flash_otp_write.c

Now knowing from the previous resolution that with base=3Df360a3e0
(=3D origin + patch1) merging

	d407ebbf (=3D origin) and
	31b963e2 (=3D origin + patch1 + patch2)

gives 648e0422 (origin + patch2),
git could know that with base=3Dd407ebbf (origin) merging 648e0422 (ori=
gin
+ patch1) and f360a3e0 (origin + patch1) gives 31b963e2 (origin + patch=
1
+ patch2) again.

And git doesn't prepare 31b963e2 in flash_otp_write.c for me.

@Johannes, do you have some non-standard setting, or can you reproduce?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
