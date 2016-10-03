Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6AC207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbcJCWwt (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:52:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751400AbcJCWwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:52:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B22543002;
        Mon,  3 Oct 2016 18:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w2fEhmbWnGzcPJw93Og2L3ytw3c=; b=wPHbo3
        +Z9lzcV4hUe+C7krut5UHDdLkjD5ghMQMHAZLKu54gsmCOUtERsitusXfSA8BG+X
        wvoDxa+e6Tqqr1iAavUBShoDYH46JraOG72U6d6c3PkTa6RisHcKsO4vTMigCAMx
        ycRoD1w6hPmlDa9RyBou8v2I1vlrMVfS5sx2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NtO+jTNLe7ijgcpII8wVEJXTMEip7bBG
        bi6nFdwOwYWK95wURBD2DmiT+azrVBuLUD7g/VfA5pcA9yryZ/kmL1pCta4QlqsI
        Vi3lInCCgE+hJjjwTJK+LVf57KLomHr3PAhK+fuD+yhFwX5KFrSnmTgMpkn8vbaz
        mTRzVVRKcYs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93F0B43001;
        Mon,  3 Oct 2016 18:52:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17B9944FFF;
        Mon,  3 Oct 2016 18:52:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
References: <20161001001937.10884-1-gitster@pobox.com>
        <20161001001937.10884-4-gitster@pobox.com>
        <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
        <CA+55aFydV+9c3-5C03XUj7v_wGJF5NyJNaP6742zLVgZs410FA@mail.gmail.com>
        <20161003224028.ksvwaplxe7a3vtwv@sigill.intra.peff.net>
Date:   Mon, 03 Oct 2016 15:52:44 -0700
In-Reply-To: <20161003224028.ksvwaplxe7a3vtwv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 18:40:28 -0400")
Message-ID: <xmqqoa313v0j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19CD117A-89BC-11E6-B0C8-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 03, 2016 at 03:34:03PM -0700, Linus Torvalds wrote:
>
>> On Mon, Oct 3, 2016 at 3:27 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > +       if (len < 0) {
>> > +               unsigned long count = approximate_object_count();
>> > +               len = (msb(count) + 1) / 2;
>> > +               if (len < 0)
>> > +                       len = FALLBACK_DEFAULT_ABBREV;
>> > +       }
>> 
>> that second "if (len < 0)" should probably be testing against
>> FALLBACK_DEFAULT_ABBREV, not zero. Or at the very least
>> MINIMUM_ABBREV. Because a two-character abbreviation won't even be
>> recognized, even if the git project is very small indeed.
>
> Oops, yes, clearly it should be FALLBACK_DEFAULT_ABBREV. What is there
> would not even pass the tests (it _does_ work on linux.git, of course,
> because it is much too large for that code to be triggered).

OK, as Linus's "count at the point of use" is already in 'next',
could you make it incremental with a log message?

Thanks.
