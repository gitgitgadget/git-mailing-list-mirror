Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F0C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C864164FCE
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhBEVSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:18:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhBETAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 14:00:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE68F96481;
        Fri,  5 Feb 2021 15:41:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Jwt8vsBA0QmI0kgX3f8xBMmwMrU=; b=j/h5ENYUBQrWMsclhngg
        FzYpJknMblDrvC9aoYPmUe4+j0nEhC219THCE1ZDFIldEJYYForyvaprpmC2k5rt
        fxQZqtu7p2HcKu+HGAH+3CUV8qyVNcpEo4dpv5up0cQXqKs2faLHPcH7hFbqrf6a
        sJhFUd3a/w23jH44KoozgTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=r6YZGfXgSI5QYA8mKCkF5+FzyVq57Ekfpv5szmJeNUaNRo
        xv9+iM4ebQ3TozPqfzBks2hVVyWZdG9ROJCDEt9RjmGAku9B4C8EZG5LKtAX0eab
        W/cPFIEyxNN/1V96eQVjDDaWU4CfIU1RIluy7LqIaTJXAtOhM2jCi3eENBRYo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3B8F96480;
        Fri,  5 Feb 2021 15:41:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 359A79647E;
        Fri,  5 Feb 2021 15:41:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        szeder.dev@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
        <xmqq8s834c4s.fsf@gitster.c.googlers.com>
        <CAPx1GvcNTkXo-6rdaRc4YNGAq8AoCtwT86AEUT+A6c22erVW0g@mail.gmail.com>
Date:   Fri, 05 Feb 2021 12:41:48 -0800
Message-ID: <xmqqwnvmz1pv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91E5DEB2-67F2-11EB-9188-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Thu, Feb 4, 2021 at 4:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>  * the fourth parameter of add_chunk() is of size_t, not uint64_t;
>>    shouldn't the multiplication be done in type size_t instead?
>
> There are (still) systems with 32-bit size_t (but 64-bit
> off_t / file sizes), so ... probably not.  Is size_t ever more than
> 64 bits these days?

Sorry, you lost me.  I do not see how it would help to perform the
multiplication in uint64_t, when you suspect that size_t is too
small, if the final destination of the result of the multiplication
is a function argument of type size_t?
