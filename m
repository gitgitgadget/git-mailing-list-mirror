Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93ADC1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbcJKRzx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:55:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63518 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751226AbcJKRx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:53:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A01C143D2C;
        Tue, 11 Oct 2016 13:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yvmm4tpEnXLo6hH1IlzwEAqhiqA=; b=H63N6B
        80T6MU8zZh9LrrOCwyePJVXSmgQrGFhB8YeuL4wlbZLv424zS4c4e0M89+eU4wQu
        6TErj9p8Ws/NIlo2x6oW0WO4/JmBIayxMcJtfWQUfd80Fb3c0Q+CrLvEqLiJJhlh
        Cs85hiB/LICRNzKCzMW3Odq1LoYuDnDyTx4GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kqAVHnnCsYRLRxTdGHEfbNKVhW3690vL
        Jp4pPC4nZRNlxYUGpYG4YORVQNuyCH+8PZCfdsNEExL7leptX1IaJ9OpS9JqzE4b
        UC8aXjT3iUR5m+hfr9sb4MMUI68vlRQorPJGZlBZ+FZymUo6grnbcfUA+VjcfNiB
        SLDCulk/qeo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98CB243D2B;
        Tue, 11 Oct 2016 13:53:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14F2943D2A;
        Tue, 11 Oct 2016 13:53:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: support the --stdin option
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
        <2c7a52e43be710c7f37c4886629bda38df183c21.1476202100.git.johannes.schindelin@gmx.de>
Date:   Tue, 11 Oct 2016 10:53:52 -0700
In-Reply-To: <2c7a52e43be710c7f37c4886629bda38df183c21.1476202100.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 11 Oct 2016 18:09:11 +0200
        (CEST)")
Message-ID: <xmqqeg3mai1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD63C85A-8FDB-11E6-9BEA-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	if (read_from_stdin) {
> +		strbuf_getline_fn getline_fn = nul_term_line ?
> +			strbuf_getline_nul : strbuf_getline_lf;
> +		int flags = PATHSPEC_PREFER_FULL |
> +			PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP;
> +		struct strbuf buf = STRBUF_INIT;
> +		struct strbuf unquoted = STRBUF_INIT;
> +
> +		if (patch_mode)
> +			die(_("--stdin is incompatible with --patch"));
> +
> +		if (pathspec.nr)
> +			die(_("--stdin is incompatible with path arguments"));
> +
> +		if (patch_mode)
> +			flags |= PATHSPEC_PREFIX_ORIGIN;

Didn't we already die above under that mode?

> +		while (getline_fn(&buf, stdin) != EOF) {
> +			if (!nul_term_line && buf.buf[0] == '"') {
> +				strbuf_reset(&unquoted);
> +				if (unquote_c_style(&unquoted, buf.buf, NULL))
> +					die(_("line is badly quoted"));
> +				strbuf_swap(&buf, &unquoted);
> +			}
> +			ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
> +			stdin_paths[stdin_nr++] = xstrdup(buf.buf);
> +			strbuf_reset(&buf);
> +		}
> +		strbuf_release(&unquoted);
> +		strbuf_release(&buf);
> +
> +		ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
> +		stdin_paths[stdin_nr++] = NULL;

It makes sense to collect, but...

> +		parse_pathspec(&pathspec, 0, flags, prefix,
> +			       (const char **)stdin_paths);

...letting them be used as if they are pathspec is wrong when
stdin_paths[] contain wildcard, isn't it?  

I think flags |= PATHSPEC_LITERAL_PATH can help fixing it.  0/2 said
this mimicks checkout-index and I think it should by not treating
the input as wildcarded patterns (i.e. "echo '*.c' | reset --stdin"
shouldn't be the way to reset all .c files --- that's something we
would want to add to the test, I guess).

Thanks.

