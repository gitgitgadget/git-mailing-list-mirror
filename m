Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D40C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87942240D
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nU9U1dvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfKTE0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:26:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50271 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTE0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 23:26:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C3102A6DB;
        Tue, 19 Nov 2019 23:26:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=td5G9Mf0b7N6yYqifrmq2mFuK0g=; b=nU9U1d
        vETmyAM4u8aRWuraLAR4KaPbQ9beYvptc0ebz7zyhz1nnowryemuobTJmNIVqctE
        KowI0vvET6S0wNABK1dRf1Up3n+R2/DXEoijxKv+PUKWQJwEFTEW/aDWr1iz3E5L
        J+afnHFMZ6tRVTmR2VephwFgol4CoTgVk/508=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jXhYIZlhrr6p8snD1AzFdlHSMxz2f/TN
        dWpZPo6DQnYpfdADAHoTX2THpFtMGA0CIuHaN00cpKERS887jip6GyLYFn/ps2u5
        meeC62c4bvWSoo8YwpFpHJ1TcrvIVvgnqOioLuUp/VUdnnVH1RfEzTpEGElAiN4t
        Hlan6z4TcYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2DDD2A6DA;
        Tue, 19 Nov 2019 23:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C62D2A6D8;
        Tue, 19 Nov 2019 23:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 7/8] range-diff: passthrough --[no-]notes to `git log`
References: <cover.1574125554.git.liu.denton@gmail.com>
        <cover.1574207673.git.liu.denton@gmail.com>
        <0cb86b383b9c115c9c6077d47f0c124a96b30acf.1574207673.git.liu.denton@gmail.com>
Date:   Wed, 20 Nov 2019 13:26:04 +0900
In-Reply-To: <0cb86b383b9c115c9c6077d47f0c124a96b30acf.1574207673.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 19 Nov 2019 15:55:44 -0800")
Message-ID: <xmqqwobvb2cj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE02AB02-0B4D-11EA-BB3D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When a commit being range-diff'd has a note attached to it, the note
> will be compared as well. However, if a user has multiple notes refs or
> if they want to suppress notes from being printed, there is currently no
> way to do this.
>
> Passthrough `---no--notes` to the `git log` call so that this option is

"`--[no-]notes`" or perhaps "`--[no-]notes` and `--notes=<ref>`"?

I think the verb phrase is two words, "pass through", by the way.

> +--[no-]notes[=<treeish>]::
> +	This flag is passed to the `git log` program
> +	(see linkgit:git-log[1]) that generates the patches.

I can see this was taken from "git log --help", and it probably
needs fixing for consistency as well, but I think --notes=<ref>
would be easier to click users' minds with notes.displayRef
configuration variable.

> @@ -61,8 +62,11 @@ static int read_patches(const char *range, struct string_list *list)
>  			"--output-indicator-new=>",
>  			"--output-indicator-old=<",
>  			"--output-indicator-context=#",
> -			"--no-abbrev-commit", range,
> +			"--no-abbrev-commit",
>  			NULL);
> +	if (other_arg)
> +		argv_array_pushv(&cp.args, other_arg->argv);
> +	argv_array_push(&cp.args, range);

Makes sense.

> diff --git a/range-diff.h b/range-diff.h
> index 08a50b6e98..7d918ab9ed 100644
> --- a/range-diff.h
> +++ b/range-diff.h
> @@ -2,6 +2,7 @@
>  #define RANGE_DIFF_H
>  
>  #include "diff.h"
> +#include "argv-array.h"
>  
>  #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
>  
> @@ -12,6 +13,7 @@
>   */
>  int show_range_diff(const char *range1, const char *range2,
>  		    int creation_factor, int dual_color,
> -		    struct diff_options *diffopt);
> +		    struct diff_options *diffopt,
> +		    struct argv_array *other_arg);
>  
>  #endif

I thought a mere use of "pointer to a struct" did not have to bring
the definition of the struct into the picture?  In other words,
wouldn't it be fine to leave the other_arg a pointer to an opaque
structure by not including "argv-array.h" in this file?

Thanks.
