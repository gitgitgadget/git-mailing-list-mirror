From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] unpack-trees: plug a memory leak
Date: Sun, 2 Jun 2013 17:45:06 -0500
Message-ID: <CAMP44s2WSmu-JfKFPpNyQzDMfULMy9hCVb9Tu_Qd_bcKotOYjQ@mail.gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-4-git-send-email-felipe.contreras@gmail.com>
	<7vfvx0nw7t.fsf@alter.siamese.dyndns.org>
	<CAMP44s3aF8VsNqJA3GNLN=cw6Vp4iJEcTn5WDq2XPs-Le--szg@mail.gmail.com>
	<7vehckma34.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjH1U-0006NP-UR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3FBWpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 18:45:09 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:55060 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab3FBWpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 18:45:08 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so2887558lab.38
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VBSfMqAq9iYvGdjVAzo4t/Q42O8saS2zjZaf7yrmC1o=;
        b=0J3m8BAr4dcjktB3//vnd68Uc3NEGCTINbFeM3VHynzVZuvcKvVHEdhONLTOOxW/ps
         R8p6S0jXb5VeebSd1CX5dw6Moj1Q3w4rFaGXkr7t+qeukFnbfOzmjOsmzbzAfpswLwQa
         o/20OE/RwtqFgaRpxHnzo5fP4cQp0HuLrVRG62ITNBK0MsaGY8Ub94ivR2NP32mGqZP3
         yiikBKuDdwv9G+js9AyqBh2w0BhFICr+aTRBtKuZ8tadWIc5Yf+9bELlb0SBTma8//RZ
         AZh6CBPv64Smhwj8Ao4MMqnVSgdCttoBbqckDnWbcZdNfYg+J7DEc+uOCIlCPMPzEBfE
         8DUQ==
X-Received: by 10.112.88.166 with SMTP id bh6mr9803487lbb.47.1370213106346;
 Sun, 02 Jun 2013 15:45:06 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 15:45:06 -0700 (PDT)
In-Reply-To: <7vehckma34.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226190>

On Sun, Jun 2, 2013 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Jun 2, 2013 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Before overwriting the destination index, first let's discard it's
>>>> contents.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>  unpack-trees.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>>> index ede4299..eff2944 100644
>>>> --- a/unpack-trees.c
>>>> +++ b/unpack-trees.c
>>>> @@ -1146,8 +1146,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>>
>>>>       o->src_index = NULL;
>>>>       ret = check_updates(o) ? (-2) : 0;
>>>> -     if (o->dst_index)
>>>> +     if (o->dst_index) {
>>>> +             discard_index(o->dst_index);
>>>>               *o->dst_index = o->result;
>>>> +     }
>>>
>>> I seem to recall that many callers set src_index and dst_index to
>>> the same istate, and expect that the original istate pointed by the
>>> src_index to remain usable.  Is it safe to discard it like this at
>>> this point?
>>
>> Who expects that?
>
> The patch you posted expects that no such caller depends on
> src_index being left alone by the call, and I was asking if that
> expectantion holds, i.e. if it is safe to discard.

No, it expects that no caller depends on dst_index being left alone.

> I think your answer can be one of "Yes, it is safe, as no current
> caller does so", "I dunno, I did not check", or "No, this and that
> caller need to be adjusted".

If what you say is true, it would not be safe, but AFAIK what you said
is not true, so it is safe. I wouldn't have sent the patch otherwise.

-- 
Felipe Contreras
