Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECD71F453
	for <e@80x24.org>; Mon,  5 Nov 2018 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeKERpJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 12:45:09 -0500
Received: from 0x63.nu ([109.74.10.199]:39864 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKERpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 12:45:09 -0500
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJaDR-0008NU-Et; Mon, 05 Nov 2018 09:26:33 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu> <20181104152232.20671-3-anders@0x63.nu> <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 2/5] pretty: allow showing specific trailers
Message-ID: <875zxckk1g.fsf@0x63.nu>
In-reply-to: <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
Date:   Mon, 05 Nov 2018 09:26:32 +0100
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:
> Should the code tolerate a trailing colon? (Genuine question; it's
> easy to do and would be more user-friendly.)

I would make sense to allow the trailing colon, it is easy enough to
just strip that away when reading the argument.

However I'm not sure how that would fit together with the possibility to
later lifting it to a regexp, hard to strip a trailing colon from a
regexp in a generic way.


> What happens if 'key=...' is specified multiple times?

My first thought was to simply disallow that. But that seemed hard to
fit into current model where errors just means don't expand.

I would guess that most useful and intuitive to user would be to handle
multiple key arguments by showing any of those keys.



> Thinking further on the last two points, should <val> be a regular expression?

It probably would make sense. I can see how the regexp '^.*-by$' would
be useful (but glob style matching would suffice in that case).

Also handling multi-matching with an alternation group would be elegant
%(trailers:key="(A|B)"). Except for the fact that the parser would need to
understand some kind of quoting, which seems like an major undertaking.

I guess having it as a regular exception would also mean that it needs
to get some way to cache the re so it is compiled once, and not for each expansion.

>
>> +               free(opts.filter_key);
>
> If I understand correctly, this is making a copy of <val> so that it
> will be NUL-terminated since the code added to trailer.c uses a simple
> strcasecmp() to match it. Would it make sense to avoid the copy by
> adding fields 'opts.filter_key' and 'opts.filter_key_len' and using
> strncasecmp() instead? (Genuine question; not necessarily a request
> for change.)

I'm also not very happy about that copy.

Just using strncasecmp would cause it to be prefix match, no?

But if changing matching semantics to handle multiple key options to
something else I'm thinking opts.filter_key would be replaced with a
opts.filter callback function, and that part would need to be rewritten
anyway.

>
>> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
>> @@ -598,6 +598,51 @@ test_expect_success ':only and :unfold work together' '
>> +test_expect_success 'pretty format %(trailers:key=foo) shows that trailer' '
>> +       git log --no-walk --pretty="%(trailers:key=Acked-by)" >actual &&
>> +       {
>> +               echo "Acked-by: A U Thor <author@example.com>" &&
>> +               echo
>> +       } >expect &&
>> +       test_cmp expect actual
>> +'
>
> I guess these new tests are modeled after one or two existing tests
> which use a series of 'echo' statements

I guess I could change it to "--pretty=format:%(trailers:key=Acked-by)"
to get separator semantics and avoid that extra blank line, making it
simpler.
