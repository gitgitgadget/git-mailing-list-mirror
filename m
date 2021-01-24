Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C427C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AB522C9F
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhAXKqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:46:30 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:41550 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbhAXKq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:46:27 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4DNqQr5ldZz5tl9;
        Sun, 24 Jan 2021 11:45:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9D47C20F3;
        Sun, 24 Jan 2021 11:45:39 +0100 (CET)
Subject: Re: [PATCH v3 2/4] grep/pcre2: simplify boolean spaghetti
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>
References: <20190726150818.6373-9-avarab@gmail.com>
 <20210124021229.25987-3-avarab@gmail.com>
 <xmqqim7m292j.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ac4f3b95-49f7-7a90-b7f7-9efbb57a7392@kdbg.org>
Date:   Sun, 24 Jan 2021 11:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqim7m292j.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.01.21 um 06:33 schrieb Junio C Hamano:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>>     NOT(A && B) is Equivalent to (NOT(A) OR NOT(B))
> 
> At this level, however, the left one looks much simpler than the
> right one ;-)
> 
> 
>>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>> +	    (opt->ignore_case || !(p->fixed || p->is_fixed)))
>>  		options |= PCRE2_UTF;
> 
> In the context of this expression, well, I guess the rewritten one
> is probably simpler but can we explain the whole condition in fewer
> than three lines?  With or without the rewrite, it still looks too
> complicated to me.

Make the condition

 	if (!opt->ignore_locale &&
	    is_utf8_locale() &&
	    has_non_ascii(p->pattern) &&
	    (opt->ignore_case ||
		(!p->fixed &&
		 !p->is_fixed)))
	{
  		options |= PCRE2_UTF;
	}

With the knowledge of the equivalence

    (A => B)  <=>  (NOT(A) OR B)

(A => B means "if A then B"), the condition makes a lot of sense when
read aloud:

    if
       NOT ignore locale
       AND
       is UTF8
       AND
       has non-ASCII
       AND
         if
            NOT ignore case
         then if also
            NOT fixed
            AND
            NOT is fixed
    then
        ...


The codition amounts to extending a series of conjunctions with more
conjuctions IF a condition is satisfied. That's quite sensible.

You have to swap the polarity of the first condition of || in your head,
though, to achieve that meaning. That works with every OR condition, BTW.

-- Hannes
