From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/7] unpack-trees: free cache_entry array members for merges
Date: Thu, 30 May 2013 10:20:48 -0500
Message-ID: <CAMP44s10a9fj4No6o3GZQrwkREQP2WXbXr+1F83Q11EJ1AxrcA@mail.gmail.com>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1369913664-49734-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2=YuBLHgz52ie-FZYU5iz4o4tY0-zH+6XuzpiupjomLA@mail.gmail.com>
	<51A764CE.4000708@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 30 17:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4et-0003xp-2P
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231Ab3E3PUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 11:20:52 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:64286 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699Ab3E3PUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 11:20:50 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so385341lab.34
        for <git@vger.kernel.org>; Thu, 30 May 2013 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bLB6We2RmgfKw3ldHB2+WoA9WrJj7d9F3I3Vf+a72g8=;
        b=QHQDSigRYW7CTDZV+gMwCHzOkeqH/mU59Om1vDiLQ4v1z7N7X/Hx9C0JfEp0xDJ05b
         bH4tf5554Q12w6fsNaiaVu1YzY9L+qY43E/5su+IFLWnDLo19xiAbp4j3jhjpfI5SFUK
         rWqt/9fxDE7H7UCDBUeKqYB2ur0LO/KDfp14ldPD48Hg3nPxCQcoSFjDPGy674rmllY8
         Yk5Vzc66u4t+EmqW9VMYUq+DA9ne4/T3XQSUJwH6YM/ChcUPpvioWx6pJmFhuirecr6H
         96HgyJ/GH0u0pMFdahKd6/fWmVmdOrVgJvikA1NUBEBdolEJ5odZFiSRoxRlqrk1k2vO
         lkbA==
X-Received: by 10.112.156.164 with SMTP id wf4mr3866249lbb.76.1369927248604;
 Thu, 30 May 2013 08:20:48 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 08:20:48 -0700 (PDT)
In-Reply-To: <51A764CE.4000708@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226012>

On Thu, May 30, 2013 at 9:40 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 30.05.2013 14:04, schrieb Felipe Contreras:
>
>> On Thu, May 30, 2013 at 6:34 AM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>> The merge functions duplicate entries as needed and they don't free
>>> them.  Release them in unpack_nondirectories, the same function
>>> where they were allocated, after we're done.
>>
>>
>> Ah, you beat me to this change, but..
>>
>>> @@ -600,9 +600,14 @@ static int unpack_nondirectories(int n, unsign=
ed
>>> long mask,
>>>                  src[i + o->merge] =3D create_ce_entry(info, names =
+ i,
>>> stage);
>>>          }
>>>
>>> -       if (o->merge)
>>> -               return call_unpack_fn((const struct cache_entry * c=
onst
>>> *)src,
>>> -                                     o);
>>> +       if (o->merge) {
>>> +               int rc =3D call_unpack_fn((const struct cache_entry=
 * const
>>> *)src,
>>> +                                       o);
>>> +               for (i =3D 1; i <=3D n; i++)
>>> +                       if (src[i] && src[i] !=3D o->df_conflict_en=
try)
>>> +                               free(src[i]);
>>
>>
>> Doesn't it make more sense to follow the code above and do src[i +
>> o->merge]?
>
>
> Not sure I understand.  Is the goal to avoid confusion for code reade=
rs by
> using the same indexing method for allocation and release?  Or are yo=
u
> worried about o->merge having a different value than 1 in that loop?

Both. In particular I'm eyeballing the code you can even see in this pa=
tch:

 src[i + o->merge] =3D create_ce_entry(info, names + i, stage);

If you think it's better to use src[i], then I think the code above
should do the same.

--=20
=46elipe Contreras
