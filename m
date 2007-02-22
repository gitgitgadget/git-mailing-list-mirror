From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 17:46:15 +0100
Message-ID: <45DDC8D7.60902@fs.ei.tum.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerz burg.de> <alpine.LRH.0.82.0702212224510.31945@xanadu.home> <Pine.LNX.4.63.0702221654131.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45DDC158.9090902@fs.ei.tum.de> <Pine.LNX.4.63.0702221735130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCDD4CFAD081FEB811C6C438E"
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 17:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKH6S-0003mZ-KW
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 17:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbXBVQqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXBVQqX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 11:46:23 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:52295 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbXBVQqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 11:46:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 42D0128277;
	Thu, 22 Feb 2007 17:46:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ip4F1W5PNS3G; Thu, 22 Feb 2007 17:46:20 +0100 (CET)
Received: from [62.216.212.169] (ppp-62-216-212-169.dynamic.mnet-online.de [62.216.212.169])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id A8E3728274;
	Thu, 22 Feb 2007 17:46:19 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0702221735130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40360>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDD4CFAD081FEB811C6C438E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 22 Feb 2007, Simon 'corecode' Schubert wrote:
>=20
>> Johannes Schindelin wrote:
>>> Hi,
>>>
>>> On Wed, 21 Feb 2007, Nicolas Pitre wrote:
>>>
>>>> On Thu, 22 Feb 2007, Johannes Schindelin wrote:
>>>>
>>>>> diff --git a/index-pack.c b/index-pack.c
>>>>> index fa9a0e7..5ccf4c4 100644
>>>>> --- a/index-pack.c
>>>>> +++ b/index-pack.c
>>>>> @@ -457,8 +457,8 @@ static void parse_pack_objects(unsigned char *s=
ha1)
>>>>>  	/* If input_fd is a file, we should have reached its end now. */
>>>>>  	if (fstat(input_fd, &st))
>>>>>  		die("cannot fstat packfile: %s", strerror(errno));
>>>>> -	if (S_ISREG(st.st_mode) && st.st_size !=3D consumed_bytes)
>>>>> -		die("pack has junk at the end");
>>>>> +	if (input_fd && S_ISREG(st.st_mode) && st.st_size !=3D consumed_b=
ytes)
>>>>> +		die("pack has junk at the end: 0%o, %d, %d %d", st.st_mode,
>>>>> (int)st.st_size, (int)consumed_bytes, input_fd);
>>>>>   	if (!nr_deltas)
>>>>>  		return;
>>>> What is this supposed to mean?
>>> The funny thing is, if you stream part of the bundle file to index-pa=
ck,
>>> S_ISREG(st.st_mode) is true, even if input_fd =3D=3D 0.
>> Well, of course:  you opened a regular file and pass this as stdin to
>> index-pack.
>>
>> Maybe something like this would be cleaner:
>>
>> if (IS_REF(st.st_mode) && lseek(input_fd, 0, SEEK_CUR) !=3D st.st_size=
)
>> 	die("...");
>=20
> The lseek would fail whenever the input is _not_ a file, dying. Since=20
> index-pack is called from fetch-pack, with a socket instead of a file, =
it=20
> would fail for the most common user.

that's why i put IS_REF (should read IS_REG) there.

but as nicolas pointed out, this won't work for read-ahead.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigCDD4CFAD081FEB811C6C438E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3cjar5S+dk6z85oRAnHrAJ4gErG6r0ZyOT0Y7KbQQhPYI/7FcQCeJGI6
V8HqPs9oZrxc2w8DZP6QvrQ=
=xMtL
-----END PGP SIGNATURE-----

--------------enigCDD4CFAD081FEB811C6C438E--
