Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55943C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiCXSn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbiCXSnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:43:55 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB08A6E08
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:42:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 754ED186249;
        Thu, 24 Mar 2022 14:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j1T7+Vnz6EDBf5xHnX2PTVNBsNxD/MbPFs0TXu
        LDXng=; b=Fq7ES2qwYdfTrxL1M1CnbWaxKcgiV0m8/DkMM4IM5QXbQN02vTx51b
        N+b1iSgBpLBV8hhsxSLPh1kbXD71dAWg1+ZoyOzHsQgDc64XMZT2MUX4cBHYRVkV
        fA8rMRQLHnvWV138zuXbpP/p6WSai0cyVsuEO+RMMHxrhR0O0jDAY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E073186248;
        Thu, 24 Mar 2022 14:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6DBD186247;
        Thu, 24 Mar 2022 14:42:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com,
        derrickstolee@github.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 3/3] bitmap: add trace outputs during open "bitmap" file
References: <cover.1648119652.git.dyroneteng@gmail.com>
        <9912450fc11f869ad1b6409d7adcfe20f06c17ff.1648119652.git.dyroneteng@gmail.com>
Date:   Thu, 24 Mar 2022 11:42:13 -0700
In-Reply-To: <9912450fc11f869ad1b6409d7adcfe20f06c17ff.1648119652.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 24 Mar 2022 19:44:01 +0800")
Message-ID: <xmqqy20zgpkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FD84BEE-ABA2-11EC-81D4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> It's supported for a Git repo to use bitmap in both normal bitmap way
> or a multi-pack-index bitmap.

This step out of 3 patches does match what was sold on the cover
letter, and it does not seem to even need the other two.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  midx.c        | 2 ++
>  pack-bitmap.c | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/midx.c b/midx.c
> index 865170bad0..fda9644028 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -392,6 +392,8 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
>  	struct multi_pack_index *m_search;
>  
>  	prepare_repo_settings(r);
> +	trace2_data_string("midx", r, "core.multipackIndex",
> +					   r->settings.core_multi_pack_index ? "true" : "false");

That's an overly deep contination line.

>  	if (!r->settings.core_multi_pack_index)
>  		return 0;
>  
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index b1357137bf..14cf8abebd 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -490,6 +490,8 @@ static int open_pack_bitmap(struct repository *r,
>  		}
>  	}
>  
> +	trace2_data_string("bitmap", the_repository, "open bitmap (non-midx)",
> +					   ret ? "failed" : "ok");

Likewise.

>  	return ret;
>  }
>  
> @@ -507,6 +509,8 @@ static int open_midx_bitmap(struct repository *r,
>  			break;
>  		}
>  	}
> +	trace2_data_string("midx", the_repository, "open bitmap (midx)",
> +					   ret ? "failed" : "ok");

Likewise.

>  	return ret;
>  }
