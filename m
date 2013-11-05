From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: htonll, ntohll
Date: Tue, 05 Nov 2013 00:00:24 +0000
Message-ID: <52783518.1030908@ramsay1.demon.co.uk>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de> <527158AF.3070204@ramsay1.demon.co.uk> <52716C58.3090507@web.de> <5271750D.5010801@ramsay1.demon.co.uk> <52725A05.1050805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 05 01:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdU4c-0005ox-MW
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 01:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab3KEAAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Nov 2013 19:00:33 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:40435 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751451Ab3KEAAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 19:00:33 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id AF0B6AC4071;
	Tue,  5 Nov 2013 00:00:30 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id B16D9AC4079;
	Tue,  5 Nov 2013 00:00:28 +0000 (GMT)
Received: from [192.168.254.3] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Tue,  5 Nov 2013 00:00:26 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52725A05.1050805@web.de>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237314>

On 31/10/13 13:24, Torsten B=C3=B6gershausen wrote:
> On 2013-10-30 22.07, Ramsay Jones wrote:
[ ... ]
>> Yep, this was the first thing I did as well! ;-) (*late* last night)
>>
>> I haven't had time today to look into fixing up the msvc build
>> (or a complete re-write), so I look forward to seeing your solution.
>> (do you have msvc available? - or do you want me to look at fixing
>> it? maybe in a day or two?)
>>
> Ramsay,
> I don't have msvc, so feel free to go ahead, as much as you can.
>=20
> I'll send a patch for the test code I have made, and put bswap.h on h=
old for a week
> (to be able to continue with t5601/connect.c)

Unfortunately, I haven't had much time to look into this.

I do have a patch (given below) that works on Linux, cygwin,
MinGW and msvc. However, the msvc build is still broken (as a
result of _other_ commits in this 'jk/pack-bitmap' branch; as
well as the use of a VLA in another commit).

So, I still have work to do! :(

Anyway, I thought I would send what I have, so you can take a look.
Note, that I don't have an big-endian machine to test this on, so
YMMV. Indeed, the *only* testing I have done is to run the test added
by this branch (t5310-pack-bitmaps.sh), which works on Linux, cygwin
and MinGW.

[Note: I have never particularly liked htons, htonl et.al., so adding
these htonll/ntohll functions doesn't thrill me! :-D For example see
this post[1], which echo's my sentiments exactly.]

HTH

ATB,
Ramsay Jones

[1] http://commandcenter.blogspot.co.uk/2012/04/byte-order-fallacy.html

-- >8 --
Subject: [PATCH] compat/bswap.h: Fix build on cygwin, MinGW and msvc

---
 compat/bswap.h | 97 ++++++++++++++++++++++++++++++++++++++++----------=
--------
 1 file changed, 68 insertions(+), 29 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index ea1a9ed..c18a78e 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -17,7 +17,20 @@ static inline uint32_t default_swab32(uint32_t val)
 		((val & 0x000000ff) << 24));
 }
=20
+static inline uint64_t default_bswap64(uint64_t val)
+{
+	return (((val & (uint64_t)0x00000000000000ffULL) << 56) |
+		((val & (uint64_t)0x000000000000ff00ULL) << 40) |
+		((val & (uint64_t)0x0000000000ff0000ULL) << 24) |
+		((val & (uint64_t)0x00000000ff000000ULL) <<  8) |
+		((val & (uint64_t)0x000000ff00000000ULL) >>  8) |
+		((val & (uint64_t)0x0000ff0000000000ULL) >> 24) |
+		((val & (uint64_t)0x00ff000000000000ULL) >> 40) |
+		((val & (uint64_t)0xff00000000000000ULL) >> 56));
+}
+
 #undef bswap32
+#undef bswap64
=20
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
=20
@@ -32,54 +45,80 @@ static inline uint32_t git_bswap32(uint32_t x)
 	return result;
 }
=20
+#define bswap64 git_bswap64
+#if defined(__x86_64__)
+static inline uint64_t git_bswap64(uint64_t x)
+{
+	uint64_t result;
+	if (__builtin_constant_p(x))
+		result =3D default_bswap64(x);
+	else
+		__asm__("bswap %q0" : "=3Dr" (result) : "0" (x));
+	return result;
+}
+#else
+static inline uint64_t git_bswap64(uint64_t x)
+{
+	union { uint64_t i64; uint32_t i32[2]; } tmp, result;
+	if (__builtin_constant_p(x))
+		result.i64 =3D default_bswap64(x);
+	else {
+		tmp.i64 =3D x;
+		result.i32[0] =3D git_bswap32(tmp.i32[1]);
+		result.i32[1] =3D git_bswap32(tmp.i32[0]);
+	}
+	return result.i64;
+}
+#endif
+
 #elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
=20
 #include <stdlib.h>
=20
 #define bswap32(x) _byteswap_ulong(x)
+#define bswap64(x) _byteswap_uint64(x)
=20
 #endif
=20
-#ifdef bswap32
+#if defined(bswap32)
=20
 #undef ntohl
 #undef htonl
 #define ntohl(x) bswap32(x)
 #define htonl(x) bswap32(x)
=20
-#ifndef __BYTE_ORDER
-#	if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDI=
AN)
-#		define __BYTE_ORDER BYTE_ORDER
-#		define __LITTLE_ENDIAN LITTLE_ENDIAN
-#		define __BIG_ENDIAN BIG_ENDIAN
-#	else
-#		error "Cannot determine endianness"
-#	endif
+#endif
+
+#if defined(bswap64)
+
+#undef ntohll
+#undef htonll
+#define ntohll(x) bswap64(x)
+#define htonll(x) bswap64(x)
+
+#else
+
+#undef ntohll
+#undef htonll
+
+#if !defined(__BYTE_ORDER)
+# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDI=
AN)
+#  define __BYTE_ORDER BYTE_ORDER
+#  define __LITTLE_ENDIAN LITTLE_ENDIAN
+#  define __BIG_ENDIAN BIG_ENDIAN
+# endif
+#endif
+
+#if !defined(__BYTE_ORDER)
+# error "Cannot determine endianness"
 #endif
=20
 #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
 # define ntohll(n) (n)
 # define htonll(n) (n)
-#elif __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
-#	if defined(__GNUC__) && defined(__GLIBC__)
-#		include <byteswap.h>
-#	else /* GNUC & GLIBC */
-static inline uint64_t bswap_64(uint64_t val)
-{
-	return ((val & (uint64_t)0x00000000000000ffULL) << 56)
-		| ((val & (uint64_t)0x000000000000ff00ULL) << 40)
-		| ((val & (uint64_t)0x0000000000ff0000ULL) << 24)
-		| ((val & (uint64_t)0x00000000ff000000ULL) <<  8)
-		| ((val & (uint64_t)0x000000ff00000000ULL) >>  8)
-		| ((val & (uint64_t)0x0000ff0000000000ULL) >> 24)
-		| ((val & (uint64_t)0x00ff000000000000ULL) >> 40)
-		| ((val & (uint64_t)0xff00000000000000ULL) >> 56);
-}
-#	endif /* GNUC & GLIBC */
-#	define ntohll(n) bswap_64(n)
-#	define htonll(n) bswap_64(n)
-#else /* __BYTE_ORDER */
-#	error "Can't define htonll or ntohll!"
+#else
+# define ntohll(n) default_bswap64(n)
+# define htonll(n) default_bswap64(n)
 #endif
=20
 #endif
--=20
1.8.4
