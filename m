Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C3C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9023A01
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qOL50mMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgI0UuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 16:50:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50932 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgI0UuD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 16:50:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19B92E4714;
        Sun, 27 Sep 2020 16:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=04psePzrq1mSOyxIUCHe3MwhweM=; b=qOL50m
        MISj4Om6RHLakh0SJeWr1CqJVnxr6BnDstvIXWSxytsIw7lZKgv85C5Ei0lnjeGY
        RqvqvTHw9n71fDNU209GnAatYdzEsEMZR9un4LBkn+3KqdelTIpEnZAgjRxJocaC
        xRlNNsnPaky00G00pSRyE5QaszNw3+eO3bhns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s0FoTV0b+DX4paFOCSDR5Y1V6o7Zpn+Q
        nVo3AHPL2rztSIVGf6E35BgZH/JdbbJ/PRPBT54kvfQvvY2PqK/J3GMx1KSmMGZK
        ZjGql496yHIRhHPFyf92fwfbh/l/tcaPYoLzriTYTfvyip7m443CvG5S4RjuOs5T
        7qH01RsfFeE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6565E4713;
        Sun, 27 Sep 2020 16:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38FB4E4712;
        Sun, 27 Sep 2020 16:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 7/8] shortlog: parse trailer idents
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927084011.GG2465761@coredump.intra.peff.net>
Date:   Sun, 27 Sep 2020 13:49:56 -0700
In-Reply-To: <20200927084011.GG2465761@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 27 Sep 2020 04:40:11 -0400")
Message-ID: <xmqqd027ndvv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01409EF2-0103-11EB-B48E-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +Shortlog will attempt to parse each trailer value as a `name <email>`
> +identity. If successful, the mailmap is applied and the email is omitted
> +unless the `--email` option is specified. If the value cannot be parsed
> +as an identity, it will be taken literally and completely.

Makes sense.

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index e6f4faec7c..28133aec68 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -228,6 +228,7 @@ static void insert_records_from_trailers(struct shortlog *log,
>  	struct trailer_iterator iter;
>  	const char *commit_buffer, *body;
>  	struct strset dups = STRSET_INIT;
> +	struct strbuf ident = STRBUF_INIT;
>  
>  	/*
>  	 * Using format_commit_message("%B") would be simpler here, but
> @@ -245,12 +246,17 @@ static void insert_records_from_trailers(struct shortlog *log,
>  		if (strcasecmp(iter.key.buf, log->trailer))
>  			continue;
>  
> +		strbuf_reset(&ident);
> +		if (!parse_ident(log, &ident, value))
> +			value = ident.buf;

And the implementation is quite straight-forward.

>  		if (strset_check_and_add(&dups, value))
>  			continue;
>  		insert_one_record(log, value, oneline);
>  	}
>  	trailer_iterator_release(&iter);
>  
> +	strbuf_release(&ident);
>  	strset_clear(&dups);
>  	unuse_commit_buffer(commit, commit_buffer);
>  }

Looking good.  Thanks.
