Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C502C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E48861396
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhFAPyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:54:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:43286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhFAPyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:54:23 -0400
Received: (qmail 28395 invoked by uid 109); 1 Jun 2021 15:52:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Jun 2021 15:52:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11645 invoked by uid 111); 1 Jun 2021 15:52:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Jun 2021 11:52:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Jun 2021 11:52:40 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:35:56PM +0000, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
> 
> When `--batch` used with `--batch-all-objects`,
> with some format atoms like %(objectname), %(rest)
> or even no atoms may cause Git exit and report
> "object xxx changed type!?".
> 
> E.g. `git cat-file --batch="batman" --batch-all-objects`
> 
> This is because we did not get the object type through
> oid_object_info_extended(), it's composed of two
> situations:
> 
> 1. Since object_info is empty, skip_object_info is
> set to true, We skipped collecting the object type.
> 
> 2. The formatting atom like %(objectname) does not require
> oid_object_info_extended() to collect object types.
> 
> The correct way to deal with it is to swap the order
> of setting skip_object_info and setting typep. This
> will ensure that we must get the type of the object
> when using --batch.

Thanks, this explanation and the patch make sense, and I'd be happy if
we take it as-is. But in the name of GSoC, let me offer a few polishing
tips.

The commit message hints at the root of the problem, but doesn't say it
explicitly. Which is: because setting skip_object_info depends on seeing
that the object_info is empty, we can't add items to it after setting
that flag. And the code path for --batch does that, hence re-ordering
them is the solution.

It might also be worth noting that the bug was present from when the
skip_object_info code was initially added in 845de33a5b (cat-file: avoid
noop calls to sha1_object_info_extended, 2016-05-18).

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 5d2dc99b74ad..1502a27142ba 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -586,4 +586,23 @@ test_expect_success 'cat-file --unordered works' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cat-file --batch="%(objectname)" with --batch-all-objects will work' '
> +	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
> +	git -C all-two cat-file --batch="%(objectname)" <objects >expect &&
> +	git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >actual &&
> +	cmp expect actual
> +'

OK, we're checking the output of --batch-all-objects versus taking the
object list from the input. We can depend on the ordering being
identical between the two because --batch-all-objects sorts. Good.

> +test_expect_success 'cat-file --batch="%(rest)" with --batch-all-objects will work' '
> +	git -C all-two cat-file --batch="%(rest)" <objects >expect &&
> +	git -C all-two cat-file --batch-all-objects --batch="%(rest)" >actual &&
> +	cmp expect actual
> +'

This one is rather curious. It definitely shows the bug, but I can't
imagine why %(rest) would be useful with --batch-all-objects, since its
purpose is to show the rest of the input line (and there are no input
lines!).

That might be a problem later if we change the behavior (e.g., to say
"%(rest) does not make sense with --batch-all-objects"). But I'm also OK
leaving it for now; somebody later can dig up this commit via git-blame.

> +test_expect_success 'cat-file --batch="batman" with --batch-all-objects will work' '
> +	git -C all-two cat-file --batch="batman" <objects >expect &&
> +	git -C all-two cat-file --batch-all-objects --batch="batman" >actual &&
> +	cmp expect actual
> +'

And this one is a more extreme version of the "%(objectname)" one. It's
useful as a regression test because we might later change the
optimization so that %(objectname) ends up filling in the other object
info.

There's a subtle dependency here on the "objects" file from the earlier
test. In such a case, we'll often split that out as a separate setup
step like:

  test_expect_success 'set up object list for --batch-all-objects tests' '
	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects
  '

That makes it more clear that all three of the other tests are doing the
same thing (just with different formats), and can be reordered, removed,
etc, later if we wanted to. So not a correctness thing, but rather just
communicating the structure of the tests to later readers.

-Peff
