Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB0C3DA4D
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 16:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351947AbjHQQMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351973AbjHQQMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 12:12:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2530F6
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 09:12:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EDA234FF7;
        Thu, 17 Aug 2023 12:12:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qe0I2yvr+Jl81pB4WORZacEIfOPqfrBe2/2gay
        I2vts=; b=JV8MlXkhdi2rYF4bZx0WtcT8XBQb42nZgNF1wWpUkWNiIrZnUKJTuI
        QcukPQ1LSXRnsM9w4bua04RqyJZ9rci+XJ6JhRlOdUlvebwJagybh9GXbgWmWR5c
        oPRDbZxaErgWEbqttoBe3oi1r6ijsQJfBHy97ZN2fXdyn4rHQKNVg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6765934FF6;
        Thu, 17 Aug 2023 12:12:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5ECC534FF5;
        Thu, 17 Aug 2023 12:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Paul Watson <pwatson2@wellmed.net>
Subject: Re: [PATCH] diff: tighten interaction between -w and --exit-code
References: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
        <xmqqbkfh8nu3.fsf@gitster.g> <xmqqv8ded018.fsf@gitster.g>
        <20230817051059.GA3006160@coredump.intra.peff.net>
Date:   Thu, 17 Aug 2023 09:12:09 -0700
In-Reply-To: <20230817051059.GA3006160@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 17 Aug 2023 01:10:59 -0400")
Message-ID: <xmqqy1i9bqcm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1D5E3CA-3D18-11EE-88FD-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For the diffstat case, I think we could check the mode here, but there
> are other cases (e.g., adding or deleting an empty file). The code right
> below the hunk I quoted seems to try to deal with that (the "cancelling
> the no-op" your comment mentions). I'm not sure if we want something
> like this:
>
> diff --git a/diff.c b/diff.c
> index 38b57b589f..1dbfdaeff0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3853,6 +3853,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  				&& one->mode == two->mode) {
>  				free_diffstat_file(file);
>  				diffstat->nr--;
> +			} else {
> +				o->found_changes = 1;
>  			}
>  		}
>  	}

That is much better.  In all cases where the above diffstat->nr-- is
not reached and diffstat is kept is where we found changes, so an
even simpler solution that fundamentally cannot go wrong would be to
see "diffstat->nr" at the end (i.e. "are we going to show diffstat
for *any* filepair?").  If it is non-zero, we did find a difference.

Then we do not have to wonder if that else clause is in the right
place, or we have to do something similar to the above for cases
where DIFF_FILE_VALID() is not true for both sides (i.e. creation or
deletion).

Thanks.



