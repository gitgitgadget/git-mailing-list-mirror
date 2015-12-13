From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Sun, 13 Dec 2015 03:45:06 -0500
Message-ID: <CAPig+cRwD_W5pQSpiHR8izQ+=6stY+XwpXEJ5HU4gi+MQFaH2Q@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-9-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
	<CAOLa=ZQKR4+a-hpL-8xjE-93btWpUt4zAfCGTHBGWwhvLtQoRg@mail.gmail.com>
	<CAOLa=ZQD1ZhkOGr6Y3ZTwkRC--gMVjwXhpvGpBUGuoHjw9hoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 09:45:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a82HL-00055d-JX
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 09:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbbLMIpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 03:45:08 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33456 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbLMIpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 03:45:07 -0500
Received: by vkca188 with SMTP id a188so139314442vkc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 00:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zHeitTQGDZSLdRmZ8Uo3zYd/lPKh063uHvM/A4joJOo=;
        b=QRHvLhc9u2JZJchxexTAJ2y70jxA5WdJgl9jCUbkhst2QW4HfCx1IXnfLWfWrroknW
         w7z/Fk9zwN0ZDjsZnAXof37MM+QH7If8nKXyKdDnUrtrrEzNG+stMLWL2cBA69fv6dvw
         yK/Cvf3y7LzyC3qNzNkquWAcIoUWacdZw5KC+5PkAh+eOs0flwRo23QJL/wzRHfVuESt
         LOsTmZDPrD/b71St/fxf8uQUCL/FJHARUOIzC4v2et+jQpqWZY7Tz0/i5DBwx2IzEs0O
         oaPM07QFBzdF5Cv0ilVZRcUswCl9DmQuhlv529jYJGZSC3/oIG044woKl6B37wZo7A0l
         tLVg==
X-Received: by 10.31.182.129 with SMTP id g123mr20653010vkf.45.1449996306689;
 Sun, 13 Dec 2015 00:45:06 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 13 Dec 2015 00:45:06 -0800 (PST)
In-Reply-To: <CAOLa=ZQD1ZhkOGr6Y3ZTwkRC--gMVjwXhpvGpBUGuoHjw9hoJQ@mail.gmail.com>
X-Google-Sender-Auth: O54huO5FbW9ivo37QvMl7to5yo4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282326>

On Sun, Dec 13, 2015 at 3:32 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Dec 13, 2015 at 6:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>>>> and '%(push)' atoms and store information into the 'used_atom'
>>>> structure based on the modifiers used along with the corresponding
>>>> atom.
>>>>
>>>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>>>> ---
>>>> diff --git a/ref-filter.c b/ref-filter.c
>>>> @@ -37,6 +37,11 @@ static struct used_atom {
>>>>         union {
>>>>                 const char *color;
>>>>                 struct align align;
>>>> +               struct {
>>>> +                       unsigned int shorten : 1,
>>>> +                               track : 1,
>>>> +                               trackshort : 1;
>>>> +               } remote_ref;
>>>
>>> Are 'shorten', 'track', and 'trackshort' mutually exclusive? If so, a
>>> simple enum would be clearer than bitfields:
>>>
>>>     union {
>>>         const char *color;
>>>         struct align align;
>>>         enum { RR_PLAIN, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>>>             remote_ref;
>>>     };
>>>
>>> Or something.
>
> There's also a slight problem with using enum's with the current implementation.
> The problem is the enum is set to 0 by default (since we use memset).
> so the first value is set by default, not something we'd want.

I'm afraid I don't see the problem. Doesn't the RR_PLAIN in the
example cover this case?

> So either we stick to the structure
> with unsigned bits or we introduce a pseudo value in the enum. I
> prefer the former.

It's not a pseudo-value, but rather just one of the mutually exclusive states.
