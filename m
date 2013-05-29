From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] wildmatch: properly fold case everywhere
Date: Wed, 29 May 2013 20:52:07 +0700
Message-ID: <CACsJy8A61nYu9a-BhUiBhBEv-e6_CtYyZE3sG9iCiau+3EKVdw@mail.gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
 <1369749497-55610-1-git-send-email-n.oxyde@gmail.com> <CACsJy8CY_T44ymUnLWv4FpF3zpL3WKSysJ1wBhfxGHNPJ6kSmg@mail.gmail.com>
 <4E816EBA-A22D-4507-BED0-0DE55D2E619C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:52:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhgnz-0008Ox-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935149Ab3E2Nwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:52:39 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:55141 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935131Ab3E2Nwi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 09:52:38 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so11746166oag.32
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bBZJmb0wvVLhIesTMIqmeOEmxDhwxAzM6m5IyhsQQL0=;
        b=kobMpS8iBxbGmfBILe2ULBlspFTfG0hNNYrq1N49qZUxgL4Nu9VHgxrycZCLZWOPmo
         J1Ul7IZG5POj+Q9OxVHxE94Zf9e6sehQX0Zv7+8uhsDTyrHcPYWORX5Dq4hb1YxqHUJg
         wL7C0+rs3onMFA6kRXA+nD876XqwaWR+xOtJmlKgMUezwJIXR3Gx/bmKwSgH9hnQBxjj
         dHnKvxEhHGOP9PNkEdFezqrK6WWAWO1WVb94zeeSFfYLzwQ67sBuOuvY01Iw94gFJG6Y
         pGiwHiU0SaUGMlk+/OLtCKpWjir8gVNRNplTiMBoFqKrVKAwSSLoIToVQhnr7/FQjRM4
         ehRQ==
X-Received: by 10.60.99.10 with SMTP id em10mr1618396oeb.58.1369835557436;
 Wed, 29 May 2013 06:52:37 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 06:52:07 -0700 (PDT)
In-Reply-To: <4E816EBA-A22D-4507-BED0-0DE55D2E619C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225827>

On Wed, May 29, 2013 at 8:37 PM, Anthony Ramine <n.oxyde@gmail.com> wro=
te:
> Le 29 mai 2013 =C3=A0 15:22, Duy Nguyen a =C3=A9crit :
>
>> On Tue, May 28, 2013 at 8:58 PM, Anthony Ramine <n.oxyde@gmail.com> =
wrote:
>>> Case folding is not done correctly when matching against the [:uppe=
r:]
>>> character class and uppercased character ranges (e.g. A-Z).
>>> Specifically, an uppercase letter fails to match against any of the=
m
>>> when case folding is requested because plain characters in the patt=
ern
>>> and the whole string and preemptively lowercased to handle the base=
 case
>>> fast.
>>
>> I did a little test with glibc fnmatch and also checked the source
>> code. I don't think 'a' matches [:upper:]. So I'm not sure if that's=
 a
>> correct behavior or a bug in glibc. The spec is not clear (I think) =
on
>> this. I guess we should just assume that 'a' should match '[:upper:]=
'?
>
> I don't know, in my opinion if case folding is enabled we should say =
[:upper:], [:lower:] and [:alpha:] are equivalent.
>
> This opinion is shared by GNU Flex [1]:
>
>>       =E2=80=A2 If your scanner is case-insensitive (the =E2=80=98-i=
=E2=80=99 flag), then =E2=80=98[:upper:]=E2=80=99 and =E2=80=98[:lower:=
]=E2=80=99 are equivalent to =E2=80=98[:alpha:]=E2=80=99.
>
> [1] http://flex.sourceforge.net/manual/Patterns.html

Then we should do it too because of this precedent, I think.

>>> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar =
*text, unsigned int flags)
>>>                                        }
>>>                                        if (t_ch <=3D p_ch && t_ch >=
=3D prev_ch)
>>>                                                matched =3D 1;
>>> +                                       else if ((flags & WM_CASEFO=
LD) && ISLOWER(t_ch)) {
>>> +                                               uchar t_ch_upper =3D=
 toupper(t_ch);
>>> +                                               if (t_ch_upper <=3D=
 p_ch && t_ch_upper >=3D prev_ch)
>>> +                                                       matched =3D=
 1;
>>> +                                       }
>>
>> Or we could stick with to tolower. Something like this
>>
>> if ((t_ch <=3D p_ch && t_ch >=3D prev_ch) ||
>>   ((flags & WM_CASEFOLD) &&
>>      t_ch <=3D tolower(p_ch) && t_ch >=3D tolower(prev_ch)))
>>   match =3D 1;
>>
>> I think it's easier to read if we either downcase all, or upcase all=
, not both.
>
> If the range to match against is [A-_], it will become [a-_] which is=
 an empty range, ord('a') > ord('_'). I think it is simpler to reuse to=
upper() after the fact as I did.
>
> Anyway maybe I should add a test for that corner case?

Yeah I was thinking about such a case, but I saw glibc do it... I
guess we just found another bug, at least in compat/fnmatch.c. Yes a
test for it would be great, in case I change my mind 2 years from now
and decide to turn it the other way ;)

>
>>>                                        p_ch =3D 0; /* This makes "p=
rev_ch" get set to 0. */
>>>                                } else if (p_ch =3D=3D '[' && p[1] =3D=
=3D ':') {
>>>                                        const uchar *s;
>>> @@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar *=
text, unsigned int flags)
>>>                                        } else if (CC_EQ(s,i, "upper=
")) {
>>>                                                if (ISUPPER(t_ch))
>>>                                                        matched =3D =
1;
>>> +                                               else if ((flags & W=
M_CASEFOLD) && ISLOWER(t_ch))
>>> +                                                       matched =3D=
 1;
>>>                                        } else if (CC_EQ(s,i, "xdigi=
t")) {
>>>                                                if (ISXDIGIT(t_ch))
>>>                                                        matched =3D =
1;
>>
>> If WM_CASEFOLD is set, maybe isalpha(t_ch) is enough then?
>
> Yes isalpha() is enought but I wanted to keep the two cases separated=
, I can amend that if you want.

Either way is fine. I don't think this code is performance critical. Yo=
ur call.
--
Duy
