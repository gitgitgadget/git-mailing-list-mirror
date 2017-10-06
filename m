Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56C61FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 06:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbdJFGDw (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 02:03:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750732AbdJFGDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 02:03:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DFCBAAF54;
        Fri,  6 Oct 2017 02:03:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IqV/WMFu+uPjg8tlZD+OyxL08os=; b=U0xiJ2
        bPb6RxMFI8J58W74Mm/J6K6xseF+0aonP+hTvRcEykSATYHDI3tfagzb2tjo7OZb
        XY3M+4RHynPWLGyQTiIUvOdenXHlLpqjKP/4NpdSyLrq5vOF7qqCnU8eg3HZauFa
        CZv+pvugfktT5tZOwIxn7jTLS5zZYgYz7W/ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sWV83lsdOEL++FHBYl+2q2x3nRRfR2IK
        s0U2TcG7EqgRDA4L7xs8+l2buNFPXcd8NNHByCOTSHJRrur09aYfQT7wf/mcwic+
        OpAtwUYp423NeJ1eVrZODaKZGWG/yHd27MLia0wNX0qdBySw28LOS/Xuql/FLM+Y
        UsjNBWhTnlo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15DB1AAF52;
        Fri,  6 Oct 2017 02:03:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84A53AAF51;
        Fri,  6 Oct 2017 02:03:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
        <20171005104407.65948-3-lars.schneider@autodesk.com>
        <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net>
        <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com>
        <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net>
Date:   Fri, 06 Oct 2017 15:03:49 +0900
In-Reply-To: <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Oct 2017 00:56:40 -0400")
Message-ID: <xmqqd160x16i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FD0BB0A-AA5C-11E7-8501-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't know if we wanted to capture any of the reasoning behind using
> error() here or not. Frankly, I'm not sure how to argue for it
> succinctly. :) I'm happy with letting it live on in the list archive.

Are you talking about the "philosophical" thing?  

Because we cannot quite tell between the two cases (one is error--we
wrote or we thought we wrote, but we cannot find it, the other is
dubious--somebody was racing with us in the filesystem), I think it
is reasonable to err on the safer side, even though an error abort
while doing "as we know we wrote the thing that match the index, we
might as well lstat and mark the cache entry as up-to-date" might be
a bit irritating.


>> diff --git a/entry.c b/entry.c
>> index f879758c73..6d9de3a5aa 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -341,7 +341,9 @@ static int write_entry(struct cache_entry *ce,
>>  	if (state->refresh_cache) {
>>  		assert(state->istate);
>>  		if (!fstat_done)
>> -			lstat(ce->name, &st);
>> +			if (lstat(ce->name, &st) < 0)
>> +				return error_errno("unable stat just-written file %s",
>> +						   ce->name);
>
> s/unable stat/unable to stat/, I think.

Thanks.
