Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F091F461
	for <e@80x24.org>; Mon,  9 Sep 2019 16:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfIIQjs (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 12:39:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63782 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfIIQjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 12:39:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 925A56899C;
        Mon,  9 Sep 2019 12:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=njt3Q8dVOKkdhVxm/rvslnuyrrc=; b=HXQF4P
        bl76QqUGO0y80yi7TME5CBu117gQK7oyaStH5nT8hpEKyFvoV0Q7l6yW/26wlFZY
        uRZWamW/fmxmXnTzpyn1Xo1V7WKJBsECN9qc7jztEbqFlLjSRebB7hXeFPyz5xbt
        lV+NI+dq79AnU+vULjPTuX6ADad5LHhXwW4iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TnPiy6rLnk1jngdZf+YnpIGIlxUTRZEP
        KNr+ingtFGSXXQLcb2sdxOEi5mwHxpqECDP1eMgHNt4UmoezfmxcgdmghIM+e/sF
        Oi0jd8EXI5Hlc7nSWwtBWHwIpS5IB9WRlqgHpzeSa9sO3WiPWvX5UGMvx5QuTZxv
        vcLoyXMjMAU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A79C6899B;
        Mon,  9 Sep 2019 12:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B72E568999;
        Mon,  9 Sep 2019 12:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
References: <cover.1567563244.git.me@ttaylorr.com>
        <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
        <20190904030456.GA28836@sigill.intra.peff.net>
        <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
        <20190906063503.GB5122@sigill.intra.peff.net>
        <xmqqk1alnyxz.fsf@gitster-ct.c.googlers.com>
        <20190906170451.GB23181@sigill.intra.peff.net>
Date:   Mon, 09 Sep 2019 09:39:41 -0700
In-Reply-To: <20190906170451.GB23181@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Sep 2019 13:04:52 -0400")
Message-ID: <xmqqzhjdl8z6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D4CD5C8-D320-11E9-A368-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 06, 2019 at 09:59:04AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So far so good. But now imagine we call parse_commit_buffer() again, and
>> > we re-parse. How does that interact with the half-parsed state? Some of
>> > it works OK (e.g., lookup_tree() would find the same tree). Some not so
>> > much (I think we'd keep appending parents at each call).
>> >
>> > I guess this might not be too bad to handle. Value fields like
>> > timestamp_t are OK to overwrite. Pointers to objects likewise, since the
>> > memory is owned elsewhere. If we see existing parent pointers in an
>> > object we're parsing, we could probably free them under the assumption
>> > they're leftover cruft. Likewise for the "tag" field of "struct tag",
>> > which is owned by the struct and should be freed.
>> 
>> Yeah, or clear them before returning with .corrupt bit set?
>
> This was my attempt to avoid dealing with a .corrupt bit. :)

Then, clear them before returning with .parsed bit clear?
