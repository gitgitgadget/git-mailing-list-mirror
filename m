Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0EC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiA0T5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:57:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57722 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343494AbiA0T5i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:57:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D80B17FDCB;
        Thu, 27 Jan 2022 14:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e1qpvBJflO7wMQfEXGqMrydc0fTs5F13AR6q+c
        HK0BU=; b=k27FeQlizuy1Du9Yr5E5au9Ne5g/mT2m46I5HYzAdVQEdmJHhsM/gk
        v4hOT7Rs9rI2pPuXd99nFZ7dMou4gI7sgUXsPR9gz+ysKmBJ1jOcCoBkhT2UCgHT
        +aQvHNivIS4s/Cfar+jbznXv/MUmnTAR2Rg/1ASMQm6IPfhlNRUXg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0599C17FDC9;
        Thu, 27 Jan 2022 14:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1280517FDC8;
        Thu, 27 Jan 2022 14:57:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
Date:   Thu, 27 Jan 2022 11:57:32 -0800
In-Reply-To: <20220127153714.1190894-1-t.gummerer@gmail.com> (Thomas
        Gummerer's message of "Thu, 27 Jan 2022 15:37:14 +0000")
Message-ID: <xmqqmtjh0x5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E5C3C72-7FAB-11EC-AC3C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> When pruning refs fails, we currently print an error to stderr, but
> still exit 0 from 'git fetch'.  Since this is a genuine error fetch
> should be exiting with some non-zero exit code.  Make it so.
>
> The --prune option was introduced in f360d844de ("builtin-fetch: add
> --prune option", 2009-11-10).  Unfortunately it's unclear from that
> commit whether ignoring the exit code was an oversight or
> intentional, but it feels like an oversight.

It is a good idea to signal, with a non-zero status, that the user
needs to inspect the situation and possibly take a corrective
action.  I however do not know if it is sufficient to just give the
same exit status as returned by prune_refs(), which may or may not
happen to crash with other possible non-zero exit status to make it
indistinguishable from other kinds of errors.

>  		if (rs->nr) {
> -			prune_refs(rs, ref_map, transport->url);
> +			retcode = prune_refs(rs, ref_map, transport->url);
>  		} else {
> -			prune_refs(&transport->remote->fetch,
> -				   ref_map,
> -				   transport->url);
> +			retcode = prune_refs(&transport->remote->fetch,
> +					     ref_map,
> +					     transport->url);
> +		}

It seems that it is possible for do_fetch() to return a negative
value, even without this patch.  The return value from prune_refs()
comes from refs.c::delete_refs(), which can come from error_errno()
that is -1, so this patch adds more of the same problem to existing
ones, though.

And the value propagates up to cmd_fetch() via fetch_one().  This
will be relayed to exit() without changing via this callchain:

    git.c::cmd_main()
      git.c::run_argv()
        git.c::handle_builtin()
          git.c::run_builtin()

This is not a new problem, which does not want to be corrected as
part of this patch, but let's leave a mental note as #leftoverbits
for now.

> +		if (retcode) {
> +			free_refs(ref_map);
> +			goto cleanup;
>  		}

This part is iffy.  We tried to prune refs, we may have removed some
of the refs missing from the other side but we may still have some
other refs that are missing from the other side due to the failure
we noticed.

Is it sensible to abort the fetching?  I am undecided, but without
further input, my gut reaction is that it is safe and may even be
better to treat this as a soft error and try to go closer to where
the user wanted to go as much as possible by continuing to fetch
from the other side, given that we have already paid for the cost of
discovering the refs from the other side.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 20f7110ec1..df824cc3d0 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -164,6 +164,16 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
>  	git rev-parse sometag
>  '
>  
> +test_expect_success REFFILES 'fetch --prune fails to delete branches' '
> +	cd "$D" &&
> +	git clone . prune-fail &&
> +	cd prune-fail &&
> +	git update-ref refs/remotes/origin/extrabranch main &&
> +	>.git/packed-refs.new &&
> +	test_must_fail git fetch --prune origin

Is it because the lockfile ".new" on packed-refs prevents deletion
of refs but does not block creation and updates to existing refs
that it is an effective test for the "--prune" issue?  If we somehow
"locked" the whole ref updates, then the fetch would fail even
without "--prune", so it may be "effective", but smells like knowing
too much implementation detail.  Yuck, but I do not offhand think of
any better way (it is easier to think of worse ways), so without
further input, I would say that this is the best (or "least bad") we
can do.

Another tangent #leftoverbits is that many tests in this script are
so old-style that chdir around without isolating themselves in
subshells, while some do.  We may want to clean them up when the
file is quiescent.

Thanks.
