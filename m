From: Anthony Ramine <n.oxyde@gmail.com>
Subject: Re: [PATCH v3] wildmatch: properly fold case everywhere
Date: Wed, 29 May 2013 15:37:10 +0200
Message-ID: <4E816EBA-A22D-4507-BED0-0DE55D2E619C@gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com> <1369749497-55610-1-git-send-email-n.oxyde@gmail.com> <CACsJy8CY_T44ymUnLWv4FpF3zpL3WKSysJ1wBhfxGHNPJ6kSmg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgZA-00045Y-0A
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935178Ab3E2NhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:37:17 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63937 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab3E2NhP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 09:37:15 -0400
Received: by mail-wi0-f174.google.com with SMTP id c10so3539988wiw.1
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=R0JNmU1dbA4CF+DKtCmKNjHzeLr5BHub3PmVpS8ZH2U=;
        b=X9brXHyDwpa0Pxr2pMbDj6UdkVoeAFZyjjJV4n6LUXRURhlqFQwYH8g1fl46R1gfGE
         6amIWSAnpmgwMGHLnAs8nCVyKjdKPq8kGsDDhtyWYsDpNEdj6gJbxVgAS016ryQf1HKY
         de3Ti6rbAXkocTIcIFFWZ4hQ5F6s4xXvIqxDJPKZFuI2wI7L408wDuzu13UXbuMmeU/e
         6pto3qy70jx+upclowwT0T8rQufkz7f43a3TkJmmWsuT8qDCqhRJjuxYxwNv+8Jf2ude
         f/5o0qqYVQSsQnnIczElDPj2Hrs5njb/cmhXRwhzr3hRlYliFGMzvQ95FCm7GUZiK+JJ
         jOkQ==
X-Received: by 10.180.206.205 with SMTP id lq13mr15892711wic.56.1369834633832;
        Wed, 29 May 2013 06:37:13 -0700 (PDT)
Received: from [192.168.118.50] (33-43.83-90.static-ip.oleane.fr. [90.83.43.33])
        by mx.google.com with ESMTPSA id h8sm31240002wiz.9.2013.05.29.06.37.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 06:37:12 -0700 (PDT)
In-Reply-To: <CACsJy8CY_T44ymUnLWv4FpF3zpL3WKSysJ1wBhfxGHNPJ6kSmg@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225820>

Replied inline.

Regards,

--=20
Anthony Ramine

Le 29 mai 2013 =E0 15:22, Duy Nguyen a =E9crit :

> On Tue, May 28, 2013 at 8:58 PM, Anthony Ramine <n.oxyde@gmail.com> w=
rote:
>> Case folding is not done correctly when matching against the [:upper=
:]
>> character class and uppercased character ranges (e.g. A-Z).
>> Specifically, an uppercase letter fails to match against any of them
>> when case folding is requested because plain characters in the patte=
rn
>> and the whole string and preemptively lowercased to handle the base =
case
>> fast.
>=20
> I did a little test with glibc fnmatch and also checked the source
> code. I don't think 'a' matches [:upper:]. So I'm not sure if that's =
a
> correct behavior or a bug in glibc. The spec is not clear (I think) o=
n
> this. I guess we should just assume that 'a' should match '[:upper:]'=
?

I don't know, in my opinion if case folding is enabled we should say [:=
upper:], [:lower:] and [:alpha:] are equivalent.

This opinion is shared by GNU Flex [1]:

> 	=95 If your scanner is case-insensitive (the =91-i=92 flag), then =91=
[:upper:]=92 and =91[:lower:]=92 are equivalent to =91[:alpha:]=92.

[1] http://flex.sourceforge.net/manual/Patterns.html

>> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *=
text, unsigned int flags)
>>                                        }
>>                                        if (t_ch <=3D p_ch && t_ch >=3D=
 prev_ch)
>>                                                matched =3D 1;
>> +                                       else if ((flags & WM_CASEFOL=
D) && ISLOWER(t_ch)) {
>> +                                               uchar t_ch_upper =3D=
 toupper(t_ch);
>> +                                               if (t_ch_upper <=3D =
p_ch && t_ch_upper >=3D prev_ch)
>> +                                                       matched =3D =
1;
>> +                                       }
>=20
> Or we could stick with to tolower. Something like this
>=20
> if ((t_ch <=3D p_ch && t_ch >=3D prev_ch) ||
>   ((flags & WM_CASEFOLD) &&
>      t_ch <=3D tolower(p_ch) && t_ch >=3D tolower(prev_ch)))
>   match =3D 1;
>=20
> I think it's easier to read if we either downcase all, or upcase all,=
 not both.

If the range to match against is [A-_], it will become [a-_] which is a=
n empty range, ord('a') > ord('_'). I think it is simpler to reuse toup=
per() after the fact as I did.

Anyway maybe I should add a test for that corner case?

>>                                        p_ch =3D 0; /* This makes "pr=
ev_ch" get set to 0. */
>>                                } else if (p_ch =3D=3D '[' && p[1] =3D=
=3D ':') {
>>                                        const uchar *s;
>> @@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar *t=
ext, unsigned int flags)
>>                                        } else if (CC_EQ(s,i, "upper"=
)) {
>>                                                if (ISUPPER(t_ch))
>>                                                        matched =3D 1=
;
>> +                                               else if ((flags & WM=
_CASEFOLD) && ISLOWER(t_ch))
>> +                                                       matched =3D =
1;
>>                                        } else if (CC_EQ(s,i, "xdigit=
")) {
>>                                                if (ISXDIGIT(t_ch))
>>                                                        matched =3D 1=
;
>=20
> If WM_CASEFOLD is set, maybe isalpha(t_ch) is enough then?

Yes isalpha() is enought but I wanted to keep the two cases separated, =
I can amend that if you want.
