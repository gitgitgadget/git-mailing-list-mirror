Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA510EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjF0TIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0TIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:08:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB683FD
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:08:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAE1719EC85;
        Tue, 27 Jun 2023 15:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qenyPEjyyJ3FGtdYBgNljgSRIUltRoRGCeQkj+
        a+Lqc=; b=m1odiAabO7pcOyPqW5lNgdofHTkq5RTIRVrUC3hwdrT5MH+6IGuivU
        0UuxNHRj4IZ7RtGT+mOPpDEfXHTuvpJx027By2liqPtL4fsDwne7sTUCIfXWyMaP
        yrcIAG7F/1R2j0dJoZipWaWVbCpUQcE5c9nHu4hdhBtxZl1om6KH8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0B5D19EC84;
        Tue, 27 Jun 2023 15:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38CA419EC83;
        Tue, 27 Jun 2023 15:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Joshua Hudson <jhudson@cedaron.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
        <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
        <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
        <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
        <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de>
Date:   Tue, 27 Jun 2023 12:08:10 -0700
In-Reply-To: <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de> (Johannes
        Schindelin's message of "Tue, 27 Jun 2023 14:02:02 +0200 (CEST)")
Message-ID: <xmqqedlwhgf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5859EBE-151D-11EE-BB41-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 23 Jun 2023, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Elijah Newren <newren@gmail.com> writes:
>> >
>> >> Reviewed-by: Elijah Newren <newren@gmail.com>
>> >
>> >
>> > Thanks for a quick review.
>>
>> Unfortunately Windows does not seem to correctly detect the aborting

Sorry, I did not mean "abort(3)" literally.  What I meant was that
an external merge driver that gets spawned via the run_command()
interface may not die by calling exit()---like "killed by signal"
(including "segfaulting").  The new test script piece added in the
patch did "kill -9 $$" to kill the external merge driver itself,
which gets reported as "killed by signal" from run_command() by
returning the signal number + 128, but that did not pass Windows CI.

