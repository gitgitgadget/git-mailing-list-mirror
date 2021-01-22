Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51BC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CB523B06
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbhAVWBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:01:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58611 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbhAVWAb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:00:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D64D395055;
        Fri, 22 Jan 2021 16:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zR8ldKC70Rak2H7pYvWg0T3Qia4=; b=itj6gW
        QLW3SwfQ04iMvraskBK7tGXBCG6KFVYQzgzItPKADERPpGaBoqjye+75d5OWMxiB
        Wcdhs8YA2uoCmwdPFV3KIYRO/77uAURbWZKR5lCdl4epAkP3adQM57WFqfveJaOu
        tTHE2tv3VZtqxtKDmf8hYMnJjwgi1EnMpi+tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iza5HdA20Yk++xB8lehSs1L71py4PY3o
        wyGcd8T3XMyrrPsE5vwEaCW32buk/STZ42Lec9vcYPF34bofMSq/JgIMs/xG90SE
        7SqjpKsXqC+kB6Scp+biLbvhaofuvting4rfa0W1kV/dJXqWAnQTqNOH83haulxx
        3+DRXyhowuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEF4995054;
        Fri, 22 Jan 2021 16:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48B0495053;
        Fri, 22 Jan 2021 16:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] range-diff: refactor check for commit range
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
        <0ce0953a-92b2-2ce6-1e13-6f6240933ce1@gmail.com>
Date:   Fri, 22 Jan 2021 13:59:36 -0800
In-Reply-To: <0ce0953a-92b2-2ce6-1e13-6f6240933ce1@gmail.com> (Phillip Wood's
        message of "Fri, 22 Jan 2021 19:12:54 +0000")
Message-ID: <xmqqbldg7hvb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E81691E-5CFD-11EB-AC3D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +static int is_range(const char *range)
>> +{
>> +	return !!strstr(range, "..");
>> +}
>
> If the user wrongly passes two arguments referring to single commits
> with `:/<text>` or `@{/<text>}` where text contains ".." this will
> give a false positive.

True.  I do not think this aims to be complete revision parser in
the first place, though.

It is tempting to at least idly speculate if an approach to run
setup_revisions() on argument is_range() takes and checking the
result would yield a more practical solution.  I would imagine that
we would want to see in the resulting revs.pending has at least one
positive and one negative, and none of them have SYMMETRIC_LEFT set
in their .flags word.

    Side note: Strictly speaking, people could wish "rev" to mean
               "everything reachable from the rev, down to root", so
               requiring one negative may technically be a wrong
               thing, but in the context of "range-diff", I am not
               sure how useful such a behaviour would be.
