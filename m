Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6458AC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF761D56
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhF2EZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:25:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63131 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhF2EZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 00:25:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49798D48F4;
        Tue, 29 Jun 2021 00:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=/punMIIgUVnB+JV7pEsbTKdYbYAGlFtifm3wv904uiw=; b=ETxh
        3txHy1ku1/oF6T2CV0AzL+eEdpHW80zpNAdm78guay5PC2wmrrr6tgsdj0jnf00o
        qriPnkvBQiGolgWdnicIcwQnyfL+C7NW4Z7cSOWxkhpE/Y/n4h8VNFtFmK+QPEy9
        8HQ0Gztmxi6b1u0WAb4jQskvvBMuzUlzwm1d0ns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F038D48F3;
        Tue, 29 Jun 2021 00:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81BD8D48F2;
        Tue, 29 Jun 2021 00:22:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 1/3] Add a second's delay to t7519 for untracked cache
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <c4d2a3cab4bd5243a776002e4f04fead7b1f34c5.1624559402.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Jun 2021 21:22:37 -0700
Message-ID: <xmqq8s2t1er6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A33DAB76-D891-11EB-BC59-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> In t7519 there is a test that writes files to disk, and immediately
> writes the untracked index. Because of mtime-comparison logic
> that uses a 1-second resolution, this means the cached entries
> are not trusted/used under some circumstances (see
> read-cache.c#is_racy_stat()).
>
> Untracked cache tests in t7063 use a 1-second delay to avoid
> this issue. We should do the same here.

We shouldn't waste wallclock time by slowing down tests, which
already take way too much time.  If you can use "test-tool chmtime"
to pretend as if the index file was written earlier than it actually
is, that would be a better solution.

> +avoid_racy() {

Style (see below).

> +	sleep 1
> +}
> +
>  dirty_repo () {
