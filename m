Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1861FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbdCGWmx (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 17:42:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933046AbdCGWmw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 17:42:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B5FA7F0DE;
        Tue,  7 Mar 2017 17:42:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bCGjG81sUa8+vkMZa/H3WjJjOrA=; b=mmwPgHtt6MJhoAJ5UcGO
        MIf4l8xxZ1Jl90XfetBeNhNRsLSHRo46UGqG6e2Nz+zASJm9pEqIzsX+uTf43MsS
        henKYs/dl5fOvHfOihAGd6jqBSw96d2bGF5Rri3DOGyVWHSMOINEdx7EXpvLaN4J
        LD0EBIrRVIu46YjfB1y9diQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=P7VqsDBVPsDRJSiU2Z0Eusqzaq7lm+XWryI/6fPERJqU2w
        9Qrx/7swp2sOglK/FEMO4RiKmn1+G6cY+o5IkoKx06waTzL06SXngd4T0EPH8YPm
        Bs+BxPNB/DDSXlzptq0Njl370K1cGssaowbVw5upQNz4nLIDdxi5YSCHDsmj4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71FB27F0DD;
        Tue,  7 Mar 2017 17:42:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA7C67F0DC;
        Tue,  7 Mar 2017 17:42:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe selected submodules.
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-16-sbeller@google.com>
Date:   Tue, 07 Mar 2017 14:42:48 -0800
Message-ID: <xmqqfuio674n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64631EB0-0387-11E7-B788-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  read-cache.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 9054369dd0..9a2abacf7a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -18,6 +18,8 @@
>  #include "varint.h"
>  #include "split-index.h"
>  #include "utf8.h"
> +#include "submodule.h"
> +#include "submodule-config.h"
>  
>  /* Mask for the name length in ce_flags in the on-disk index */
>  
> @@ -520,6 +522,22 @@ int remove_index_entry_at(struct index_state *istate, int pos)
>  	return 1;
>  }
>  
> +static void remove_submodule_according_to_strategy(const struct submodule *sub)
> +{
> +	switch (sub->update_strategy.type) {
> +	case SM_UPDATE_UNSPECIFIED:
> +	case SM_UPDATE_CHECKOUT:
> +	case SM_UPDATE_REBASE:
> +	case SM_UPDATE_MERGE:
> +		submodule_move_head(sub->path, "HEAD", NULL, \

What is this backslash doing here?

> +				    SUBMODULE_MOVE_HEAD_FORCE);
> +		break;
> +	case SM_UPDATE_NONE:
> +	case SM_UPDATE_COMMAND:
> +		; /* Do not touch the submodule. */
> +	}
> +}
> +
>  /*
>   * Remove all cache entries marked for removal, that is where
>   * CE_REMOVE is set in ce_flags.  This is much more effective than
> @@ -532,8 +550,13 @@ void remove_marked_cache_entries(struct index_state *istate)
>  
>  	for (i = j = 0; i < istate->cache_nr; i++) {
>  		if (ce_array[i]->ce_flags & CE_REMOVE) {
> -			remove_name_hash(istate, ce_array[i]);
> -			save_or_free_index_entry(istate, ce_array[i]);
> +			const struct submodule *sub = submodule_from_ce(ce_array[i]);
> +			if (sub) {
> +				remove_submodule_according_to_strategy(sub);
> +			} else {
> +				remove_name_hash(istate, ce_array[i]);
> +				save_or_free_index_entry(istate, ce_array[i]);
> +			}

I cannot readily tell as the proposed log message is on the sketchy
side to explain the reasoning behind this, but this behaviour change
is done unconditionally (in other words, without introducing a flag
that is set by --recurse-submodules command line flag and switches
behaviour based on the flag) here.  What is the end-user visible
effect with this change?  Can we have a new test in this same patch
to demonstrate the desired behaviour introduced by this change (or
the bug this change fixes)?

>  		}
>  		else
>  			ce_array[j++] = ce_array[i];
