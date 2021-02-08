Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA8C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4F064E82
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhBHViM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:38:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53821 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbhBHVhd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 16:37:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D7A5A7E73;
        Mon,  8 Feb 2021 16:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3xxSU8yTD1ICjmJCtlfowGY+/3M=; b=ceUuQs
        p1NxKkdQp/Edj7oD/hlkH+8qpyTjW89w2ETILWLhRdrI7+ecc504qAqe0xgynFdI
        cWTZk+06MWBZoSJDAmX5SPB2n15KEYVjfIT2LAcZJD7Vr2deg4WO7buoS1TkUjxB
        Q5vRn/PxOoFLXMNgo8p3jCk2ZNIG++7X7qbEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sRiqytctaiFkj9+97AKs+fnV1XJDrdmq
        B3CEGTBVjCRckgkl+yx6o+DjQrGWkPyau41J4LHO7si9Jwj689ANoLQuUdn6MFKT
        3vcKEpH8FGn16i9Z31An+/fYQxPFshWRytDJiaW93lf0hKZW0DPsO/0s60D7SIrb
        11mOVy4Fvg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 925B0A7E72;
        Mon,  8 Feb 2021 16:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02883A7E70;
        Mon,  8 Feb 2021 16:36:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 04/11] t/lib-rebase: change the implementation of
 commands with options
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210208192528.21399-5-charvi077@gmail.com>
Date:   Mon, 08 Feb 2021 13:36:43 -0800
In-Reply-To: <20210208192528.21399-5-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Tue, 9 Feb 2021 00:55:22 +0530")
Message-ID: <xmqq1rdq5jis.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCFBFC7A-6A55-11EB-A0C1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> However, "fixup" is very different from "exec". Its arguments are not
> arbitrary at all, so there isn't a good reason to mirror the choice of
> "_" to represent a space, which leads to rather unsightly tokens such
> as "fixup_-C". Let's replace it with simpler tokens such as "fixup-C"
> and "fixup-c".

Sadly, I have to say that this change may be making the developer
experience worse.

To use the original, test writers only need to remember a single
rule: "when a single command needs to embed a SP, replace it with
underscore" regardless of which insn they are listing in FAKE_LINES.

Now they need to remember that rule only applies to exec, and merge
and fixup uses a different rule, namely, a SP immediately before a
dash must be removed.

So, if I didn't know you folks have invested enough hours in this
patch, I would have said not to do this, but it is such a small
change, its effect isolated to only those who would be writing tests
for "rebase -i", it may be OK to let them endure a bit additional
burden to remember an extra rule with this patch.  I dunno.
