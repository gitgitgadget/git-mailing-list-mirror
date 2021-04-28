Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F19C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAEE613F9
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhD1EFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:05:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52777 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhD1EFV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:05:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1F29123C5C;
        Wed, 28 Apr 2021 00:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m2hwES0halJwpg2iB5VtCe7wDWdZF/XcFJO7Xh
        GA5hE=; b=eXwrZa+951LV1sohAmxko3L8q28MctxPcb+4elTiN+Eh9jzgxdOaHi
        7PilU7haBJOCgvfQabdb798t75LySppJX18uDcL2R78ORZqTb/QYBU1fheHG1wJU
        6KQXBsV5qDlWLJak3szZYa47gaLqzBI0BDYTwb185VARy6TsQBMwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA475123C5B;
        Wed, 28 Apr 2021 00:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D3D6123C58;
        Wed, 28 Apr 2021 00:04:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
        <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
Date:   Wed, 28 Apr 2021 13:04:32 +0900
In-Reply-To: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com> (Josh
        Soref via GitGitGadget's message of "Thu, 22 Apr 2021 00:55:06 +0000")
Message-ID: <xmqqbl9zcawf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D744193C-A7D6-11EB-A297-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> Usually, it is easier to read a message if it makes its primary
> point first, before giving a parenthetical note.
>
> Possible messages before include:
> ` (nothing to squash)Already up to date.
> `
> and
> `Already up to date. Yeeah!
> `
>
> After:
> `Already up to date (nothing to squash).
> `
> and
> `Already up to date.
> `
>
> Localizations now have two easy to understand translatable strings.
> (All localizations of the previous strings are broken.)
>
> Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---

I am not sure why this is Co-au, and not the more usual "Helped-by".

The patch text makes sense to me.

Thanks.


> diff --git a/builtin/merge.c b/builtin/merge.c
> index 062e91144125..f8c3d0687eaf 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -380,10 +380,14 @@ static void restore_state(const struct object_id *head,
>  }
>  
>  /* This is called when no merge was necessary. */
> -static void finish_up_to_date(const char *msg)
> +static void finish_up_to_date(void)
>  {
> -	if (verbosity >= 0)
> -		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
> +	if (verbosity >= 0) {
> +		if (squash)
> +			puts(_("Already up to date (nothing to squash)."));
> +		else
> +			puts(_("Already up to date."));
> +	}
>  	remove_merge_branch_state(the_repository);
>  }
>  
> @@ -1482,7 +1486,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		 * If head can reach all the merge then we are up to date.
>  		 * but first the most common case of merging one remote.
>  		 */
> -		finish_up_to_date(_("Already up to date."));
> +		finish_up_to_date();
>  		goto done;
>  	} else if (fast_forward != FF_NO && !remoteheads->next &&
>  			!common->next &&
> @@ -1566,7 +1570,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			}
>  		}
>  		if (up_to_date) {
> -			finish_up_to_date(_("Already up to date. Yeeah!"));
> +			finish_up_to_date();
>  			goto done;
>  		}
>  	}
>
> base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
