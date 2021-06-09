Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8732EC47082
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6180D61352
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhFIAQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:16:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58840 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFIAQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 20:16:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6240B9E82;
        Tue,  8 Jun 2021 20:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xTjyfioaaFJnKkPGZk57EtnkFJUDCW9nd8lcws
        5uQgw=; b=K0n1j2PE7KIixD8ku8b7BlLz6SbFzNylRUhsoMTrE9NtL4R+f/nqY4
        m90VjKAImwRjmg2Pujp3dbpz8A4I79Y5vePpbaK2X1XexO3HsRLIv/GZzoOD87Rr
        Yl9UgSIM5m7Aqp8hfQuEni6iR1XVUQkQFSBf6xTeLLF79siyivfM8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DD67B9E80;
        Tue,  8 Jun 2021 20:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7632B9E7B;
        Tue,  8 Jun 2021 20:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: use HEAD as primary sort key in
 git_get_heads_list()
References: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
        <20210608211440.37985-1-greg@hurrell.net>
Date:   Wed, 09 Jun 2021 09:15:00 +0900
In-Reply-To: <20210608211440.37985-1-greg@hurrell.net> (Greg Hurrell's message
        of "Tue, 8 Jun 2021 23:14:40 +0200")
Message-ID: <xmqqpmwvnbaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBB41D28-C8B7-11EB-BD61-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greg Hurrell <greg@hurrell.net> writes:

> Prior to this commit, the "heads" section on a gitweb summary page would
> list the heads in `-committerdate` order (ie. the most recently-modified
> ones at the top), tie-breaking equal-dated refs using the implicit
> `refname` sort fallback.

Please lose "Prior to this commit"; when we talk about the state of
the code, we talk about what we have _without_ the proposed change,
so "Currently", etc. are noisewords.

And then we go on to explain why the current behaviour presented in
the first paragraph is undesirable, and how the proposal wants to
change the world to a better place.  That is missing here in the
proposed log message.

And then we give an order to the codebase to "become like so" in
imperative mood, perhaps turn this paragraph

> This commit adds another `--sort` parameter to the `git for-each-ref`
> invocation in `git_get_heads_list()`, ensuring that the `HEAD` ref
> always ends up getting sorted to the top, seeing as it is typically the
> "primary" line of development in some sense.

into:

    In addition to sorting with committerdate (most recent first),
    first show the primary branch that is pointed at with HEAD, by
    adding another `--sort` parameter ... 

> This seems to be a useful change, because I can't see anywhere else in
> the gitweb UI where we actually indicate to the user what the "default"
> branch is (ie. what they'll checkout if they run `git clone`).

The justification is a bit too weak to convince readers that using
%(HEAD) as the primary sort key to list the branch first in the list
view is *the* best way to solve the "it is unclear which one is the
defaul branch" problem, though.  An obvious alternative would be to
show '*' next to such a branch just like "git branch --list" does,
without changing the sort order at all, for example.

I am not sure if using it as the primary key is a good idea, though.
Wasn't your motivating example about tiebreaking between 'main' and
'master' that always point at the same commit?

> +		($limit ? '--count='.($limit+1) : ()),
> +		'--sort=-committerdate', '--sort=-HEAD',

Comparing %(HEAD), which is either ' ' or '*', for each ref?  It is
beyond "cute".  Nicely done.


