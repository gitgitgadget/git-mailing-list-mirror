Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E68C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0670207D0
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgLJBof (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:44:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53985 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLJBof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 20:44:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01D63102FA5;
        Wed,  9 Dec 2020 20:43:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ymj+9KbnX9hHSnBZeUBbdxYNCRY=; b=uMaqfh
        EYGFuCfpeVOj4ADQ6qbvrEiOMu3k+wEvL8wdhgtGnf7nfc4CMlc0nrMg/fulvulZ
        DloXPLUoQqm6JGiov/jMeuRMdWXZrO1Nr3kbSu0ub7hZHxAhEVRSMm8Gp/VTY0Gt
        MicGCAkkX7BOZL89ZA8wxywcSndkrhHkH29YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HplJCXhYyjtV6qUQpUi/kC+5Q7LR1PTD
        Z71zEuBwPNe4+j6KC4ql1HBm30CLPx+QdtvMIg/kTAbMiBSZSiy47nz1eswvcm6C
        ynA4h7jMImh9GK8HF7K66Ge55uaJuTPiobDaN5V7J3mRRK29LZCrzoY+Adf0oqGf
        yJk0UD1s2jo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE896102FA4;
        Wed,  9 Dec 2020 20:43:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 469A3102F9D;
        Wed,  9 Dec 2020 20:43:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] Accelerate rename_dst setup
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <3e83b51628b6f3aeb71c5e637eca03dd63f9e95f.1607223276.git.gitgitgadget@gmail.com>
        <X9FXPHUZJAZKSset@nand.local>
        <CABPp-BEhVK9mMsqS-6Yg2ad5nG0=Pm5by80d9nrHKFp2hrMSBw@mail.gmail.com>
Date:   Wed, 09 Dec 2020 17:43:48 -0800
In-Reply-To: <CABPp-BEhVK9mMsqS-6Yg2ad5nG0=Pm5by80d9nrHKFp2hrMSBw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Dec 2020 16:57:02 -0800")
Message-ID: <xmqq1rfyzb8r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26EEAB52-3A89-11EB-89AB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> It's identical for runtime correctness, yes.  But the primary point
> isn't what happens at runtime, but what happens when future code
> readers come along.  If I only keep the "if (dst->is_rename)" line
> that comes after without the assert, then someone in the future will
> come along (maybe even myself) and think "the original author wasn't
> being careful here; they should change this to a check on (dst &&
> dst->is_rename)" (because honestly, it is the kind of mistake I'm
> prone to make).  However, if they were to do so, and some bug gets
> introduced so that locate_rename_dst() returns a NULL for a pair of
> interest, then they've masked a bug in the algorithm and made it fail
> in harder-to-detect-and-track-down ways.  I wanted it to be clear that
> dst == NULL is unacceptable.  I guess I could have marked it with
> BUG(), but between an assertion and a NULL-pointer indirection, I
> figured that code aborting under that condition was pretty well
> covered.  :-)

assert() often gets turned into no-op, so it is more like leaving a
comment in the code.  A comment or BUG("text") can describe not just
the fact that reaching this point with dst==NULL is a bug in the
caller but also why it is a bug (e.g. how NULL-dst would screw up
the computation downstream from this point), but an assert() cannot.

