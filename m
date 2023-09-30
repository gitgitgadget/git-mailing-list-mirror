Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255EE7735A
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 05:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjI3FqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjI3FqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 01:46:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56855F1
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 22:46:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 665821D98B;
        Sat, 30 Sep 2023 01:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+pupg8BkMqVZy5RrNzr3Jbs5UZZsZHA4A49w0L
        3CHdc=; b=NkRoIef33PljjaEM4LE7MDxhIfyouYBj80SDiErn9HtEYCdBy9amjU
        uLHwOU2qnPOPP/nmByWnI2+oR5g2nAGauvGPXAkTwaGXlJyQXI64bAQGntIl4JVf
        EH60LbZYBelOpN0zpXx8Ywee+wfx1dLRgk9z2Z0D5kS6Uspj59Lbs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51B871D98A;
        Sat, 30 Sep 2023 01:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7CD21D986;
        Sat, 30 Sep 2023 01:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Benjamin Hiller <benhiller@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep performance regression on macOS
In-Reply-To: <CAPWWTaDE5559vA1qa0zhBid_ep9ht+PxPSDS5YC7Dk0NN8sp9A@mail.gmail.com>
        (Benjamin Hiller's message of "Fri, 29 Sep 2023 16:56:19 -0700")
References: <CAPWWTaDE5559vA1qa0zhBid_ep9ht+PxPSDS5YC7Dk0NN8sp9A@mail.gmail.com>
Date:   Fri, 29 Sep 2023 22:45:58 -0700
Message-ID: <xmqqa5t4gqnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A22AF8FA-5F54-11EE-AA9F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Benjamin Hiller <benhiller@gmail.com> writes:

> git grep seems to have gotten much slower as of git 2.39 on macOS for
> complex extended regexes.

> I confirmed that the performance regression was first introduced in
> 2.39. Additionally, I saw that reverting the change to Makefile from
> https://github.com/git/git/commit/1819ad327b7a1f19540a819813b70a0e8a7f798f
> fixed the performance regression and the git grep command went back to
> taking <1 second. That seems to indicate that switching from Git's
> regex library to the native macOS regex library caused this
> performance regression, but I haven't investigated beyond that to see
> why the native macOS regex library is so much slower.

Yeah, that does sound a plausible explanation.

The regexp code in compat/ is meant as a fallback implementation for
platforms whose regexp library lack certain features we take
advantage of, but it has a limitation that it is not unicode aware.
In the olden days, regexp library on macOS lacked REG_STARTEND
feature, which forced us to use NO_REGEX (hence the fallback
implementation we ship that is not unicode aware).  The commit you
cite makes us use the macOS native regexp library, as somebody on
the platform got annoyed enough by the lack of unicode awareness of
the fallback implementation, and also noticed that REG_STARTEND is
supported by the macOS native regexp library these days.

The change in 2.39 was unfortunately about correctness.  It would
have been nicer if macOS native implementation were faster, but use
of fallback implementation would be favoring "performance" (which
produces incorrect results "faster" when run with multi-byte
strings) over correctness, so it is not likely that a straight
reverting of the commit is a good idea.

