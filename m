Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCDCC2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4040F20936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iMY3UN/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgDJAJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:09:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55105 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgDJAJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 20:09:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE11841C88;
        Thu,  9 Apr 2020 20:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vcLvjeIF9Ic3CmUPqYjKZljrGDU=; b=iMY3UN
        /miByVsjgo6rSO7KT0x2L81C6QV5vkTPsQkKpMTEPRgoOL9tdffSeJViDaREMcv2
        0bw8tUT+uBjgQBDGwDKw7ViOdjp7vQq/WjGceMwd2bjDBt9qzokwbd6Me/OOXW/6
        NZ7ZFGVLd9CxLcX+tK+q/vmQUTbC/aTHnOxdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HSbJg4eX40VRL9CM/OHiurL/RIiW5yrv
        gWIK+r4CqacuzI3F6ocX75AgupZOxjQ+pYEb5qufKC+O+uLnDUM8H8lMNlCNLatz
        hht4LBwKlXJDXEggcPg/Gc1hofZEEnTq5osh7/izAMDn9dfAQRK4GP9ZmlhF5is9
        JiSJK3jGn/8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B64AD41C87;
        Thu,  9 Apr 2020 20:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4246541C86;
        Thu,  9 Apr 2020 20:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/receive-pack: use constant-time comparison for HMAC value
References: <20200409233730.680612-1-sandals@crustytoothpaste.net>
Date:   Thu, 09 Apr 2020 17:09:29 -0700
In-Reply-To: <20200409233730.680612-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 9 Apr 2020 23:37:30 +0000")
Message-ID: <xmqqr1wwkxqe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C81D046-7ABF-11EA-A47D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When we're comparing a push cert nonce, we currently do so using strcmp.
> Most implementations of strcmp short-circuit and exit as soon as they
> know whether two values are equal.  This, however, is a problem when
> we're comparing the output of HMAC, as it leaks information in the time
> taken about how much of the two values match if they do indeed differ.
>
> In our case, the nonce is used to prevent replay attacks against our
> server via the embedded timestamp and replay attacks using requests from
> a different server via the HMAC.  Push certs, which contain the nonces,
> are signed, so an attacker cannot tamper with the nonces without
> breaking validation of the signature.  They can, of course, create their
> own signatures with invalid nonces, but they can also create their own
> signatures with valid nonces, so there's nothing to be gained.  Thus,
> there is no security problem.
>
> Even though it doesn't appear that there are any negative consequences
> from the current technique, for safety and to encourage good practices,
> let's use a constant time comparison function for nonce verification.
> POSIX does not provide one, but they are easy to write.

Devil's advocate mode on.

If the HMAC plus digital signature are the real security, even
though writing this patch may be a nice mental exercise, is there a
merit in deliberately adding more code and making the code
immesurably slower by applying it? 

You just established in the previous paragraph that "for safety" is
a red herring.
