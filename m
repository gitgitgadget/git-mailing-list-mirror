Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA42C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17FC61029
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhDSXRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:17:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64419 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhDSXRa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:17:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4BBFC91D3;
        Mon, 19 Apr 2021 19:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8f1kNiNFtataJ0yABUXMwXImdxw=; b=cwI+XS
        LWdxHLt2jC1qb4TEFSgN5FJTuuZSb0oQtN7yGzrWBAk0pJKpKvceqFl1ydY8eFhY
        PPPGMpKU6dFzwne2WBmokGQRiHlhH8p0O+dYlldqCKNiIe4/twK/TfPB+FhPYgMg
        8NeGXRXVXfWiazGngS/A0qiG5verT2JKXSclM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y8rifrvKnJIkBeNJfX+70DsQx+tADhAu
        r62PUJQMwycwbZhB/pZFVjh38aq0epG5kF5hcaoIA1OlhQmiFDjSAbqzqtwku6ke
        WNIPsikETECeifI/9gyI4XC5D+ybbPl5HvDnSOWd/QGF2zoECNtAdD6LJxXU6hEg
        4U7xrtSN3Os=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E3CC91D2;
        Mon, 19 Apr 2021 19:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F3CBC91D1;
        Mon, 19 Apr 2021 19:16:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/8] rev-list: implement object type filter
References: <cover.1618234575.git.ps@pks.im> <cover.1618832437.git.ps@pks.im>
Date:   Mon, 19 Apr 2021 16:16:58 -0700
In-Reply-To: <cover.1618832437.git.ps@pks.im> (Patrick Steinhardt's message of
        "Mon, 19 Apr 2021 13:46:32 +0200")
Message-ID: <xmqq1rb5985x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 573A70AA-A165-11EB-AC31-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the fifth version of my patch series which implements a new
> `object:type` filter for git-rev-list(1) and git-upload-pack(1) and
> extends support for bitmap indices to work with combined filters.
>
> Changes compared to v4:
>
>     - I'm now explicitly passing `strlen(v0)` to
>       `type_from_string_gently()` to be prepared for the future
>       semantics change here.
>
>     - The error message printed in case the user passes in invalid
>       object type to `--filter=object:type=` now prints the wrong
>       value passed by the user.
>
>     - Fixed missing header in list-objects-filter-options.h.
>
>     - Tests now use test_create_repo and test_commit.
>
>     - Removed a needless subshell in the tests.
>
> I hope that this catches all feedback and that I didn't misunderstand or
> miss something. If I did, please give me a shout!

Thanks.  Will queue and wait.

I am expecting to go offline for about a week starting 21st or so;
hopefully the topyc is ready to merge it to 'next' by the time I
come back online.

