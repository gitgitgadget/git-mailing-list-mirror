Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E8D1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759279AbcLPT25 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:28:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52951 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759269AbcLPT2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:28:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C901556092;
        Fri, 16 Dec 2016 14:28:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HIklLfw9iU01W/n9RkGC6X3vzgE=; b=OXNGZa
        IQWRtuNOvMHVmEoHIMFy6MAAG7CyNR/KwjfErw5U38MRxNmrDi/bJztNlVsCwO4x
        gdlxoB/3ggDmOXQB79mw9znBwjYTNiL9AZ+OA5qa3SSmOjWMgF/a/exPtxzZjDPA
        fsBKVDB8+w7/a6VM8+T5xk6omG8chDJg495Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iYAGUu+Pqp6qRRNCEt4eR8j7h2/us7za
        SnuD/VhhTz2jdTp8JhYqaW8dFwpmFWeMiueEDYczGvNt2WILcLpKs4/OicwsufpL
        lTpKti0RNQtUlns6KBlhq10Xr0DC6sDPf2qrobxoLCxplBzYPMaEp5lVN7P0nF0t
        SP9XlNdBo/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1DE256091;
        Fri, 16 Dec 2016 14:28:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 445ED56090;
        Fri, 16 Dec 2016 14:28:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 18/34] sequencer (rebase -i): refactor setting the reflog message
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <6f7ec89ac91ba1aa860a28c27ab93f60099f1ddb.1481642927.git.johannes.schindelin@gmx.de>
Date:   Fri, 16 Dec 2016 11:28:51 -0800
In-Reply-To: <6f7ec89ac91ba1aa860a28c27ab93f60099f1ddb.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:31:22 +0100
        (CET)")
Message-ID: <xmqqzijvr7v0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E10AF3CC-C3C5-11E6-AB3D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This makes the code DRYer, with the obvious benefit that we can enhance
> the code further in a single place.
>
> We can also reuse the functionality elsewhere by calling this new
> function.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 33fb36dcbe..d20efad562 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1750,6 +1750,26 @@ static int is_final_fixup(struct todo_list *todo_list)
>  	return 1;
>  }
>  
> +static const char *reflog_message(struct replay_opts *opts,
> +	const char *sub_action, const char *fmt, ...)
> +{
> +	va_list ap;
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	va_start(ap, fmt);
> +	strbuf_reset(&buf);
> +	strbuf_addstr(&buf, action_name(opts));
> +	if (sub_action)
> +		strbuf_addf(&buf, " (%s)", sub_action);
> +	if (fmt) {
> +		strbuf_addstr(&buf, ": ");
> +		strbuf_vaddf(&buf, fmt, ap);
> +	}
> +	va_end(ap);
> +
> +	return buf.buf;
> +}

It is unlikely for a single caller to want to format another reflog
entry after formating one but before consuming it [*1*], so this
"call this, and you can use the return value until you call it the
next time without worrying about leakage" is quite a reasonable
pattern to employ.

[Footnote]

*1* And it is unlikely that this will run in a multi-threaded
    environment, either ;-)

