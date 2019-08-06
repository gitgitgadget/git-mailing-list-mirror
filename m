Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8411F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbfHFR0G (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:26:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60665 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:26:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5CF2166FA5;
        Tue,  6 Aug 2019 13:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVYGMU36OTqZMi5Iolkj5zPR0m0=; b=n8raIX
        +EIY+yHQcmu2qq/YgXGiA54qCTN3AXBt/g4OCfdwLug/AsyeHThrzxB8zzmsuJN3
        SBYNQVZgvS3r07AN7m+HXQbhE6H56XcxvBiXFM98pnh+eozXp1gc9flLGtglfV6e
        Wq7JOFHAHOeEdYa94jstO2Vl3TvIJFIoUr5HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=igDl3tc3pD7JBF37QmwDYD2qhBZGgC0v
        Z2IhkmNdNa+ADR3T3Sd2276XPoSsY6957vPhS9mj7v6iJRpUhhPbQsN20wbbKUvI
        0OernRXmHLO71ETJPP1jbrPb2SxZf7zt/MliExalzTpCh+wOWX6tfUQpajUoP3ZH
        DdjDA5gDc60=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE050166FA4;
        Tue,  6 Aug 2019 13:26:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13506166FA3;
        Tue,  6 Aug 2019 13:26:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in recursive case
References: <20190726220928.GG113966@google.com>
        <20190805223350.27504-1-newren@gmail.com>
Date:   Tue, 06 Aug 2019 10:26:02 -0700
In-Reply-To: <20190805223350.27504-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 5 Aug 2019 15:33:50 -0700")
Message-ID: <xmqqwofqjjdh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43DD05A8-B86F-11E9-842A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I know this bug doesn't satisfy the normal criteria for making it into
> 2.23 (it's a bug that was present in 2.22 rather than a regression in
> 2.23), but given that it's a BUG() condition, I was hoping it is
> important and safe enough to include anyway.

For maintenance and upcoming release, a safer "fix" to do might be
to also (in addition to this patch) flip the default to no to revert
to the stable state before "directory renames" was introduced, while
still allowing those who want to help can explore the right fix to
this codepath.

> (This fix does merge down cleanly to master, next, and pu.)
>
>  merge-recursive.c                   |   3 +-
>  t/t6043-merge-rename-directories.sh | 111 ++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d2e380b7ed..c7691d9b54 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2856,7 +2856,8 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	head_pairs = get_diffpairs(opt, common, head);
>  	merge_pairs = get_diffpairs(opt, common, merge);
>  
> -	if (opt->detect_directory_renames) {
> +	if ((opt->detect_directory_renames == 2) ||
> +	    (opt->detect_directory_renames == 1 && !opt->call_depth)) {


