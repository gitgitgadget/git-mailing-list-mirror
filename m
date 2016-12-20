Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6561FF40
	for <e@80x24.org>; Tue, 20 Dec 2016 01:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbcLTBc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 20:32:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56818 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752796AbcLTBcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 20:32:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D4EA5A9AE;
        Mon, 19 Dec 2016 20:32:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ekV9hPyXLKr4R5OZ3rMaxnwm/eQ=; b=RuGO+/
        vvTlEAtMU63yt86X54GfQkS2ddJgnkTksZxL5dsUXAkS5bQhKJnT6jlX6mecXVzo
        ekKYjnbYJlv/jJD2iK1cRNJGpQsYHKPfXRWJAHWmIlyRD46e3JWAwBLlpnVD3PnK
        aiTTNIdTBe/uU7H4IQevhZJS4UhEs1LtV9pSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UMiFC1nOffnKipPecJMkRXUQlnlNUzgD
        dFpBw143lB+9ONTATsfd3pndqUiARH9FG6nxvwohM2XmGWKaYSGhNxtpj5WdcMg/
        0vhKGYEAjKJBOkJLCk1xT3w754pQmMRQmPoQyEwKkNuGTtLwAz3tjhypA3n60ewU
        ohjVQlSh3rI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 258D25A9AD;
        Mon, 19 Dec 2016 20:32:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89B1C5A9AC;
        Mon, 19 Dec 2016 20:32:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 09/34] sequencer (rebase -i): write an author-script file
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <09c2718e119f809093794410ae1a738c1cd122d1.1481642927.git.johannes.schindelin@gmx.de>
        <xmqqd1gtuivc.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612191800530.54750@virtualbox>
Date:   Mon, 19 Dec 2016 17:32:19 -0800
In-Reply-To: <alpine.DEB.2.20.1612191800530.54750@virtualbox> (Johannes
        Schindelin's message of "Mon, 19 Dec 2016 18:06:37 +0100 (CET)")
Message-ID: <xmqqy3zbl718.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 266FA1FC-C654-11E6-A202-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 15 Dec 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > +	strbuf_addstr(&buf, "GIT_AUTHOR_NAME='");
>> > +	while (*message && *message != '\n' && *message != '\r')
>> > +		if (skip_prefix(message, " <", &message))
>> > +			break;
>> > +		else if (*message != '\'')
>> > +			strbuf_addch(&buf, *(message++));
>> > +		else
>> > +			strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> > +	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
>> > +	while (*message && *message != '\n' && *message != '\r')
>> > +		if (skip_prefix(message, "> ", &message))
>> > +			break;
>> > +		else if (*message != '\'')
>> > +			strbuf_addch(&buf, *(message++));
>> > +		else
>> > +			strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> 
>> Aren't these reading from an in-core commit object?  
>> 
>> If so, it should use split_ident_line() for consistency with other
>> parts of the system to do this parsing.  We should also already have
>> a helper for simple shell-quoting in quote.c and you would want to
>> use that instead of open coding like this.
>
> We keep coming back to the same argument. You want this quoting/dequoting
> to be turned into a full-fledged parser. And I keep pointing out that the
> code here does not *need* to parse but only construct an environment
> block.

I am afraid you are mis-reading me.  I see a code that _READS_ some
data format, for which we already have a parser, and then write out
things based on what it read.  I do not want you to make anything
into a full-fledged parser---I just do not want to see an ad-hoc
reader and instead the code to USE existing parser.

