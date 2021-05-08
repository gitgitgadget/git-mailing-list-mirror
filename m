Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055C8C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8567611ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEHKUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 06:20:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54589 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHKUU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 06:20:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17043B8917;
        Sat,  8 May 2021 06:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AsFRoJfYDgEz8Z6c65Yj10Xp7gk4arzCM9xbeA
        QLtIA=; b=m99vMZU19fMGUZeAl6iYeHigEswKkir1vepchhpp4yt5J5wzYdN3Hm
        c9+w1X1t01LUjaiiOxxdcfNn3+/FelB839dfAiHe8kcetRVoCZ+kRSNs6I5R+Y52
        aS6GPxktbCg9hWDqQJEkIXCBvZlp0KcreviYfSuZNf2sp5fj9SGA8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D553B8916;
        Sat,  8 May 2021 06:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D21CB8914;
        Sat,  8 May 2021 06:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/8] t7300: add testcase showing unnecessary
 traversal into ignored directory
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:19:18 +0900
In-Reply-To: <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        00:08:13 +0000")
Message-ID: <xmqq8s4pv87t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D92E7338-AFE6-11EB-8EAF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		# alpine-linux-musl fails to "rm -rf" a directory with such
> +		# a deeply nested hierarchy.  Help it out by deleting the
> +		# leading directories ourselves.  Super slow, but, what else
> +		# can we do?  Without this, we will hit a
> +		#     error: Tests passed but test cleanup failed; aborting
> +		# so do this ugly manual cleanup...
> +		while test ! -f directory-random-file.txt; do
> +			name=$(ls -d directory*) &&
> +			mv $name/* . &&
> +			rmdir $name
> +		done

Another thing: this not being a test_when_finished handler means it
would not help after a test failure.

Perhaps wrap it in a helper

    clean_deep_hierarchy () {
	rm -fr directory* ||
	while test ! -f directory-random-file.txt
	do
		...
	done
    }

and call it from test_when_finished?
