Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F7C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8450B610C8
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhE3VLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:11:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:41470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhE3VLY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:11:24 -0400
Received: (qmail 18820 invoked by uid 109); 30 May 2021 21:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 May 2021 21:09:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21830 invoked by uid 111); 30 May 2021 21:09:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 May 2021 17:09:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 30 May 2021 17:09:44 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 30, 2021 at 08:29:26AM +0000, ZheNing Hu via GitGitGadget wrote:

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

Good find. I think this bug is mostly my fault, as I added the
skip_object_info flag but never thought to use it with --batch.

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
> +			if (data->info.sizep && size != data->size)
> +				die("object %s changed size!?", oid_to_hex(oid));
> +		}

Wouldn't checking data->skip_object_info be sufficient? It's only set
when opt->all_objects is set anyway. But more importantly, it is the
most direct root of the problem: we did not find out the type and size
earlier, so comparing anything against data->type is useless.

But that leads me to a follow-up question: what if we did give a format,
so skip_object_info isn't set, but it didn't include the type or size?

In the size code, it looks like we explicitly protect against this by
checking if data->info.sizep is set (i.e., did we request the size from
oid_object_info_extended). But it's not for the type.

So the assumption is that we do always fill in the type, even if the
user didn't ask for it. And that assumption is actually violated much
earlier. These two bits of code from the setup are out of order:

          if (opt->all_objects) {
                  struct object_info empty = OBJECT_INFO_INIT;
                  if (!memcmp(&data.info, &empty, sizeof(empty)))
                          data.skip_object_info = 1;
          }

          /*
           * If we are printing out the object, then always fill in the type,
           * since we will want to decide whether or not to stream.
           */
          if (opt->print_contents)
                  data.info.typep = &data.type;

We should not let skip_object_info kick in at all if opt->print_contents
is requested. And that causes other bugs outside of the spot you found.
We look at data->type earlier in print_object_or_die() to decide whether
or not to stream the contents, but we'll see garbage (fortunately we
zero-initialize the expand_data struct, so it's at least predictably
zero, and not random undefined behavior).

But I think we'd want to solve it by swapping the two conditionals I
showed above, which restores the assumption made in print_object_or_die().

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

Is it worth testing both of these? The %(objectname) one will fail in
the same way (because we do not need to run oid_object_info() to get the
oid, which we already have). I'm OK doing both for better coverage, but
it may be worth mentioning either in a comment or in the commit message
that we expect both to fail, and why.

-Peff
