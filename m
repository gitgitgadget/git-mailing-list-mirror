Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ADFC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiGLOQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiGLOQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F048BA90
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 07:16:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8455F131D17;
        Tue, 12 Jul 2022 10:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pjTrE8yqVqA2zQSQxX2vJJ1ANXLkgkqP80gd5Y
        +n7hg=; b=jj9yi2JM8YZHTsoIO5zG3Oc6JWGZtFgnu6ux5se9rSDK3m1DQRQQfZ
        GR3nDmyasEahg2JjBczpnPVWvnby9neoR5riT4utvP7vNi3nqQXbeCHgzh44Xkbh
        8gN1VC1lZUCN8im179UUdv2lmdCmnTgHArjMTVu82W5lIUzfr0z4M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B2B3131D16;
        Tue, 12 Jul 2022 10:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3C8A131D15;
        Tue, 12 Jul 2022 10:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH v3 0/4] Add support for mailmap in cat-file
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
        <20220709154149.165524-1-siddharthasthana31@gmail.com>
        <xmqqv8s5sf8x.fsf@gitster.g>
        <50s3714q-8p5n-2379-65r4-17304426rp93@tzk.qr>
Date:   Tue, 12 Jul 2022 07:16:16 -0700
In-Reply-To: <50s3714q-8p5n-2379-65r4-17304426rp93@tzk.qr> (Johannes
        Schindelin's message of "Tue, 12 Jul 2022 14:34:38 +0200 (CEST)")
Message-ID: <xmqqwnciifgv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3233CA1A-01ED-11ED-B8E9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch introduced new test cases that rely on the side effects of
> the earlier test case `set up symlink tests`. However, that test case is
> guarded behind the `SYMLINKS` prereq, therefore it is not run e.g. on
> Windows.

Ah, that explains why it only fails there.

> Let's fix that by removing the prereq from the `set up` test case, and
> adjusting its title to reflect its broadened responsibility.
>
> -test_expect_success SYMLINKS 'set up symlink tests' '
> +test_expect_success 'set up symlink/--use-mailmap tests' '
>  	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
>  	echo "New <new@example.com> <orig@example.com>" >map &&
>  	rm -f .mailmap

OK, this sets up

 * one commit that can be used in a test, authored by "Orig" person;
 * the "map" file that maps the "Orig" person; and
 * ensures .mailmap is not there.

with the intention to make a symbolic link that points at the "map"
to use as the mailmap file in later tests.  This step does not require
symbolic links at all, but because the point of this set-up is to serve
the later tests, all requiring symbolic link support, it was OK to have
the prerequisite.

The cat-file tests does not have to use the "map" file to do its
thing at all.  In fact, these tests prepare their own .mailmap file
inside them.  But because it chose to run in the history prepared by
previous tests, it broke, because without SYMLINKS, the sought-for
commit does not get created.

Makes sense.  I would have retitled it to s/set up/prepare for/ but
that is minor.

Thanks.  Siddharth, please squash the fix in when rerolling.

