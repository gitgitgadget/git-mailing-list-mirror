From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: tr/xdiff-fast-hash generates warnings and breaks tests
Date: Thu, 17 May 2012 20:40:12 +0200
Message-ID: <4FB5460C.10807@lsrfire.ath.cx>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com> <4FB4A4B9.3080009@lsrfire.ath.cx> <xmqqmx56rd2r.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 17 20:40:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV5cd-0002VI-08
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 20:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762310Ab2EQSkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 14:40:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:60838 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760878Ab2EQSkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 14:40:15 -0400
Received: from [192.168.2.105] (p4FFD9588.dip.t-dialin.net [79.253.149.136])
	by india601.server4you.de (Postfix) with ESMTPSA id 840D32F806F;
	Thu, 17 May 2012 20:40:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <xmqqmx56rd2r.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197925>

Am 17.05.2012 18:23, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>> On Ubuntu 12.04 x86, t0020 fails for me as well when I compile with
>> XDL_FAST_HASH explicitly set (it's off by default).
>
> OK.  So does that indicate at least breakage in the Makefile that
> attempts to set XDL_FAST_HASH only on x86_64, mistakenly triggering
> on =C3=98yvind's x86 32-bit userland, or did =C3=98yvind manually fli=
pped the
> feature on?

It's turned on by default if uname -m says x86_64, which it does for=20
=C3=98yvind (64-bit kernel).  His userland is a 32-bit one, though.

> It is a separate issue that XDL_FAST_HASH code does not work on 32-bi=
t
> systems, even though it is advertised that it only needs to be on
> little-endian.

Indeed.

>> It succeeds after reverting 6f1af02, though, strangely enough.
>
> It is strange.  I do not see anything glaringly wrong in the conversi=
on
> in that commit.  The only difference I see is that count_masked_bytes=
 in
> the original used to take unsigned long on 64-bit archs but the updat=
ed
> one takes signed long, but that on 32-bit archs the function takes
> signed long in both versions so it cannot be it.  Stumped...

The assembly differs in two instructions:

	--- master/xdiff/xutils.s
	+++ reverted/xdiff/xutils.s
	@@ -733,7 +733,7 @@
	 	shrl	$7, %ebx
	 	leal	-256(%ebx), %ecx
	 	movl	%ebx, %edi
	-	shrl	$23, %ecx
	+	sarl	$23, %ecx
	 	andl	$1, %edi
	 	leal	1(%ecx,%edi), %ecx
	 	addl	%ecx, %esi
	@@ -934,7 +934,7 @@
	 	jmp	.L123
	 .L153:
	 	movl	$__PRETTY_FUNCTION__.4151, 12(%esp)
	-	movl	$374, 8(%esp)
	+	movl	$380, 8(%esp)
	 	movl	$.LC1, 4(%esp)
	 	movl	$.LC2, (%esp)
	 	call	__assert_fail

The second one is just a line number of an assert() that is moved aroun=
d=20
a bit.  The first one means that master is doing a logical shift right=20
(shr) while with 6f1af02 reverted, an arithmetic shift right (sar) is=20
performed in the same place.

While sar keeps the sign bit of the operand intact, shr shifts it to th=
e=20
right like the other bits.  The code seems to rely on arithmetic shift=20
being done.  It's implementation-defined for signed numbers, but that's=
=20
not that much of a problem, as we turn on the feature only on selected=20
architectures anyway (modulo detection problems, as above ;).

The real issue seems to be that the shifted number is unsigned:

		long a =3D (mask - 256) >> 23;

=46or unsigned values, a logical shift right is done, always. Not sure =
why=20
wrapping it  in "if (sizeof(long) =3D=3D 8)" would make a difference at=
 all,=20
though.

The following patch on top of master makes the compiler put a sarl in m=
y=20
build, and "make -j4 XDL_FAST_HASH=3D1 test" passes.

=C3=98yvind, does this oneliner help in your case as well?

-- >8 --
Subject: xdiff: signed right shift for 32-bit case of XDL_FAST_HASH

In the 32-bit branch of count_masked_bytes(), the compiler uses a
logical right shift on mask, because it is unsigned.  We want it to
be an arithmetic right shift, however (keeping negative numbers
negative instead of shifting the sign bit as well).

There is no way to specify it in C, but we can at least cast mask to
signed long.  This will make the compiler use an arithmetic right shift
on certain implementations, but that's OK because we only turn on
XDL_FAST_HASH in the Makefile for known-good architectures, and at leas=
t=20
gcc 4.6.3 and clang 3.0 do what we want on the most interesting one (x8=
6).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
  xdiff/xutils.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 1b3b471..29df57e 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -311,7 +311,7 @@ static inline long count_masked_bytes(unsigned
  		 * (a+b+1) gives us
  		 *   correct 0-3 bytemask count result
  		 */
-		long a =3D (mask - 256) >> 23;
+		long a =3D ((long)mask - 256) >> 23;
  		long b =3D mask & 1;
  		return a + b + 1;
  	}
--=20
1.7.10.2
