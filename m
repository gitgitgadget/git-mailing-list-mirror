Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B471F461
	for <e@80x24.org>; Wed, 10 Jul 2019 17:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfGJRxh (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 13:53:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfGJRxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 13:53:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93B617996E;
        Wed, 10 Jul 2019 13:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KguHDX4ViPrHp4JkfwB8+l06Sqs=; b=P0Rv4c
        5Z0fKfC+Un6fR279o1W+bEmNKWCbJUq+pacti1bdKfh4NNIN6v/oYMFV19BLbHXz
        IR7vJWH0c7pdELWoD75c+4EwvNxDOW0Hfi0IT/PfFA334fvxECyw/PRplBL13hTx
        oGsZdORf3sPvyh/Y1F7Hpgvsyhn1VPGlVHEJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bzW9KQD67fGlXjQI03O2aQUDZD4Fx/t7
        XHFJs/NFdqtoQjKRil7mYEgVCSfkGyDZnddfAnWCxEtNu9J2X18BBHyveyaLYkxU
        g3+kvcV54LNH4dpDHaX7pOsD7ZLuphYgGYQC3XgZRmgGzmXRs926ZOr3X9bpTi4u
        PJ4sehh50xo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C0917996D;
        Wed, 10 Jul 2019 13:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE2127996B;
        Wed, 10 Jul 2019 13:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
References: <20190709211043.48597-1-emilyshaffer@google.com>
        <xmqqpnmhu6mh.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 10 Jul 2019 10:53:30 -0700
In-Reply-To: <xmqqpnmhu6mh.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Jul 2019 10:44:22 -0700")
Message-ID: <xmqqims9u679.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1F804D8-A33B-11E9-9C58-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	# the new branch should not have been created upstream
>> +	test_must_fail git -C "$d" rev-parse refs/heads/atomic &&
>
> The new branch should not have been created; if this rev-parse
> succeeded, it would be a bug.

One thing I forgot.  If refs/heads/atomic did not exist, but say
refs/tags/refs/heads/atomic did, the rev-parse would succeed, which
is a rather unfortunate source of confusion.

Of course, we know we have never touched "$d" to cause such a funny
tag, so rev-parse is good enough in practice, but

    git -C "$d" show-ref --verify refs/heads/atomic

would not dwim (its --verify mode was invented specifically for
rectifying this issue with rev-parse, if I recall correctly), and is
more appropriate best-practice version to write here, especially if
we anticipate that future developers and Git users would treat this
line as an example to mimic.

> Up to point, I have no possible improvements to offer ;-)
> Very well done.

So, I lied, but still the tests looked quite well done.
