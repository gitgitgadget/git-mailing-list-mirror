Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA7EC35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0606120661
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qJgjLXLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJTau (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:30:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62251 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 14:30:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF589446B2;
        Mon, 10 Feb 2020 14:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5ypISC2tN9HQHOWiviUR4X1oapo=; b=qJgjLX
        LcBzuoaIBfDLgvXDFPel/xA8Tc5yOKdm9R6AXwhwlFqt2FCsUe0ShhQf5rgpkPNT
        +CZhlax7aD6Zeh70+lck4KTt2fa9bUbJS2mVAu4XUyT6OEKiamVYC7wEdakoM81B
        0AgbK+t5jaTqM+koa6m3WkwBfw/DgOHn5e15U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lL9VrMB4s4NGXSeWme4CVCpwO+6ZaLzX
        zOnGMllYGIx0rT5a/moOVhpu4krWEly1f3G7l7y/APOBCHUj1vgCMJjFre+bpMYQ
        Jk2C09oY8F3uSA2ObYwTSILjSeKycXLq0XhC3EXp2vrX6lsejd6QML6WUGBZthGH
        Hy8hT/u0iM8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A66E3446B1;
        Mon, 10 Feb 2020 14:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B4EA446B0;
        Mon, 10 Feb 2020 14:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
        <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
Date:   Mon, 10 Feb 2020 11:30:46 -0800
In-Reply-To: <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com> (Derrick
        Stolee's message of "Mon, 10 Feb 2020 09:38:51 -0500")
Message-ID: <xmqq8slaz1cp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D65B017C-4C3B-11EA-A7E9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +static const char turn_off_instructions[] =
>> +N_("\n"
>> +"Turn this message off by running\n"
>> +"\"git config %s false\"");
>
> I have mixed feelings on the use of these instructions. Perhaps at
> minimum the addition of these instructions could be left to a
> separate patch than the creation of advise_ng().
>
> My biggest concern is that this adds unexpected noise to users who
> want the advice to stay. I'm calling attention to it, because this
> part isn't a simple refactor like the rest of the patch.
> ...
> I definitely tend to recommend more tests than most, but perhaps this
> unit test is overkill? You demonstrate a good test below using a real
> Git command, which should be sufficient. If the "turn this message off"
> part gets removed, then you will still have coverage of your method.
> It just won't require a test change because it would not modify behavior.
> ...

All good suggestions.  Thanks for an excellent review.

Another thing.  

advise_ng() may have been a good name for illustration but is a
horrible name for real-world use (imagine we need to revamp the API
one more time in the future---what would it be called, which has to
say that it is newer than the "next generation"?
advise_3rd_try()?).

Thanks.
