Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EBC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B73C20737
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZqQdbkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgDAUd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:33:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52527 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 16:33:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 003F5C410E;
        Wed,  1 Apr 2020 16:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6aNG9qU7c+T9pjoMkYkH6F/gBwE=; b=jZqQdb
        kOH79niBZsAQOtrxMoLkPitxoovJBD9arH7gLssAs/xieahJgYOpXXS3lvd8jb0o
        0Ya1/CYEHTimtIGqeXkxnSvsz1PF1olbvgqvLDpb771Tcmu7UzdpPsbQ5VGIYBPc
        /57rHYTZsPwSR5P1FY20IuaKZG7PIIaws+nYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=erNXBK/7I7qmtTJISWQMbqVsid0sqQsw
        cFLx/WyHK2zAlci/NyBhYj1d2mbUDXQ+KQVt//8m+QBFzsB6gq3Fjxu2ZHfFZ9k4
        Bt3CaBSRanYWjK2iDkWBBF69AUKO8++hyPtDKRtu7C6A3ht61HlS1EBAkhMuY/FM
        VHb9GiJrxCs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB97DC410D;
        Wed,  1 Apr 2020 16:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BE10C410A;
        Wed,  1 Apr 2020 16:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
        <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
        <20200401195708.GA3063415@coredump.intra.peff.net>
Date:   Wed, 01 Apr 2020 13:33:49 -0700
In-Reply-To: <20200401195708.GA3063415@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 1 Apr 2020 15:57:08 -0400")
Message-ID: <xmqqk12z54k2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18F0F156-7458-11EA-8BB7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 01, 2020 at 12:49:25PM -0700, Junio C Hamano wrote:
>
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> > diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
>> > index 53b2e6b4555..4e4efcaff22 100755
>> > --- a/t/t5324-split-commit-graph.sh
>> > +++ b/t/t5324-split-commit-graph.sh
>> > @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
>> >  		git config core.commitGraph true &&
>> >  		test_line_count = 2 $graphdir/commit-graph-chain &&
>> >  		test_commit 15 &&
>> > -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
>> > +		touch -m -t 201801010000.00 $graphdir/extra.graph &&
>> 
>> We have "test-tool chmtime" since 17e48368 (Add test-chmtime: a
>> utility to change mtime on files, 2007-02-24) and refrained from
>> using "touch -t" anywhere in our tests.  Can we use it here, too?
>
> There are a couple new ones added last year in t5319. Nobody has
> complained yet, but I wonder if it's a matter of time.

Indeed.  We should fix them (#leftoverbits).
