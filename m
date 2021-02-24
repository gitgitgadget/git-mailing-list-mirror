Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E184C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2CB64E85
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhBXFhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 00:37:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59089 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhBXFhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 00:37:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEBA010C74C;
        Wed, 24 Feb 2021 00:36:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tXEowX0NAVmRGkmQbSsmAgwO8EA=; b=WQanaz
        PTsWhBSUpjUygkxnHOBpu4nhuB9+XAoicGCu/sljcNBZbDrCTggwyrmqPMX0/v/g
        D7ZoPm2p+HRzjhls7B/cp81Lw6btRu2RN8L3t186ZGtw6KxqYPJNMQ1fLMUO9bLx
        vWzMv5y/WIi9Obc2f9xjyDkCBw3VDNxyTNdAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F1aD9t58ccSFCTyoa9LrtnOEslJKFkMu
        x3VfoP2nGoIfI3K+ziUB7WjoI18g3o+bkbL3MEZF3cDzgZvXcICl1IB2KAFTK6TD
        WdwNDhYFLvWW8F+v1Kmd0dFE0AaqtsIoCoXxmLpRF2KsmCkr/oNXquN7BJ+DcDn6
        Hx/FiRNXKjw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB0D910C74B;
        Wed, 24 Feb 2021 00:36:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF61810C749;
        Wed, 24 Feb 2021 00:36:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
        <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
Date:   Tue, 23 Feb 2021 21:36:25 -0800
In-Reply-To: <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 23 Feb 2021 23:46:28 -0500")
Message-ID: <xmqqzgzuyqli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DC27B82-7662-11EB-BCD9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2021 at 11:43:16PM -0500, Jeff King wrote:
>
>> The workaround here is enabled all the time, without a Makefile knob,
>> since it's a complete noop if open() never returns EINTR. I did push it
>> into its own compat/ source file, though, since it has to #undef our
>> macro redirection. Putting it in a file with other code risks confusion
>> if more code is added after that #undef.
>
> Whoops, sorry, I had a last-minute change of heart here and just stuck
> it in wrapper.c with a bit of preprocessor magic to guard it. It felt
> weird having compat/open.c, when the rest of compat/ is always
> conditional on Makefile knobs. But I'm happy to go the other way if
> anybody feels strongly.

Hmph, just like other workarounds, shouldn't this be "if your
platform screws this up, define this knob to work it around"?  That
would make it fit better with the rest of compat/.

I dunno.  A no-op wrapper makes the code less transparent, which I
am somewhat unhappy.  But a wrapper that is always used even on
platforms that do not need might give us a better chance of noticing
a bug in the wrapper itself, making it less likely for us to leave
only the users of minority broken platforms behind.  So...


