From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] merge-base: "--reflog" mode finds fork point from
 reflog entries
Date: Thu, 24 Oct 2013 17:43:16 -0400
Message-ID: <CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:43:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSgb-0004iE-UR
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab3JXVnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:43:18 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:46693 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3JXVnR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:43:17 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so95952lbj.31
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=chbLNy0ZaArkixshsTb7ZrUiK3SnQw+f9FmNxckkYjs=;
        b=uK01FZYGCnBHtQIGAy/zaKcpEhp84A00jns5rGaBWapP/3rUePigGUPwbYmk4y2Q79
         tJ7BHJNfwESXKX3tkUYUHSIQ8b2OA8kNslhn6YpmkV2Z2cCxmjRm8pinoNLgpukAt4Ak
         Yw6RDZhCdrMq+NUjfYdu3lXTClOWpzcZXJF+wSAONSvqt8VGMPQgddO6x6ztahwBA5DH
         d3tBKDlEqCeNkzVDCL+M/HaYmJW85FIZPYNdxoPo2V3VD/e7frkqVMgKCkwhmvV7WZpF
         NnV6NzD9fHVbmHWHv2TiGfDwfINlidqCSYAbPXJ/8FvR8meXCNdLDaCp0bH9gVwC4oYq
         1tyg==
X-Received: by 10.112.56.177 with SMTP id b17mr161721lbq.74.1382650996064;
 Thu, 24 Oct 2013 14:43:16 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Thu, 24 Oct 2013 14:43:16 -0700 (PDT)
In-Reply-To: <xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: KTpFTiy9kKxwvk2-t7cn6Iyzfrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236631>

On Thu, Oct 24, 2013 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Oct 24, 2013 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
>>> index f80bba8..3a1abee 100755
>>> --- a/t/t6010-merge-base.sh
>>> +++ b/t/t6010-merge-base.sh
>>> @@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>>>         test_cmp expected.sorted actual.sorted
>>>  '
>>>
>>> +test_expect_success 'using reflog to find the fork point' '
>>> +       git reset --hard &&
>>> +       git checkout -b base $E &&
>>> +       (
>>> +               for count in 1 2 3 4 5
>>> +               do
>>> +                       git commit --allow-empty -m "Base commit #$count" &&
>>> +                       git rev-parse HEAD >expect$count &&
>>> +                       git checkout -B derived &&
>>> +                       git commit --allow-empty -m "Derived #$count" &&
>>> +                       git rev-parse HEAD >derived$count &&
>>> +                       git checkout base &&
>>> +                       count=$(( $count + 1 )) || exit 1
>>> +               done
>>
>> Did you want && here?
>
> No, I did not.  Can't you tell from the fact that I didn't put one
> there ;-)?
>
> It does not hurt to have one there, but it is not necessary.
>
> Because the loop itself does not &&-cascade from anything else, the
> only case anything after "done &&" would be skipped and making the
> whole thing fail would be when anything inside the loop fails, but
> we already "exit 1" to terminate the whole subprocess in that case,
> so we will not continue past the loop.

I didn't read inside the loop closely enough to see that. Sorry for the noise.

>
>>> +
>>> +               for count in 1 2 3 4 5
>>> +               do
>>> +                       git merge-base --reflog base $(cat derived$count) >actual &&
>>> +                       test_cmp expect$count actual || exit 1
>>> +               done
>>
>> And here?
>
> Likewise.
>
> Thanks.
>
>>> +
>>> +               # check defaulting to HEAD
>>> +               git merge-base --reflog base >actual &&
>>> +               test_cmp expect5 actual
>>> +       )
>>> +'
>>> +
>>>  test_done
