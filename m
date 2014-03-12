From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 22:45:15 +0100
Message-ID: <5320D56B.8060101@web.de>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>	<20140312175624.GA7982@sigill.intra.peff.net>	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>	<5320C8CC.3010404@web.de> <87fvmni0de.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Quint Guvernator <quintus.public@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqyh-0001Th-7S
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbaCLVqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 17:46:14 -0400
Received: from mout.web.de ([212.227.15.3]:52445 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbaCLVqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:46:14 -0400
Received: from [192.168.178.27] ([79.250.169.126]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M0yeJ-1XIZco2IN5-00v8VZ; Wed, 12 Mar 2014 22:46:05
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <87fvmni0de.fsf@fencepost.gnu.org>
X-Provags-ID: V03:K0:4X2es7mf0Ej0L3rQ8KmDi8kNLrk9tUh9xXkMXGvbCVvr+OZrcfs
 ffTQIbvoNZ5hygAV/4FJoVf6pB2ITJOac7r8IXmMK5sTweWcjx5sLbwQH9Kjc5QM0LQqZLD
 +iWP58fIKwbO/XgtFJ9kYZqii/Wmmd1eKeywT2ld5CocrD5evYHg6fhTiOOcrIAHJaMh3zS
 owIAdc/Q0BeeganH5OuAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244002>

Am 12.03.2014 22:16, schrieb David Kastrup:
> Ren=E9 Scharfe <l.s.r@web.de> writes:
>
>> Am 12.03.2014 20:39, schrieb Junio C Hamano:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>>>    static inline int standard_header_field(const char *field, siz=
e_t len)
>>>>>    {
>>>>> -	return ((len =3D=3D 4 && !memcmp(field, "tree ", 5)) ||
>>>>> -		(len =3D=3D 6 && !memcmp(field, "parent ", 7)) ||
>>>>> -		(len =3D=3D 6 && !memcmp(field, "author ", 7)) ||
>>>>> -		(len =3D=3D 9 && !memcmp(field, "committer ", 10)) ||
>>>>> -		(len =3D=3D 8 && !memcmp(field, "encoding ", 9)));
>>>>> +	return ((len =3D=3D 4 && starts_with(field, "tree ")) ||
>>>>> +		(len =3D=3D 6 && starts_with(field, "parent ")) ||
>>>>> +		(len =3D=3D 6 && starts_with(field, "author ")) ||
>>>>> +		(len =3D=3D 9 && starts_with(field, "committer ")) ||
>>>>> +		(len =3D=3D 8 && starts_with(field, "encoding ")));
>>>>
>>>> These extra "len" checks are interesting.  They look like an attem=
pt to
>>>> optimize lookup, since the caller will already have scanned forwar=
d to
>>>> the space.
>>
>> I wonder what the performance impact might be.  The length checks ar=
e
>> also needed for correctness, however, to avoid running over the end =
of
>> the buffer.
>
> Depends on whether memcmp is guaranteed to stop immediately on mismat=
ch.
> Then memcmp(field, "tree ", 5) cannot walk across a NUL byte in field=
=2E

I'm not sure we can rely on that property.  But anyway -- if field=20
points to, say, a one-byte buffer containing the letter t, then memcmp=20
would overrun that buffer.  If field was guaranteed to be NUL-terminate=
d=20
then at least starts_with would stop at the end, but the signature of=20
standard_header_field() suggests that it can be used with arbitrary=20
buffers, not just C strings.

Ren=E9
