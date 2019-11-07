Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964991F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfKGFc6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:32:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53114 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGFc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:32:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45C7336F42;
        Thu,  7 Nov 2019 00:32:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AfizLg/18df4jcRIf84meb9MF0s=; b=Q6tdAq
        whyodb4PHhvJXSvPrQ1ctc1p4qo1HjDHog2m83QbbpuKhga+Az/DTcyU67FVktuw
        ogZ6ZE6Z1a4ZB0yoiDDBDh5mxUAxkmWhLoLmpyEnxUk5ipXHHXS15136bzIUkQ17
        PfuBIxtspXfKN3bVbg/NASEG+9jG5CTwE0/qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n9NNm9gumbNyh7t/k/NEf78PSElKWjKc
        fK5Gdj3YgVzV9NIk3uT0e76/RoOFYbUHPrVE1ZJ8DANkx7liXPRIKcA3J8Kir6fQ
        c7Y9HTelUSa362OSKG+XyzqryxoTS/cfTQjtXEKgcEFqpyhrM2mfNaE5XfWt0N56
        42ZWrmOgVbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D56036F41;
        Thu,  7 Nov 2019 00:32:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8212D36F40;
        Thu,  7 Nov 2019 00:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Chen <erikchen@chromium.org>
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
        <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
        <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 14:32:53 +0900
In-Reply-To: <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
        (Erik Chen via GitGitGadget's message of "Wed, 06 Nov 2019 19:39:12
        +0000")
Message-ID: <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C5223B2-0120-11EA-972C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Erik Chen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Erik Chen <erikchen@chromium.org>
>
> Add trace2 regions to fetch-pack.c to better track time spent in the various
> phases of a fetch:
>
>     * matching common remote and local refs
>     * marking local refs as complete (part of the matching process)
>
> Both of these stages can be slow for repositories with many refs.
>
> Signed-off-by: Erik Chen <erikchen@chromium.org>
> ---
>  fetch-pack.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

OK.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 0130b44112..5e3eee0477 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -669,6 +669,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  
>  	save_commit_buffer = 0;
>  
> +	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
> +
>  	for (ref = *refs; ref; ref = ref->next) {
>  		struct object *o;
>  
> @@ -690,6 +692,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  		}
>  	}
>  
> +	/* This block marks all local refs as COMPLETE, and then recursively marks all
> +	 * parents of those refs as COMPLETE.
> +	 */

        /*
         * We write our multi-line comments like this, with the
         * slash-asterisk at the beginning and the asterisk-slash
         * at the end on its own line.  Learn such local conventions
         * from the existing surrounding code and imitate, which
         * would reduce stylistic errors.
         */

Will fix-up while queuing (no need to reroll only to fix this).

> +	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
>  	if (!args->deepen) {
>  		for_each_ref(mark_complete_oid, NULL);
>  		for_each_cached_alternate(NULL, mark_alternate_complete);
> @@ -697,6 +703,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  		if (cutoff)
>  			mark_recent_complete_commits(args, cutoff);
>  	}
> +	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
>  
>  	/*
>  	 * Mark all complete remote refs as common refs.
> @@ -716,6 +723,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	}
>  
>  	save_commit_buffer = old_save_commit_buffer;
> +	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);


So this introduces a single region around the entire function body
of mark_complete_and_common_ref(), within which only one subpart is
also enclosed in a nested region.  Is that because the parts inside
the outer region before and after the inner region are known to
consume negligible time?  IOW I would understand

        F () {
                <region 1 begin>
                    <region 1.1 begin>
                        code
                    <region 1.1 end>
                    <region 1.2 begin>
                        code
                    <region 1.2 end>
                    <region 1.3 begin>
                        code
                    <region 1.3 end>
                <region 1 end>
        }

or

        F () {
                        trivial code
                <region 1 begin>
                        heavy code
                <region 1 end>
                        trivial code
        }

but this appears to do


        F () {
                <region 1 begin>
                        code
                    <region 1.1 begin>
                        code
                    <region 1.1 end>
                        code
                <region 1 end>
        }

which is somewhat puzzling.

Thanks.
