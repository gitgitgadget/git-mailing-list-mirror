From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] parse_tag_buffer(): do not prefixcmp() out of range
Date: Wed, 16 Feb 2011 10:39:24 +0700
Message-ID: <AANLkTin+zR81H0aahveMMOwKyxVV_wRoab=pqk51joop@mail.gmail.com>
References: <20110212144706.GA25124@do> <1297688571-1962-1-git-send-email-pclouds@gmail.com>
 <7vsjvpm1xh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:40:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpYFG-0006Y3-CX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1BPDj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 22:39:57 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51399 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1BPDj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 22:39:56 -0500
Received: by wyb28 with SMTP id 28so912793wyb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 19:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xPyFXMwlovpzZGeejmT9Y4Qn9TB96eCbB3+e9CDAB+I=;
        b=nlT+90s/JygGT6//sV/6AxAwq5ZksYFx9KQEXsiAwiTqonVsVHJJItr8wmCL8YFGCr
         fNiO1EOEIe6+tmmW8w8zOHcevbHXaE4bRt+37PFuVvOoFTSYlXWPO7EWZhx8h5XWIp4o
         goIwoK+yIWYb0OAh6H1jzJdRKvRsPwqjsqdTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GtsP1A8CO0uMWU3WrBAFZlAwGEK7FuzhJcgWpC0EaQln9SkfUU/eJeWr4OdbgPr1lh
         VSiLRwUnBvvIcTcq+EY5gDnnw2exNbd2QxKgayCwc3HqxcXay52h1oj88L9qOiOnbPdn
         Ru4vbaFMjMfkRjfOAf+MBQyZQMi/VLB4qKKR0=
Received: by 10.216.87.130 with SMTP id y2mr51402wee.58.1297827594672; Tue, 15
 Feb 2011 19:39:54 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Tue, 15 Feb 2011 19:39:24 -0800 (PST)
In-Reply-To: <7vsjvpm1xh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166921>

2011/2/16 Junio C Hamano <gitster@pobox.com>:
>> - =C2=A0 =C2=A0 if (prefixcmp(bufptr, "tag "))
>> + =C2=A0 =C2=A0 if (bufptr + 4 < tail && !prefixcmp(bufptr, "tag "))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* good */
>> + =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> =C2=A0 =C2=A0 =C2=A0 bufptr +=3D 4;
>> =C2=A0 =C2=A0 =C2=A0 nl =3D memchr(bufptr, '\n', tail - bufptr);
>
> If there weren't enough bytes between bufptr and tail, prefixcmp may =
still
> match with "tag " while later part of the matched string might be com=
ing
> from trailing garbage outside our memory. =C2=A0Unless we correctly f=
ail the
> prefixcmp() part, memchr() would be fed negative value, no?

Yes, memchr() would be fed negative, but prefixcmp() already steps
outside allocated memory. I believe that caused valgrind error Thomas
reported (although I couldn't reproduce it).

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> There is a check (size < 64) at the beginning of the function, but
>> that only covers object+type lines.
>>
>> Strictly speaking the current code is still correct even if it
>> accesses outside 'data' because 'tail' is used right after
>> prefixcmp() calls.
>
> What do you mean by this?  I don't get it.

Because memchr() would be fed negative, memchr() would fail so the
code is still correct.
--=20
Duy
