Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676FEC56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D3A2145D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JV4JcEsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgKRU2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:28:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52132 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRU2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:28:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D016DA0B2A;
        Wed, 18 Nov 2020 15:28:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spuYDcfFudSh4ztTb0aJheDB04Y=; b=JV4JcE
        syLfcbSuBD8uwNPSuBjQT8a+BTahBsTf7hOTeX8XcdOhPeGsjZN4kikUFcCM/iuQ
        5zXPzMo5t2Oc/dsxG1HZ1c7WaIDUJECTkE7SkGOFPt9x849KC5fYo/3LBim3oHqB
        zwH79ZMXYyFbPkAJu6R2ABbBE5RmlAJyFn0xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d3Is/FMDv5bSJnwXwHb4laVo3MHO4DMu
        Ome07xL5sS8NqBVdjCgqdLclCDav3etY9oHVA2FpbrQaBGcBgcwDcIjL8gfxOtJc
        L219wbgUMGRo28o2HUehgp1onTwdZPs/IxYzx8EdvkadYQEVwz7XhEBL7F8BVmNw
        al+2/RB5dis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8333A0B28;
        Wed, 18 Nov 2020 15:28:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F383A0B27;
        Wed, 18 Nov 2020 15:28:10 -0500 (EST)
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
        <xmqqo8ju1ooc.fsf@gitster.c.googlers.com>
        <c7dfbd1b-44bc-d074-5ec9-1011738c1522@gmail.com>
Date:   Wed, 18 Nov 2020 12:28:09 -0800
In-Reply-To: <c7dfbd1b-44bc-d074-5ec9-1011738c1522@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Nov 2020 14:42:37 -0500")
Message-ID: <xmqq8say1kbq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 931F6FFE-29DC-11EB-8145-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> test_expect_success '--replace-all and value_regex' '
>>> 	q_to_tab >.git/config <<-\EOF &&
>>> 	[abc]
>>> 	Qkey = one
>>> 	Qkey = two
>>> 	Qkey = three
>>> 	EOF
>>> 	q_to_tab >expect <<-\EOF &&
>>> 	[abc]
>>> 	Qkey = four
>>> 	Qkey = two
>>> 	Qkey = three
>>> 	EOF
>>> 	git config --replace-all abc.key four "o*" &&
>>> 	test_cmp expect .git/config
>>> '
>> ...
> Thank you. Naturally, PEBKAC and my lack of understanding the
> regex I was using in my own test. Clearly this is behaving
> correctly. Modifying as suggested shows this works properly.

It is an easy confusion.

When I see a pattern, especially a single letter followed by an
asterisk like "o*", my eyes take it as a glob pattern that is left
anchored, i.e. "any string that begins with an 'o'", and if that
were the matching rule, what you expected is totally the natural
outcome.  But here we unfortunately are looking at ERE.

