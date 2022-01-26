Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5229DC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 05:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiAZFNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:13:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53276 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiAZFN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 00:13:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F193171743;
        Wed, 26 Jan 2022 00:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=sREo9FOyosvPXrYEV0Mnc312YTKNHAEJr7XUw+
        dprdg=; b=Nm+kyF2T5ETHT2g0USu3qSLKIC9YeGt99LKARcXncY8sVfdLZ66txh
        41vkhDy6sgprbKWo85hdP6vx7z19qLbnPI4WLShPBxla8immijZftp+bzZmyBdvQ
        tz/W9+cHYBRMZ7E35qzzyFcO/2TYusmwdp42XxaYQy3CdAt8B3DPA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08B08171742;
        Wed, 26 Jan 2022 00:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73409171711;
        Wed, 26 Jan 2022 00:13:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] patch-id: fix scan_hunk_header on diffs with -U1
In-Reply-To: <20220125221602.26557-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 25 Jan 2022 14:16:02 -0800")
References: <20220125221602.26557-1-jerry@skydio.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Tue, 25 Jan 2022 21:13:25 -0800
Message-ID: <xmqqtudrt6yy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B11CD660-7E66-11EC-9B26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Normally diffs will contain a hunk header of the format
> "@@ -2,2 +2,15 @@ code". However when git diff is given "-U1"
> indicating that diffs are surrounded by only one line of
> context, it can omit the second comma separated value in
> either before or after line counts in the case where there
> is only one line.

Yes, it is possible that l and n in "@@ -k,l +m,n @@" is 1 in which
case ",1" is omitted altogether.  I however do not think it is
limited to "-U1".  The above description is inaccurate.

	$ echo one >foo
	$ git add foo
	$ echo two >foo
	$ git diff foo
	diff --git i/foo w/foo
	index 257cc5642c..5716ca5987 100644
	--- i/foo
	+++ w/foo
	@@ -1 +1 @@
	-one
	+two

> Fix by explicitly setting line count to 1 when there is
> no comma, and add a test.

It is correct to assume missing ,l and ,n as 1.  We should have the
same logic in apply.c (I wonder if there is a way to share the
parser, but I do not know if it is worth it).

> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
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

I wonder if the repeated code from here ...

>  	n = strspn(q, digits);
>  	if (q[n] == ',') {
>  		q += n + 1;
> +		*p_before = atoi(q);
>  		n = strspn(q, digits);
> +	} else {
> +		*p_before = 1;
>  	}
> +

... down to here ought to be in a helper function to parse l out of
k[,l].  But that can and should be done as a post-fix cleanup.

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
> index 80f4a65b28..08d10dfc3e 100755
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
> +test_expect_success 'patch-id handles diffs with -U1' '
> +	cat diffu1 | calc_patch_id diffu1 &&
> +	test_config patchid.stable true &&
> +	cat diffu1 | calc_patch_id diffu1stable
> +'
>  test_done
