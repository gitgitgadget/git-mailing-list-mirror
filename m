Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F4C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915FC2078D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IBFcDS+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgIQRBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:01:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53483 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgIQRAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 13:00:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35B6886982;
        Thu, 17 Sep 2020 13:00:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4YPVa3riZtznBc+3w0Gi3MKY7Ek=; b=IBFcDS
        +b2RT0Mqjj0ZMAl6F/ggo5KOf/pkQZRGKDmiN3dmHSH76hbtz7IfUdgN4l4jdkga
        vSPRCf1g2VhPYRtuHZfTo5d5q1b9kEAXabApGcEl48kHK1acmx2Oo0+JFJ3Q6D08
        8ewvEyshQzZkZAudmCRFla6kira0IkqiAIuPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LZmd2YYXjtp8ndhyTgc82VQW1anJIrXJ
        ZeAVgAmXSnpUlOO/tzue/f0/UH2WofYQRYwNyGW7n0ScLLbsB+BSQi9MxpIJspGB
        Psu+FDfvc+3lZIhK0WN9j+/5t/kpmFlTBlcx/6ySCFI6zuU5CtZzIyqZ1/CnLQc/
        aLiHNRlVveE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E07586981;
        Thu, 17 Sep 2020 13:00:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6F2386980;
        Thu, 17 Sep 2020 13:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] diff-lib: accept option flags in run_diff_index()
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <496908ac10152edb9cbcfdb75c43b1d00e163e3c.1600328335.git.liu.denton@gmail.com>
Date:   Thu, 17 Sep 2020 10:00:37 -0700
In-Reply-To: <496908ac10152edb9cbcfdb75c43b1d00e163e3c.1600328335.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 17 Sep 2020 00:44:09 -0700")
Message-ID: <xmqqh7rws5hm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FCB1128-F907-11EA-8302-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 50521e2093..0a0e69113c 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -518,7 +518,7 @@ static int diff_cache(struct rev_info *revs,
>  	return unpack_trees(1, &t, &opts);
>  }
>  
> -int run_diff_index(struct rev_info *revs, int cached)
> +int run_diff_index(struct rev_info *revs, unsigned int option)
>  {
>  	struct object_array_entry *ent;

If we introduce

	int cached = !!(option & DIFF_INDEX_CACHED);

we do not have to touch the remainder of the function, and it makes
it easier to read the place(s) where 'cached' is used.  At that
point, the fact that we were instructed by a bit in the option flag
word is much much less important than we were instructed to compare
the tree-ish with the index and not the working tree files.

The same technique is used with DIFF_RACY_IS_MODIFIED flag in
run_diff_files().

> diff --git a/diff.h b/diff.h
> index e0c0af6286..0cc874f2d5 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -585,7 +585,8 @@ const char *diff_aligned_abbrev(const struct object_id *sha1, int);
>  /* report racily-clean paths as modified */
>  #define DIFF_RACY_IS_MODIFIED 02
>  int run_diff_files(struct rev_info *revs, unsigned int option);
> -int run_diff_index(struct rev_info *revs, int cached);
> +#define DIFF_INDEX_CACHED 01
> +int run_diff_index(struct rev_info *revs, unsigned int option);

It is unclear from the above if the option word for run_diff_files()
and run_diff_index() share the same bit assignment.  After reading
the series through to the end, I know they are independent set of
bits and never shared, but I wonder if we can make it more obvious
here.

Perhaps an extra blank line before this new #define is sufficient to
make it clear?
