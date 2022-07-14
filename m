Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0699C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 16:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiGNQ1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiGNQ1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 12:27:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779A61B1E
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 09:27:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A4EA14300C;
        Thu, 14 Jul 2022 12:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tDHEqk93N80P0oh7jKjKr+aGJuulTZqxgwEikd
        NALGY=; b=j2JqAfLS4nHqdntocECVXIDcU1Al0w/HZiijAPdbsKzBIEyU/L7giG
        bNL5wo1esbAIGygd0Fb39MtDexLDt3b71e5Fp9fhaW34cX+zHozkFIWTfxnKPqGx
        RkRgU0VZLhyKF5SM8AjaITuAdDADZoOQB1381GvadeI+YaPXzKH/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4096E14300B;
        Thu, 14 Jul 2022 12:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9956114300A;
        Thu, 14 Jul 2022 12:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
        <pull.1287.v2.git.1657809063728.gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 09:27:33 -0700
In-Reply-To: <pull.1287.v2.git.1657809063728.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 14 Jul 2022 14:31:03
        +0000")
Message-ID: <xmqqy1wv7j7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDE7DE00-0391-11ED-9A0A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  	if $base_present
>  	then
> -		eval "$merge_tool_path" \
> -			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> +		eval '"$merge_tool_path"' \
> +			-f "$FINAL_CMD" '"$LOCAL"' '"$BASE"' '"$REMOTE"' '"$MERGED"'
>  	else
>  		# If there is no BASE (example: a merge conflict in a new file
>  		# with the same name created in both braches which didn't exist
> @@ -424,8 +424,8 @@ merge_cmd () {
>  		FINAL_CMD=$(echo "$FINAL_CMD" | \
>  			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
>  
> -		eval "$merge_tool_path" \
> -			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
> +		eval '"$merge_tool_path"' \
> +			-f "$FINAL_CMD" '"$LOCAL"' '"$REMOTE"' '"$MERGED"'
>  	fi

If there were another syntactic fix we need in the future, we may by
mistake fix one but not the other, and the test we add in this patch
checks only one side but not the other.  In a follow-up we may want
to unify the two eval invocations to make the testing of this part
more robust.

But as a minimum and obvious fix, stopping at the above is
appropriate for this patch.

> + ...
> +	diff -u expect actual || at_least_one_ko=true

I wonder if we still should care about platforms that need to set
GIT_TEST_CMP_USE_COPIED_CONTEXT while running our tests.  If we use
"diff -u" hardcoded like this here, we are declaring that they are
now unwelcome to run our tests.

It might be just the matter of using "cmp -s" here (or run "diff"
without any option).  Do we care about emitting the difference in
the output?  I doubt it.

>  	if test "$at_least_one_ko" = "true"
>  	then
>  		return 255

Thanks.
