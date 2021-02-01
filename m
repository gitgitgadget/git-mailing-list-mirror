Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF4C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C0864E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBAWHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:07:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61163 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhBAWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:05:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9241DB44CF;
        Mon,  1 Feb 2021 17:05:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J7d7yFJwxO4Bp+MK9TRODCcyOdM=; b=atR4Vs
        qt5JojmR50ZAFgClmWjNhqSqvgRKmBMcMpxHgVa+xEqYp+uJJ03nraKCNfdIAX6k
        QsJZ0MvaxlhNlYZZNrKAy2YlgWE2iuLO4fRy+8H5KG0BWAWq8f/Hr3AFGbUsmi5p
        RkS2yFZKQ33v8DjHoTYwUnVBOfTEjVu61Acqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mKwUPAjMH65knbpXf9n/XCMQq6xO0JZ1
        iYyjLRrDfbQ87DtzZh+/7gq/e90qYZfi9XX8CqK14Dq/rRqRSx1rXn/+fYHYQ1fj
        134eOCFE5ouhwsDxUfgc9yTo/anKTKlYb2lpRRaM7DusbDgWpIsPaU47LpByTDtl
        ASeeFWJA04A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A2EBB44CE;
        Mon,  1 Feb 2021 17:05:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE862B44CC;
        Mon,  1 Feb 2021 17:05:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 02/17] am: convert applypatch hooks to use config
References: <20201222000435.1529768-1-emilyshaffer@google.com>
        <20201222000435.1529768-3-emilyshaffer@google.com>
Date:   Mon, 01 Feb 2021 14:05:11 -0800
In-Reply-To: <20201222000435.1529768-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 21 Dec 2020 16:04:20 -0800")
Message-ID: <xmqqsg6fjvfs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E004358-64D9-11EB-9F71-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
> hook.h library instead of the run-command.h library. This enables use of
> hooks specified in the config, in addition to those in the hookdir.
> These three hooks are called only by builtin/am.c.

I was interested in the applypatch-msg the most; it gets fed the
"final-commit" file as its input and expected to modify it in place,
so if you allow two or more to work in series, you do not have to
anything extra (like swapping the output from the previous step to
the input for the next step), which makes this a relatively easy
conversion.
