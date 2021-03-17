Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B505C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F8D64F44
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhCQSYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:24:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55877 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhCQSYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:24:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2718BA88DA;
        Wed, 17 Mar 2021 14:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UbqbevlyPSKvBwNTsft8pa/rkS4=; b=wJQC5f
        8xEE2gWfkqnxzrNMw65wCC4/HN+YCpCcbbV5ir+WAaaCdUJ+iqWFqAV9bOLQTTl5
        27hVmNYTFS2wbcmU27W3SfdSJXiTSYNMYBpKTeb+5kHrJxF+ENqBTNF09Zj8yUkR
        mwNoigtdHmC2aQdrR5I0kuR60FsyY9EvJvjGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dDtufz8wCnfA0rAeZJ3MXjtUAu6zdNFQ
        f6HF8kD0yZq7HmG7XQ2k/LfsYtM57sA/ha16ViUO8uh+z42hgIKtf7C+oOm3HfpS
        vU0eoPNxofAydCOHAKaA4+KA3FD3uhN3RGPrgFFtNUXDI6B1dwkvnK6KrIZNkzxA
        vUymPI904Mg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB7B3A88D9;
        Wed, 17 Mar 2021 14:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD056A88D7;
        Wed, 17 Mar 2021 14:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bisect: peel annotated tags to commits
References: <878s6nz1sg.fsf@igel.home>
        <YFDGX4EsrvHqZgPF@coredump.intra.peff.net>
        <YFDLq9mLbJtLqKea@coredump.intra.peff.net>
Date:   Wed, 17 Mar 2021 11:24:03 -0700
In-Reply-To: <YFDLq9mLbJtLqKea@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Mar 2021 11:15:55 -0400")
Message-ID: <xmqqim5pwse4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F40E3E02-874D-11EB-A080-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Looks like it bisects to 27257bc466 (bisect--helper: reimplement
>> `bisect_state` & `bisect_head` shell functions in C, 2020-10-15), which
>> isn't too surprising. So it broke in v2.30, but nobody seems to have
>> noticed during the last cycle.
>> 
>> I'd guess it's just missing a call to peel the input oid.
>
> Yep. Here's a fix. Again, not new in v2.31, so we don't have to worry
> about a brown-bag fix for yesterday's release. But I do think it's worth
> trying to get onto a maint release. I prepared this patch on top of
> mr/bisect-in-c-3.

Thanks.  Yes, if we ever do another update to 2.30.x, this probably
should be in it, as it is expected that people will start with tags
and not with individual commits.

