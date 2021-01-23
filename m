Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC5C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA76229C5
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 17:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbhAWR4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 12:56:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbhAWR4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 12:56:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B9E49CE70;
        Sat, 23 Jan 2021 12:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8TaShqBkm9xsN9pL1YZAqNZ90Uc=; b=LxppxZ
        KgVJKkfzVoBDjzDvyXCEdlfSNNxiNcg8sciiEzNBIXW/OUKx2b/TLiOAHQbcbYZ4
        GzAcuwXgeaVKrnvkj3/bIRRgwHIIEshiASTNei9YlIo3x4zr4uih51E9cARtJg+2
        Hd3npKaxMfXignvo3n/SOZdWEXwZWCPeAjlbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLBpqu/Sfn3vsIJ9VKh2Cjd27/GmaC9F
        HXqzp2+Yje5sjLJmFjVvkSsrMjhpAazdlyWO+k5mjjlUJYxVSHszi974f/k/B/Bd
        DITMJSVx0pmDZQcPBea+lqWn7xOi95gmlYsSHTDrkBpGchfuyjrDZRFKNnZxGWER
        qbmL6Ws81dA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 319D19CE6F;
        Sat, 23 Jan 2021 12:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5A1E9CE6E;
        Sat, 23 Jan 2021 12:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 1/3] ls_files.c: bugfix for --deleted and --modified
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <fbc38ce9075d3d28187351b0fb6b34a27ec431fd.1611397210.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 09:55:22 -0800
In-Reply-To: <fbc38ce9075d3d28187351b0fb6b34a27ec431fd.1611397210.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 23 Jan 2021 10:20:08
        +0000")
Message-ID: <xmqqwnw34jxx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AB76178-5DA4-11EB-ABBE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> This situation may occur in the original code: lstat() failed
> but we use `&st` to feed ie_modified() later.
>
> Therefore, we can directly execute show_ce without the judgment of
> ie_modified() when lstat() has failed.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/ls-files.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Looks good.  I think we are finished with this part, except for one
nit.

> +			if (stat_err && show_deleted)
>  				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> -			if (show_modified && ie_modified(repo->index, ce, &st, 0))
> -				show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +			if (show_modified &&
> +				(stat_err || ie_modified(repo->index, ce, &st, 0)))
> +					show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  		}

The last line is misindented by having one leading horizontal tab
too many.  show_ce() for modified files and show_ce() for deleted
files are done independently under different conditions and stand as
equals, so the beginning of them should align to show that.

Perhaps format the last three lines more like so:

			if (show_modified &&
			    (stat_err || ie_modified(repo->index, ce, &st, 0)))
				show_ce(repo, dir, ce, fullname.buf, tag_modified);

Again this would cascade throughout the sreies, but let's see if
there are other things we may want to change in the rest of the
series first.  Otherwise, instead of having you rebase, I probably
have time to tweak the series on my end while queuing.

Thanks.
