Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FFA1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 19:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755280AbcLNTaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 14:30:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57562 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756540AbcLNTaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 14:30:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1039456AF5;
        Wed, 14 Dec 2016 14:30:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZJ3lMUKJ5gUXOEOtq5VSIYeEZ0c=; b=J6tZj6
        l+7uNnddPLtICUgzO0JypQaKBIYlg1xSocPXj5hf2iCgjuuWFDHhJZDpXat5z0So
        XW/fxGrBVaCBS9uRyweAsYn4M+MsTZaUzTrG9Hd3rt7rcuhuvUWMHkczccifZ+Hy
        HlbaaU2zdGar14YnGTldHRP9pTHNiqSoVF/2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xIKzNZS1S3UPWPUoLyM/cxHUl2WueumR
        NK64/m5Y38YTg3tbyDFRUDhZpS3o9tAQT7PiPo1XqmZSk/CT4M98Ztyqrh9BZnU5
        JhccIW5q42KVmoWDEIjjBqLnzA2kAnn4WL7c1FxJUOBW4Vkvzx5Lio3nUtE7KZkl
        wRnGwCnluTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E8CD56AF1;
        Wed, 14 Dec 2016 14:30:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D30356AF0;
        Wed, 14 Dec 2016 14:30:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 01/34] sequencer: support a new action: 'interactive rebase'
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
Date:   Wed, 14 Dec 2016 11:29:59 -0800
In-Reply-To: <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:14 +0100
        (CET)")
Message-ID: <xmqqy3ziwbpk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B45B13A4-C233-11E6-828C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -/* We will introduce the 'interactive rebase' mode later */
>  static inline int is_rebase_i(const struct replay_opts *opts)
>  {
> -	return 0;
> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
>  }
>  
>  static const char *get_dir(const struct replay_opts *opts)
>  {
> +	if (is_rebase_i(opts))
> +		return rebase_path();
>  	return git_path_seq_dir();
>  }

This obviously makes the assumption made by 39784cd362 ("sequencer:
remove useless get_dir() function", 2016-12-07) invalid, where the
"remove useless" thought that the callers of this function wants a
single answer that does not depend on opts.

I'll revert that commit from the sb/sequencer-abort-safety topic (as
the topic is in 'next' already) to keep this one.  Please holler if
that is a mistaken decision.

Thanks.



