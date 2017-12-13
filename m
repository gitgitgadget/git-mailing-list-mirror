Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B0B1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 20:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbdLMUyr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 15:54:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50195 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752908AbdLMUyr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 15:54:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A83FEB8944;
        Wed, 13 Dec 2017 15:54:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WK4pHzDE19w8UFyfh1ZGwqkvwwc=; b=P5OjmL
        rdG+HltFN6QZxE/bGnqzD6KpIu/6KABuCn4rZsmYUZlRO4gWxn8irrrhyKcBaDPM
        hREMRMVFaVyVV1EF2XMXTUc68OQc2jAgGN5J2UE96IOnNERlB6vOyXYlayHZCgaZ
        4ltS5LDvAKlVqYLNugHb8oekWg2Ljpb0nPnqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V5SUMdtm3Nv3nBVH2XK3m0DKRbKA7ny9
        znu/iIZUo7HYFHqIgiUc3JhCMg7wdDeHw+hUDY4bIkNcwBji0Bzu8HXAhzKb6dXf
        u78UzGr3k2NM3ivGJ+0E5DucPrj/8aSDVvLdQlIHhK8Ioy6VLLRgb7bvJBsGm+SJ
        DUIAyG+SEDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0EBAB8942;
        Wed, 13 Dec 2017 15:54:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07DADB893F;
        Wed, 13 Dec 2017 15:54:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/8] perf/run: use $default_value instead of $4
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
        <20171213151344.2138-5-chriscool@tuxfamily.org>
        <xmqqbmj2wedd.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 13 Dec 2017 12:54:44 -0800
In-Reply-To: <xmqqbmj2wedd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 13 Dec 2017 12:40:30 -0800")
Message-ID: <xmqq4louwdpn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9E6B370-E047-11E7-AECF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you want to be able to use this helper to specify a default value
> of an empty string (which the orignal that used $4 did), then the
> previous hunk must be corrected so that it does not unconditionally
> set default_value to $4.  Perhaps like
>
> 	if test -n "${4+x}"
> 	then
> 		default_value=$4
> 	else
> 		unset default_value || :
> 	fi
>
> or something.

And if you do not care about passing an empty string as the default
value, then the earlier hunk can stay the same

	default_value=$4

but the eval part should become something like

	test -n "$default_value" && eval ...

Given that you are planning to add yet another optional argument to
the helper, and when you pass that variable, you'd probably need to
pass "" as the "default" that is not exported, perhaps this "give up
ability to pass an empty string as the default" approach may be the
only thing you could do.

