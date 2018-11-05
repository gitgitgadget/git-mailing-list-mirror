Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052FA1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeKFDpO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 22:45:14 -0500
Received: from 0x63.nu ([109.74.10.199]:43792 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeKFDpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 22:45:13 -0500
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJjXr-00020V-SE; Mon, 05 Nov 2018 19:24:15 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu> <20181104152232.20671-6-anders@0x63.nu> <xmqqpnvkjmtu.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 5/5] pretty: add support for separator option in %(trailers)
Message-ID: <871s7zl6xp.fsf@0x63.nu>
In-reply-to: <xmqqpnvkjmtu.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 05 Nov 2018 19:24:14 +0100
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:
> Anders Waldenborg <anders@0x63.nu> writes:
>
>> @@ -1352,6 +1353,17 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>>  						arg++;
>>
>>  					opts.only_trailers = 1;
>> +				} else if (skip_prefix(arg, "separator=", &arg)) {
>> +					size_t seplen = strcspn(arg, ",)");
>> +					strbuf_reset(&sepbuf);
>> +					char *fmt = xstrndup(arg, seplen);
>> +					strbuf_expand(&sepbuf, fmt, format_fundamental, NULL);
>
> This somehow feels akin to using end-user supplied param to printf(3)
> as its format argument e.g.
>
> 	int main(int ac, char *av) {
> 		printf(av[1]);
> 		return 0;
> 	}
>
> which is not a good idea.  Is there a mechanism with which we can
> ensure that the separator=<what> specification will never come from
> potentially malicious sources (e.g. not used to show things on webpage
> allowing random folks who access he site to supply custom format)?

I can't see a case where this could add anything that isn't already
possible.

AFAICU strbuf_expand doesn't suffer from the worst things that printf(3)
suffers from wrt untrusted format string (i.e no printf style %n which
can write to memory, and no vaargs on stack which allows leaking random
stuff).

The separator option is part of the full format string. If a malicious
user can specify that, they can't really do anything new, as the
separator only can expand %n and %xNN, which they already can do in the
full string.

But maybe I'm missing something?
