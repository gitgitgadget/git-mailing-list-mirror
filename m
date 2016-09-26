Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877CD207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423371AbcIZTL4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:11:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1423331AbcIZTLz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:11:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EFF74004C;
        Mon, 26 Sep 2016 15:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SUZLkGUz69ntvCdVRpWeq084cAE=; b=p40Pzc
        zr4C4qebo77B/I/RHcZflrOkcB/5/SDqhSijT9VnU5KGhTtEO+Vbf9GiWCxUZuyJ
        6CxRC1hil+vYJbl6YyuQdn+XDyo3XHjmzGnUU2jszrVr2EfyWzhecTL35r37Ap/k
        8Eq15xDfM9fDMpvz/fRebEfpKTUNfe5TjCOAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=orwBDVBBmOG/NSUHQmP9r0DiF6I9TFO0
        OZgmy1JfytymqssW6+tUJneiIEXZk3ksmNh/Sz3TwwMkgLPyDKB2BndsKkjTiw1W
        L4J7GCbcQ3IZfnEOM2ibXzIJueKXOPlKvw4JI+ELrW0cNf30FqJ1/Wc4XSYCT3uz
        Xeoa5j+QVxo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 876FF40047;
        Mon, 26 Sep 2016 15:11:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10B3D40046;
        Mon, 26 Sep 2016 15:11:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] mailinfo: unescape quoted-pair in header fields
References: <20160919185440.18234-1-me@ikke.info>
        <20160925210808.26424-1-me@ikke.info>
        <20160925210808.26424-2-me@ikke.info>
Date:   Mon, 26 Sep 2016 12:11:52 -0700
In-Reply-To: <20160925210808.26424-2-me@ikke.info> (Kevin Daudt's message of
        "Sun, 25 Sep 2016 23:08:08 +0200")
Message-ID: <xmqq4m52scg7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1616043C-841D-11E6-8C5E-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> rfc2822 has provisions for quoted strings and comments in structured header
> fields, but also allows for escaping these with so-called quoted-pairs.
>
> The only thing git currently does is removing exterior quotes, but
> quotes within are left alone.
>
> Remove exterior quotes and remove escape characters so that they don't
> show up in the author field.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Changes since v2:
>
>  - handle comments inside comments recursively
>  - renamed the main function to unquote_quoted_pairs because it also
>    handles quoted pairs in comments

Sounds good, and the implemention looked straight-forward from a
quick scan.

> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index c4ed0f4..3e983c0 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -144,4 +144,18 @@ test_expect_success 'mailinfo unescapes with --mboxrd' '
>  	test_cmp expect mboxrd/msg
>  '
>  
> +test_expect_success 'mailinfo handles rfc2822 quoted-string' '
> +	mkdir quoted-string &&
> +	git mailinfo /dev/null /dev/null <"$DATA"/quoted-string.in \
> +		>quoted-string/info &&
> +	test_cmp "$DATA"/quoted-string.expect quoted-string/info
> +'
> +
> +test_expect_success 'mailinfo handles rfc2822 comment' '
> +	mkdir comment &&
> +	git mailinfo /dev/null /dev/null <"$DATA"/comment.in \
> +		>comment/info &&
> +	test_cmp "$DATA"/comment.expect comment/info
> +'
> +
>  test_done

Don't these also need to be downcased if you prefer $data over
$DATA, though?

Thanks.
