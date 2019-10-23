Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9321F1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 01:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfJWB60 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 21:58:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55011 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWB60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 21:58:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD1B4AF7FB;
        Tue, 22 Oct 2019 21:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1l1+miiarHpA3d8zTB0fzTJfZR8=; b=SDJOhQ
        tN3BcM1mb52PaX9SLe758aaAakThBCh40VJ3x4CH8UFIlUKAPcqTUPGf1gcFS3yB
        aOokxaP7LOJEjOjjPszQLnK+wr7cFaH9UPD6WEBDgg0SWwuTiwmIKApljj/OD3xi
        1x9xvHN+QQKOjT6hbEuGjQP0lI4cGeHf/33BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=acOWyUBpaQPmp/x6nhHE9qrJF98/YdAt
        pcyyRkYXeIzhQLz8d56BD98fjHNWk9y8tYnzYTMv8selWl5jIV8cgqqBjT9c2gAx
        5P9gtKQFdShdJOFvbMUkq6Om1omWDMzzCL5lbBlfQ1EllSwceTIld7JFLrgpSMdG
        WPHEihwedU4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D554EAF7FA;
        Tue, 22 Oct 2019 21:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D85FAF7F9;
        Tue, 22 Oct 2019 21:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
        <20190731071755.GF4545@pobox.com>
        <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
        <20191019233706.GM29845@szeder.dev>
        <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
        <20191021032144.GB13083@sigill.intra.peff.net>
        <xmqqftjmlbvb.fsf@gitster-ct.c.googlers.com>
        <20191021184954.GA2526@sigill.intra.peff.net>
Date:   Wed, 23 Oct 2019 10:58:20 +0900
In-Reply-To: <20191021184954.GA2526@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 21 Oct 2019 14:49:55 -0400")
Message-ID: <xmqqpniojk8z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9820394A-F538-11E9-B52F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But here's where it gets tricky. In addition to catching any size
> mismatches, this will also catch signedness problems. I.e., if we make
> OPT_INTEGER() use "intp", then everybody passing in &unsigned_var now
> gets a compiler warning. Which maybe is a good thing, I dunno.

Hmph, true.  I'd agree with back-burnering it for now.  

Perhaps we'd fix the signedness issue one by one in a preparatory
series before converting the value field to a union, if we want to
pursue this idea further (in which I am mildly interested, by the
way), but it does sound like it should be given lower priority.

> So that's where I gave up. Converting between signed and unsigned
> variables needs to be done very carefully, as there are often subtle
> impacts (e.g., loop terminations). And because we have so many sign
> issues already, compiling with "-Wsign-compare", etc, isn't likely to
> help.

True.

Thanks.
