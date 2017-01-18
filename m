Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F311F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbdARUR1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:17:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61279 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750890AbdARUR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:17:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1744D6223F;
        Wed, 18 Jan 2017 15:17:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zQhiUXyihtAk59P9oq245gM6aNU=; b=ithAc6
        tv5n7Ud6wVcLucsXSfDqIK3FPC0ynzHRb0xjoWltPw3hNa0YSI76ZkkFJubL2sDO
        AzKGXL1f889R1mmR4aT+s6ELaOoywCxCGdb4KE+JgNTrOomQLm13jy7+cKILXgop
        Ytm4Azwh/aWWbm98I9IB5KE4JN9/ttJ8+gJ6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+zRCDlPdKgzGpAv4I7JW0m2Hz4SrikQ
        r7JQQ0VGgbxbp6vSs7e1e08rnE8qV29PEsvo34SA10IhDvEpXeN+jBdp+hJOrciq
        g1iGftKYtp96tGXiBY7ag1mSvWOZKMcRP3wOpq/dk7RhWdLW9FPuILdrKLZXV6++
        HW50WVI1QZs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D1F26223E;
        Wed, 18 Jan 2017 15:17:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 517636223D;
        Wed, 18 Jan 2017 15:17:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 5/5] describe: teach describe negative pattern matches
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-6-jacob.e.keller@intel.com>
Date:   Wed, 18 Jan 2017 12:17:22 -0800
In-Reply-To: <20170118000930.5431-6-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 17 Jan 2017 16:09:30 -0800")
Message-ID: <xmqqpojk86nh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FCD037A-DDBB-11E6-A957-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-describe the `--exclude` option which will allow specifying
> a glob pattern of tags to ignore. This can be combined with the
> `--match` patterns to enable more flexibility in determining which tags
> to consider.
>
> For example, suppose you wish to find the first official release tag
> that contains a certain commit. If we assume that official release tags
> are of the form "v*" and pre-release candidates include "*rc*" in their
> name, we can now find the first tag that introduces commit abcdef via:
>
>   git describe --contains --match="v*" --exclude="*rc*"
>
> Add documentation and tests for this change.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

The above is much better than 3/5 with a concrete example (compared
to the vague "certain kinds of references").  It also does not have
the "we check this first and then that" ;-).

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index 7ad41e2f6ade..21a43b78924a 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -88,6 +88,14 @@ OPTIONS
>  	patterns will be considered. Use `--no-match` to clear and reset the
>  	list of patterns.
>  
> +--exclude <pattern>::
> +	Do not consider tags matching the given `glob(7)` pattern, excluding
> +	the "refs/tags/" prefix. This can be used to narrow the tag space and
> +	find only tags matching some meaningful criteria. If given multiple
> +	times, a list of patterns will be accumulated and tags matching any
> +	of the patterns will be excluded. Use `--no-exclude` to clear and
> +	reset the list of patterns.
> +

Similar to 3/5, perhaps we want to say something about interaction
between this one and --match?

