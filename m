Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6DBC433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 00:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66FF61409
	for <git@archiver.kernel.org>; Sat,  1 May 2021 00:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhEAAmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 20:42:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59191 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhEAAmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 20:42:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04A1213CC7C;
        Fri, 30 Apr 2021 20:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vy1xM4D1EUGm7/mZxo9XLMNXhYcaC3iAMFdbLm
        enHUk=; b=LiEIZMcPnYF5XHznIdCUIo5EUtmdG0BW7ByGMs/iY8FFnsFS2BzN0w
        X2Ox/rXaLyhVRndxglxTIHJ7orNvbtMDVh652k0m0rkmGuyTnbNmnyooPKIp78u8
        LekcZi3ZhtPN1SLA+hT2J9Z4+fGM9cwnvnCZYizkBBuO9MfSsKfJ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F153B13CC7B;
        Fri, 30 Apr 2021 20:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33E9C13CC7A;
        Fri, 30 Apr 2021 20:41:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru>
Date:   Sat, 01 May 2021 09:41:08 +0900
In-Reply-To: <87v9837tzm.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        30 Apr 2021 17:00:13 +0300")
Message-ID: <xmqqzgxfb80r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC696470-AA15-11EB-AA70-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> Luckily,
>>
>>     $ git log [--stat] --diff-merges=first-parent master..seen
>>
>> seems to do almost the right thing, with respect to the "It is
>> probably OK to special case" I gave above.
>
> I believe any special-casing is to be a last resort, and definitely is
> not the right thing to do in this particular case.

I do not know if I get it.  "log --diff-merges=<kind>" giving the
same output as "log" (i.e. no trace of any kind of diff) would be
puzzling to users, and to help them, it is OK to say that

 * "--diff-merges=<kind>" enables some kind of diff output
   automatially (for both merges and non-merges), and

 * when there is no user preference given as to what kind of diff is
   desired, we default to "-p".

As it is natural to expect "--stat --diff-merges=<kind> would give
only the diffstat without patch, we end up "special casing"
"--diff-merges=<kind>" that is given alone, without specifying what
kind of diff is desired, and behave as if "-p" was given.  So I
would have expected you to call this kind of "special casing" a good
thing.

>> It only "enables diff" for merge commits, which does not quite feel
>> right and we may want to do the same "enable diff" for single parent
>> commits, but the good part is that it does not blindly imply "-p".
>>
>> It seems to do the "enable diff" the right way by honoring other
>> command line options that specify the format of the diff, so with
>> "--stat" included in the sample command line above, we get the
>> diffstat for single parent commits (because we ask for "--stat" from
>> the command line to show it throughout the history) and also for
>> merge commits (because --diff-merges=first-parent does *not* blindly
>> turn the textual patch '-p' on).
>
> Good to know! I must admit I did nothing special in this regard, just
> paid attention to avoid breaking any existing logic, at least knowingly.
>
>>
>>> [Footnote]
>>>
>>> *1* They are not limited to "-p", "--stat" and "--summary", but
>>> you'd need to also pay attention to "--raw", "--name-only", etc.)
>>
>> I've merged the so/log-diff-merge topic to 'master', with this
>> (possibly) known breakage that it does not do anything for single
>> parent commits.  We may want to fix this last mile before the
>> release that is scheduled to happen around early June.
>
> I have no idea what the breakage is or could be.

Because I view

 * "--diff-merges" is a way to specify how merge commits are passed
   to the diff machinery (e.g. pass nothing to the diff machinery,
   compare only with the first parent, etc.), and

 * "--patch", "--stat", "--cc" etc are to specify if we use the diff
   machinery and what kind of output is desired.

but we are conflating the "enable diff" feature into the former to
match end-user expectation, if "--diff-merges" without any of the
"--patch", "--stat", etc. enables the "--patch" output for merge
commits, it would be confusing if we do not give the same "--patch"
output for single-parent commits, too.

But the current code gives "--patch" output only for merge commits,
doesn't it?  E.g.

    $ git log --diff-merges=first-parent master..next

would give patches only for merge commits, but

    $ git log --stat --diff-merges=first-parent master..next

would give us diffstat for all commits, including merges (against
their first parents).
