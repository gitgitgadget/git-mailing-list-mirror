Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEE320A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdK0Bq0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:46:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752227AbdK0BqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:46:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2323BA6B2;
        Sun, 26 Nov 2017 20:46:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqruaBunG8zHXzXshI7Puv5XGnY=; b=JQaVaP
        xQNf0Vs2kel3w33Y5HtlrYSOSfy+HSoe1EKR6t3EEi5NqyDQWoD+5ja+NZCeNl9S
        gJ8u0OeIyPgKZxzOONXY29Qo88rxhextCgm7ck6C9BcJ0q/iyznPJ3qzKDIVDZYv
        UodFK+tYFbHpJP/+umVzl896sw/buO4bBfC5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VX9R17IeXO7y/bbuMX3JeySdi62CtDfg
        akzRjWeim7NIsZM7K3DcW09kYaGxaO2R7cbRnbbBoC5Vt0UmeTOYpvPUO9Npjr8l
        yvO3TLbacbyXjwUItYMFEBbFXdxgCQ/8GWF6ZVBBJnwfZIHMT3qBq9X87SjULePx
        OssyPp5tGPM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9312BA6B1;
        Sun, 26 Nov 2017 20:46:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65364BA6B0;
        Sun, 26 Nov 2017 20:46:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     mwnx <mwnx@gmx.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pretty: fix buffer over-read with %> and %<
References: <20171126025222.7831-1-mwnx@gmx.com>
Date:   Mon, 27 Nov 2017 10:46:23 +0900
In-Reply-To: <20171126025222.7831-1-mwnx@gmx.com> (mwnx@gmx.com's message of
        "Sun, 26 Nov 2017 03:52:22 +0100")
Message-ID: <xmqqh8tgfq8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6AFB8FA-D314-11E7-BE56-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mwnx <mwnx@gmx.com> writes:

> diff --git a/pretty.c b/pretty.c
> index 2f6b0ae6c..4c70bad45 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1021,7 +1021,7 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
>  		const char *end = start + strcspn(start, ",)");
>  		char *next;
>  		int width;
> -		if (!end || end == start)
> +		if (!*end || end == start)

Yuck.  This is so obvious a typo as it is quite clear that a few
lines above will never give us !end.  Well spotted.

By the way, Documentation/SubmittingPatches has this in "(5) Certify
your work" section:

    Also notice that a real name is used in the Signed-off-by: line. Please
    don't hide your real name.


>  			return 0;
>  		width = strtol(start, &next, 10);
>  		if (next == start || width == 0)
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 591f35daa..4d9555962 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -598,4 +598,10 @@ test_expect_success ':only and :unfold work together' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'unterminated alignment formatting' '
> +	git log -n1 --format="%<(42" >actual &&
> +	echo "%<(42" >expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done
