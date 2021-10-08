Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B43C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C04D60FC2
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbhJHV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:28:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60178 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243452AbhJHV22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:28:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6593D14CBED;
        Fri,  8 Oct 2021 17:26:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qeat1PXNq09AdMQ0A2aGdoRQ2wGBAUrHxkGzww
        MOn+U=; b=R+YNAwgQO+cXjGAFhdSCCUtaK5RUC0dt68eTiT6O8If2PQNotQ8t8y
        PKk1dBNTeWIP2rPG85ATTptjdA+dSrq+1Z+A3IRx7o+ftL0/6HewW5vaZqyjiuIL
        lTuxhmDT47johhIT2mWsmPXSRsWs778CxVY/9I30DzsOwIE3U1GVM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CD4D14CBEC;
        Fri,  8 Oct 2021 17:26:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDEE214CBEB;
        Fri,  8 Oct 2021 17:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v11 3/3] grep: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211007203148.23888-1-someguy@effective-light.com>
        <20211007203148.23888-3-someguy@effective-light.com>
Date:   Fri, 08 Oct 2021 14:26:28 -0700
In-Reply-To: <20211007203148.23888-3-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Thu, 7 Oct 2021 16:31:48 -0400")
Message-ID: <xmqq1r4vjji3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66D6222A-287E-11EC-8BF4-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> If we attempt to grep non-ascii log message text with an ascii pattern, we
> run into the following issue:
>
>     $ git log --color --author='.var.*Bjar' -1 origin/master | grep ^Author
>     grep: (standard input): binary file matches
>
> So, to fix this teach the grep code to mark the pattern as UTF-8 (even if
> the pattern is composed of only ascii characters), so long as the log
> output is encoded using UTF-8.

We'd need this only if we are using pcre2 backend, no?  If that is
the case, that fact needs to be recorded in the proposed log message
to help later developers, when they wonder why this "all-the-things"
knob exists.

And if it is the case that this bit is needed only to work around a
glitch while using pcre2 backend, I'd rather want to see a solution
that does not need to contaminate the more generic "struct grep_opt"
data and "setup_revisions()" codepath.

In other words, can't the function compile_pcre2_pattern() make the
"is log output encoding utf8?" decision locally and act accordingly?

Thanks.
