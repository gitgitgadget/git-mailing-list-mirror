Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F56BC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5320829
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hPIMn+I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgEURf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 13:35:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52571 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgEURf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 13:35:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7CF1DB72A;
        Thu, 21 May 2020 13:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zMviOiODhvsFc0nGG/FOIx3jNCU=; b=hPIMn+
        I1pgXtqvoFM5rIKMMd+98F2HaKjTv2ZuDSqfKyp2qEgtBnLFIOBmsLS2Tgt6LfOs
        kSnkNxeRgW9zc1pisqJBAfMmrzmJcvAlkTl8rkYp/5GMnMaZWQgfpOOjagtXRd+A
        9uKOuN9yziXeLaXoHEXWeTFNVa6ZfblkaPZFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o1yV2lSPZKEpbwyF5XzZikZMQg6k689h
        BLImqnz1kFncGFplWYatiHynm42DiTO8INTqFmizHnHyV+Nc372PVJVTAYHB6bbb
        UX9NoaUg1xwQhdOGgeDVWSN1DZsP/h22Gtqzfpa/NbKfxePY25iC+V7wHNBHVc6M
        221LkfxXSSU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0142DB729;
        Thu, 21 May 2020 13:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E3D4DB727;
        Thu, 21 May 2020 13:35:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] builtin/checkout: simplify metadata initialization
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
        <20200521020712.1620993-1-sandals@crustytoothpaste.net>
        <20200521020712.1620993-2-sandals@crustytoothpaste.net>
Date:   Thu, 21 May 2020 10:35:22 -0700
In-Reply-To: <20200521020712.1620993-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 21 May 2020 02:07:11 +0000")
Message-ID: <xmqq1rndtcmd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 739D8792-9B89-11EA-A319-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  The only case in which we do not have a commit object is when
> invoking git switch with --orphan.  Moreover, we can only hit this code
> path without a commit object additionally with either --force or
> --discard-changes.

It was easy for me to trace the codepath to see when these options
are used we end up with no commit object, but I ran out of time
trying to see if the "forced orphan" is the only way to end up with
a NULL in new_branch_info->commit.  Assuming that is true, of course
the following perfectly makes sense.

> In such a case, there is no point initializing the checkout metadata
> with a commit or tree because (a) there is no commit, only the empty
> tree, and (b) we will never use the data, since no files will be smudged
> when checking out a branch with no files.  Pass the all-zeros object ID
> in this case, since we just need some value which is a valid pointer.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/checkout.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e9d111bb83..62b5e371bc 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -621,9 +621,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
>  	init_checkout_metadata(&opts.meta, info->refname,
> -			       info->commit ? &info->commit->object.oid :
> -			       is_null_oid(&info->oid) ? &tree->object.oid :
> -			       &info->oid,
> +			       info->commit ? &info->commit->object.oid : &null_oid,
>  			       NULL);
>  	parse_tree(tree);
>  	init_tree_desc(&tree_desc, tree->buffer, tree->size);
