Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590CA1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbcJKQa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:30:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54008 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752263AbcJKQa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:30:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D810406FF;
        Tue, 11 Oct 2016 12:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xXEHgHzIhOA5boHDDUODizAVNp4=; b=EbEwjE
        TohpIxjKzqKimfDO0rLQIZZhMe+87GcqxbH251lh03uV4kz660KhfeWgQR3K2KaC
        z5MeiIcPkRVRxGNXRQoFTFYg28Kx89kwF7+9JMtjNwcnkg+OyxLpyAmCGi2H7a2M
        6i1udN4GivD4wnWSRzBuJRgGEZd0xw6fhbQiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oMntS2MM7+zLy+i9UeweZL3VpkeewGxB
        TfJP4YrdWVVhmIXM5HRwaObNo7Y02aedAQ4k1+plVU7hUCaKkc/HCjY8KGeVH9kr
        TwOhCeJ/YSMDtSs5vgPyTkYxs8ymlxXMntpYNsFYsHp9F9qJgNtuqK1YCkbady37
        LJ6l70raf2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 558AC406FE;
        Tue, 11 Oct 2016 12:30:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAE7E406FD;
        Tue, 11 Oct 2016 12:30:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 05/25] sequencer: eventually release memory allocated for the option values
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 11 Oct 2016 09:30:23 -0700
In-Reply-To: <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 10 Oct 2016 15:18:07 -0700")
Message-ID: <xmqq4m4ic0gw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A43D0A-8FD0-11E6-A15A-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This certainly is good, but I wonder if a new variant of OPT_STRING
> and OPTION_STRING that does the strdup for you, something along the
> lines of ...
> ... may make it even more pleasant to use?  Only for two fields in
> this patch that may probably be an overkill, but we may eventually 
> benefit from such an approach when we audit and plug leaks in
> parse-options users.  I dunno.

After sleeping on it, I do think this is an overkill.  The pattern I
would expect for the most normal (boring) code to use is rather:

    struct app_specific app;
    const char *opt_x = NULL;
    struct option options[] = {
	...
	OPT_STRING(0, "xopt", &opt_x, N_("x option"), ...),
        ...
	OPT_END()
    };

    parse_options(ac, av, prefix, options, ...);
    app.x_field = xstrdup_or_null(opt_x);
    ... other values set to app's field based on
    ... not just command line options but from
    ... other sources.

The only reason why the OPT_STRDUP appeared convenient was because
options[] element happened to use a field in the structure directly.
The patch under discussion does an equivalent of

    app.x_field = xstrdup_or_null(opt_x);

but the "opt_x" happens to be the same "app.x_field" in this case,
so in that sense, it follows the normal and boring pattern.

The "struct app_specific" may not even exist in the same scope as
the caller of parse_options(), but may have to be initialized in a
function that is three-level deep in the callchain, with opt_x
variable passed through as a parameter.  So OPT_STRDUP may not be a
bad or horrible idea, but it is not such a great one, either.

