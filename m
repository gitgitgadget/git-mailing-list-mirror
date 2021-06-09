Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFDCC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4451F611BD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhFIFa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:30:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56719 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhFIFa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 01:30:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 708EDD41EA;
        Wed,  9 Jun 2021 01:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KrEhnWIbzGS8Ii2L8UiGcMSKje3tfS03657Wb4
        T8Ws4=; b=r3GPw02JbudruCS5y4Tl0SB2dcPoph+A3JYk9dA2hOiBqFwKhknzne
        YeLA9ix9VSazxRJobFDNgUSvMp3S8geQW89QIusO2espivwar40i8DryBI0e35hq
        f7jSVFIT9UkWg0waU/2fwGuAG7DvFqdGhE+UEuA+Er9ORKBzwts6s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 572DDD41E9;
        Wed,  9 Jun 2021 01:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 584B0D41E8;
        Wed,  9 Jun 2021 01:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 3/4] run-command: move envvar-resetting function
References: <xmqqo8chq9g8.fsf@gitster.g>
        <20210609043238.2324303-1-jonathantanmy@google.com>
Date:   Wed, 09 Jun 2021 14:28:31 +0900
In-Reply-To: <20210609043238.2324303-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 8 Jun 2021 21:32:38 -0700")
Message-ID: <xmqqo8cfk3nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87A53522-C8E3-11EB-B7CA-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> It does make sense to move this to run-command.c from submodule.c
>> and the function name is already suitable for being global.  I
>> however cannot help wondering if we should also pay attention to the
>> GIT_CONFIG_KEY_$n and GIT_CONFIG_VALUE_$n pairs (which is not a new
>> problem in this patch).
>
> Note that I changed the function name (the previous one was too
> submodule-specific).

Ah, sorry for a stale mention of that thing---in any case, the name
is suitable for a global.

> As for the config pairs, they are currently being
> passed through - do you have a situation in mind in which they should
> not be passed through?

Wasn't the GIT_CONFIG_KEY/VALUE meant as a moral equivalent of the
GIT_CONFIG_PARAMETERS for those scripts that do not want to bother
following the quoting rules of the single parameter approach?

I do not see why we should filter configuration variables passed via
one mechanism and let variables passed via the other machanism
through.  That feels inconsistent (I suspect that there may already
be inconsistencies introduced when GIT_CONFIG_KEY/VALUE mechanism
was added, though).
