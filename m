Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7047C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiAaWyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:54:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63908 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiAaWyW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:54:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 500F8165D3B;
        Mon, 31 Jan 2022 17:54:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+0ZzWt8Yj1ArDIfaGlEemmPS96DNOZ7rBvH5QD
        HlvDw=; b=q9URdWxYUXDgeDAGYWP4GSMMfXEdwubI3bPuwcrKxP2okEDMvkxNE9
        XuDRIozEQSPSSqG4u5l5xuXYNOPJppSbAP6yk1YLPaFh5nERGukiKWynlI/AyXcV
        zta8O+TQQWjlYIF7x9IJJhU5yo5QOHgj6pvZF4UVImPGWxQXPEToY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47F35165D3A;
        Mon, 31 Jan 2022 17:54:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B51AB165D37;
        Mon, 31 Jan 2022 17:54:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V2] patch-id: fix scan_hunk_header on diffs with 1 line
 of before/after
References: <20220125221602.26557-1-jerry@skydio.com>
        <20220129024757.24763-1-jerry@skydio.com>
Date:   Mon, 31 Jan 2022 14:54:18 -0800
In-Reply-To: <20220129024757.24763-1-jerry@skydio.com> (Jerry Zhang's message
        of "Fri, 28 Jan 2022 18:47:57 -0800")
Message-ID: <xmqqr18nh5yd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B97BA3E6-82E8-11EC-979F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Normally diffs will contain a hunk header of the format
> "@@ -2,2 +2,15 @@ code". However in certain situations git can
> omit the second comma separated value in either before or after
> line counts in the case where there is only one line.
>
> This can produce hunk headers that look like
> "@@ -2 +2,18 @@ code" or "@@ -2,2 +2 @@ code".
> As a result, scan_hunk_header mistakenly returns the line
> number as line count, which then results in unpredictable
> parsing errors with the rest of the patch, including giving
> multiple lines of output for a single commit.
>
> Fix by explicitly setting line count to 1 when there is
> no comma, and add a test.
>
> apply.c contains this same logic except it is correct. A
> worthwhile future project might be to unify these two diff
> parsers so they both benefit from fixes.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V1->V2:
> - Removed references to -U1 since this isn't limited to that
> - Added notes for future tasks
>
>  builtin/patch-id.c  |  9 +++++++--
>  t/t4204-patch-id.sh | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 822ffff51f..881fcf3273 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -30,26 +30,31 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
>  
>  	q = p + 4;
>  	n = strspn(q, digits);
>  	if (q[n] == ',') {
>  		q += n + 1;
> +		*p_before = atoi(q);
>  		n = strspn(q, digits);
> +	} else {
> +		*p_before = 1;
>  	}
> +
>  	if (n == 0 || q[n] != ' ' || q[n+1] != '+')
>  		return 0;
>  
>  	r = q + n + 2;
>  	n = strspn(r, digits);
>  	if (r[n] == ',') {
>  		r += n + 1;
> +		*p_after = atoi(r);
>  		n = strspn(r, digits);
> +	} else {
> +		*p_after = 1;
>  	}
>  	if (n == 0)
>  		return 0;
>  
> -	*p_before = atoi(q);
> -	*p_after = atoi(r);
>  	return 1;
>  }
>  
>  static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
>  			   struct strbuf *line_buf, int stable)
> diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
> index 80f4a65b28..34a386aee2 100755
> --- a/t/t4204-patch-id.sh
> +++ b/t/t4204-patch-id.sh
> @@ -36,11 +36,11 @@ test_expect_success 'patch-id output is well-formed' '
>  calc_patch_id () {
>  	patch_name="$1"
>  	shift
>  	git patch-id "$@" >patch-id.output &&
>  	sed "s/ .*//" patch-id.output >patch-id_"$patch_name" &&
> -	test_line_count -gt 0 patch-id_"$patch_name"
> +	test_line_count -eq 1 patch-id_"$patch_name"
>  }
>  
>  get_top_diff () {
>  	git log -p -1 "$@" -O bar-then-foo --
>  }
> @@ -200,6 +200,36 @@ EOF
>  test_expect_success 'patch-id handles no-nl-at-eof markers' '
>  	cat nonl | calc_patch_id nonl &&
>  	cat withnl | calc_patch_id withnl &&
>  	test_cmp patch-id_nonl patch-id_withnl
>  '
> +
> +cat >diffu1 <<\EOF
> +diff --git a/bar b/bar
> +index bdaf90f..31051f6 100644
> +--- a/bar
> ++++ b/bar
> +@@ -2 +2,2 @@
> + b
> ++c
> +diff --git a/car b/car
> +index 00750ed..2ae5e34 100644
> +--- a/car
> ++++ b/car
> +@@ -1 +1,2 @@
> + 3
> ++d
> +diff --git a/foo b/foo
> +index e439850..7146eb8 100644
> +--- a/foo
> ++++ b/foo
> +@@ -2 +2,2 @@
> + a
> ++e
> +EOF
> +
> +test_expect_success 'patch-id handles diffs with one line of before/after'

There is a opening quote for the body missing here.

> +	cat diffu1 | calc_patch_id diffu1 &&
> +	test_config patchid.stable true &&
> +	cat diffu1 | calc_patch_id diffu1stable
> +'
>  test_done
