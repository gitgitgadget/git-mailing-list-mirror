Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96364C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D011221EC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lMe7OVwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIQRar (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:30:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60579 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIQR3o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 13:29:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58834EE9A4;
        Thu, 17 Sep 2020 13:28:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9tpuK22MjTTfA1VgF1NlxSyyIx4=; b=lMe7OV
        wp+TdnOmU5G+bUHwLjZ6e+uMLOS8/TWW0M9V6qLXn6e6yeq39615FHlaHqn2dqQj
        dUVXQHxqJiEr8fmMVz5FIqplyORxMwBdg012DT4/LxKM8022ofizZhcIubBWAJC8
        ibV+nM4GyKMinqkPB442mSOlxbw50Fedla020=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hgfkzygx9M/x8nps69MfzQ1GlEWPdLHK
        NAeHna3Ju2Bk3xQOveUg10sMpG7IsQjT+RpFsgMY/5Pyf2g2cIbG5wn/4piqew2X
        EO4BVXSRB+gSi3Gp5GqSVI3bQOx8Llg7hyXtXpGF8DVkOTGKIZdc0ENJijTH4Etd
        rxAayvEFHBY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5277DEE9A3;
        Thu, 17 Sep 2020 13:28:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99F1DEE9A0;
        Thu, 17 Sep 2020 13:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] builtin/diff-index: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <1e4f805e570b8caad26c43b4c8293413e9128d5f.1600328335.git.liu.denton@gmail.com>
Date:   Thu, 17 Sep 2020 10:28:53 -0700
In-Reply-To: <1e4f805e570b8caad26c43b4c8293413e9128d5f.1600328335.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 17 Sep 2020 00:44:12 -0700")
Message-ID: <xmqq8sd8s46i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 433FE5F6-F90B-11EA-8603-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index c3878f7ad6..7f5281c461 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -33,6 +33,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>  
>  		if (!strcmp(arg, "--cached"))
>  			option |= DIFF_INDEX_CACHED;
> +		else if (!strcmp(arg, "--merge-base"))
> +			option |= DIFF_INDEX_MERGE_BASE;
>  		else
>  			usage(diff_cache_usage);
>  	}
> diff --git a/builtin/diff.c b/builtin/diff.c
> index e45e19e37e..1baea18ae0 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -139,6 +139,8 @@ static int builtin_diff_index(struct rev_info *revs,
>  		const char *arg = argv[1];
>  		if (!strcmp(arg, "--cached") || !strcmp(arg, "--staged"))
>  			option |= DIFF_INDEX_CACHED;
> +		else if (!strcmp(arg, "--merge-base"))
> +			option |= DIFF_INDEX_MERGE_BASE;
>  		else
>  			usage(builtin_diff_usage);
>  		argv++; argc--;

OK.

> diff --git a/diff-lib.c b/diff-lib.c
> index e01c3f0612..68bf86f289 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -569,13 +569,24 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
>  int run_diff_index(struct rev_info *revs, unsigned int option)
>  {
>  	struct object_array_entry *ent;
> +	struct object_id oid;
> +	const char *name;

Let's do the same

	int compare_with_merge_base = !!(option & DIFF_INDEX_MERGE_BASE);

here to keep the result easier to follow.

>  	if (revs->pending.nr != 1)
>  		BUG("run_diff_index must be passed exactly one tree");
>  
>  	trace_performance_enter();
>  	ent = revs->pending.objects;
> -	if (diff_cache(revs, &ent->item->oid, ent->name, !!(option & DIFF_INDEX_CACHED)))
> +
> +	if (option & DIFF_INDEX_MERGE_BASE) {
> +		diff_get_merge_base(revs, &oid);
> +		name = xstrdup(oid_to_hex(&oid));

Leak?

> +	} else {
> +		oidcpy(&oid, &ent->item->oid);
> +		name = ent->name;
> +	}
> +
> +	if (diff_cache(revs, &oid, name, !!(option & DIFF_INDEX_CACHED)))
>  		exit(128);
>  
>  	diff_set_mnemonic_prefix(&revs->diffopt, "c/", (option & DIFF_INDEX_CACHED) ? "i/" : "w/");

> +for cmd in diff-index diff
> +do
> +	test_expect_success "$cmd --merge-base with one commit" '
> +		git checkout master &&
> +		git $cmd commit-C >expect &&
> +		git $cmd --merge-base br2 >actual &&
> +		test_cmp expect actual
> +	'

OK, the same command, when comparing with commit-C and with
"--merge-base br2" that should compute the same commit-C, should
give the same answer.  Good testing strategy.

Thanks.
