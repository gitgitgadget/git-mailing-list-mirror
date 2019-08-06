Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979E71F731
	for <e@80x24.org>; Tue,  6 Aug 2019 18:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfHFSOf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 14:14:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64274 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFSOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 14:14:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 055F4158A99;
        Tue,  6 Aug 2019 14:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ABKGbfrcALDO9L90TeP/9U//bDk=; b=vBx+cI
        vfOMC0cI5lC7LPXmFzecDvZlSsCludgRQrhzGYneHNuHG2iNh/OF1x7B8GoiZiH4
        EkhrT9jdNEhsCn6ttMnOLX/TrpdeNu4BLkiJUN5r54op1EY4008GWwIz2t9t9TcP
        URB4QGdoL2sAxpgb/FTNjSsljl2ZDmEW3z0JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JZBzPlcjT2Tlcz1ECZBTP1HEXWHPafqe
        BOsiZrQtO7EVVyU/jHmku8kKFcjQRq0AAv0PmkwiMVHaezY1GkiraAMjOSLCq8ie
        vTbgUHpxJOjukX6lMVMFbMRQEbASa3a42Z4+MftZ8RpShePp61pCMDptS8nJpnfG
        sfFIvPZecJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFD87158A98;
        Tue,  6 Aug 2019 14:14:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 563EB158A96;
        Tue,  6 Aug 2019 14:14:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@grubix.eu, martin.agren@gmail.com
Subject: Re: [PATCH v4 1/4] t7503: verify proper hook execution
References: <cover.1564695892.git.steadmon@google.com>
        <cover.1565044345.git.steadmon@google.com>
        <50857290955c5467ef6f75083395c695340fa284.1565044345.git.steadmon@google.com>
Date:   Tue, 06 Aug 2019 11:14:27 -0700
In-Reply-To: <50857290955c5467ef6f75083395c695340fa284.1565044345.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 5 Aug 2019 15:43:36 -0700")
Message-ID: <xmqqk1bqjh4s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 078B0738-B876-11E9-930D-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> t7503 did not verify that the expected hooks actually ran during
> testing. Fix that by making the hook scripts write their $0 into a file
> so that we can compare actual execution vs. expected execution.
>
> While we're at it, do some test style cleanups, such as using
> write_script() and doing setup inside a test_expect_success block.
> ...

The result mostly looks more pleasant compared to the original,
modulo a few nits.

>  test_expect_success 'with succeeding hook' '
> -
> -	echo "more" >> file &&
> +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
> +	ln -s "success.sample" "$PRECOMMIT" &&

Not all systems that want to run Git are capable of symbolic links.
We should be able to do a copy here, perhaps?  Just the most basic
form of "cp" without even "-p" would be sufficient as the target is
expected to be missing (i.e. "cp" or "ln -s" would be creating the
"$PRECOMMIT"), right?

