Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE6C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiFPEXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiFPEXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:23:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022182C11C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:23:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34ADC124220;
        Thu, 16 Jun 2022 00:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ig+74Sgdh4ckhgrbaQBkRnJPLGSsXl5JxaQ3gK
        qAxDk=; b=QeqegSBgh2GJapMPAGbJBgQG/L5Yry687h1dtod+rShWVhT/NLksOU
        fRa5AtrhXDFmDqfORfKvY4LZYvnLkMxB1HYS2mwqL8mXPE78SR2Xs1fLu9tNQng9
        U4JPIMA/R9xbl+21LfrrGbMP8TpCtHka3cr0eddNxptWIH+F/Qqjs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BF1812421E;
        Thu, 16 Jun 2022 00:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8958812421B;
        Thu, 16 Jun 2022 00:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 03/11] submodule--helper: avoid memory leak in
 `update_submodule()`
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:23:04 -0700
In-Reply-To: <877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:37 +0000")
Message-ID: <xmqq35g5xmmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04C180CA-ED2C-11EC-B7E4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/submodule--helper.c | 2 ++
>  1 file changed, 2 insertions(+)


> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5c77dfcffee..d7b8004b933 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2512,6 +2512,8 @@ static int update_submodule(struct update_data *update_data)
>  
>  		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
>  								  update_data->prefix);
> +		free(prefixed_path);
> +

This function has two very similar code block that computes
prefixed_path depending on the same condition, and one frees the
variable correctly while the other one (i.e. this one) forgets to do
so, which is irritating to see.

Perhaps the whole "we have update_data structure, in which
recursive_prefix, sm_path and prefix members in it; please set the
displaypath member based on these values" should become a helper
function, e.g.

	static const char *displaypath_from_update_data(struct update_data *u)
	{
		char *pp, *ret;

		if (u->recursive_prefix)
			pp = xstrfmt("%s%s", u->recursive_prefix, u->sm_path);
		else
			pp = xstrdup(u->sm_path);

		ret = get_submodule_displaypath(pp, u->prefix);
		free(pp);
		return ret;
	}

to avoid duplicated computation.

But the whole thing may become moot, as there seems to be a move to
get rid of submodule--helper.c altogether?

I'll refrain from touching this patch and instead redirect it to
Glen; perhaps removal of submodule--helper.c involves moving the
code here to another file or something, in which case it is far
easier if I outsource that to somebody who is actually working on
the file ;-)

Thanks.

>  		next.prefix = NULL;
>  		oidcpy(&next.oid, null_oid());
>  		oidcpy(&next.suboid, null_oid());
