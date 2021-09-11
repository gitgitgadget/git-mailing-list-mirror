Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1AC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D47F61208
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhIKAWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 20:22:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63180 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKAWg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 20:22:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 879C015F04D;
        Fri, 10 Sep 2021 20:21:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TewlQB24JTwR
        C7Ll6w6Zin7241FynrYmcjwiDWGyrHc=; b=a6NPryZVKOIqqZ7gDmDqDO6kuRh9
        CVi0SoNowA/LlAvmIJ/i59DcX634QROW4T/SHWjxxg8CL3lfSipZHY/5kiHczGmU
        FvMlOeLC3p1f6V6EnbxLfD4vZTz5X3KLj0dHaw/uu6rMHTs1AJ34RCr7hVgSOy0d
        7UywIZi0KZyeWCI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8017115F04C;
        Fri, 10 Sep 2021 20:21:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC38D15F04B;
        Fri, 10 Sep 2021 20:21:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] parse-options: stop supporting "" in the
 usagestr array
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <patch-v2-3.6-11f4a119563-20210910T153147Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 17:21:20 -0700
In-Reply-To: <patch-v2-3.6-11f4a119563-20210910T153147Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 17:38:33
        +0200")
Message-ID: <xmqqlf44otbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3105F2CC-1296-11EC-A755-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The strings in the the "usagestr" array have special handling for the
> empty string dating back to f389c808b67 (Rework make_usage to print
> the usage message immediately, 2007-10-14).
>
> We'll prefix all strings after the first one with "or: ". Then if we
> encountered a "" we'll emit all strings after that point verbatim
> without any "or: " prefixing.
>
> This gets rid of that special case, which was added in
> f389c808b67 (Rework make_usage to print the usage message immediately,
> 2007-10-14). It was only used "blame" (the "credential-cache*" use of

used *by* "blame"

> it was removed in the preceding commit). Before this change we'd emit:
>
>     $ git blame -h
>     usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>
>
>         <rev-opts> are documented in git-rev-list(1)

The most crucial information is missing.  It may be shared with the
previous step but it is even worse in this step.

Why is this loss of feature a desirable thing in the first place?

What are we gaining by breaking the "after listing the alternative
forms concatenated with 'or:', we can give a general description,
before going onto the list of options"?

Without that explained, the remainder of the proposed log message
reads more like an excuse for breaking the feature, justifying that
the loss of feature can be worked around, than the description of a
solution.

Thanks.
