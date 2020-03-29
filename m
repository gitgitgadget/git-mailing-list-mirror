Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1EDC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 17:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E215720714
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 17:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CKGXvvcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgC2Rj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:39:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60534 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgC2Rj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 13:39:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F127263907;
        Sun, 29 Mar 2020 13:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RKo8e5L+EnTj/QL1j+kpujzxtck=; b=CKGXvv
        clJ8JT3yvJ1zXRRLiXOGjBe82uUbPVBW+YHFxK+uGnu9FByIuday0Szlr9Yj/ZYy
        Od8m/ncaLcK5Vt+7csIm3sP7MhTv6bpL2lz8jS++QZ/3QXfAsdWiMFUGbSR+SWPi
        ssYZdFTHHgCL668q5WPo4vmZxzs5/4mv+QD70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cyIManj1OxxD/MeCtfGGBck7J8ZjE644
        mVDRjA+S5LHIMXhz4YJ3cD7ZSz3Y93H9U0w13EZsamcLKrSLplmXBXM+EwtyY4/4
        ckTYvkiM27TotryjIpbft1oM4xVK3sfelqZQth3qWzj1FlKVCSyVafPp8a1bfeyP
        dGwOCoFPUvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9AB063906;
        Sun, 29 Mar 2020 13:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AA4663905;
        Sun, 29 Mar 2020 13:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
References: <20200320220045.258462-1-jonathantanmy@google.com>
        <20200326211156.GA37946@google.com>
        <20200326231416.GC12694@google.com>
Date:   Sun, 29 Mar 2020 10:39:54 -0700
In-Reply-To: <20200326231416.GC12694@google.com> (Josh Steadmon's message of
        "Thu, 26 Mar 2020 16:14:16 -0700")
Message-ID: <xmqqeetbawlx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D8399DA-71E4-11EA-938F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> Having a look at the final structure of the loop with these gotos, I'm a
>> little confused. Could be this isn't C-idiomatic but I think the code
>> could be easier to read with helpers instead of gotos. I realize it's
>> longer but I have a hard time understanding that your gotos are used to
>> double-continue or double-break; nested loops tend to make me want to
>> use helpers. But - I'm a lowly barely-reformed C++ developer, so what do
>> I know ;)
>> 
>>   int oid_in_promisor(oid) {
>>     for (p = get_all_packs(the_repository); p; p = p->next) {
>>       if (!p->pack_promisor)
>>         continue;
>>       if (find_pack_entry_one(oid.hash, p)
>>         return 1;
>>     }
>>   }
>> 
>>   int all_oids_in_promisors(oid, fn, cb_data)
>>   {
>>     do {
>>       if (! oid_in_promisor(oid))
>>         return 0;
>>     } while (!fn(cb_data, &oid));
>>     return 1;
>>   }
>> 
>>   int check_connected(...)
>>   {
>>     ...
>>     if (has_promisor_remote()) {
>>       if (all_oids_in_promisors(oid, fn, cb_data))
>>         return 0;
>>       if (opt->shallow_file) {
>>        ...
>>   }
>
> I like this version better as well.

Sounds good.  Jonathan?  I've squashed Josh'es Reviewed-by, but I
will refrain from merging it to 'next' just yet to see if you too
like the proposed code structure.

Thanks, all.
