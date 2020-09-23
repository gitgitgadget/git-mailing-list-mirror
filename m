Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ED9C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B484C20936
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gsFi3jKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWQrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:47:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61797 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgIWQrL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 12:47:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 728E684083;
        Wed, 23 Sep 2020 12:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vl5vGXvg2f+tZVDbFMHaBlsVA+M=; b=gsFi3j
        Kf6rwW5Szs+MPiK2H65jgb9UakP2BdMVcN6MXdHfxrN70tZML/Z2s5iAqYpTGqEQ
        xxmTkFEq2+YTiG3TSApTuCO4OAaHn616xsiRM5bYwwkfLHdu9YhA25pXI6Uplq3K
        E4xGkv91T+Yg0OVSn1fbwJTh3LCGRFCnL1yJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GRfSioxnMHTOBYz69SO5ilopK777zL9B
        zcUNUjnp5eWfbCnPnKvluLngA/rukgai3mQosYKxQwooEX7xnTrAPg4/Ptqpwa7X
        zSScZp/uIgkJkB+cj7iM6k/7x4Ldq3gt7bsd8sfyBIE/nbObirtdWhYAp8ISeU6Z
        we7DRZUC02s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A3E084082;
        Wed, 23 Sep 2020 12:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E23E084081;
        Wed, 23 Sep 2020 12:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
        <xmqqft7djzz0.fsf@gitster.c.googlers.com>
        <20200921084231.GA64896@mail.clickyotomy.dev>
        <xmqqimc7ezk2.fsf@gitster.c.googlers.com>
        <20200923102215.GA70669@mail.clickyotomy.dev>
Date:   Wed, 23 Sep 2020 09:47:08 -0700
In-Reply-To: <20200923102215.GA70669@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Wed, 23 Sep 2020 15:52:15 +0530")
Message-ID: <xmqq1risjv8z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B9E050E-FDBC-11EA-8632-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

>> >   - check if the remote ref is reachable from any of the local ref's
>> >     "reflog" entries using "in_merge_bases_many()" in batches as
>> >     suggested here.
>> 
>> I think it amounts to the same as "does any reflog entry of HEAD
>> reach it?" and shares the same issues with false positives as the
>> first one.
>
> Hmm, isn't this the same as what was mentioned by you earlier (without
> the timestamp:

I misunderstood what you meant with the "any of the local ref" part
of the sentence and mistook it as "enumerate all the local refs and
HEAD, and collect all reflog entries of these local refs, and see if
any of them reach the remote ref".  Re-reading the sentence with
that "any of" refers to "entries" (of a single local ref) in mind,
it is pretty much the same as we agreed is a good way to go.

Thanks.
