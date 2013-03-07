From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: feature suggestion: improve rerere
Date: Thu, 07 Mar 2013 08:05:07 +0100
Message-ID: <51383C23.2090900@viscovery.net>
References: <20130306101640.GA15375@pengutronix.de> <51374382.6050101@viscovery.net> <20130306144225.GB15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 07 08:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDUtn-0005zH-I2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 08:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab3CGHFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 02:05:15 -0500
Received: from so.liwest.at ([212.33.55.24]:2829 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3CGHFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 02:05:11 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UDUt1-0004Cg-NZ; Thu, 07 Mar 2013 08:05:08 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4484D1660F;
	Thu,  7 Mar 2013 08:05:07 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130306144225.GB15375@pengutronix.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217575>

Am 3/6/2013 15:42, schrieb Uwe Kleine-K=F6nig:
> On Wed, Mar 06, 2013 at 02:24:18PM +0100, Johannes Sixt wrote:
>> Am 3/6/2013 11:16, schrieb Uwe Kleine-K=F6nig:
>>> 	++<<<<<<< ours
>>> 	 +ssize_t xread(int fd, void *buf, size_t count)
>>> 	 +{
>>> 	 +	ssize_t ret, done =3D 0;
>>> 	 +
>>> 	 +retry:
>>> 	 +	ret =3D read(fd, buf + done, count - done);
>>> 	 +	if (ret < 0)
>>> 	 +		return ret;
>>> 	 +
>>> 	 +	done +=3D ret;
>>> 	 +
>>> 	 +	if (ret =3D=3D 0 /* EOF */ || done =3D=3D count)
>>> 	 +		return done;
>>> 	 +	else
>>> 	 +		goto retry;
>>> 	 +}
>>> 	 +
>>> 	++||||||| base
>>> 	++=3D=3D=3D=3D=3D=3D=3D
>>> 	+ #include "common.h"
>>> 	+=20
>>> 	++>>>>>>> theirs
>>> 	  int main(int argc,char *argv[])
>>> 	  {
>>> 		int fd, val, ret, size, wrote, len;
>>>
>>> This is the same conflict as the first one, just with ours and thei=
rs
>>> exchanged. So my suggestion is to make rerere use the resolution
>>> recorded for the first conflict here.
>>>
>>> Sounds sensible?
>>
>> Of course, and rerere already does it. But only when you use git's d=
efault
>> conflict markers rather than diff3 style markers that have this extr=
a
>> ||||| line.
> I only did git checkout --conflict=3Ddiff3 after the merge conflict
> happend. So I cannot confirm that git already does it.
>=20
> So here is a reproduction receipe:
>=20
> 	git clone git://git.infradead.org/mtd-utils.git
> 	cd mtd-utils
> 	git checkout ca39eb1
> 	wget -O patch1 http://article.gmane.org/gmane.linux.drivers.mtd/4577=
9/raw
> 	wget -O patch2 http://article.gmane.org/gmane.linux.drivers.mtd/4559=
1/raw

At least patch2 has incorret index information; it does not apply with =
am
-3. I generated a working version with format-patch after applying it
directly on top of ca39eb1.

> 	for p in patch1 patch2; do perl -p -i -e 'print "From tralala Mon Se=
p 17 00:00:00 2001\n" if $. =3D=3D 1' $p; done

Do you have rerere enabled at this point?

	git config rerere.enabled true

> 	git am patch1
> 	git am -3 patch2 # first merge conflict
> 	perl -n -i -e 's/=3D=3D=3D=3D=3D=3D=3D//; print unless /^[<>]{7} /;'=
 flash_otp_write.c # resolve
> 	git add flash_otp_write.c
> 	git am --resolved
> 	git rebase -i ca39eb1 # swap order of the two patches
>=20
> results in
>=20
> 	$ git ls-files -u
> 	100644 f360a3e025deaf7acfb7b20c9fad90f498ae4430 1	flash_otp_write.c
> 	100644 d407ebbf400e630dc00ee004ecb44be8af51b25d 2	flash_otp_write.c
> 	100644 31b963e2d6cf0016ca542529886e1ee71a22664e 3	flash_otp_write.c

Same here.

>=20
> and resolving yields:
>=20
> 	$ git ls-files -s flash_otp_write.c
> 	100644 648e0422d21c0ffa7621f82b86c02a065e488293 0	flash_otp_write.c

OK.

>=20
> Then
> 	git rebase --continue=20
>=20
> gives the 2nd rebase conflict:
>=20
> 	$ git ls-files -u
> 	100644 d407ebbf400e630dc00ee004ecb44be8af51b25d 1	flash_otp_write.c
> 	100644 648e0422d21c0ffa7621f82b86c02a065e488293 2	flash_otp_write.c
> 	100644 f360a3e025deaf7acfb7b20c9fad90f498ae4430 3	flash_otp_write.c

Same here.

>=20
> Now knowing from the previous resolution that with base=3Df360a3e0
> (=3D origin + patch1) merging
>=20
> 	d407ebbf (=3D origin) and
> 	31b963e2 (=3D origin + patch1 + patch2)
>=20
> gives 648e0422 (origin + patch2),
> git could know that with base=3Dd407ebbf (origin) merging 648e0422 (o=
rigin
> + patch1) and f360a3e0 (origin + patch1) gives 31b963e2 (origin + pat=
ch1
> + patch2) again.

=46or me, it works as expected, i.e., I get the conflict resolved by re=
rere.

>=20
> And git doesn't prepare 31b963e2 in flash_otp_write.c for me.
>=20
> @Johannes, do you have some non-standard setting, or can you reproduc=
e?

Perhaps:

$ git config --global -l | grep rerere
rerere.enabled=3Dtrue

-- Hannes
