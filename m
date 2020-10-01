Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF562C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AC020759
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lC8JtGE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgJATX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:23:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54928 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 15:23:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E677989AB;
        Thu,  1 Oct 2020 15:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n8XKz95ulDLTwGsTp4lhcv93xoA=; b=lC8JtG
        E9vMP9unpprnq/Txii3iaHMqzBqmL23GvppvV3NV22TBDTchDUvSfOBBjMmhddcw
        IwKyKqQxHAVUM8s4fFPI9PpjpF3V2fej1aB7sDVO5bgkX4+9AG9zRo4uNzh8E6NL
        Ab6YKhjYrWHYTgflgKR6rNKo5SELKHupmQDz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H148/gPcksRQ3xJB7LxMQ6+BuFPEZ4Ay
        Zw+zu/Cezsryr6c36n/p5R7LuMHkeziX1rO4FMt1ZRnsaQN0kPhL9uRtSlXv4sDK
        BpRwgdE1pZ4ILekPSXwsGfPzFzf9ygaP/0zhQpveTgNi53jGoG6N+OCXF6vPou21
        1Y+ZhhwJDY0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55951989AA;
        Thu,  1 Oct 2020 15:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD6B0989A9;
        Thu,  1 Oct 2020 15:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 06/13] reftable: (de)serialization for the
 polymorphic record type.
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <8eb944ea9b1c0bdc4a3ebb4e79fd12187f6c988c.1601568663.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 12:23:24 -0700
In-Reply-To: <8eb944ea9b1c0bdc4a3ebb4e79fd12187f6c988c.1601568663.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 01 Oct 2020
        16:10:56 +0000")
Message-ID: <xmqqk0w9bvir.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9367C222-041B-11EB-81F8-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct reftable_record reftable_new_record(uint8_t typ)
> +{
> +	struct reftable_record rec = { NULL };

I can see a lot of "sparse" inspired work went into this, but we
would want to take the previous discussion into account, as nothing
has changed since then.

https://lore.kernel.org/git/41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org/

https://lore.kernel.org/git/1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com/

Unfortunately we didn't reach a clear consensus back then; I thought
we saw a fix to make sparse silent when we use the "= { 0 }" idiom
in recent versions of sparse, but the above threads do not have any
mention of it, so either I am misremembering or there were other
discussions on the same topic where it was also mentioned.

> +	switch (typ) {

Need blank before this line.

Thanks.
