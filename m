From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Wed, 30 Oct 2013 19:06:23 +0000
Message-ID: <527158AF.3070204@ramsay1.demon.co.uk>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbb6C-0000F1-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab3J3TG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 15:06:29 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:52895 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754236Ab3J3TG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:06:28 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 24454A64C38;
	Wed, 30 Oct 2013 19:06:26 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id D2562A64BDB;
	Wed, 30 Oct 2013 19:06:25 +0000 (GMT)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Wed, 30 Oct 2013 19:06:25 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <52713E67.3000202@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237056>

On 30/10/13 17:14, Torsten B=C3=B6gershausen wrote:
> On 2013-10-30 18.01, Vicent Mart=C3=AD wrote:
>> On Wed, Oct 30, 2013 at 5:51 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>>> There is a name clash under cygwin 1.7 (1.5 is OK)
>>> The following "first aid hot fix" works for me:
>>> /Torsten
>>
>> If Cygwin declares its own bswap_64, wouldn't it be better to use it
>> instead of overwriting it with our own?
> Yes,
> this will be part of a longer patch.
> I found that some systems have something like this:
>=20
> #define htobe64(x) bswap_64(x)
> And bswap_64 is a function, so we can not detect it by "asking"
> #ifdef bswap_64
> ..
> #endif
>=20
>=20
> But we can use
> #ifdef htobe64
> ...
> #endif
> and this will be part of a bigger patch.
>=20
> And, in general, we should avoid to introduce functions which may hav=
e a
> name clash.
> Using the git_ prefix for function names is a good practice.
> So in order to unbrake the compilation error under cygwin 17,
> the "hotfix" can be used.

heh, my patch (given below) took a different approach, but ....

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] compat/bswap.h: Fix redefinition of bswap_64 error on =
cygwin
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Since commit 452e0f20 ("compat: add endianness helpers", 24-10-2013)
the cygwin build has failed like so:

    GIT_VERSION =3D 1.8.4.1.804.g1f3748b
        * new build flags
        CC credential-store.o
    In file included from git-compat-util.h:305:0,
                     from cache.h:4,
                     from credential-store.c:1:
    compat/bswap.h:67:24: error: redefinition of 'bswap_64'
    In file included from /usr/include/endian.h:32:0,
                     from /usr/include/cygwin/types.h:21,
                     from /usr/include/sys/types.h:473,
                     from /usr/include/sys/unistd.h:9,
                     from /usr/include/unistd.h:4,
                     from git-compat-util.h:98,
                     from cache.h:4,
                     from credential-store.c:1:
    /usr/include/byteswap.h:31:1: note: previous definition of \
	=E2=80=98bswap_64=E2=80=99 was here
    Makefile:1985: recipe for target 'credential-store.o' failed
    make: *** [credential-store.o] Error 1

Note that cygwin has a defintion of 'bswap_64' in the <byteswap.h>
header file (which had already been included by git-compat-util.h).
In order to suppress the error, ensure that the <byteswap.h> header
is included, just like the __GNUC__/__GLIBC__ case, rather than
attempting to define a fallback implementation.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/bswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index ea1a9ed..b864abd 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -61,7 +61,7 @@ static inline uint32_t git_bswap32(uint32_t x)
 # define ntohll(n) (n)
 # define htonll(n) (n)
 #elif __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
-#	if defined(__GNUC__) && defined(__GLIBC__)
+#	if defined(__GNUC__) && (defined(__GLIBC__) || defined(__CYGWIN__))
 #		include <byteswap.h>
 #	else /* GNUC & GLIBC */
 static inline uint64_t bswap_64(uint64_t val)
--=20
1.8.4
