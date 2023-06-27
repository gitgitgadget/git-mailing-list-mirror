Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC0EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 20:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjF0UEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0UEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 16:04:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380191BEA
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 13:04:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62DFF19F339;
        Tue, 27 Jun 2023 16:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tj/le7YC7Nj7kwORiVRBO+METLsPfdjDZPssNt
        bZKNA=; b=MfnVRybJylN67Ch2c86iot6WQaMKiVGDfU9Tq/ISHK3KXhX/4TaCch
        65edqJmDR18ZMJrpZYp3XulPsrZRfDZVT8x/3qQckJxn0NHjJPPxk0MZ0wqgTC7g
        9H+ZGHXw3n7HvLHbT/1Tkyus4D1bvXDr9oUYa8Je5K042wuKDbAQo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 597A119F338;
        Tue, 27 Jun 2023 16:04:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFEDC19F335;
        Tue, 27 Jun 2023 16:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Hudson <jhudson@cedaron.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
        <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
        <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
        <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
        <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de>
        <xmqqedlwhgf9.fsf@gitster.g>
        <4f28a9c4-b422-69b7-ccc1-2661d756d876@cedaron.com>
Date:   Tue, 27 Jun 2023 13:04:16 -0700
In-Reply-To: <4f28a9c4-b422-69b7-ccc1-2661d756d876@cedaron.com> (Joshua
        Hudson's message of "Tue, 27 Jun 2023 12:10:36 -0700")
Message-ID: <xmqqttusfz9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC251E8E-1525-11EE-B72B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Hudson <jhudson@cedaron.com> writes:

> On 6/27/2023 12:08 PM, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Fri, 23 Jun 2023, Junio C Hamano wrote:
>>>
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>
>>>>> Elijah Newren <newren@gmail.com> writes:
>>>>>
>>>>>> Reviewed-by: Elijah Newren <newren@gmail.com>
>>>>>
>>>>> Thanks for a quick review.
>>>> Unfortunately Windows does not seem to correctly detect the aborting
>> Sorry, I did not mean "abort(3)" literally.  What I meant was that
>> an external merge driver that gets spawned via the run_command()
>> interface may not die by calling exit()---like "killed by signal"
>> (including "segfaulting").  The new test script piece added in the
>> patch did "kill -9 $$" to kill the external merge driver itself,
>> which gets reported as "killed by signal" from run_command() by
>> returning the signal number + 128, but that did not pass Windows CI.
>>
> Do you need me to provide a windows test harness?

Sorry, I do not understand the question.

FWIW how "external merge driver that kills itself by sending a
signal to itself does not get noticed on Windows" appears in our
tests can be seen at

https://github.com/git/git/actions/runs/5360824580/jobs/9727137272

The job is "win test(0)", part of our standard Windows test harness
implemented as part of our GitHub Actions CI test.

Thanks.
