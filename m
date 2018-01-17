Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4799E1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeAQWlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:41:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52532 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbeAQWlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:41:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BEBCC0B58;
        Wed, 17 Jan 2018 17:41:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MXfOSQJTlcrtg6Q59PbQ1zm9Rrw=; b=AwnJdO
        j4XE83OhD9zfpf8y9BI9p+AalbT3AAMbw68H0TUCYmvczQJm8cjHl6ckLjXHKlcE
        NrGsIK9u6WgHh4LW9PV18yU9RXd4rte76ecrIw6+8uppQbNBLe+2conVyXthBsuH
        +ST26P1KUOq4IFqowvq6sol8kJE/4Ejw427IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tYJm146D/k9SjM/uUxHdx745p0Asiew0
        1oodAXt6NCUI20+M8K9hPFpOMw7PvAwYKN3vEz0kq0v6XtdseqvO52zNTzeEu2Lu
        NTUnewQEVrVn5+fKrJm5Aih1vAfUg8lO4EPO6J6L1JwAaC57ecrEG5IHSdMUcnjy
        tNCLHpRmPTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92B04C0B57;
        Wed, 17 Jan 2018 17:41:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7171C0B56;
        Wed, 17 Jan 2018 17:41:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 4/7] trace.c: introduce trace_run_command()
References: <20180113064949.6043-1-pclouds@gmail.com>
        <20180115105949.18328-1-pclouds@gmail.com>
        <20180115105949.18328-5-pclouds@gmail.com>
        <20180117222143.GA15317@sigill.intra.peff.net>
Date:   Wed, 17 Jan 2018 14:41:28 -0800
In-Reply-To: <20180117222143.GA15317@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 17 Jan 2018 17:21:43 -0500")
Message-ID: <xmqqr2qoqfaf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F637ECC-FBD7-11E7-8D89-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +void trace_run_command(const struct child_process *cp)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +
>> +	if (!prepare_trace_line(__FILE__, __LINE__,
>> +				&trace_default_key, &buf))
>> +		return;
>
> I think technically this should be TRACE_CONTEXT instead of __FILE__,
> though I wonder if anybody has ever set that (there is not even a
> Makefile knob for it, so you'd have to -DTRACE_CONTEXT manually).

Oooh. Today I learned a new thing ;-)

> I actually wonder if it would be nicer to keep this whole thing in
> run-command.c, and just prepare it all in a buffer. That's basically
> what we're doing here anyway, and then we could get rid of the funny
> __FILE__ stuff. I.e., something like:
>
>   struct strbuf buf = STRBUF_INIT;
>
>   if (!trace_want(&trace_default_key))
> 	return;
>
>   strbuf_addf(&buf, "trace: run_command: ");
>   sq_quote_argv_pretty(&buf, cp->argv);
>
>   trace_printf("%s", buf.buf);
>   strbuf_release(&buf);
>
> AFAICT we aren't really using any internals of trace.c in our new
> function.  That would get rid of this __FILE__ bit, it would eliminate
> the need for trace.h to know about "struct child_process", and it would
> mean the output still says "run-command.c" in it.

Sounds nice.
