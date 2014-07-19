From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Sat, 19 Jul 2014 19:53:04 +0200
Message-ID: <53CAB080.8060005@web.de>
References: <53C944B3.5080106@web.de> <20140718184246.GS12427@google.com> <53C971FD.6040500@web.de> <20140718235706.GA11192@peff.net> <53CA6072.8000009@web.de> <20140719164324.GA5616@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:54:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8YqP-0004iE-Jt
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 19:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556AbaGSRxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2014 13:53:24 -0400
Received: from mout.web.de ([212.227.15.4]:49523 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755317AbaGSRxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 13:53:23 -0400
Received: from [192.168.178.27] ([79.253.155.202]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MCeX4-1XGmIc2ykU-009PaY; Sat, 19 Jul 2014 19:53:20
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140719164324.GA5616@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:PuAS2NZWu+ak+yozP1dVkiwnXFwnAEd7q6EazrT5I/Y5+SsCGbS
 rOhBGk9IAjk3gXfLnUreJnHRR1x54/udvoBAfodl+q8UULzks3zSGeBO46xWGMXawBYtf/G
 AiAIci3t0bLDxqwastpFj9Yj/Vfm1GrcjPv6fzLPQx/mU15ejpRKJSjcN7JC0QO+fCddEqv
 0L1CcLcqvCfnvgSCYoyiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253900>

Am 19.07.2014 18:43, schrieb brian m. carlson:
> On Sat, Jul 19, 2014 at 02:11:30PM +0200, Ren=C3=A9 Scharfe wrote:
>> I'd say if a platform doesn't bother optimizing memcmp() then they
>> deserve the resulting performance.  And it's probably not too bad a
>> penalty because such comparisons probably won't make up a significan=
t
>> part of most applications.
>
> I tend to agree with this.  On many modern versions of GCC, the compi=
ler
> can generate an appropriately optimized inline version when it sees a
> memcmp call, so it's more of a compiler issue then, since no actual c=
all
> to the function will be emitted.

I just found this open GCC bug entry about glibc memcmp being faster=20
than the inlined version of the compiler:=20
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D43052.

(Found through=20
http://randomascii.wordpress.com/2012/10/31/comparing-memory-is-still-t=
ricky/,=20
which says that the compilers coming with Microsoft Visual Studio 2010=20
and 2012 are not optimizing memcmp() as much as they could as well.)

>>   static inline int hashcmp(const unsigned char *sha1, const unsigne=
d char *sha2)
>>   {
>> +	const uint32_t *p1 =3D (const uint32_t *)sha1;
>> +	const uint32_t *p2 =3D (const uint32_t *)sha2;
>
> You can't make this cast.  The guaranteed alignment for sha1 and sha2=
 is
> 1, and for p1 and p2, it's 4.  If sha1 and sha2 are not suitably
> aligned, this will get a SIGBUS on sparc and possibly a wrong value o=
n
> ARM[0].
>
> [0] http://www.aleph1.co.uk/chapter-10-arm-structured-alignment-faq

Yeah, it was just a test balloon that happens to work on amd64.  We=20
could invent a hash type with correct alignment (a struct with a=20
uint32_t[5] member?) and replace all those unsigned char pointers if we=
=20
wanted to go with such a "vectorized" hashcmp, but that would be=20
maximally invasive.

Ren=C3=A9
