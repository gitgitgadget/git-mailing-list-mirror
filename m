From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Sat, 2 Feb 2013 00:21:56 -0800
Message-ID: <CANiSa6gxoHPWO85ZYu5iyHxzpE4HAprpEgG4305_jhyOE0LWGQ@mail.gmail.com>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com>
	<CANiSa6gM1gpj0A6PC0qNVSaWvVrOBnSnjn2uKR9-cHSLAZ2OVA@mail.gmail.com>
	<510C2E10.1050403@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, phil.hord@gmail.com,
	Neil Horman <nhorman@tuxdriver.com>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 09:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1YN7-0002Gc-1z
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 09:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab3BBIWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 03:22:00 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:36328 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3BBIV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 03:21:59 -0500
Received: by mail-we0-f171.google.com with SMTP id u54so3623705wey.16
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 00:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vAKCIDMfnx2iu2jpxxeHWiGy8HeZwHQSkAFeRfNX9qo=;
        b=zyHxRZtnWrQahFdU6PERgjQIIpvhHj7fI/F3Cdremt+ELS6DBKPCYlcc9dY/Wu5eSD
         h4aSi4ZFMhkAMRD3B7QX7XJ7LeWw91NeSi1sl6y1ikEmRK/pJATvD5aYaAONMpcSBydx
         s8FLBLQpG1FtCv8G+0vvw/cQmDdlJpToJd7zqcvgJGmqcwrORGCV4aq6cHnCXUjQSedt
         PIdWIJ8ReB+x+LhooS8I+xbIm3yyiB4gTegUvfx9EdCUKfepABhMoRxmRPvUZgdIdz6i
         UIUjotOExBDpsQSdkWDYMgTSbBJwO82cCs7ihzZfveiqZp7ZUVfCLKmWsrxk4BsruQaR
         tLcQ==
X-Received: by 10.194.78.236 with SMTP id e12mr25842856wjx.32.1359793316353;
 Sat, 02 Feb 2013 00:21:56 -0800 (PST)
Received: by 10.180.85.8 with HTTP; Sat, 2 Feb 2013 00:21:56 -0800 (PST)
In-Reply-To: <510C2E10.1050403@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215285>

On Fri, Feb 1, 2013 at 1:05 PM, Phil Hord <hordp@cisco.com> wrote:
>
> This is probably right, but it is not exactly the case that caused my itch.
> I think my branch looked like [...]

That also makes sense. I'll add tests for both cases. Your patch makes
both of them pass.

>> # a---b---c
>> #      \   \
>> #       d   \
>> #        \   \
>> #         e   \
>> #          \   \
>> #           C---l
>>
>> As you say, your patch doesn't try to handle this case, but at least
>> the new behavior seems better. I think we would ideally want the
>> recreated 'l' to have only 'C' as parent in this case. Does that make
>> sense?
>
> This is not what I meant, but it is a very interesting corner case.  I
> am not sure I have a solid opinion on what the result should be here.

Neither do I, so I'll just drop the test case. Thanks.

> Here is the corner case I was thinking of.  I did not test this to see
> if this will happen, but I conceived that it might.  Suppose you have
> this tree where
>
> # a---b---c
> #      \
> #       d---g---l
> #        \ /
> #         C
>
> where 'C' introduced the same changes as 'c'.
>
> When I execute 'git rebase -p l c', I expect that I will end up with
> this:
>
> # a---b---c---d---
> #              \  \
> #               ---g---l
>
> That is, 'C' gets skipped because it introduces the same changes already
> seen in 'c'.  So 'g' now has two parents: 'd' and 'C^'.  But 'C^' is 'd',
> so 'g' now has two parents, both of whom are 'd'.
>
> I think it should collapse to this instead:
>
> # a---b---c---d---g---l

I think this is actually what you will get. But I think it will only
be linearized if the branch that should be dropped is the second
parent. I have two tests for this, but I need to simplify them a
little to see that that (parent number) is the only difference.

> I hope this is clear, but please let me know if I made it too confusing.

Very clear. Thanks.
