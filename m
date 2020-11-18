Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0E0C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF9D20870
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KC/boMxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKRSyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:54:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64672 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKRSyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:54:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A271E10DFA5;
        Wed, 18 Nov 2020 13:54:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wTg8AnP3pZH5pOy8l/Tz1e/4bVo=; b=KC/boM
        xn4mzTobw10uKoFwI8nDEqkRco/KHHbpKaopZsjFzNWFGJKdaaTss+qhXGejNJzn
        0AEOJlj5+Dld+YHKL+FXCw3v4h+BAFg8ha0SfBqLiz+qmCBD9pX/yWsPRFZF5F+U
        nRATF82fwUDov508GFUUC5h3i301Ab7DG0a3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pCM+2XaVRuispjGs8ZsvsJ8dEToVZbkD
        AvFLQV24NKLJoPfWUfn82O2yx8zHjhCeFVxaO7T1ObWB0B9cDAXBUEpm2l2R/j36
        00Oq09xe/C6gThy2eSYHjQvFXmxjbszF46biR7H4cNWCk14g3psc0tOHwC3lxWO9
        7laR4UkRmFM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AD3110DFA4;
        Wed, 18 Nov 2020 13:54:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C18410DFA2;
        Wed, 18 Nov 2020 13:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [BUG?] "git config --replace-all key value value_regex" ignores
 value_regex?
References: <466ee1d8-efaa-fc91-f3d9-230672289ffb@gmail.com>
Date:   Wed, 18 Nov 2020 10:54:11 -0800
In-Reply-To: <466ee1d8-efaa-fc91-f3d9-230672289ffb@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Nov 2020 13:07:29 -0500")
Message-ID: <xmqqo8ju1ooc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 736517D4-29CF-11EB-990E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> --replace-all::
> 	Default behavior is to replace at most one line. This replaces
> 	all lines matching the key (and optionally the value_regex).
>
> However, this test fails:
>
> test_expect_success '--replace-all and value_regex' '
> 	q_to_tab >.git/config <<-\EOF &&
> 	[abc]
> 	Qkey = one
> 	Qkey = two
> 	Qkey = three
> 	EOF
> 	q_to_tab >expect <<-\EOF &&
> 	[abc]
> 	Qkey = four
> 	Qkey = two
> 	Qkey = three
> 	EOF
> 	git config --replace-all abc.key four "o*" &&
> 	test_cmp expect .git/config
> '

I do not know or try to guess the original intention (I thought this
is Dscho's thing, no?), but if there are one/two/three and I were
asked to replace all of those that have zero or more 'o' in it with
'four' I would expect that

 (1) all three be removed, because they all have zero or more 'o',
     and then

 (2) one instance of 'four' be added,

resulting in a single 'four' left.

If the value_regex were "o+" (since it takes ERE) to mean one or
more, then my expectation would be

 (1) one and two be removed, because 'three' does not match, and
     then

 (2) one instance of 'four' be added,

resulting in two items, 'three' and 'four'.

An alternative interpretation would be that each of the removed
entries is replaced with a new one, resulting in three entries
(i.e. with "o*", it would leave three identical entries 'four',
with "o+", it would leave 'four', 'four' and 'three'), but that
may be less useful in practice.

