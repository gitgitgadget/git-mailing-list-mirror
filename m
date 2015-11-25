From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for
 each atom in valid_atom
Date: Wed, 25 Nov 2015 14:41:15 -0500
Message-ID: <CAPig+cRcxr7uT2OJX=TnaVf+gXQdw9ydp+7X+Kis4Vb5+6RHiA@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
	<CAOLa=ZTFeKMMSRCTWi9RkSvuCh7ZecPudSgsJB4TV76U4aGJJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:41:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1fwN-0003ta-1K
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 20:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbKYTlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 14:41:18 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36588 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbKYTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 14:41:16 -0500
Received: by vkay187 with SMTP id y187so41107959vka.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k7o62AeA+Ljkk3Iywfl9AYdITxx+X6Y37sjZdccZcLE=;
        b=EeRRGhH3hgvbnCmkNafGThomEo3UYo5ELK4J7GSKhJrWF1fvZg72m6GtcQDdxy4hKf
         op69ds31s02tXdhW4A3EC+EEMVCL5RuMBfItwv84pJ2qKhRgJwkEqLtSClJqkoT4wdAJ
         qJbub6JJDwxGAKB1+k83wyrKXmJ6RcNw99Q5FlVxw6UagwM4e7ncr+Y+EPwlc5BCrzGs
         cTudqchxUV2Gfc6jG9+Fx7yHWM9HURaHFMWl0IoJP7tnt8cAezC8IM9TIK7kB5OW7nm/
         +ZgSeb64OuMokMucsigLz8ur5bIuty2MHjWj5ZWWChN0Xm1sqG0c10pP8YGSdRPL9L/S
         qfZA==
X-Received: by 10.31.13.205 with SMTP id 196mr35687285vkn.37.1448480476035;
 Wed, 25 Nov 2015 11:41:16 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Wed, 25 Nov 2015 11:41:15 -0800 (PST)
In-Reply-To: <CAOLa=ZTFeKMMSRCTWi9RkSvuCh7ZecPudSgsJB4TV76U4aGJJA@mail.gmail.com>
X-Google-Sender-Auth: 9ftVrDTQdj_UlV0E4ATfIlmUtHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281732>

On Wed, Nov 25, 2015 at 7:10 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Tue, Nov 24, 2015 at 5:14 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Introduce a parsing function for each atom in valid_atom. Using this
>>> we can define special parsing functions for each of the atoms. Since
>>> we have a third field in valid_atom structure, we now fill out missing
>>> cmp_type values.
>>
>> I don't get it. Why do you need to "fill out missing cmp_type values"
>> considering that you're never assigning the third field in this patch?
>> Are you planning on filling in the third field in a future patch?
>
> I plan on filling that in upcoming patches. Probably, should mention that in
> the commit message.

Making it clear that this patch is preparatory for introduction of
'valid_atom' is a good idea, however, adding the unused 'valid_atom'
field in this patch is not recommended. It would be better to
introduce 'valid_atom' in the patch which actually needs it.

>>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>>> ---
>>> diff --git a/ref-filter.c b/ref-filter.c
>>> @@ -19,42 +19,43 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>>  static struct {
>>>         const char *name;
>>>         cmp_type cmp_type;
>>> +       void (*parser)(struct used_atom *atom);
>>
>> Compiler diagnostic:
>>
>>     warning: declaration of 'struct used_atom' will not be
>>         visible outside of this function [-Wvisibility]
>>
>> Indeed, it seems rather odd to introduce the new field in this patch
>> but never actually do anything with it. It's difficult to understand
>> the intention.
>
> This is to make way for upcoming patches. But the compiler error is
> accurate used_atom only becomes a structure in the next patch.
> Should change that.

This problem will go away if you introduce the 'valid_atom' field in
the patch which actually needs it (as suggested above) rather than in
this patch.
