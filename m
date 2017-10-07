Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935CE20372
	for <e@80x24.org>; Sat,  7 Oct 2017 02:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbdJGC3X (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 22:29:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753316AbdJGC3V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 22:29:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 388F9B12F4;
        Fri,  6 Oct 2017 22:29:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X8tLUgLOE6yVyCfmBxLv2cBu9w4=; b=YhId2K
        lOSrWFD7pV8e76u0VAME+StvW9ejFpXYjJbRXF3SU6SLlz7XbFah03b2f2QuR+am
        7gd+6TakKZPb0Kqm72BwK2+haLa0TwIt8kYbjxnHcERR0O2O4OZfrgbkKB9gB2fg
        pavpN9Inj/Tr5XpEzGPerMNnB1XIY6zGmS4eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7F1yv6h/ty5Tna5bhuGMebrgHtGwLUD
        7s3ISamQ0a8q4JMb+Al0L8u6Wv/6kWA9TguSNsfWca5XRv9jQgcy2ZBcNNtLmmj5
        J+gVAIpUNhWjZ9eDDT0SFE42KveIp6hMY6o/pzgaih6BBLMG29IVJoWFopgxoDHQ
        EXmi+5J5iTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30CE4B12F3;
        Fri,  6 Oct 2017 22:29:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EAA5B12F2;
        Fri,  6 Oct 2017 22:29:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: fix diff order arguments in test_cmp
References: <20171006190006.19623-1-sbeller@google.com>
        <20171006190006.19623-2-sbeller@google.com>
Date:   Sat, 07 Oct 2017 11:29:19 +0900
In-Reply-To: <20171006190006.19623-2-sbeller@google.com> (Stefan Beller's
        message of "Fri, 6 Oct 2017 12:00:06 -0700")
Message-ID: <xmqqwp47u1vk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 532C6E26-AB07-11E7-AD7B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index ec5f530102..42f584f8b3 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -590,7 +590,7 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
>  test_expect_success ':only and :unfold work together' '
>  	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
>  	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
> -	test_cmp actual reverse &&
> +	test_cmp reverse actual &&
>  	{
>  		grep -v patch.description <trailers | unfold &&
>  		echo

This test is trying to see that giving the two modifers in any order
produces identical results, so the result of swaping is no more or
no less correct than the original, because what this test calls
"actual" is no less authoritative result than what is in "reverse"
at this point, which is the reason why we prefer "expect actual" in
the typical use of test_cmp.

Renaming <actual, reverse> to (rather meaningless) <one, two> or
<only-unfold, unfold-only> might make the intention a bit clearer.

THanks.
