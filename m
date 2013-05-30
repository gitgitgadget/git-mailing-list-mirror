From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Thu, 30 May 2013 01:40:29 -0500
Message-ID: <CAMP44s0eUWRXcXFeKyUrMwKDWcpn7dMX0km10Zpe0ZALW6T6LA@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-3-git-send-email-martinvonz@gmail.com>
	<51A5A992.306@viscovery.net>
	<CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
	<CAMP44s0x8e2xpycOEswnYDBM5WKn=fCp7hcUEniARGVZUw1XkQ@mail.gmail.com>
	<CANiSa6hxhiFYn1atdh+zA76H=XsiAHown8Ndn0T6fXRPJEaWEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 08:40:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhwXL-0005RX-U4
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 08:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967586Ab3E3Gkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 02:40:32 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39816 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967574Ab3E3Gka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 02:40:30 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so6937561wgh.25
        for <git@vger.kernel.org>; Wed, 29 May 2013 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TCkrsfX6x6//BYkTILlrZrq7JdDbLr52f+dHIzKee9g=;
        b=hP/ol+TcgW0sWmn3UMyxkSRZzCt5qLGqXAOPtq9vMF6ydE/b8iX5d94JGikta1F5dl
         K9Udvq6T7tvCLApZK2kDDARyS+d/LlJztXbLUV2IwliXmMLQO1IJqjjWaXdbPnMJkB7n
         Zb0ajv19dNpuuvP5E2EB8LQhs5ZeHY/naThWA5HDh6sLrgVKEaBb5rNRI8kyPZF1ZFNR
         Djr3ZSIq628lmfT+SVD8Q9HUx6hM4hLmYQS4/tQg3E9ZUvcBoACSS6KceiIe9/QwWb6m
         h5rFgcM/UZqQEYCzIKC1WN4b9VmYgtCnNftNBAWhYeUnxw3os+XirSbH/QizGKW8GpS/
         Hsyw==
X-Received: by 10.180.189.136 with SMTP id gi8mr17260515wic.11.1369896029613;
 Wed, 29 May 2013 23:40:29 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 23:40:29 -0700 (PDT)
In-Reply-To: <CANiSa6hxhiFYn1atdh+zA76H=XsiAHown8Ndn0T6fXRPJEaWEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225932>

On Thu, May 30, 2013 at 1:14 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Wed, May 29, 2013 at 10:41 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Thu, May 30, 2013 at 12:30 AM, Martin von Zweigbergk
>> <martinvonz@gmail.com> wrote:
>>> On Wed, May 29, 2013 at 12:09 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>>>>> +#       f
>>>>> +#      /
>>>>> +# a---b---c---g---h
>>>>> +#      \
>>>>> +#       d---G---i
>>>> ...
>>>>> +test_run_rebase () {
>>>>> +     result=$1
>>>>> +     shift
>>>>> +     test_expect_$result "rebase $* --onto drops patches in onto" "
>>>>> +             reset_rebase &&
>>>>> +             git rebase $* --onto h f i &&
>>>>> +             test_cmp_rev h HEAD~2 &&
>>>>> +             test_linear_range 'd i' h..
>>>>
>>>> Isn't this expectation wrong? The upstream of the rebased branch is f, and
>>>> it does not contain G. Hence, G should be replayed. Since h is the
>>>> reversal of g, the state at h is the same as at c, and applying G should
>>>> succeed (it is the same change as g). Therefore, I think the correct
>>>> expectation is:
>>>>
>>>>                 test_linear_range 'd G i' h..
>>>
>>> Good question! It is really not obvious what the right answer is. Some
>>> arguments in favor of dropping 'G':
>>
>> I think the answer is obvious; G should not be dropped. Maybe it made
>> sense to drop g in upstream, but d fixes an issue, and it makes sense
>> to apply G on upstream.
>
> Well, maybe I was wrong in thinking that dropping 'G' in 'git rebase
> --onto f h i' is bad. It seems to complicate things a lot, so maybe we
> should just decide that it's fine to do that (to drop 'G' in that
> case). Since that's mostly how it has worked forever and no one seems
> to have reported a problem with it, I'm probably just being paranoid.
> Thoughts?

Huh? I said the opposite; G should *not* be dropped.

-- 
Felipe Contreras
