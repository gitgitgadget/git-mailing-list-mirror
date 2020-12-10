Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E56C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03E523B53
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgLJChW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:37:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65142 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgLJChP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:37:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0A9B112B43;
        Wed,  9 Dec 2020 21:36:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1Xc1xdzIztyG4GqMk2wLQwKagU=; b=bblOlq
        TG672c8QTodk9s4hmhaNjcq3/nreXsiNlrN3oYR40/KouuIUjzYLS+H0BUKcySIG
        qfedzjFAdhXc/CB7ocuHbyd8ePUlzgE1t17PrEIgcOwQuO/ykuMqKIHuRDFh3DS1
        vuPKUDZVbyWy7p3WWZc7lNUn2FmL8JG/ek7U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xwH2Ef/ldgZhSREisULha1hm8Nbcv5HA
        TBzq6wLc1HMfRs2zLRMEczVTlIqTxhQhFczSbeT5DwuUKda+O26Mftw8vXlzVccM
        bx771Ar6O4buoc7Q89RhAcgTsHHeV6daXPsRRyaixYjzKeYncmGBpWTaatX6T3R7
        kUJyCv9Bf4E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9BB9112B42;
        Wed,  9 Dec 2020 21:36:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4051F112B40;
        Wed,  9 Dec 2020 21:36:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] diffcore-rename: reduce jumpiness in progress counters
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <e8257516c1f983d590b8a81fb32ecd5cb91dc737.1607223276.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 18:36:26 -0800
In-Reply-To: <e8257516c1f983d590b8a81fb32ecd5cb91dc737.1607223276.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 06 Dec 2020
        02:54:34 +0000")
Message-ID: <xmqqh7ouxu8l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 813B5324-3A90-11EB-97B2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Inexact rename detection works by comparing all sources to all
> destinations, computing similarities, and then finding the best matches
> among those that are sufficiently similar.

Here, you are using <sources, destinations> as contrasting pair of
words, which supports my comment on 1/7 and 3/7 ;-)

> However, it is preceded by exact rename detection that works by
> checking if there are files with identical hashes.  If exact renames are
> found, we can exclude some files from inexact rename detection.
>
> The inexact rename detection loops over the full set of files, but
> immediately skips those for which rename_dst[i].is_rename is true and
> thus doesn't compare any sources to that destination.  As such, these
> paths shouldn't be included in the progress counter.
> ...
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 7270eb6af48..3d637ba4645 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -587,7 +587,7 @@ void diffcore_rename(struct diff_options *options)
>  	if (options->show_rename_progress) {
>  		progress = start_delayed_progress(
>  				_("Performing inexact rename detection"),
> -				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
> +				(uint64_t)num_targets * (uint64_t)rename_src_nr);
>  	}

The num_targets (number of destinations) holds the "remaining"
candidates after exact renames are taken care of, so this reduces
the size of the matrix used to count the progress meter.  OK.

>  	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
> @@ -626,7 +626,8 @@ void diffcore_rename(struct diff_options *options)
>  			diff_free_filespec_blob(two);
>  		}
>  		dst_cnt++;
> -		display_progress(progress, (uint64_t)(i+1)*(uint64_t)rename_src_nr);
> +		display_progress(progress,
> +				 (uint64_t)dst_cnt * (uint64_t)rename_src_nr);

And this fills the progress meter by using the number of
destinations that are actually considered.  Between the two hunks,
there is a "if the source of this destination is already known, move
to next 'i'" continue, that does not update the progress meter.
Changing (i+1) to dst_cnt here compensates for the reduction of the
matrix size we see above.

Makes sense.  This looks good.

>  	}
>  	stop_progress(&progress);
