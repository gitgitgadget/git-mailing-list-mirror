Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD9E94125
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 21:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjJFVvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjJFVvb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 17:51:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CCBE
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 14:51:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FA4827E33;
        Fri,  6 Oct 2023 17:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Gq9OOTJTcnk+kYmsLJ5gcvTHQi8dDM1zbxMc9y
        Hu4QI=; b=ltbu8HecQ+t45xomMxP2A4ZKPN+stSvqhI271M1N7aNpZCE6fnOECY
        phmp2nPBfQBWRgXrp0V1p7G31WD6KD6leZJVI4FBdW3N3p5as42QtJUhJWKxWIIt
        Qt2+Wdv3g0A9KqBHDmZfUski/9VVBtWfPjaoRVXxQPpFf8kPfCKAw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57D6827E32;
        Fri,  6 Oct 2023 17:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA4C927E30;
        Fri,  6 Oct 2023 17:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/4] ref-cache.c: fix prefix matching in ref iteration
In-Reply-To: <59276a5b3fd1fd3b25db73e096cf0e834af2d4f9.1696615769.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 06 Oct 2023 18:09:26
        +0000")
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <59276a5b3fd1fd3b25db73e096cf0e834af2d4f9.1696615769.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 14:51:24 -0700
Message-ID: <xmqqfs2n8lnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F46BB10-6492-11EE-9B62-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Update 'cache_ref_iterator_advance' to skip over refs that are not matched
> by the given prefix.
>
> Currently, a ref entry is considered "matched" if the entry name is fully
> contained within the prefix:
>
> * prefix: "refs/heads/v1"
> * entry: "refs/heads/v1.0"
>
> OR if the prefix is fully contained in the entry name:
>
> * prefix: "refs/heads/v1.0"
> * entry: "refs/heads/v1"
>
> The first case is always correct, but the second is only correct if the ref
> cache entry is a directory, for example:
>
> * prefix: "refs/heads/example"
> * entry: "refs/heads/"
>
> Modify the logic in 'cache_ref_iterator_advance' to reflect these
> expectations:
>
> 1. If 'overlaps_prefix' returns 'PREFIX_EXCLUDES_DIR', then the prefix and
>    ref cache entry do not overlap at all. Skip this entry.
> 2. If 'overlaps_prefix' returns 'PREFIX_WITHIN_DIR', then the prefix matches
>    inside this entry if it is a directory. Skip if the entry is not a
>    directory, otherwise iterate over it.
> 3. Otherwise, 'overlaps_prefix' returned 'PREFIX_CONTAINS_DIR', indicating
>    that the cache entry (directory or not) is fully contained by or equal to
>    the prefix. Iterate over this entry.
>
> Note that condition 2 relies on the names of directory entries having the
> appropriate trailing slash. The existing function documentation of
> 'create_dir_entry' explicitly calls out the trailing slash requirement, so
> this is a safe assumption to make.

Thanks for explaining it very well and clearly.  

Allowing prefix="refs/heads/v1.0" to yield entry="refs/heads/v1"
(case #2 above that this patch fixes the behaviour for) would cause
ref_iterator_advance() to return a ref outside the hierarhcy,
wouldn't it?  So it appears to me that either one of the two would
be true:

 * the code is structured in such a way that such a condition does
   not actually happen (in which case this patch would be a no-op),
   or

 * there is a bug in the current code that is fixed by this patch,
   whose externally observable behaviour can be verified with a
   test.

It is not quite clear to me which is the case here.  The code with
the patch looks more logical than the original, but I am not sure
how to demonstrate the existing breakage (if any).

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  refs/ref-cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 2294c4564fb..6e3b725245c 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -412,7 +412,8 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  
>  		if (level->prefix_state == PREFIX_WITHIN_DIR) {
>  			entry_prefix_state = overlaps_prefix(entry->name, iter->prefix);
> -			if (entry_prefix_state == PREFIX_EXCLUDES_DIR)
> +			if (entry_prefix_state == PREFIX_EXCLUDES_DIR ||
> +			    (entry_prefix_state == PREFIX_WITHIN_DIR && !(entry->flag & REF_DIR)))
>  				continue;
>  		} else {
>  			entry_prefix_state = level->prefix_state;
