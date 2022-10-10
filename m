Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B8CC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJJRya (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJRy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:54:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31615800
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:54:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 778BF1BE3C9;
        Mon, 10 Oct 2022 13:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rkmvxrCDA3S08PBWJqcwMRJnV/fzptn7kVrqYy
        YtAiM=; b=P3xJ/PhZ5+mlVP6cZ2SR9IK4DtwjvRRBipZDp9vOk/auWzNEO/BduN
        DIT/4hWby+aJSP8AT04XvFFwHUdAJpiJUxl8LABOkm2dnlv6f8U+i2LpKdBuS4+s
        ObhFyXM+O6g9w3Tfd2KfI1XxdWP1JTUU9b5GZ0u3Jl02uxT6KjHDo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7047B1BE3C8;
        Mon, 10 Oct 2022 13:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A14E11BE3C5;
        Mon, 10 Oct 2022 13:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, orygaw@protonmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH 2/2] grep.c: tolerate NULL grep_expr in free_pattern_expr()
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
        <cover.1665423686.git.me@ttaylorr.com>
        <7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com>
Date:   Mon, 10 Oct 2022 10:54:23 -0700
In-Reply-To: <7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 10 Oct 2022 13:41:32 -0400")
Message-ID: <xmqqy1tn36pc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93AD7ACA-48C4-11ED-85BD-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/grep.c b/grep.c
> index 52a894c989..bcc6e63365 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -752,6 +752,9 @@ void compile_grep_patterns(struct grep_opt *opt)
>  
>  static void free_pattern_expr(struct grep_expr *x)
>  {
> +	if (!x)
> +		return;
> +
>  	switch (x->node) {
>  	case GREP_NODE_TRUE:
>  	case GREP_NODE_ATOM:

This hunk makes sense, but

> @@ -790,8 +793,6 @@ void free_grep_patterns(struct grep_opt *opt)
>  		free(p);
>  	}
>  
> -	if (!opt->extended)
> -		return;
>  	free_pattern_expr(opt->pattern_expression);
>  }

I do not know about this one.  We used to avoid freeing, even when
the .pattern_expression member is set, as long as the .extended bit
is not set.  Now we unconditionally try to free it even when the bit
says it does not want to.  Why?

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index e3ec5f5661..44f7ef0ea2 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -297,7 +297,7 @@ test_expect_success 'log --invert-grep --grep -i' '
>  	fi
>  '
>  
> -test_expect_failure 'log --invert-grep (no --grep)' '
> +test_expect_success 'log --invert-grep (no --grep)' '
>  	git log --pretty="tformat:%s" >expect &&
>  	git log --invert-grep --pretty="tformat:%s" >actual &&
>  	test_cmp expect actual

Especially for something this small, doing the "failing test first
and then fix with flipping the test to success" is very much
unwelcome.  For whoever gets curious (me included when accepting
posted patch), it is easy to revert only the part of the commit
outside t/ tentatively to see how the original code breaks.  Keeping
the fix and protection of the fix together will avoid mistakes.  In
this case, the whole test fits inside the post context of the patch,
but in general, this "flip failure to success" will hide the body of
the test that changes behaviour while reviewing the patch text,
which is another downside.

Thanks.

