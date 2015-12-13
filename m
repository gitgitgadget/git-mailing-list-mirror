From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Sun, 13 Dec 2015 14:23:22 +0530
Message-ID: <CAOLa=ZQ=GL9F8ecOfa3rQ_rXP6_eEpA+ms8zOz5TBbmY9frnaw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-9-git-send-email-Karthik.188@gmail.com> <CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
 <CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
 <CAOLa=ZQD1ZhkOGr6Y3ZTwkRC--gMVjwXhpvGpBUGuoHjw9hoJQ@mail.gmail.com> <CAPig+cRwD_W5pQSpiHR8izQ+=6stY+XwpXEJ5HU4gi+MQFaH2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 09:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a82QL-0001zy-V6
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 09:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbbLMIxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 03:53:53 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36156 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbLMIxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 03:53:53 -0500
Received: by vkay187 with SMTP id y187so138427053vka.3
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6/m5cPGvpD++AH3I44v6SEBCxKZ2qz45piRWBN22auY=;
        b=iW4K1PBRm4g274t/Rh6SMQNykcuF/yL/1wdbr9n5abrJp5s7f8y0LLroEwK4D8NJvP
         Mw1CxPtoIwknObfGsgJC1M6zBTm7jPPjHzddqJWKVChEe4nJ/VXtn8ldl7T7b8vTHUMq
         S7h4TN6GSFVvwGoVrJGGSUgb/WzaYk3ZaU2RKHkUbLAAniFMh5dtKhgWw75SmDjcBff8
         Yd9moA7cw+iKAVX6MFAZMQmNsNPbi3YmFVkOSg1cztZZ+d5Z3/mnIxg89MkbEt9oGdmf
         ODHKH/Gbe0OOsZbD4eySa3s8lhbXiwGJWAO8NXpf/sswP356C53z0JPElt5GoZEiH3nV
         OG6A==
X-Received: by 10.31.130.80 with SMTP id e77mr20048187vkd.97.1449996832311;
 Sun, 13 Dec 2015 00:53:52 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 00:53:22 -0800 (PST)
In-Reply-To: <CAPig+cRwD_W5pQSpiHR8izQ+=6stY+XwpXEJ5HU4gi+MQFaH2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282327>

On Sun, Dec 13, 2015 at 2:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Dec 13, 2015 at 3:32 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Sun, Dec 13, 2015 at 6:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>>>>> and '%(push)' atoms and store information into the 'used_atom'
>>>>> structure based on the modifiers used along with the corresponding
>>>>> atom.
>>>>>
>>>>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>>>>> ---
>>>>> diff --git a/ref-filter.c b/ref-filter.c
>>>>> @@ -37,6 +37,11 @@ static struct used_atom {
>>>>>         union {
>>>>>                 const char *color;
>>>>>                 struct align align;
>>>>> +               struct {
>>>>> +                       unsigned int shorten : 1,
>>>>> +                               track : 1,
>>>>> +                               trackshort : 1;
>>>>> +               } remote_ref;
>>>>
>>>> Are 'shorten', 'track', and 'trackshort' mutually exclusive? If so, a
>>>> simple enum would be clearer than bitfields:
>>>>
>>>>     union {
>>>>         const char *color;
>>>>         struct align align;
>>>>         enum { RR_PLAIN, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>>>>             remote_ref;
>>>>     };
>>>>
>>>> Or something.
>>
>> There's also a slight problem with using enum's with the current implementation.
>> The problem is the enum is set to 0 by default (since we use memset).
>> so the first value is set by default, not something we'd want.
>
> I'm afraid I don't see the problem. Doesn't the RR_PLAIN in the
> example cover this case?
>
>> So either we stick to the structure
>> with unsigned bits or we introduce a pseudo value in the enum. I
>> prefer the former.
>
> It's not a pseudo-value, but rather just one of the mutually exclusive states.

This example is actually fine, the next one "%(contents)" is more of
the problem,
the check is done in grab_sub_body_contents() where previously "contents.all"
would be enough to check if we need to add contents value. Now the first enum
value is selected. Maybe have a "NOT_VALID" field in the enum.

-- 
Regards,
Karthik Nayak
