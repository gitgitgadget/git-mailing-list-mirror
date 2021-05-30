Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA8C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6573610CC
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhE3VQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:16:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63215 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhE3VQm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:16:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40049CF11D;
        Sun, 30 May 2021 17:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EOw6WF0x42l5cscCE+elmz4MHmudUc7fOpc1E0qvdc4=; b=kvcT
        K7i9js3YX3jk88zrqGYsjRznjC4INDB0qLUr9luIgr2ElTQ/JT2wpcPJvAILdYiz
        NO/tzo19c/oqXP8PYrupqNjnakPuC3ZvhEDZUn78/CDDf94dUscp7rEf5AQjGh/+
        Kcq5WnKfh98xHWeloj4GgBzh3Gi4RCfxU6wvV6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C4EECF11B;
        Sun, 30 May 2021 17:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10E0FCF118;
        Sun, 30 May 2021 17:15:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 06:15:00 +0900
Message-ID: <xmqqy2bv3ovf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18D1A8AA-C18C-11EB-BABE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use `--batch` with no atoms formatting and use
> `--batch-all-objects` at the same time (e.g.
> `git cat-file --batch="batman" --batch-all-objects`),
> Git will exit and report "object xxx changed type!?".
>
> This is because we have a format string which does not
> contain any atoms, so skip_object_info option will be
> set if we also use --batch-all-objects, and then
> `oid_object_info_extended()` will be skipped in
> `batch_object_write()`, it cause object type to not be
> collected. Therefore, it reported object type has changed.

The above analysis on how these die()s get hit makes sense, but ...

> So avoid checking changes in type and size when all_objects
> and skip_object_info options are set at the same time.

... it is not immediately clear how the above conclusion follows.

An obvious alternative, however, is to avoid skipping object info
when all objects is in use---but that goes directly against why this
"skip" mechanism was added at 845de33a (cat-file: avoid noop calls
to sha1_object_info_extended, 2016-05-18).

Which makes me suspect that the solution presented here would be
going in the right direction.

There however is one curious thing about this.  The log message of
the original commit that introduced this optimization does use the
batch-check and batch-all-objects at the same time.  Was this
breakage not there when the original was written and we broke it in
a later update?  If so, with what commit?  Can that commit have
broken other places in cat-file in a similar manner?

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5ebf13359e83..5f9578f9b86b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -345,11 +345,12 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  		contents = read_object_file(oid, &type, &size);
>  		if (!contents)
>  			die("object %s disappeared", oid_to_hex(oid));
> -		if (type != data->type)
> -			die("object %s changed type!?", oid_to_hex(oid));
> -		if (data->info.sizep && size != data->size)
> -			die("object %s changed size!?", oid_to_hex(oid));
> -
> +		if (!(opt->all_objects && data->skip_object_info)) {
> +			if (type != data->type)
> +				die("object %s changed type!?", oid_to_hex(oid));

When skip_object_info bit is set, we know data->type and date->size
are unusable and should not be checked, regardless of the reason why
skip_object_info bit is set, don't we?

> +			if (data->info.sizep && size != data->size)
> +				die("object %s changed size!?", oid_to_hex(oid));

Does this check need to be modified at all?  Would info.sizep ever
be set to non-NULL if skip_object_info is set (hence we are not
calling object-info)?

> +		}

In other words, shouldn't this patch just this one liner?

-		if (type != data->type)
+		if (data->skip_object_info && type != data->type)
			die("object %s changed type!?", oid_to_hex(oid));

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 5d2dc99b74ad..9b0f1ae5ef8b 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -586,4 +586,10 @@ test_expect_success 'cat-file --unordered works' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cat-file --batch="batman" with --batch-all-objects will work' '
> +	git -C all-two cat-file --batch-all-objects --batch="%(objectname)" | wc -l >expect &&
> +	git -C all-two cat-file --batch-all-objects --batch="batman" | wc -l >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
>
> base-commit: 5d5b1473453400224ebb126bf3947e0a3276bdf5
