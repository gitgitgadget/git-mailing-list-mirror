From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] parse_tag_buffer(): do not prefixcmp() out of range
Date: Thu, 17 Feb 2011 13:43:35 +0100
Message-ID: <4D5D17F7.4010003@lsrfire.ath.cx>
References: <20110212144706.GA25124@do> <1297688571-1962-1-git-send-email-pclouds@gmail.com> <7vsjvpm1xh.fsf@alter.siamese.dyndns.org> <AANLkTin+zR81H0aahveMMOwKyxVV_wRoab=pqk51joop@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq3DJ-0004N8-G5
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab1BQMnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 07:43:51 -0500
Received: from india601.server4you.de ([85.25.151.105]:56460 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab1BQMnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:43:50 -0500
Received: from [192.168.2.103] (p4FFD904E.dip.t-dialin.net [79.253.144.78])
	by india601.server4you.de (Postfix) with ESMTPSA id DDBC22F8043;
	Thu, 17 Feb 2011 13:43:42 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTin+zR81H0aahveMMOwKyxVV_wRoab=pqk51joop@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167080>

Am 16.02.2011 04:39, schrieb Nguyen Thai Ngoc Duy:
> 2011/2/16 Junio C Hamano<gitster@pobox.com>:
>>> -     if (prefixcmp(bufptr, "tag "))
>>> +     if (bufptr + 4<  tail&&  !prefixcmp(bufptr, "tag "))
>>> +             ;               /* good */
>>> +     else
>>>                return -1;
>>>        bufptr +=3D 4;
>>>        nl =3D memchr(bufptr, '\n', tail - bufptr);
>>
>> If there weren't enough bytes between bufptr and tail, prefixcmp may=
 still
>> match with "tag " while later part of the matched string might be co=
ming
>> from trailing garbage outside our memory.  Unless we correctly fail =
the
>> prefixcmp() part, memchr() would be fed negative value, no?
>
> Yes, memchr() would be fed negative, but prefixcmp() already steps
> outside allocated memory. I believe that caused valgrind error Thomas
> reported (although I couldn't reproduce it).
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmail.com>  writes=
:
>>
>>> There is a check (size<  64) at the beginning of the function, but
>>> that only covers object+type lines.
>>>
>>> Strictly speaking the current code is still correct even if it
>>> accesses outside 'data' because 'tail' is used right after
>>> prefixcmp() calls.
>>
>> What do you mean by this?  I don't get it.
>
> Because memchr() would be fed negative, memchr() would fail so the
> code is still correct.

memchr() won't notice if a negative value has been passed as third=20
parameter because its type is size_t, which is unsigned.  Negative=20
values are converted to big positive ones..

Ren=C3=A9
