Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ED0C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4973A22256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRt6rgbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgKSTub (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:50:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53209 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbgKSTub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 14:50:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5B75FFBA6;
        Thu, 19 Nov 2020 14:50:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YvfnhtXb+g28Lird7bgcukcH+wo=; b=lRt6rg
        bldS5JqTSSCHjqXeRIx7FatzBYe0xx6G4qfMnf0vW2SdeKwspuKFJY+R+FwoHx/P
        opSryaus7jEIfYsu5I8CZZWlzKtLAxtJYdoymT0oDQQOCnucqycPjt5WR2YNxcdr
        Rf8rnf2aZsYUXq8OlrR9ebsOYnJPi3VGFdKTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pdv3vkofDtDJr0C7Rixy955jXk/nzRE0
        vaoquNwbSdcf5VfveobYn4NYRTKBF8n6iGYBb/8mYdxf+TGKmuXIwsz01x2Cdro7
        OPiC2SR9m9cQgon+6g8SrZXSweHgMzD++s1p2dHbWLfm5tTnJPpwuNytGLEa+ps2
        vSLmOT+6iC4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AED0CFFBA5;
        Thu, 19 Nov 2020 14:50:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 068A0FFBA3;
        Thu, 19 Nov 2020 14:50:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
References: <20201118190414.32616-1-szeder.dev@gmail.com>
        <20201119155824.GB25426@coredump.intra.peff.net>
        <20201119175608.GA132922@coredump.intra.peff.net>
Date:   Thu, 19 Nov 2020 11:50:26 -0800
In-Reply-To: <20201119175608.GA132922@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Nov 2020 12:56:08 -0500")
Message-ID: <xmqqd009xh19.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79235858-2AA0-11EB-A5C8-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I took a look at converting some of the existing tests. This seems to
> work. It's a bit longer to read, perhaps, but I kind of like that the
> expected outcome is all laid out. It also pollutes the test output less
> (e.g., if you wanted to count up skipped tests in the whole suite, you'd
> get a bunch of noise from t0000 for these uninteresting skips).
>
> Thoughts? I think this is something I'd do on top of your patch.

Yes, it looks nice as the expectation is expressed much clearly.
