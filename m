From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Tue, 26 Apr 2011 18:54:43 +0200
Message-ID: <4DB6F8D3.6040200@lsrfire.ath.cx>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com> <7v7hahghls.fsf@alter.siamese.dyndns.org> <BANLkTi=ECjmjBLfS=s6fMWXgtxDYmxcP5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElY7-0001DM-Bp
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 18:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab1DZQzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 12:55:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:55753 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab1DZQzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 12:55:38 -0400
Received: from [192.168.2.106] (p4FFDA9E5.dip.t-dialin.net [79.253.169.229])
	by india601.server4you.de (Postfix) with ESMTPSA id 534752F8050;
	Tue, 26 Apr 2011 18:55:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTi=ECjmjBLfS=s6fMWXgtxDYmxcP5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172108>

Am 26.04.2011 17:32, schrieb Nguyen Thai Ngoc Duy:
> 2011/4/26 Junio C Hamano<gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmail.com>  writes=
:
>>
>>> strbuf_grow(sb, 0) may allocate less than requested len and violate=
 the
>>> next assertion.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gm=
ail.com>
>>> ---
>>>   strbuf.h |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/strbuf.h b/strbuf.h
>>> index 07060ce..ab213da 100644
>>> --- a/strbuf.h
>>> +++ b/strbuf.h
>>> @@ -34,7 +34,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
>>>
>>>   static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>>>        if (!sb->alloc)
>>> -             strbuf_grow(sb, 0);
>>> +             strbuf_grow(sb, len);
>>>        assert(len<  sb->alloc);
>>
>> This looks so obviously correct that it is scary.
>>
>> How could 60 callsites of this function manage to have run without c=
rashes
>> so far?  They all happen to use the function on a buffer that alread=
y has
>> something on it?
>
> I guess no current call site does _setlen right after initialization.
> It's new code that triggers it.

Documentation/technical/api-strbuf.txt says that you can't use=20
strbuf_setlen() to allocate more space for a strbuf, i.e. you can use i=
t=20
only to shorten a string or set it to its current length.  If the strbu=
f=20
in question hasn't allocated any buffer at all (sb->alloc =3D=3D 0) the=
n the=20
only valid len is zero.

Where is it used to extend strbufs, i.e. which is the new code you=20
mentioned?

Ren=C3=A9
