Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B41C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D7206B6
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nHvU9AOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBMWWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:22:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55647 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMWWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 17:22:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64DB3404CF;
        Thu, 13 Feb 2020 17:22:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1j+DUzU4iSny/9U77kYgd1YSglk=; b=nHvU9A
        OMQan93oXvPbwE58fxCLmFOTzCOgLcL7DHmYu4OLztzPAE9UJRkBLIjazuTshPK1
        ImIfww2ZDxL7p77lewrVN188mFy1+PfKaQEempaIAoHVsvsbqPlsCJD2HekeaxBp
        /Itac27pmroTuqScmw4l6sKAlGYYxD//A6pY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K6/DbrAQTFAJhVT77KIYf5M3BMwHh6De
        XpjxCvuEbh5iKD8wKCg7QXEWdlcvlH54LLhNRL0MNg6tJPX4Oztwsq5tYm+uV+rP
        rihfIazNrMK4YcgFAdUtdWRmWZ/JJhf0Ddamby3IUclXLlvJY5ErHsBDKyLmfM8R
        2mi9cKVOsno=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BA3D404CE;
        Thu, 13 Feb 2020 17:22:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0788404CD;
        Thu, 13 Feb 2020 17:22:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/13] rev-list: use bitmap filters for traversal
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213022125.GI1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 14:22:07 -0800
In-Reply-To: <20200213022125.GI1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:21:25 -0500")
Message-ID: <xmqqblq2qga8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45F372CE-4EAF-11EA-8805-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This just passes the filter-options struct to prepare_bitmap_walk().
> Since the bitmap code doesn't actually support any filters yet, it will
> fallback to the non-bitmap code if any --filter is specified. But this
> lets us exercise that rejection code path, as well as getting us ready
> to test filters via rev-list when we _do_ support them.

So we used to look at filter_options.choice and declared any filter
is incompatible with use_bitmap_index quite early, but now we let
each of the try_bitmap_*() helpers check what is in the filter and
make their own decisions.

Of course, the prepare_bitmap_walk() call at the beginning of these
helpers does not know how to work with any filter at this point in
the series, so all of the above cancel out :-).

Makes sense.

I wonder if the "revs.prune" thing that forces use_bitmap_index off
should also move to prepare_bitmap_walk() at some point in the
series (or after the current series is done).  After all, the point
of introducing try_bitmap_*() helpers was to let these bitmap
specific logic to know what is and is not compatible with the bitmap
routines.

Thanks.

> @@ -441,7 +443,7 @@ static int try_bitmap_traversal(struct rev_info *revs)
>  	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
>  		return -1;
>  
> -	bitmap_git = prepare_bitmap_walk(revs, NULL);
> +	bitmap_git = prepare_bitmap_walk(revs, filter);
>  	if (!bitmap_git)
>  		return -1;
>  
> @@ -612,7 +614,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	    (revs.left_right || revs.cherry_mark))
>  		die(_("marked counting is incompatible with --objects"));
>  
> -	if (filter_options.choice || revs.prune)
> +	if (revs.prune)
>  		use_bitmap_index = 0;
>  
>  	save_commit_buffer = (revs.verbose_header ||
> @@ -625,9 +627,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		progress = start_delayed_progress(show_progress, 0);
>  
>  	if (use_bitmap_index) {
> -		if (!try_bitmap_count(&revs))
> +		if (!try_bitmap_count(&revs, &filter_options))
>  			return 0;
> -		if (!try_bitmap_traversal(&revs))
> +		if (!try_bitmap_traversal(&revs, &filter_options))
>  			return 0;
>  	}
