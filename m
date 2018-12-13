Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF4020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 06:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLMGgC (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 01:36:02 -0500
Received: from mail.javad.com ([54.86.164.124]:42160 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeLMGgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 01:36:02 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 987143EC2C;
        Thu, 13 Dec 2018 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1544682961;
        bh=+9RvjY0ONalsatyn8RrbC7g/0zXMSehxengvFfiW01A=; l=1861;
        h=Received:From:To:Subject;
        b=eBxK6n0rcDVTNj3DwlI6kCuVGFXu4qIt5zQFfGHYqbwTaOnfxNIoaygMYhpWKecYt
         qgFaTHnBVdayOVWmV8DEpO5bZk60faX8933xm1xgRH6CY0dY1alQB1sTsRZsOEn05f
         mKFu+SyQsfNilHaU21oHMqM1E22OFc4GedLmbWlM=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gXKbG-0002Bw-Tl; Thu, 13 Dec 2018 09:35:58 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <871s6n5mtd.fsf@javad.com>
        <xmqqo99qf46q.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Dec 2018 09:35:58 +0300
In-Reply-To: <xmqqo99qf46q.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Dec 2018 13:20:29 +0900")
Message-ID: <87o99qylv5.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> When cherry-picking multiple commits, it's impossible to have both
>> merge- and non-merge commits on the same command-line. Not specifying
>> '-m 1' results in cherry-pick refusing to handle merge commits, while
>> specifying '-m 1' fails on non-merge commits.
>>
>> This patch allows '-m 1' for non-merge commits. Besides, as mainline is
>> always the only parent for a non-merge commit, it made little sense to
>> disable it in the first place.
>
> In the original context to pick a single commit, it made perfect
> sense to avoid mistakes by blindly passing '-m 1' to non-merge
> commit.
>
> It may be fair to say that we failed to reconsider what to
> do with '-m 1' when we did 7e2bfd3f, but it is utterly an unfair 
> history revisionism to say that it made little sense to disable it
> in the first place.

In fact I had zero intention on any revisionism. Now I see I should have
said "makes little sense" in present tense to avoid touching deep
historical issues, sorry!

Something like:

"This patch allows '-m 1' for non-merge commits. As mainline is always
the only parent for a non-merge commit, it makes little sense to disable
it."

sounds OK?

>
> The change to the code itself looks sane, but applying this patch
> alone will break existing tests whose expectations must be updated,
> and this new behaviour must be protected by a new test (or two) so
> that we won't accidentally stop accepting "-m 1" for a single-parent
> commit.

I fixed most of the tests, but

"t3510/4: cherry-pick persists opts correctly"

is an offender for me. It looks like it [ab]uses current "-m 1" behavior
just to stop in the middle of the sequence, and I'm not sure how to fix
it most suitably.

Thanks!

-- 
Sergey
