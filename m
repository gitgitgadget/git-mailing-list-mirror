From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Wed, 30 Oct 2013 19:11:58 +0000
Message-ID: <527159FE.6040706@ramsay1.demon.co.uk>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de> <5271443D.3070402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbbBd-000238-L2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab3J3TME convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 15:12:04 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:53987 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754091Ab3J3TMB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:12:01 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 627C5A64C81;
	Wed, 30 Oct 2013 19:12:00 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 252E8A648D0;
	Wed, 30 Oct 2013 19:12:00 +0000 (GMT)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Wed, 30 Oct 2013 19:11:59 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <5271443D.3070402@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237058>

On 30/10/13 17:39, Torsten B=C3=B6gershausen wrote:
> On 2013-10-30 18.14, Torsten B=C3=B6gershausen wrote:
>> On 2013-10-30 18.01, Vicent Mart=C3=AD wrote:
>>> On Wed, Oct 30, 2013 at 5:51 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:
>>>> There is a name clash under cygwin 1.7 (1.5 is OK)
>>>> The following "first aid hot fix" works for me:
>>>> /Torsten
>>>
>>> If Cygwin declares its own bswap_64, wouldn't it be better to use i=
t
>>> instead of overwriting it with our own?
>> Yes,
>> this will be part of a longer patch.
>> I found that some systems have something like this:
>>
>> #define htobe64(x) bswap_64(x)
>> And bswap_64 is a function, so we can not detect it by "asking"
>> #ifdef bswap_64
>> ..
>> #endif
>>
>>
>> But we can use
>> #ifdef htobe64
>> ...
>> #endif
>> and this will be part of a bigger patch.
>>
>> And, in general, we should avoid to introduce functions which may ha=
ve a
>> name clash.
>> Using the git_ prefix for function names is a good practice.
>> So in order to unbrake the compilation error under cygwin 17,
>> the "hotfix" can be used.
>> /Torsten
> I just realized that there seem to problems to compile pu under msysg=
it.
> More investigation needed here.

=2E.. I noticed this too, and my patch is given below (I have another
patch for mingw which fixes some printf format warnings too) ...

However, you would not be surprised to hear that this breaks on msvc
too, so I too was planning a larger re-write ... :-D

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] compat/bswap.h: Fix failure to determine endianness on=
 MinGW

Since commit 452e0f20 ("compat: add endianness helpers", 24-10-2013)
added the 'ntohll' and 'htonll' helpers, the MinGW build has failed
like so:

    GIT_VERSION =3D 1.8.4.1.804.g1f3748b
        * new build flags
        CC credential-store.o
    In file included from git-compat-util.h:305,
                     from cache.h:4,
                     from credential-store.c:1:
    compat/bswap.h:56:4: error: #error "Cannot determine endianness"
    make: *** [credential-store.o] Error 1

The #error is triggered because the 'endian macros' BYTE_ORDER,
LITTLE_ENDIAN and BIG_ENDIAN not being defined. On MinGW, these macros
are defined in the <sys/param.h> header file. In order to suppress the
error, set the build variable NEEDS_SYS_PARAM_H, which will cause the
"git-compat-util.h" header file to include <sys/param.h>.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 82d549e..c03ea1e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -469,6 +469,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep =3D ;
 	NO_PREAD =3D YesPlease
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
+	NEEDS_SYS_PARAM_H =3D YesPlease
 	NO_LIBGEN_H =3D YesPlease
 	NO_POLL =3D YesPlease
 	NO_SYMLINK_HEAD =3D YesPlease
--=20
1.8.4
