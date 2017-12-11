Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720591F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdLKXpG (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:45:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54040 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751512AbdLKXpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:45:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C669BBA71;
        Mon, 11 Dec 2017 18:44:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SC+C/Jp1c39I6ajFcCqp9/7yRaE=; b=GdhOte
        OzbAFBf3uWJgjOTB55fpQeGhudJgkVHXFy5NqdpTxKe0PBsL34QE9z+if1iLvAB2
        r6UXTWrQq3ePVuLN1E7+WFBcAibQwk3JT7TYg6JQNZUaSU4RV8b+m7py6hmyfK7y
        E9s3QR1W9kXPzl4K89SFsVvQ5ZvXGXoACzk00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FK9rF60fiy3zx5qgjFOIZKwrkSYCeuSc
        n/Wh7COJCOgtTVRk/dhZCasXVh6QtoPeUhpYqMuKOTasv1ACM/52hSCqmpPzK5HZ
        Q/TrCQ0eN6D9jwacofBzc1vGYDoxQ2/9yd3okmSJChu6J4iDodwmVydHTBA6Ynpp
        8LRlI1trE9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85399BBA6F;
        Mon, 11 Dec 2017 18:44:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E83FDBBA6E;
        Mon, 11 Dec 2017 18:44:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 0/9] sequencer: don't fork git commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171211141330.23566-1-phillip.wood@talktalk.net>
Date:   Mon, 11 Dec 2017 15:44:57 -0800
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 11 Dec 2017 14:13:21 +0000")
Message-ID: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C727EF0-DECD-11E7-99D8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've reworked the config handling since v4. It now stores the default
> values in struct replay_opt rather than using global variables and
> calls git_diff_basic_config(). Unfortunately I've not had time to
> modify git_gpg_config() to indicate if it successfully handled the key
> so git_diff_basic_config() is called unnecessarily in that case. Within
> git_diff_basic_config() userdiff_config() also suffers from the same
> problem of not indicating if it has handled the key.

Ouch.  I thought we agreed that we were ready to go incremental and
the topic was merged to 'next' earlier last week.

After scanning the difference between the two rounds, it seems that
the more important difference is the rework of the configuration,
which looks better thought out than the previous round, and with
associated change to use replay_opts fields instead of free variables
to carry gpg-sign and cleanup-mode settings around, which also looks
sensible to me.

Can you make these differences into incremental "that earlier one
was suboptimal for this and that reasons, let's make it better by
doing this" patches to queue them on top?

Thanks.
