Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17C11F461
	for <e@80x24.org>; Fri, 28 Jun 2019 16:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF1QXB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 12:23:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55105 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfF1QXA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 12:23:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B65B715DC4D;
        Fri, 28 Jun 2019 12:22:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K6+WoZhHqX8gg2gbEUfGAi/3Q5s=; b=qM/cEb
        WgL1E+Ro/6VTbtNnhLfETZc3VpqB/yYREcCpAjLCVPMvFlZWcxyEya6XIUtrOxhc
        3e74zD93+iT8mM+OjHeQaKPGEF19HPJ2EfkUsnuiOv53IlbYVTkZXEi/4N0iSFeN
        eX8q05C1ugi2DNpTlNmKtgVhfrXwP675fdLuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IpkaTBVaGmmn50PFJ4PExaOrrVtBTGFw
        at4tVvNSzMrXKi07I7kVPXztDOr2NQOM9wbDw1jI6c9UoEgw6OlN4v/Vwq1Q/QDs
        Eb6X2cRGH+pyodCgT+D7zQsxqUhmUAZc5ql45dK8bwXB8Xm82dwF4P3zsZJ0aqyI
        8jQku67uVYg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA73015DC4C;
        Fri, 28 Jun 2019 12:22:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F097515DC4B;
        Fri, 28 Jun 2019 12:22:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips are valid
References: <20190628101131.GA22862@sigill.intra.peff.net>
Date:   Fri, 28 Jun 2019 09:22:56 -0700
In-Reply-To: <20190628101131.GA22862@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 28 Jun 2019 06:11:31 -0400")
Message-ID: <xmqqpnmx8ysf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDA9A752-99C0-11E9-BC58-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we receive a remote ref update to sha1 "X", we want to check that
> we have all of the objects needed by "X". We can assume that our
> repository is not currently corrupted, and therefore if we have a ref
> pointing at "Y", we have all of its objects. So we can stop our
> traversal from "X" as soon as we hit "Y".
>
> If we make the same non-corruption assumption about any repositories we
> use to store alternates, then we can also use their ref tips to shorten
> the traversal.
> ...
> diff --git a/connected.c b/connected.c
> index 1ab481fed6..cd9b324afa 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -80,6 +80,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		argv_array_push(&rev_list.args, "--all");
>  	}
>  	argv_array_push(&rev_list.args, "--quiet");
> +	argv_array_push(&rev_list.args, "--alternate-refs");
>  	if (opt->progress)
>  		argv_array_pushf(&rev_list.args, "--progress=%s",
>  				 _("Checking connectivity"));

Quite honestly, I am very surprised that we did not do this.  The
idea of alternate object store, as well as reducing transfer cost by
advertising their tips as '.have' phony refs, is almost as old as
the pack protocol itself.
