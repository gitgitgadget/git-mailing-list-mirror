From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Wed, 04 Jun 2014 16:25:47 +0200
Message-ID: <538F2C6B.2030004@web.de>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com> <1401853091-15535-2-git-send-email-dturner@twitter.com> <538ED2F1.9030003@web.de> <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsC8b-0001gZ-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 16:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbaFDOZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 10:25:53 -0400
Received: from mout.web.de ([212.227.15.3]:52337 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbaFDOZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 10:25:52 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MeBVG-1XAQ0g2PGg-00PxLf; Wed, 04 Jun 2014 16:25:48
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
X-Provags-ID: V03:K0:TNaDj9gZOGZYyu/SmjTvZLCkdHbTT3ul5a2zW0mWUGhTuHCfkQd
 7S1OF20ZhAfY9c1lveFPeuuNFqMLM0c15+bq1qg42KfEcNkUCvx504k8KMTG5OMVTCUxPhm
 oZrgclHLB8IiVo13pY8ZixEj2nzouaGFGVqQImYtbYJbdLJhUDWI/sTtwNBBS5LDBzcmmSq
 83aSodi0WJIPLFCsAAkvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250730>

On 2014-06-04 13.21, Duy Nguyen wrote:
> On Wed, Jun 4, 2014 at 3:04 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>>
>> On 2014-06-04 05.38, David Turner wrote:
>> []
>>> []
>>> diff --git a/Makefile b/Makefile
>>> index a53f3a8..dd2127a 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1326,6 +1326,11 @@ else
>>>               COMPAT_OBJS +=3D compat/win32mmap.o
>>>       endif
>>>  endif
>>> +ifdef NO_SSE42
>>> +     BASIC_CFLAGS +=3D -DNO_SSE42
>>> +else
>>> +     BASIC_CFLAGS +=3D -msse4.2
>>> +endif
>> This does work for some people, but break for others, like the syste=
ms in my test-lab.
>> On 2 different systems the gcc has support for -msse4.2, but the pro=
cessor has not,
>> and t5511 fails with "Illegal instruction".
>> How can that be?
>> The maintainer of a Linux distro wants to ship gcc with all possible=
 features,
>> an the end-user can compile the code with all the features his very =
processor has.
>=20
> I think glibc code uses cpuid instruction to decide whether to use
> optimized version. May be we can do the same? If we go that route and
> have a way to detect sse support from compiler, then we can drop
> NO_SSE42, enable all and pick one at runtime.
>=20
Running make under a non-X86 processor like arm fails, as his gcc does =
not have -msse4.2

On the other hand, looking here:=20
http://sourceware.org/ml/libc-alpha/2009-10/msg00063.html
and looking into refs.c,
it seems as if we can try to run=20
strcspn(refname, bad_characters)
and=20
strstr(refname, "@{"
and=20
strstr(refname, ".."
on each refname, instead of checking each char in a loop.
The library will pick the fastest version for strcspn() automatically.

David, the repo you run the tests on, is it public?
Or is there a public repo with this many refs ?
Or can you make a dummy repo with 60k refs ?
