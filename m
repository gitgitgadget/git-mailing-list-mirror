Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8550EC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FA361107
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPJVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 05:21:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58860 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhFPJVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 05:21:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D76DB09EE;
        Wed, 16 Jun 2021 05:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BeobUUdL6WngwIjDEUIBk+9DBA1Rk8VUyCNDGl
        RYZd8=; b=XrNE41DXArNMxbAvtX64aA67seJUDHeCRticzRkTWHDFbfpz8WG9o3
        XAKdFLDCpVc0SGLO028gnJFBsQ3dlMt/ywnoTh/JPzcw+8iKHJPkKrabxZGk1TQx
        1vka+8eyYFcUocxGdnrQfn/HfyWxiL9OHX1llMZJY+uv6s4p3PSPs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63FBCB09ED;
        Wed, 16 Jun 2021 05:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E69ACB09EC;
        Wed, 16 Jun 2021 05:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] range expressions in GIT_SKIP_TESTS are broken in master
 (was [BUG] question mark in GIT_SKIP_TESTS is broken in master)
References: <1d003cac-83fa-0b63-f60e-55513ac45cf9@gmail.com>
        <6980e906-8076-1436-ecdb-6775eff55d39@gmail.com>
        <xmqqa6nqsd2i.fsf@gitster.g> <xmqq4kdysb1i.fsf@gitster.g>
        <YMm2Wlb+eJDL7+ua@coredump.intra.peff.net>
Date:   Wed, 16 Jun 2021 18:19:12 +0900
In-Reply-To: <YMm2Wlb+eJDL7+ua@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 16 Jun 2021 04:29:14 -0400")
Message-ID: <xmqqim2ep3ov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA2A400C-CE83-11EB-8FA8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's surprisingly hard to do field-splitting without pathname globbing
> in pure shell. I couldn't find a way without using "set -f". That's in
> POSIX, but it feels funny tweaking a global that can effect how other
> code runs. We can at least constraint it to a subshell close to the
> point of use:
> ...
> -	for pattern_
> +	(set -f
> +	for pattern_ in $*
>  	do
>  		case "$arg" in
>  		$pattern_)
> -			return 0
> +			exit 0
>  		esac
>  	done
> -	return 1
> +	exit 1)
>  }

Nice.  "set -f" is what I wanted to find myself but couldn't, when I
wrote the message you are responding to.

> -if match_pattern_list "$this_test" $GIT_SKIP_TESTS
> +if match_pattern_list "$this_test" "$GIT_SKIP_TESTS"

OK.  'for pattern_ in $*' that flattens $* allows us to quote it
here, passing it as a single argument without globbing.


