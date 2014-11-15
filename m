From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] replace: fix replacing object with itself
Date: Sat, 15 Nov 2014 12:55:11 +0100
Message-ID: <CAP8UFD3dZMmGJp1p=ttVUoUkiwh7oYL3gqgsGZ+D8Bd16FiKjQ@mail.gmail.com>
References: <1415887559-16585-1-git-send-email-manzurmm@gmail.com>
	<xmqqppcp1jvg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Manzur Mukhitdinov <manzurmm@gmail.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 12:55:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpbwo-0001iR-Kf
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 12:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbaKOLzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 06:55:14 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:48181 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbaKOLzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 06:55:12 -0500
Received: by mail-ig0-f169.google.com with SMTP id hn18so1126553igb.0
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zgps4ypYHvWyZZnCYnKZ74Rab0L0Xwki1BqM0Ta9gV8=;
        b=yTtkcSyAgDAbnLNQaF58noS/vqkQxjckpyo/kBfEtOOWrSZTQkNRVUXAdm19k/1apr
         f9u9b9iBPSpeqgj1jT+hXJ/7p0sDAHo/ro8eCTc4ETFUIf6d7hwJLDGQyaiaO+bF9KPZ
         CEY2b1N7inwUtFRxGxpLWT1mfqp69u0/Uo9QBAc8qqMITEYcAI9h8K7l4Dp9A5z1xV5j
         Vk4TBmpI4fRJDysYDTECyQdV7MELqPrB6/GPpofj1MVPju4B3jLK2wygOUTqPn/Bph8U
         Etw7fObvzZ5QdL954h3tRq/pVGfSlfZSXLL5PL0P4Y3SjlU8T6mgTyXCz6P+ejqjktQa
         QAAA==
X-Received: by 10.43.104.3 with SMTP id dk3mr16702204icc.47.1416052511887;
 Sat, 15 Nov 2014 03:55:11 -0800 (PST)
Received: by 10.50.250.179 with HTTP; Sat, 15 Nov 2014 03:55:11 -0800 (PST)
In-Reply-To: <xmqqppcp1jvg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Sorry to resend this. I am really bad at making gmail on my Android
smartphone send plain text emails.]

On Fri, Nov 14, 2014 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Manzur Mukhitdinov <manzurmm@gmail.com> writes:
>
>> When object is replaced with itself git shows unhelpful messages like(git log):
>>     "fatal: replace depth too high for object <SHA1>"
>>
>> Prevents user from replacing object with itself(with test for checking
>> this case).
>>
>> Signed-off-by: Manzur Mukhitdinov <manzurmm@gmail.com>
>> ---
>
> The patch is not wrong per-se, but I wonder how useful this "do not
> replace itself but all other forms of loops are not checked at all"
> would be in practice.  If your user did this:
>
>         git replace A B ;# pretend as if what is in B is in A
>         git replace B C ;# pretend as if what is in C is in B
>         git replace C A ;# pretend as if we have loop
>         git log C
>
> she would not be helped with this patch at all, no?

Yeah, but such loops are much less likely mistakes and are more
difficult to detect, so I think this patch is at least a good first
step.

> We have the "replace depth" thing, which is a poor-man's substitute
> for loop detection, primarily because we do not want to incur high
> cost of loop detection at runtime.  Shouldn't we be doing at least
> the same amount of loop-avoidance check, if we really want to avoid
> triggering the "replace depth" check at runtime?

We could check at replace ref creation time, but what if the user
already has a ref that replaces A using B, and then a fetch adds a ref
that replaces B using A?

Maybe we should accept that we have to rely on the runtime replace
depth anyway, and improve its output first.

Best,
Christian.
