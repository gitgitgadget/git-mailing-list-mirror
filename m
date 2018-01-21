Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036AB1F404
	for <e@80x24.org>; Sun, 21 Jan 2018 07:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750912AbeAUHdo (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 02:33:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58240 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeAUHdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 02:33:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0FF8BB2A6;
        Sun, 21 Jan 2018 02:33:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MPb7GHiVu8+xhF1/ObiZgVenfn4=; b=LDE+8G
        adybag6bdku4vuQz8lzNMn0l6LVwlqZDrRoIzdUuY1CFtKDyuAI6IxcI7YpNpivs
        cxgcsEd2P5GdPlrgjBWwbbVhuZjD0/Po/K+VpimeOMFg25lm+VqqxfROoh2QOs2u
        leLRlkVOA9pGQgKWIe3BBxIb9Jxz774+zxBL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xW5a54KejhcMX0mnGVFgkwjVb8Dpa+SZ
        KUmZ7bEMToGii0LI9zCQIV+4F4WILo9LzFAX5X5Z3k5ryyqUGWmsqE43jbFTlUcA
        FyWNVvbIwj4R4kPCacbOMufT7n8TgHCcroF4DZ6y3gasd2S/TtrLLHDGOOJpqhxf
        QFej5qZ9kxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3A2DBB2A4;
        Sun, 21 Jan 2018 02:33:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A9E7BB2A3;
        Sun, 21 Jan 2018 02:33:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
References: <20180119041825.727904-1-sandals@crustytoothpaste.net>
        <20180120203324.112522-1-sandals@crustytoothpaste.net>
Date:   Sat, 20 Jan 2018 23:33:41 -0800
In-Reply-To: <20180120203324.112522-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 20 Jan 2018 20:33:24 +0000")
Message-ID: <xmqqa7x7oecq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67AD7704-FE7D-11E7-AF1C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 0f895478f0..53b2dda9d2 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -611,4 +611,17 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
>  	git -C replay.git index-pack -v --stdin <tmp.pack
>  '
>  
> +hex2oct() {
> +	perl -ne 'printf "\\%03o", hex for /../g'
> +}
> +
> +test_expect_success 'clone on case-insensitive fs' '
> +	o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
> +	t=$(printf "100644 X\0${o}100644 x\0${o}" |
> +		git hash-object -w -t tree --stdin) &&
> +	c=$(git commit-tree -m bogus $t) &&
> +	git update-ref refs/heads/bogus $c &&
> +	git clone -b bogus . bogus
> +'
> +
>  test_done

Hmm, I seem to be seeing a failure from this thing:

    expecting success:
            o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
            t=$(printf "100644 X\0${o}100644 x\0${o}" |
                    git hash-object -w -t tree --stdin) &&
            c=$(git commit-tree -m bogus $t) &&
            git update-ref refs/heads/bogus $c &&
            git clone -b bogus . bogus

    fatal: repository '.' does not exist

even on a case sensitive platform.
