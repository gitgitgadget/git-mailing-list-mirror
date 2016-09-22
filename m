Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8711F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941099AbcIVSV0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:21:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53739 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S937229AbcIVSVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:21:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A44263FBB2;
        Thu, 22 Sep 2016 14:21:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zcmxpvj63toVB49zc1UF6PAj7OI=; b=xxKJqB
        CoJSmikUtsc71ucYwkWKQFhaRgLwS4IGZDEzWyAM7dULZUmwjqDh/z+ZHPcc6WTq
        xUyuJFlZgXopEvvfr4EM1sjFcljK9CoHSwlsmer3Fx6vVRYUJ1DQHR/F64oWpUwh
        ASyWe4dNczRG9Sm0rFcXWIbf3DAJEoWQtmO2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gSSpNBDwGv2YySc3G1eRY71HyKhbHLeZ
        54RgjV8zwtkc0JKdTKVhaTKSIEbY8uPTLy7kAJgkZIhL1E3YWW0gez15j1fSp57Y
        dksj2Lm084Ttyado6HE469gDJtDA8XUnhge3PAj53t6a/SL7ZmRBSTgBrbRRcvQL
        GOAA/obc9cU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 949E73FBB1;
        Thu, 22 Sep 2016 14:21:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C7143FBB0;
        Thu, 22 Sep 2016 14:21:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] verify_packfile: check pack validity before accessing data
References: <20160922034904.dm5okldfmgmin5d7@sigill.intra.peff.net>
        <20160922040523.x3pihbs7f5iudyfz@sigill.intra.peff.net>
Date:   Thu, 22 Sep 2016 11:21:18 -0700
In-Reply-To: <20160922040523.x3pihbs7f5iudyfz@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Sep 2016 00:05:24 -0400")
Message-ID: <xmqq37kr6bj5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C0E3F56-80F1-11E6-87D3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I wanted to know whether there were any code paths that failed to do
> so, and just blindly rely on the lazy-open. Finding the races is
> inherently hard, because you only catch them when somebody else is doing
> a repack. But if we just _remove_ the lazy-load, then it becomes easy to
> catch anybody relying on it. Like:
> ...

Clever; I like it.

> In such a case, we are relying on the lazy-load (and we _are_ racy!).
> But the patch above would punish people on low-descriptor systems. It's
> better to have an unlikely race and complete the request than to fail
> consistently. :-/
>
> For people who are running high-traffic servers, they just need to make
> sure their file descriptor limit is reasonably high to avoid the race.

Thanks for an illuminating backstory for the patch.

