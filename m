Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD32C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0936100C
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhCaSCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:02:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60368 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhCaSBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:01:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDC6DC772C;
        Wed, 31 Mar 2021 14:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=odNodEp/TTS74buhiAGQhy1t+0o=; b=IkxGbm
        4mJ7YYoM9uuR2LSAJmp8RzO+ZIcabJRt9XvT/4ST02r9MzLsETFAC+e3UbRHQW4t
        NP1paUI+cVuJPIWUkuIQwf6asrhehDuQ6wltANuAH/xxCh/pLj1OH1UpLSVWnvOz
        YpTgj5jPOBrFMtIw8hrC1AY2Qaz2WVrgjDREY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=plrJlveZiRPMjRhpkRckVVCOu36oq2cN
        e7dr6HGWNuZZ/9Um26pWAEQ+ogNlHS7lDU6V8PXBbStNmUnskQMb8NptcB0Jg6oI
        sH10XTWlgM5ZWQdqiYcuYc8QlLFAZsPBEPBiIVuVpspOv4W6234DsLKI93ymfeoJ
        8L/M6143GbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3417C772B;
        Wed, 31 Mar 2021 14:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31B68C772A;
        Wed, 31 Mar 2021 14:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
        <xmqq7dloeawf.fsf@gitster.g>
        <CABPp-BErXWkEOCyZtYP9AHd9eP2osL4s1xjMZ_BRkGSktdFnKg@mail.gmail.com>
Date:   Wed, 31 Mar 2021 11:01:51 -0700
In-Reply-To: <CABPp-BErXWkEOCyZtYP9AHd9eP2osL4s1xjMZ_BRkGSktdFnKg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Mar 2021 13:16:51 -0700")
Message-ID: <xmqqmtuj8ank.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BEF8918-924B-11EB-842C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ... would you two prefer
> that I add a new affirm() function that is ALSO compiled out in
> production?

The reason I do not think affirm would fly is because it shares the
most problematic trait with assert(): it can be comipled out.

There was at least one bug we found and fixed in a piece of code
that came later in a codepath that had an assert() in it.  The buggy
code (IIRC, it was added way after the assert() was written in an
unrelated patch) was unknowingly depending on a side-effect of an
innocuous function call (i.e. assert(func_tion(args) == expected))
made in the assert condition, and the bug did not reproduce in the
developer's environment.
