Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925A71F428
	for <e@80x24.org>; Tue,  2 Jan 2018 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbeABTnN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 14:43:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52363 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751357AbeABTnM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 14:43:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A04DED349E;
        Tue,  2 Jan 2018 14:43:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mIZ6C3l3GKYBtJzfzWfsoFohAX8=; b=lq/0E0
        ylQV4RUJ0JFeYhHbY+NAqTK5rG4E7qDmutdyY0a4KJm6fdu0+4ARnZ1LU2NthqwO
        XZ52LZuFGkwQSHUVw3efUYYmU1UaiceOSooMv16Mienp7l09q8nJmqQ052siWzvB
        hEPnIa9vOefFiY82mWEJYopV/ZSN9Rm1aZvts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gH4/UJcGR3HLzlbe3F44YebNEQkWLQoR
        snfCsrrF52l82V1k2fXY450WjYVhSPQBe6ft8HEXOlcwQqyMQ8fb86RaaExBkvwi
        CxjcuKEyqYcmW4lpb8TrBaPCMd/i9gDb/jf1bGWQE8K0SP7t98YhTzqupz6Z+flM
        f9Wvxwfu58Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98909D349D;
        Tue,  2 Jan 2018 14:43:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F9CDD349C;
        Tue,  2 Jan 2018 14:43:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCHv2 4/5] unpack-trees: oneway_merge to update submodules
References: <20171219222636.216001-1-sbeller@google.com>
        <20171227225705.73235-1-sbeller@google.com>
        <20171227225705.73235-5-sbeller@google.com>
Date:   Tue, 02 Jan 2018 11:43:09 -0800
In-Reply-To: <20171227225705.73235-5-sbeller@google.com> (Stefan Beller's
        message of "Wed, 27 Dec 2017 14:57:04 -0800")
Message-ID: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A28C08C-EFF5-11E7-8933-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index bf8b602901..ac59524a7f 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2139,6 +2139,9 @@ int oneway_merge(const struct cache_entry * const *src,
>  			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
>  				update |= CE_UPDATE;
>  		}
> +		if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
> +		    !verify_uptodate(old, o))
> +			update |= CE_UPDATE;
>  		add_entry(o, old, update, 0);
>  		return 0;
>  	}

This is more sensible than the previous one that broke same() by
unconditionally checking the working tree state, even when the
machinery is told not to look at the working tree.

The code in the pre-context of this hunk, (i.e. the original one you
are half-way mimicking), we realize that the original cache entry
and the cache entry we are checking out are exactly the same and we
overwrite when we know that the path in the working tree is dirty,
and we are not told to "skip" that path in the working tree
(i.e. sparse checkout).  That happens only when we are told to
o->update and o->reset.

Shouldn't we be setting the update bit only when o->update is in
effect, just like we can see in the pre-context of this hunk?  I do
not know if we need to require o->reset and/or need to pay attention
to the skip worktree bit in this new case.
