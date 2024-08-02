Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B81ABEB6
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722636486; cv=none; b=K+A8L2gWcVgKab5b8yIaj2k4/2HwhVYle20AUue6hLBRv7RmYi7YYOPNJxhSYUwUJLb08+tch95GUOnRqujzMYkDHQcZLL+U0SaRRPMLsL9rUO3Ao83jb0KW+/aP7SAX6WxljWexAuIzeNKZm4UL2I3hmBkafC+KwvTPtG6mxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722636486; c=relaxed/simple;
	bh=35+dGvXFjXg9MXA7OLvvmBihI3CMfQEnkz6UeVCJ0TY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IM+9fisaXiaR4PgpCG3ZpyA9/QI1Ozal9JWkkwD3Lcia+07gwF8Ty55HmmE2Gn0hoze7FnwvHLqurWy6/2fj7ZTpIIuQ462socJtY0gKu3v8T3zTRr6wBQn0sHdtOsi8AmnlXaORqiZDrYacjk+xjYpAdCbI39pgdLUYFrrIFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 472M80qR3730823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 22:08:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: <git@vger.kernel.org>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com> <ZqvgmYl8BTYvsSa0@nand.local> <032201dae461$c7bcc9d0$57365d70$@nexbridge.com> <ZqwvQUAqVozGHG/t@nand.local>
In-Reply-To: <ZqwvQUAqVozGHG/t@nand.local>
Subject: RE: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Fri, 2 Aug 2024 18:07:55 -0400
Organization: Nexbridge Inc.
Message-ID: <040801dae528$70966d10$51c34730$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIp93LlMAXo5OzQ9HEGtsfRK+e3MwGmTwJBAbmv8+0Ce5iwkLFHexWw

On Thursday, August 1, 2024 8:59 PM, Taylor Blau wrote:
>On Thu, Aug 01, 2024 at 06:25:51PM -0400, rsbecker@nexbridge.com wrote:
>> ls output with second resolution is here - the file system does not =
have
>nanosecond resolution despite showing zeros:
>>
>> /home/ituglib/randall/git/t/trash
>> directory.t7704-repack-cruft/max-cruft-size-prune/.git/objects/pack:
>> ls -la --full-time total 11 drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 =
2024-08-
>01 16:18:55.000000000 -0600 .
>> drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 2024-08-01
>16:18:48.000000000 -0600 ..
>> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB 1156 2024-08-01
>> 16:18:52.000000000 -0600
>> pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
>> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB  217 2024-08-01 =
16:18:52.000000000 -
>0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
>> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB   64 2024-08-01 =
16:18:52.000000000 -
>0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev
>
>Ah, I suspect that this is even less interesting than imprecise mtime =
resolution. The
>test expects that the packs are larger than 1M so that we can exercise =
writing
>multiple cruft packs as part of the setup.
>
>But that pack is only 217 bytes, which wouldn't trigger the split. I'm =
suspicious that
>it's even packing the cruft objects at all, so I'm curious if you can =
find $foo, $bar,
>and $baz in the cruft pack's .idx file(s, if multiple) after the first =
'git repack -d --cruft'.
>
>Assuming they are there, it's possible that setting repack.cruftWindow =
in the test
>repository would do the trick.
>
>But I'm suspicious that that's even what's going on since =
generate_random_blob()'s
>first argument is a seed, and all three objects have different seeds, =
so I don't think
>they would even be considered good delta candidates for one another. =
But it's also
>possible that your
>generate_random_blob() behaves differently from my own.

The entire final .idx file is:
0000000 377   t   O   c  \0  \0  \0 002  \0  \0  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0001500  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 002
0001520  \0  \0  \0 002  \0  \0  \0 002  \0  \0  \0 002  \0  \0  \0 002
*
0001600  \0  \0  \0 002  \0  \0  \0 003  \0  \0  \0 003  \0  \0  \0 003
0001620  \0  \0  \0 003  \0  \0  \0 003  \0  \0  \0 003  \0  \0  \0 003
*
0002000  \0  \0  \0 003  \0  \0  \0 003 316   a   1 002   ,   :   H 241
0002020   _   K   z   h 257 266 354 363 263 274 260 315 321 377 034 222
0002040   $ 256   ^   X 247   e   o 271 354 311   X   e 324   . 327 036
0002060 337 226   { 226 245   y 344   Z 030 270   % 027   2 321   h 004
0002100 262 345   j   U 003 302 375 225   d 335   =3D 272 207 227   ) =
265
0002120  \0  \0  \0 212  \0  \0  \0  \f  \0  \0  \0 267   h 306 310 310
0002140   S 211  \0   i   L   2   8  \n 301   H   B 001 310 266  \r 215
0002160 273   y 312 253 265   V 225 350 246 212   h   Z   d   ? 313   f
0002200 372   Z 336   3
0002204

After the first repack, I have the following idx files. No foo/bar/baz =
inside.
The generate_random_blob() does generate the proper amount of bytes.
I tried changing 0xff to 0x00ff at the putchar just in case we had bad
sign extension - that wasn't it.

pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx:
0000000 377   t   O   c  \0  \0  \0 002  \0  \0  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0001500  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 002
0001520  \0  \0  \0 002  \0  \0  \0 002  \0  \0  \0 002  \0  \0  \0 002
*
0001600  \0  \0  \0 002  \0  \0  \0 003  \0  \0  \0 003  \0  \0  \0 003
0001620  \0  \0  \0 003  \0  \0  \0 003  \0  \0  \0 003  \0  \0  \0 003
*
0002000  \0  \0  \0 003  \0  \0  \0 003 316   a   1 002   ,   :   H 241
0002020   _   K   z   h 257 266 354 363 263 274 260 315 321 377 034 222
0002040   $ 256   ^   X 247   e   o 271 354 311   X   e 324   . 327 036
0002060 337 226   { 226 245   y 344   Z 030 270   % 027   2 321   h 004
0002100 262 345   j   U 003 302 375 225   d 335   =3D 272 207 227   ) =
265
0002120  \0  \0  \0 212  \0  \0  \0  \f  \0  \0  \0 267   h 306 310 310
0002140   S 211  \0   i   L   2   8  \n 301   H   B 001 310 266  \r 215
0002160 273   y 312 253 265   V 225 350 246 212   h   Z   d   ? 313   f
0002200 372   Z 336   3
0002204

pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.idx:
0000000 377   t   O   c  \0  \0  \0 002  \0  \0  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0001260  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0 001
0001300  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001
*
0002000  \0  \0  \0 001  \0  \0  \0 001 255 026 276 325   L 306 034 360
0002020   6  \a   X   y 336 357 371   Z 351   w   Q   K   # 236 346 377
0002040  \0  \0  \0  \f 217   S 370   7   Y   ~ 273 337 306 370 355 027
0002060   3   I 345 316 313 317 271   ~   9 033   9 316 363 306   G   -
0002100 207   f 224 323   1 372 021   W 037 335 206 372
0002114

pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.idx:
0000000 377   t   O   c  \0  \0  \0 002  \0  \0  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0000500  \0  \0  \0  \0  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001
0000520  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001
*
0002000  \0  \0  \0 001  \0  \0  \0 001   O   3   o   =3D 363 020   T =
352
0002020 274 005 254 005 371 213 300   $ 310 340   T   #   $ 274   l 342
0002040  \0  \0  \0  \f 270 334 232 255 252 334 022 310   +  \0   S 375
0002060 356  \0   9 256 020   % 250 370 204 242   7 033   =3D   0 375 =
207
0002100 343 352 257 374 265 021   j 214   5 026 355 243
0002114

pack-c2357b2b204fda52bc1f5515de94227e1db012af.idx:
0000000 377   t   O   c  \0  \0  \0 002  \0  \0  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0001360  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0 001
0001400  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001  \0  \0  \0 001
*
0002000  \0  \0  \0 001  \0  \0  \0 001 275   D 330 252   -   " 353   G
0002020 377   p 316 364 260 273   E 321   T 236 344 234 302 311   8   h
0002040  \0  \0  \0  \f 302   5   {   +       O 332   R 274 037   U 025
0002060 336 224   "   ~ 035 260 022 257 373   U   )   - 204   " 315   v
0002100   /   E 272   e   7 342 261 037   6 255   < 306
0002114

--Randall

