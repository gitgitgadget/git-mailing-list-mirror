Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45BC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9520261176
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhELXzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:55:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54452 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbhELXuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:50:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32CDBCDC83;
        Wed, 12 May 2021 19:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KdMzMV/XZVR16bFp1myQ3myMn+2wraLtRpRdqH
        p47/g=; b=vVl9q69fSDggDPBUVelBoC8kpZkgVHlyHq99sAE4rVBhTae93Ljd76
        56z0yU0J8QP/dhGczKHzUnkKyOZrPW1O/pknEi6Z53gUQ1vlMS9kfHZrXwtN/g9r
        oieD8KDzaFMy21I1HfBjMvvF5CB68h5DiKtNqRIzDPgNQnm2SURGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28FD9CDC82;
        Wed, 12 May 2021 19:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8DA2CDC81;
        Wed, 12 May 2021 19:48:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] stash show: fix segfault with
 --{include,only}-untracked
References: <cover.1620850247.git.liu.denton@gmail.com>
        <24de72b34de45980196ed6df8b64782887e94f36.1620850247.git.liu.denton@gmail.com>
Date:   Thu, 13 May 2021 08:48:55 +0900
In-Reply-To: <24de72b34de45980196ed6df8b64782887e94f36.1620850247.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 12 May 2021 13:16:13 -0700")
Message-ID: <xmqq35urecns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D0C38D8-B37C-11EB-9E22-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When `git stash show --include-untracked` or
> `git stash show --only-untracked` is run on a stash that doesn't include
> an untracked entry, a segfault occurs. This happens because we do not
> check whether the untracked entry is actually present and just attempt
> to blindly dereference it.
>
> Ensure that the untracked entry is present before actually attempting to
> dereference it.

Makes sense.  Thanks.

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/stash.c                    |  8 ++++++--
>  t/t3905-stash-include-untracked.sh | 15 +++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 8922a1240c..82e4829d44 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -900,10 +900,14 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  		diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
>  		break;
>  	case UNTRACKED_ONLY:
> -		diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
> +		if (info.has_u)
> +			diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
>  		break;
>  	case UNTRACKED_INCLUDE:
> -		diff_include_untracked(&info, &rev.diffopt);
> +		if (info.has_u)
> +			diff_include_untracked(&info, &rev.diffopt);
> +		else
> +			diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
>  		break;
>  	}
>  	log_tree_diff_flush(&rev);
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 2e6796725b..1c9765928d 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -405,4 +405,19 @@ test_expect_success 'stash show --include-untracked errors on duplicate files' '
>  	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
>  '
>  
> +test_expect_success 'stash show --{include,only}-untracked on stashes without untracked entries' '
> +	git reset --hard &&
> +	git clean -xf &&
> +	>tracked &&
> +	git add tracked &&
> +	git stash &&
> +
> +	git stash show >expect &&
> +	git stash show --include-untracked >actual &&
> +	test_cmp expect actual &&
> +
> +	git stash show --only-untracked >actual &&
> +	test_must_be_empty actual
> +'
> +
>  test_done
