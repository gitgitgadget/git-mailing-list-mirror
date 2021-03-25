Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D2C433E0
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F26361A40
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCYSw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:52:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 14:52:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65215C68AA;
        Thu, 25 Mar 2021 14:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4f2rj3od3RPshH9IHEDsovpEp8Y=; b=TzKwsu
        iL0MxdKP3cBqGZ+PLouTONOTgpej6h54S/ELWQ2J/MwO67rwcZl7cxSAm2QpIdKm
        PoTx7PTVlgemHQ2aMbOKsU4PI9NmJb69+/TrC61vizGOZYwyxlEgTmCtVRXVTO3p
        ugQeIqifO2tXxUwju+kTfZ/9cZr1+BsSxaK3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uoRdLYQJWuT/f4jmknTr/bHv5p7Lg4Pq
        HUW9aqVkgzeq/Uj8bCxNjXI7+BDtt6+682Rkx8PBHslgvf+LIt7zCORmLGJi8Ktr
        Lp49nKqeoSTiydZcMV04NQ2Dw2+HZlgYmE5FFrtBhNv5HxZsRYG/N8/G9865oK/9
        e3T1cDnnbMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CAF0C68A9;
        Thu, 25 Mar 2021 14:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3876C68A7;
        Thu, 25 Mar 2021 14:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] csum-file: flush less often
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
        <84ccabca-0bd3-d0cb-6b38-f96d75c0bbd6@gmail.com>
        <xmqq8s6bvzpf.fsf@gitster.g>
Date:   Thu, 25 Mar 2021 11:52:29 -0700
In-Reply-To: <xmqq8s6bvzpf.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        25 Mar 2021 11:46:20 -0700")
Message-ID: <xmqq4kgzvzf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 400B8A3C-8D9B-11EB-9D19-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So, I'm of two minds here:
>>
>>  1. This is embarassing. I wasted everyone's time for nothing. I can retract
>>     this patch.
>>
>>  2. This is embarassing. I overstated the problem here. But we might be able
>>     to eke out a tiny performance boost here.
>>
>> I'm open to either. I think we should default to dropping this patch unless
>> someone thinks the rewrite above is a better organization of the logic. (I
>> can then send a v2 including that version and an updated commit message.)
>
> 3. The current code around "if (nr == sizeof(f->buffer))" might be a
>    bit too clever for readers who try to understand what is going
>    on, and the whole "while" loop may deserve a comment based on
>    what you wrote before your replacement implementation.

Having said all that, comparing the original and the version updated
with your "flush less often" patch, I find the latter quite easier
to read, so as long as the update does not give us 1% slowdown, it
may be worth adopting for the readability improvement alone.

Of course, if we were to go that route, the sales pitch in the log
message needs to be updated.

Thanks.
