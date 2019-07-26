Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA3E1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfGZTPB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 15:15:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53897 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388496AbfGZTPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 15:15:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11E9A6B0A6;
        Fri, 26 Jul 2019 15:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AsJDwFM8DALqtNnyZuDcSkffo5o=; b=Cos7Hr
        2xqcj8aZk+LhePT/carvBWweZ1wNCVLCL4D7c2o8/PVgv8w9rN4ei1alU/lim0v4
        k7RbkFG9X5tvb+bVOlxwSWPXGlztMatVfECZanq4MSTUuvsQkzP69L8nd40T5k6F
        w+Sp0k/nnHUuSRAOS+qmznGtvKLx9q173NiFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xUzks0UWqfyyCEL2L5BHYKNRKFeyDUH+
        QmLrYfY5EuwuwbpVFkCn0u45svC3rwhlowIXKiY26CSBlBf41zOZPXRorGAHSsjF
        7TP0eFPG18qI8MkpuA+Rvhy7GyLLDlC+kY7OeLPfdjYnJ1fHei45OECkIrLafBFv
        T6mNT/eBXFw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09E1C6B0A5;
        Fri, 26 Jul 2019 15:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 334946B0A3;
        Fri, 26 Jul 2019 15:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 03/20] Ensure index matches head before invoking merge machinery, round N
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-4-newren@gmail.com>
Date:   Fri, 26 Jul 2019 12:14:54 -0700
In-Reply-To: <20190726155258.28561-4-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:41 -0700")
Message-ID: <xmqqftmsobf5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A75E1F52-AFD9-11E9-8E85-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ...
> So, load the index in builtin/merge-recursive.c, reload the in-memory
> index in builtin/stash.c, and modify the t3030 testcase to correctly
> setup the index and make sure that the test fails in the expected way
> (meaning it reports a rename/rename conflict).

The last paragraph is what describes what this step does.  What is
left unsaid is how that small step relates to the change in the
larger picture (including the title).  We do want to have a code
that ensures the index has no higher-stage entries and match HEAD
at the beginning of merge_recursive backend (as your lengthy preamble
leading to the paragraph explains), but adding the code to populate
in-core index to two codepaths does not make them check the condition
automatically---it is only half the story, no?

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge-recursive.c  | 4 ++++
>  builtin/stash.c            | 2 ++
>  t/t3030-merge-recursive.sh | 9 ++++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index 5b910e351e..a4bfd8fc51 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -1,3 +1,4 @@
> +#include "cache.h"
>  #include "builtin.h"
>  #include "commit.h"
>  #include "tag.h"
> @@ -63,6 +64,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  	if (argc - i != 3) /* "--" "<head>" "<remote>" */
>  		die(_("not handling anything other than two heads merge."));
>  
> +	if (repo_read_index_unmerged(the_repository))
> +		die_resolve_conflict("merge");
> +
>  	o.branch1 = argv[++i];
>  	o.branch2 = argv[++i];
>  
> diff --git a/builtin/stash.c b/builtin/stash.c
> index b5a301f24d..4aa47785f9 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -427,6 +427,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  				return error(_("could not save index tree"));
>  
>  			reset_head();
> +			discard_cache();
> +			read_cache();
>  		}
>  	}
>  
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index ff641b348a..a37bcc58a0 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -667,15 +667,22 @@ test_expect_success 'merging with triple rename across D/F conflict' '
>  test_expect_success 'merge-recursive remembers the names of all base trees' '
>  	git reset --hard HEAD &&
>  
> +	# make the index match $c1 so that merge-recursive below does not
> +	# fail early
> +	git diff --binary HEAD $c1 -- | git apply --cached &&
> +
>  	# more trees than static slots used by oid_to_hex()
>  	for commit in $c0 $c2 $c4 $c5 $c6 $c7
>  	do
>  		git rev-parse "$commit^{tree}"
>  	done >trees &&
>  
> -	# ignore the return code -- it only fails because the input is weird
> +	# ignore the return code; it only fails because the input is weird...
>  	test_must_fail git -c merge.verbosity=5 merge-recursive $(cat trees) -- $c1 $c3 >out &&
>  
> +	# ...but make sure it fails in the expected way
> +	test_i18ngrep CONFLICT.*rename/rename out &&
> +
>  	# merge-recursive prints in reverse order, but we do not care
>  	sort <trees >expect &&
>  	sed -n "s/^virtual //p" out | sort >actual &&
