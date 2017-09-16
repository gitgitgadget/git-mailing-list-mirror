Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4749920281
	for <e@80x24.org>; Sat, 16 Sep 2017 04:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdIPE6x (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 00:58:53 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:58726 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdIPE6w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 00:58:52 -0400
Received: (qmail 10662 invoked from network); 16 Sep 2017 04:58:49 -0000
Received: from 107-131-85-42.lightspeed.tulsok.sbcglobal.net (HELO ?192.168.1.157?) (awilcox@wilcox-tech.com@107.131.85.42)
  by mail.wilcox-tech.com with ESMTPA; 16 Sep 2017 04:58:49 -0000
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
To:     Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
 <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, musl@lists.openwall.com
From:   "A. Wilcox" <awilfox@adelielinux.org>
X-Enigmail-Draft-Status: N1110
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <59BCAF81.3090206@adelielinux.org>
Date:   Fri, 15 Sep 2017 23:58:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="caRkvQO5DSEtOCt1nQOjtkfg8KuvqUdmo"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--caRkvQO5DSEtOCt1nQOjtkfg8KuvqUdmo
Content-Type: multipart/mixed;
 boundary="------------060303030405000208030508"

This is a multi-part message in MIME format.
--------------060303030405000208030508
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/09/17 06:30, Jeff King wrote:
> On Fri, Sep 15, 2017 at 08:37:40AM +0200, Kevin Daudt wrote:
>=20
>> On Thu, Sep 14, 2017 at 09:43:12PM -0500, A. Wilcox wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> Hi there,
>>>
>>> While bumping Git's version for our Linux distribution to 2.14.1, I'v=
e
>>> run in to a new test failure in t6500-gc.sh.  This is the output of
>>> the failing test with debug=3Dt verbose=3Dt:
>>
>> This is a new test introduced by c45af94db=20
>> (gc: run pre-detach operations under lock, 2017-07-11) which was
>> included in v2.14.0.
>>
>> So it might be that this was already a problem for a longer time, only=

>> just recently uncovered.
>=20
> The code change there is not all that big. Mostly we're just checking
> that the lock is actually respected. The lock code doesn't exercise lib=
c
> all that much. It does use fscanf, which I guess is a little exotic for=

> us. It's also possible that hostname() doesn't behave quite as we
> expect.
>=20
> If you instrument gc like the patch below, what does it report when you=

> run:
>=20
>   GIT_TRACE=3D1 ./t6500-gc.sh --verbose-only=3D8
>=20
> I get:
>=20
>   [...]
>   trace: built-in: git 'gc' '--auto'
>   Auto packing the repository in background for optimum performance.
>   See "git help gc" for manual housekeeping.
>   debug: gc lock already held by $my_hostname
>   [...]
>=20
> If you get "acquired gc lock", then the problem is in
> lock_repo_for_gc(), and I'd suspect some problem with fscanf or
> hostname.
>=20
> -Peff


Hey there Peff,

What a corner-y corner case we have here.  I believe the actual error is
in the POSIX standard itself[1], as it is not clear what happens when
there are not enough characters to 'fill' the width specified with %c in
fscanf:

> c
>    Matches a sequence of bytes of the number specified by the field
> width (1 if no field width is present in the conversion
> specification).

I've tested a number of machines:

* OpenBSD 5.7/amd64
* NetBSD 7.0/i386
* FreeBSD 12/PowerPC
* glibc/arm
* Windows 7 with Microsoft Visual C++ 2013

All of them will allow a so-called "short read" and give you as many
characters as they can, treating the phrase "a sequence of bytes of the
number specified" as meaning "*up to* the number".

The musl libc treats this phrase as meaning "*exactly* the number", and
fails if it cannot give you exactly the number you ask.

IBM z/OS explicitly states in their documentation[2]:

> Sequence of one or more characters as specified by field width

And Microsoft similarly states[3]:

> The width field is a positive decimal integer controlling the maximum
> number of characters to be read for that field. No more than width
> characters are converted and stored at the corresponding argument.
> Fewer than width characters may be read if a whitespace character
> (space, tab, or newline) or a character that cannot be converted
> according to the given format occurs before width is reached.

While musl's reading is correct from an English grammar point of view,
it does not seem to be how any other implementation has read the standard=
=2E


However!  It gets better.

The ISO C standard, committee draft version April 12, 2011, states[4]:

> c    Matches a sequence of characters of exactly the number specified
> by the field width (1 if no field width is present in the directive).


Since "[t]his volume of POSIX.1-2008 defers to the ISO C standard", it
stands to reason that this is the intended meaning and behaviour.  Thus
meaning that literally every implementation, with the exception of the
musl libc, is breaking the ISO C standard.


Since Git is specifically attempting to read in a host name, there may
be a solution: while 'c' guarantees that any byte will be read, and 's'
will skip whitespace, RFCs 952 and 1123 =C2=A72.1[5] specify that a netwo=
rk
host name must never contain whitespace.  IDNA2008 =C2=A72.3.2.1[6] (and
IDNA2003 before it) specifically removes ASCII whitespace characters
from the valid set of Unicode codepoints for an IDNA host name[7].
Additionally, the buffer `locking_host` is already defined as an array
of char of size HOST_NAME_MAX + 1, and the width specifier in fscanf is
specified as HOST_NAME_MAX.  Therefore, it should be safe to change git
to use the 's' type character.  Additionally, I can confirm that this
change (patch attached) allows the Git test suite to pass on musl.


I hope this message is informative.  This was an exhausting, but
necessary, exercise in trying to ensure code correctness.

I am cc'ing the musl list so that this information may live there as
well, in case someone in the future has issues with the 'c' type
specifier with fscanf on musl.


All the best,
--arw


[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/fscanf.htm=
l
[2]:
https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1=
=2Ebpxbd00/fscanf.htm
[3]: https://msdn.microsoft.com/en-us/library/xdb9w69d.aspx
[4]: http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf
[5]: https://tools.ietf.org/html/rfc1123#section-2.1
[6]: https://tools.ietf.org/html/rfc5890#section-2.3.2.1
[7]: http://unicode.org/faq/idn.html#33
--=20
A. Wilcox (awilfox)
Project Lead, Ad=C3=A9lie Linux
http://adelielinux.org

--------------060303030405000208030508
Content-Type: text/x-patch;
 name="0001-gc-use-s-type-character-for-fscanf.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-gc-use-s-type-character-for-fscanf.patch"

=46rom afceb0f7755a87d0dd2194e95f26c9dc8f4bc688 Mon Sep 17 00:00:00 2001
From: "A. Wilcox" <AWilcox@Wilcox-Tech.com>
Date: Fri, 15 Sep 2017 23:55:57 -0500
Subject: [PATCH] gc: use 's' type character for fscanf

The ISO C standard states that using a field width together with the 'c'
type character will read the exact amount specified; if that amount of
bytes is not available, a match error occurs.

This patch allows the t6500 test to pass on the musl libc, and `git gc`
to behave correctly on syystems utilising musl.

Signed-off-by: A. Wilcox <AWilcox@Wilcox-Tech.com>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c78fcb..bb2d6c1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -258,7 +258,7 @@ static const char *lock_repo_for_gc(int force, pid_t*=
 ret_pid)
 		int should_exit;
=20
 		if (!scan_fmt)
-			scan_fmt =3D xstrfmt("%s %%%dc", "%"SCNuMAX, HOST_NAME_MAX);
+			scan_fmt =3D xstrfmt("%s %%%ds", "%"SCNuMAX, HOST_NAME_MAX);
 		fp =3D fopen(pidfile_path, "r");
 		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =3D
--=20
2.10.0


--------------060303030405000208030508--

--caRkvQO5DSEtOCt1nQOjtkfg8KuvqUdmo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZvK+GAAoJEMspy1GSK50U9K8P/1L/PMIUpV5QD/4G4P+MCKX9
iGCqDt476fxYPiBaRvbUb91jvRCwcfphcWD4CyZkf4kdlgP/ZmCidziMJHngSQKU
QSgQcl8PcU16O21gguXIxaZ1zkb26hKMqR0hEvN/y3SWHsGsuwa7XQmnSGRuCLCw
I+JUFWs0ARso2esC4E0CGLnvqFCC69Q3yEabFmbgNKAQwHky1THyPa4G2x8fywop
jHjcC/maKaV/1buA4lzGq3z1aCObqFQFR/Clj+gN3JH3EjB2C840uBNZ5CPiRhUC
OvSId/xweBAKVoyBf4ZImoJQ4fNSoMXgJG6PrA7Bbr6Nges/WpeKv3JyARPG86fU
p/BhKvMg/h30FAxXYBT+rRj3D5R99hMX1P7kUOMV8ny0MCWApA1jMQ2H8/jtuP6a
oEYi8Xi9kmoX8ZmPLHibOmJISf6nx7jUrtTADOEcFoICENY9uSxk3X2QWD2icw58
plepHuxD7jxtwz1e7JtawOUJMX6i1+FGkHokvrRfglY1gFgBxnQeV912eciRk5hJ
ziIXsOzlwrnRxcFynZoVWonfFJHrGlgGmnRL56EQwIxrGQRQdkt/j8a3Z9lHvYQd
L8qDHGwPYOCelNhwLxcLWCuTlaHY8Pq2z00olIJo09UjZQ05MvLdOAT1+kOS3HKG
ji2fc57+E3+h75waltei
=j1f5
-----END PGP SIGNATURE-----

--caRkvQO5DSEtOCt1nQOjtkfg8KuvqUdmo--
