Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E835D1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbfIES5k (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:57:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58653 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732004AbfIES5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:57:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D303284AD2;
        Thu,  5 Sep 2019 14:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9IEVlc74EQ7QYerU7ILtzIjAqf8=; b=aUEGLp
        nIpK7IfmggY3qPYxmFb3L1hgUtkEwk17EXLv65K4kUyxfUGJuOoB1p3Uxdd6mSb4
        gipxm/z6pluLmBtGxhz9LPedZszLg5kzL/a+PE5yi2ARcSZhNbyo0dcOxYH+fqDP
        Xi7Jb5diYnI++NFx0LRQXU2JtCQT/EY2q4Bdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PCgxAtUAXAS/4aEw0haY1fY4N8By0sM7
        U4Pv8rJFm3VlLprPo80gD2Yk+/Q5LELu6cKGMIc9ovC7d7ejZSmEIxdQRvUFSkgw
        MtDqvgtrOAU458D8ukSZKvJVlWxTGQ736sfOLQMzLGsOC4hoKPNjTj3zmL1uohwK
        ETld67CiN0I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB95484ACF;
        Thu,  5 Sep 2019 14:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 015CC84ACC;
        Thu,  5 Sep 2019 14:57:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
References: <20190829231925.15223-1-jon@jonsimons.org>
        <20190829231925.15223-2-jon@jonsimons.org>
        <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
        <20190904045424.GA6488@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 11:57:32 -0700
In-Reply-To: <20190904045424.GA6488@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 4 Sep 2019 00:54:24 -0400")
Message-ID: <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05B3426C-D00F-11E9-94F4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So these patches are punting on the greater question of why we want to
> parse so early, and are not making anything worse. AFAICT, "clone
> --filter=sparse:oid" has never worked (even though our tests did cover
> the underlying rev-list and pack-objects code paths).
> ...
> TBH, I'm not sure why the original is so eager to parse early. I guess
> it allows:
>
>   - a dual use of the options parser; we can use it both to sanity-check
>     the options before sending them to a server, and to actually use the
>     filter ourselves.
>
>   - earlier detection maybe gives us a cleaner error path (e.g.,
>     rev-list can do its own error handling). But I'd think doing it when
>     we actually initialize the filter would be enough.
>
> I.e., if we want to go all the way, I think this two-patch series could
> basically be replaced with something like the (totally untested)
> approach below, which just pushes the parsing closer to the
> point-of-use.
>
> Adding Jeff Hostetler to the cc, in case he recalls any reason not to
> use that approach.

Thanks.
