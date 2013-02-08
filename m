From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4] Add utf8_fprintf helper which returns correct columns
Date: Fri, 08 Feb 2013 17:19:01 +0100
Message-ID: <51152575.8090507@web.de>
References: <7va9rho350.fsf@alter.siamese.dyndns.org> <4ea03e99bad13e2910b137fd3991951244fa23f1.1360289411.git.worldhello.net@gmail.com> <51149542.8060307@web.de> <CANYiYbGZEJXDjzBJa_qbQCgw9tcTMfOChNr6ANwaLvo=fB=bcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 17:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3qhi-0007fN-1z
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 17:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760059Ab3BHQVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 11:21:11 -0500
Received: from mout.web.de ([212.227.17.12]:59128 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758646Ab3BHQVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 11:21:10 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MDxGV-1U9bwm19LD-00HWBC; Fri, 08 Feb 2013 17:19:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CANYiYbGZEJXDjzBJa_qbQCgw9tcTMfOChNr6ANwaLvo=fB=bcQ@mail.gmail.com>
X-Provags-ID: V02:K0:wz3w3NjIJeZ2Do0ZWlR7w/PfthtZiCEKYgjti5NYHAB
 0R3xZqn1pRV4EKb6IBlUKcdpsDDTddv/XH7mVGv+ls1syj3Oyr
 tQkZeV6EOFZs9Ph4ee3zEKyLeJHCoZxVmUAmZ9g2CigRQAUnrv
 YzSMOHbpPGGeiHFIE/Vg9U8JA4m2e4la8/b795sntNzf6qzL4H
 t794taPnQseTph2ZG55Mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215778>

On 08.02.13 08:20, Jiang Xin wrote:
> 2013/2/8 Torsten B=C3=B6gershausen <tboegi@web.de>:
>> On 08.02.13 03:10, Jiang Xin wrote:
>>> +     /* If no error occurs, returns columns really required with u=
tf8_strwidth. */
>>> +     if (0 <=3D columns)
>>> +             columns =3D utf8_strwidth(buf.buf);
>>> +     strbuf_release(&buf);
>>> +     return columns;
>>> +}
>>> +
>>
>> I don't think we handle the return code from fputs() correctly.
>>
>> Please dee below for specifications on fprintf(),
>> something like the following could do:
>>
>> int utf8_fprintf(FILE *stream, const char *format, ...)
>> {
>>         struct strbuf buf =3D STRBUF_INIT;
>>         va_list arg;
>>         int columns =3D 0;
>>
>>         va_start (arg, format);
>>         strbuf_vaddf(&buf, format, arg);
>>         va_end (arg);
>>
>>         if (EOF !=3D fputs(buf.buf, stream))
>>                 columns =3D utf8_strwidth(buf.buf);
>>         strbuf_release(&buf);
>>         return columns;
>> }
>=20
> As fputs() returns a non-negative number (as opposed to 0) on
> successful completion,
> Test fputs() return value as "fputs() >=3D0" is correct, while "fputs=
()
> =3D=3D 0", "fputs() !=3D 0"
> are wrong. I think it's OK, must I send a new re-roll for this?
>=20
> EOF is defined as (-1) in stdio.h:
>=20
>     #define EOF     (-1)
>=20
>> And as a side note: would fprintf_strwidth() be a better name?
>=20
> This is a nice candidate.
>=20
>=20

Doing a slurp(coffe) followed by a re-read,
I think we are save with the existng code.

However, I feel that the commit message can be improved,=20
as it fixes problems not only for CJK but e.g. european languages
(and all systems using utf-8)

>Since command usages can be translated, they may not align well especi=
ally
>when they are translated to CJK. A wrapper utf8_fprintf can help to re=
turn
>the correct columns required.
=20
Since command usages can be translated, they may include utf-8 encoded =
strings,
and strlen() is different from strwidth().
A wrapper utf8_fprintf() helps to return the correct columns required.


Thanks for working on this.
