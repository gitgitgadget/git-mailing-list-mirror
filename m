Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB5C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F322225E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wK+Ku3sE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKCAV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:21:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55112 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKCAV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:21:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BE0E90706;
        Mon,  2 Nov 2020 19:21:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=GTz70FQWOsTQoXxYVL+kMLJc37Q=; b=wK+Ku3sE9IyVONEyO/yq
        f7sTpGcvtgYSYMPW2tkWBTew1C+kxLlAccYJv6Wnz/rkIEKW5c2CgopOXNcCElrh
        PB5J3NKMwx9NAAvMfa/8+lwMV0L8djptmz5ORqVDmh/gx0GRLgjpB4wpet7vz0cq
        x70/cQWH9fiGjQTJvaWpuWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=QzfSHZ7Tyfm1MpybRmDm+VyFrF2JfPW8AbrSgjLmW3+Z0Q
        BEs4Wbuv03wxaD71rRGQF3+lwA3Ir/ZywEn63zcFFwvNPnezf3n+IvWpR7yiRZrL
        ZErcaIb3dcstiZh65mnJifL+BqmEeEWBOiD/eKTfeRMXmSut6JJ3q79UMRYCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13B4590705;
        Mon,  2 Nov 2020 19:21:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9598E90704;
        Mon,  2 Nov 2020 19:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "herr.kaste" <herr.kaste@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
        <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
        <xmqq7drbbcj5.fsf@gitster.c.googlers.com>
        <CAFzd1+7wzPZa9brWzWzSQdcMEnbEcV28zqBBAV_rsdsKNaKaFg@mail.gmail.com>
Date:   Mon, 02 Nov 2020 16:21:53 -0800
Message-ID: <xmqqpn4vqogu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93ADA3F6-1D6A-11EB-9709-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"herr.kaste" <herr.kaste@gmail.com> writes:

> Phillip pointed out that ORIG_HEAD is actually not save *if* there is
> a `reset` or `rebase --skip` during the rebase.  Otherwise, by design,
> ORIG_HEAD would be easier to use, as in the form `<branch_name>@{<n>}`
> two things have to be decided and can go wrong.

What "two"?  You should be able to just say @{1} regardless---that
was the whole point of performing all the intermediate steps while
on the detached HEAD so that you can rely on <n> being 1, and @{<num
or time>} is a short-hand of <branch>@{<num or time>} for the
current branch, and not a short-hand for HEAD@{...}, to help such a
use case.

Or am I missing something?
