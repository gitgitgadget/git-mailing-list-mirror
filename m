Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB7BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350101AbiCUUeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbiCUUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:34:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2E396A8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:33:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA9C9109593;
        Mon, 21 Mar 2022 16:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YuaGFAWC+wlADcvNaELBle6kiPg+eDZG0+i9hF
        VnviQ=; b=m573BT8b3AZB3H38uZHKX1DwFwFxwpMkVkGjGZN4LTA2M75smb5ebt
        pDKootjbLvCtJpO4L5U0k/5whZ4KdIFjNg+PhysL0N5abIhIyQvM7874RBO/321L
        pF8ZUxiHPKW4iajs6fUix0yIZPv/LiC82UzFYdj+Zsq0JwzaDFkjo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0777109592;
        Mon, 21 Mar 2022 16:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80769109590;
        Mon, 21 Mar 2022 16:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] for-each-ref: respect GIT_REF_PARANOIA setting
References: <7283f826198aaec94c847f0b26e228ace9a38433.1647880211.git.me@ttaylorr.com>
Date:   Mon, 21 Mar 2022 13:33:04 -0700
In-Reply-To: <7283f826198aaec94c847f0b26e228ace9a38433.1647880211.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 21 Mar 2022 12:30:18 -0400")
Message-ID: <xmqqzgljvyf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D53902A-A956-11EC-A274-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +	ret = filter_refs(&array, &filter, FILTER_REFS_ALL);
> +	if (ret)
> +		goto cleanup;
>  	ref_array_sort(sorting, &array);

Fixing the "regression" would be a simple matter of removing the
early return from here, and instead show what we have collected?

>  	if (!maxcount || array.nr < maxcount)
> @@ -91,11 +93,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		putchar('\n');
>  	}
>  
> +cleanup:
>  	strbuf_release(&err);
>  	strbuf_release(&output);
>  	ref_array_clear(&array);
>  	free_commit_list(filter.with_commit);
>  	free_commit_list(filter.no_commit);
>  	ref_sorting_release(sorting);
> -	return 0;
> +	return ret;
>  }
> diff --git a/ref-filter.c b/ref-filter.c
> index 7838bd22b8..f9667f6ca4 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2249,7 +2249,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  
>  	if (flag & REF_ISBROKEN) {
>  		warning(_("ignoring broken ref %s"), refname);
> -		return 0;
> +		return 1;
>  	}

Ah, no, not really.  This causes us to stop iterating prematurely.

If we are iterating because we want to find any breakage, such an
early stop in iteration makes good sense, but most of the time, we
are not, and it is questionable if such an early return makes much
sense.

I suspect that a handler may need to keep going, while recording a
bit for each ref it collects.  ref_array_item may or may not have (I
do not know offhand) already a bit in its flag word to signal a broken
ref that we can carry this information out to the callers?
