Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F183EC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A964864DCE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhA1F03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 00:26:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56457 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhA1F01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 00:26:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5510D903C2;
        Thu, 28 Jan 2021 00:25:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5InAGmoerx81wyJlgeFYfKWmVS4=; b=ClMNji
        HHoot8y7NRAmaMJKmed16mOodNcgIsJh2dteEm7jjJozLeh3NJYvc6KqQR3RwD/1
        4cvwpQO5vyiZHLJcA0BvQHjGWilb1TocQXOvASC70nAYjZlquSef38g4QjWaYgty
        ROLJidI5mRFdxwet9S3V2mlQ5YpEXb+ljpAO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xH2zE/nFDFpz/L1UHgSfYTilExsd8Wxy
        ojRC64eFLQKOe8is1eoBteT6RdJKWvz0zx9/hZkKgAYeZIrkuUw+TbioCc2YMglL
        WNHcjZC4wQUxfF1sqblkCjOoo5FpGouUloFBO5QP5pvU+PkqikMQrRF0kmY/3gjS
        MwuGgHFcJrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B842903C1;
        Thu, 28 Jan 2021 00:25:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2C60903BE;
        Thu, 28 Jan 2021 00:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/27] sparse-index: implement ensure_full_index()
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
        <ebbe8569dcc16f2ae235c4167be0e72a53982982.1611596534.git.gitgitgadget@gmail.com>
        <CABPp-BE3tLmfwyncbdTKZUgLYH_8M9zMjH=+LJG4bdGcbYDPMg@mail.gmail.com>
Date:   Wed, 27 Jan 2021 21:25:42 -0800
In-Reply-To: <CABPp-BE3tLmfwyncbdTKZUgLYH_8M9zMjH=+LJG4bdGcbYDPMg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 26 Jan 2021 19:05:10 -0800")
Message-ID: <xmqqmtwty6nd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44A5C15A-6129-11EB-880D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  1. ce->ce_mode == 01000755
>
> This is a weird number.  What's the reason for choosing it?  It looks
> deceptively close to 0100755, normal executable files, but has the
> extra 0, meaning that ce->ce_mode & S_IFMT is 0, suggesting it has no
> file type.
>
> Since it's a directory, why not use S_IFDIR (040000)?
>
> (GITLINK does use the weird 0160000 value, but it happens to be
> S_IFLNK | S_IFDIR == 0120000 | 040000, which conveys "it's both a
> directory and a symlink")

Yes, that combination of IFLNK/IFDIR was the reason why we use the
value.  I tend to think IFDIR is the best thing to use here.
