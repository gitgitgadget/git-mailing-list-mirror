Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB3C20984
	for <e@80x24.org>; Wed, 14 Sep 2016 00:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbcINAEu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 20:04:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59357 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932217AbcINAEt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 20:04:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A26EA3CF16;
        Tue, 13 Sep 2016 20:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VpV12688LUumBkc91qa0p/hs/iw=; b=NlE5I9
        qxNLRCAmuDqpPsOfKYZiV/x0JtHvDbbfB1m2fKNkrWgCn077lqWTlwavVkI3i4Lv
        6sKphF9ZON0WZSLLx4cOUWEjfSt6NSscX/Gmx29u/SuceAYmu8TCZsFvz6PCFLEJ
        x4AZAi2npWJnD0g6ZyF0gsf0WcA7dLkElHVgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OYQzUdDxtZ2MDK3L6vn8O+sse6pNt/6U
        92KybgxDHrpAOOecsrGyIfAnLRTyqeNxxn+lSaEM80RmsiE2sPSdQMst5nTV+FID
        ox53zccn/WzX0ViVBSnlK6BzRihAKOBsu6kLx+0GQlS2vVb0SL9W6A7N5FOtyti8
        +eSNFDbOhOs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B6B43CF15;
        Tue, 13 Sep 2016 20:04:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 257EB3CF14;
        Tue, 13 Sep 2016 20:04:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
        <20160913234612.22806-1-me@ikke.info>
        <20160913234612.22806-2-me@ikke.info>
Date:   Tue, 13 Sep 2016 17:04:45 -0700
In-Reply-To: <20160913234612.22806-2-me@ikke.info> (Kevin Daudt's message of
        "Wed, 14 Sep 2016 01:46:12 +0200")
Message-ID: <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D91745A4-7A0E-11E6-8F11-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> +static int unescape_quoted_pair(struct mailinfo *mi, struct strbuf *line)
> +{
> +	struct strbuf outbuf = STRBUF_INIT;
> +	const char *in = line->buf;
> +	int c, skip=0;
> +	char escape_context=0;

Have SP around '=', i.e.

	int c, skip = 0;
	char escape_context = 0;

> +	while ((c = *in++) != 0) {
> +		if (!skip) {
> +			switch (c) {
> +				case '"':
> +...
> +					break;
> +			}
> +		} else {
> +			skip = 0;
> +		}
> +
> +		strbuf_addch(&outbuf, c);
> +	}

It often is easier to read if smaller of the two are in the if part
and the larger in else part.  Also your switch/case is indented one
level too deep.  I.e.

        while (...) {
                if (skip) {
                        skip = 0;
                } else {
                        switch (c) {
                        case '"':
                                do this;
                                ...
                        }
                }
                strbuf_addch(...);
        }

I found the variable name "skip" a bit hard to reason about.  What
it does is to signal the next round of the processing that we have
seen a single-byte quote and it should keep the byte it will get, no
matter what its value is.  It is "skipping" the conditional
processing, but I'd imagine most people would consider it is
"keeping the byte".

> @@ -461,6 +506,7 @@ static int check_header(struct mailinfo *mi,
>  			 */
>  			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
>  			decode_header(mi, &sb);
> +			unescape_quoted_pair(mi, &sb);
>  			handle_header(&hdr_data[i], &sb);
>  			ret = 1;
>  			goto check_header_out;

I wonder why this call is only in here, not on other headers that
all call decode_header().  For that matter, I wonder if the call (or
the logic of the helper function itself) should go at the end of
decode_header().  After all, this is different kind of decoding; the
current one knows how to do b/q encoding but forgot about the more
traditional quoting done with backslash, and you are teaching the
code that the current decoding it does is insufficient and how to
handle the one that the original implementors forgot about.

Thanks.
