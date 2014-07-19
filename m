From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Sat, 19 Jul 2014 14:11:30 +0200
Message-ID: <53CA6072.8000009@web.de>
References: <53C944B3.5080106@web.de> <20140718184246.GS12427@google.com> <53C971FD.6040500@web.de> <20140718235706.GA11192@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 14:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8TV8-0007st-4k
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 14:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbaGSMMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2014 08:12:20 -0400
Received: from mout.web.de ([212.227.15.3]:58757 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512AbaGSMMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 08:12:19 -0400
Received: from [192.168.178.27] ([79.253.155.202]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MOikY-1XDRq838bO-0069dj; Sat, 19 Jul 2014 14:11:46
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140718235706.GA11192@peff.net>
X-Provags-ID: V03:K0:dqKE47nXpqkrbF+nI4HdgZap87i9K3/w7lyNeKF5vrq1Fvt2yke
 sGeL6ugWeigD751N0CSJdy+e3+TWOpbqHsrp5vlWZr0cwC388NlHLSNZ4+7lB+YTkp0yuOD
 ICnCXD74DBUzVNT/uTO89n3xObYlyc0b20uo7vT6VS/6CCWYs13M+wirPYwiv7QllGtPpIg
 0UoMFFpoHoN4Hgu21nRVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253876>

Am 19.07.2014 01:57, schrieb Jeff King:
> On Fri, Jul 18, 2014 at 09:14:05PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> If inlining is really better is another matter; I don't understand h=
ow
>> 1a812f3a (hashcmp(): inline memcmp() by hand to optimize) could have=
 made
>> git gc 18% faster, as it claimed.  I would expect memcmp(), which ca=
n
>> compare more than a byte at a time, to be significantly faster -- or=
 at
>> least just as fast as whatever the compiler does with the inlined ve=
rsion.
>=20
> I looked into this a while ago[1]. I think with glibc 2.13 and up, th=
e
> memcmp is a win. We should consider switching back if that is what is
> common now.
>=20
> -Peff
>=20
> [1] http://article.gmane.org/gmane.comp.version-control.git/218396

On Linux this seems to improve rev-list performance by ca. 10% for me, =
but
on on FreeBSD it slows it down by ca. 25%.  That's less surprising afte=
r
looking at their memcmp() implementation:

http://svnweb.freebsd.org/base/release/10.0.0/lib/libc/string/memcmp.c?=
revision=3D260789&view=3Dco

It's basically our one-byte-at-a-time inlined version, sans inlining.

I'd say if a platform doesn't bother optimizing memcmp() then they
deserve the resulting performance.  And it's probably not too bad a
penalty because such comparisons probably won't make up a significant
part of most applications.

But perhaps we can do better.  First, here are the numbers I got for
"/usr/bin/time git rev-list --all --objects v2.0.0 >/dev/null" (best
of five runs):

Debian testing amd64 with gcc 4.9.0 and libc 2.19 on Hyper-V on Intel i=
5-4670:

  master (398dd4bd)
  2.14user 0.02system 0:02.16elapsed 99%CPU (0avgtext+0avgdata 71004max=
resident)k
  0inputs+0outputs (0major+21985minor)pagefaults 0swaps

  using memcmp
  1.92user 0.02system 0:01.95elapsed 99%CPU (0avgtext+0avgdata 71032max=
resident)k
  0inputs+0outputs (0major+21987minor)pagefaults 0swaps

  four bytes at a time
  1.93user 0.03system 0:01.97elapsed 99%CPU (0avgtext+0avgdata 71240max=
resident)k
  0inputs+0outputs (0major+22024minor)pagefaults 0swaps

Debian testing amd64 with clang 3.3 and libc 2.19 on Hyper-V on Intel i=
5-4670:

  master (398dd4bd)
  2.12user 0.04system 0:02.17elapsed 99%CPU (0avgtext+0avgdata 70976max=
resident)k
  0inputs+0outputs (0major+21995minor)pagefaults 0swaps

  memcmp
  1.94user 0.01system 0:01.95elapsed 100%CPU (0avgtext+0avgdata 71012ma=
xresident)k
  0inputs+0outputs (0major+21952minor)pagefaults 0swaps

  four bytes at a time
  1.86user 0.01system 0:01.88elapsed 99%CPU (0avgtext+0avgdata 70788max=
resident)k
  0inputs+0outputs (0major+21909minor)pagefaults 0swaps

=46reeBSD 10 amd64 with clang 3.3 on Hyper-V on Intel i5-4670c:

  master (398dd4bd)
        1.83 real         1.80 user         0.03 sys

  using memcmp
        2.32 real         2.32 user         0.00 sys

  four bytes at a time
        1.56 real         1.53 user         0.03 sys

Performance measurements in virtual machines are not very accurate, so
take them with a bag of salt, but the numbers were relatively stable
accross runs.

How come rev-list runs so much faster on FreeBSD?  Would it make sense
to apply the four-bytes-at-a-time patch?  How would it on other
platforms, especially ARM?  Can we do even better?  And more
importantly: Does it matter in the first place?

The memcmp version just replaces the body of hashcmp() with
"return memcmp(sha1, sha2, 20);".  Here's the four-bytes-at-a-time
patch:
---
 cache.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 92fc9f1..c6cd28e 100644
--- a/cache.h
+++ b/cache.h
@@ -732,13 +732,18 @@ extern const unsigned char null_sha1[20];
=20
 static inline int hashcmp(const unsigned char *sha1, const unsigned ch=
ar *sha2)
 {
+	const uint32_t *p1 =3D (const uint32_t *)sha1;
+	const uint32_t *p2 =3D (const uint32_t *)sha2;
 	int i;
=20
-	for (i =3D 0; i < 20; i++, sha1++, sha2++) {
-		if (*sha1 !=3D *sha2)
-			return *sha1 - *sha2;
+	for (i =3D 0; i < 20 / sizeof(uint32_t); i++, p1++, p2++) {
+		uint32_t v1 =3D htonl(*p1);
+		uint32_t v2 =3D htonl(*p2);
+		if (v1 < v2)
+			return -1;
+		if (v1 > v2)
+			return 1;
 	}
-
 	return 0;
 }
=20
--=20
2.0.2
