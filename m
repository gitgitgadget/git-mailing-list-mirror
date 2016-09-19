Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF6B2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbcISVYm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:24:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64928 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933011AbcISVY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:24:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BC8640B59;
        Mon, 19 Sep 2016 17:24:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8J988swdLpn5Y3HbAX5Jw7r2IgE=; b=vEGGRN
        XFFUTRb2mV6zj0AgRJpyf6qjuuE/n1eDj6FGDnXDVOy4lGUzaMnUE2060tsreN2b
        niFS76xfr+uQNVpGzhEOKltp5q5HRtUob+BEgRXHT3kcN6k5ZaZyWkhftayjGcjA
        RWrW0JkiLPnvcWKKJLUufVj6OVTe25rDcUEps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ncvcOjj2L4wE1ThvfPiJlw7Q5MaGe6Ms
        WRaywDgsEL7f10UJAvqYiLpGWRhXW/1LPwLCvArBxJPp3+n28RdLgQ9skskIwOj2
        S94l3fcc+PvZ1iaOU3g9RdPkDUKrMpCjiaYxDvGmnYlrc6g0s2lJtXMq6iu4IClW
        0hn1yD4KDrg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4194540B58;
        Mon, 19 Sep 2016 17:24:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B993940B57;
        Mon, 19 Sep 2016 17:24:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
References: <20160919185440.18234-1-me@ikke.info>
        <20160916210204.31282-1-me@ikke.info>
        <20160919185440.18234-3-me@ikke.info>
Date:   Mon, 19 Sep 2016 14:24:18 -0700
In-Reply-To: <20160919185440.18234-3-me@ikke.info> (Kevin Daudt's message of
        "Mon, 19 Sep 2016 20:54:40 +0200")
Message-ID: <xmqqvaxrd1ml.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DCA4396-7EAF-11E6-863C-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> +static void unquote_quoted_string(struct strbuf *line)
> +{
> +	const char *in = strbuf_detach(line, NULL);
> +	int c, take_next_literally = 0;
> +	int found_error = 0;
> +
> +	/*
> +	 * Stores the character that started the escape mode so that we know what
> +	 * character will stop it
> +	 */
> +	char escape_context = 0;
> +
> +	while ((c = *in++) != 0) {
> +		if (take_next_literally) {
> +			take_next_literally = 0;
> +		} else {
> +			switch (c) {
> +			case '"':
> +				if (!escape_context)
> +					escape_context = '"';
> +				else if (escape_context == '"')
> +					escape_context = 0;
> +				continue;
> +			case '\\':
> +				if (escape_context) {
> +					take_next_literally = 1;
> +					continue;
> +				}
> +				break;
> +			case '(':
> +				if (!escape_context)
> +					escape_context = '(';
> +				break;
> +			case ')':
> +				if (escape_context == '(')
> +					escape_context = 0;
> +				break;
> +			}
> +		}
> +
> +		strbuf_addch(line, c);
> +	}
> +}

The additional comment makes it very clear what is going on.

Is it an event unusual enough that is worth warning() about if we
have either take_next_literally or escape_context set to non-NUL
upon leaving the loop, I wonder?

Will queue.  Thanks.


