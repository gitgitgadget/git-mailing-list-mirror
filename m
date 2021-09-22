Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F7DC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3294A60F24
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhIVXP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:15:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57378 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhIVXP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:15:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10B2CFF995;
        Wed, 22 Sep 2021 19:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=spvZ20QElvA/y5LThAghmjSNKQkZZfSISv38wT
        hHmDQ=; b=YACmtjQCr2x2OAVSHllz9AV/hgC965fUH1UHTW3fvrbrVMo3I08Pmj
        +FTjL/ODrRJM3Oq4Rcb1ExaKoNnnOLfBVwc3m2PRmY49cYZzVV77FS7OcoklLtEN
        8gA4vlm/W6u9Qx8hOg0T2DY6zuQ5yHVsUSvNTHYV1yqHBwKASptbQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07855FF994;
        Wed, 22 Sep 2021 19:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B3D5FF993;
        Wed, 22 Sep 2021 19:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 03/14] dir: extract directory-matching logic
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Sep 2021 16:13:55 -0700
In-Reply-To: <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 20 Sep 2021
        17:45:26 +0000")
Message-ID: <xmqqwnn8430s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2BD3582-1BFA-11EC-8EFB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int path_matches_dir_pattern(const char *pathname,
> +				    int pathlen,
> +				    int *dtype,
> +				    struct path_pattern *pattern,
> +				    struct index_state *istate)
> +{
> +	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
> +	if (*dtype != DT_DIR)
> +		return 0;
> +
> +	return 1;
> +}

The function name and parameter list have "pattern" but as far as I
can see any "matches" or "pattern" comes into the picture.  The code
in the caller after calling this function may be doing pattern
matching, but not this one.

What this helper is doing is "signal if the pathname in the working
tree is supposed to be a directory with the return value, while
filling *dtype with what kind of thing it is."

path_must_be_dir_in_working_tree() or something, perhaps?

> @@ -1327,11 +1340,10 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>  		const char *exclude = pattern->pattern;
>  		int prefix = pattern->nowildcardlen;
>  
> -		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
> -			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
> -			if (*dtype != DT_DIR)
> -				continue;
> -		}
> +		if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
> +		    !path_matches_dir_pattern(pathname, pathlen,
> +					      dtype, pattern, istate))
> +			continue;
>  
>  		if (pattern->flags & PATTERN_FLAG_NODIR) {
>  			if (match_basename(basename,
