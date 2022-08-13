Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41409C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 16:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiHMQS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiHMQS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 12:18:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC711277B
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 09:18:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29270141861;
        Sat, 13 Aug 2022 12:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h0h1WI4mYtqh/AEJxIHszQosS7JNVtqI+g0ibf
        +XAGQ=; b=CGLbm5es7i3vDdHTQoQQsS5V/SQ7J+lE4O8U53g5VxfcFMxzfwN5L0
        fnPF1ajoRR4YWHMXLIZhBclXIBZ8s2rO3N29bScKky6PepPUSkNVxoB8wMh0MHGO
        rAK+IGXVJgTjdUGCuCO/AbqW+DYB3FFJDYglNgT8zRhQbvPhPVIoY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FAD714185F;
        Sat, 13 Aug 2022 12:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50D0D14185E;
        Sat, 13 Aug 2022 12:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 11/14] merge: use the "resolve" strategy without forking
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-12-alban.gruin@gmail.com>
Date:   Sat, 13 Aug 2022 09:18:50 -0700
In-Reply-To: <20220809185429.20098-12-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 9 Aug 2022 20:54:26 +0200")
Message-ID: <xmqqwnbc86c5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E63747A-1B23-11ED-96F7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This teaches `git merge' to invoke the "resolve" strategy with a
> function call instead of forking.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/merge.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index f7c92c0e64..0ab2993ab2 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -44,6 +44,7 @@
>  #include "commit-reach.h"
>  #include "wt-status.h"
>  #include "commit-graph.h"
> +#include "merge-strategies.h"
>  
>  #define DEFAULT_TWOHEAD (1<<0)
>  #define DEFAULT_OCTOPUS (1<<1)
> @@ -774,6 +775,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  			die(_("unable to write %s"), get_index_file());
>  		return clean ? 0 : 1;
> +	} else if (!strcmp(strategy, "resolve")) {
> +		return merge_strategies_resolve(the_repository, common,
> +						head_arg, remoteheads);
>  	} else {
>  		return try_merge_command(the_repository,
>  					 strategy, xopts_nr, xopts,

This is another thing that probably hurts the overall project more
than it helps, I am afraid.

Recall the recent effort by Elijah's en/merge-restore-to-pristine topic cf.
https://lore.kernel.org/git/pull.1231.v5.git.1658541198.gitgitgadget@gmail.com/

There are different failure modes of merge strategy backends, and
the "git merge" command that drives them must be prepared to handle
various failures from them.  It is one selling point of "git merge"
that there is a codepath that lets you use your own merge strategy
backend.

Before this series, we had recursive and ort backends that are
internally called without going through try_merge_command()
codepath, and resolve and octopus covered the more general codepath,
the same one that is used by external third-party strategy backends,
and we had test coverage for all.

As I said earlier, as the "ort" strategy got more mature and
performant, the simpler "resolve" may have outlived the value we get
out of its use in the real world (read: what's the last time you ran
"git merge" with th e"-s resolve" option?).  So at this point, the
value of having tests of "-s resolve" in our test suite mostly does
not come from the fact that we are keeping "resolve" alive.  It
comes from the fact that we are making sure that the codepath to
drive external merge strategy does not regress.  While it moves to
internally call resolve and octopus, I do not think this series
compensates the loss of test coverage by adding tests to drive a
custom merge strategy.

A possible correction may be to _add_ a new merge strategy written
in C that implements the same algorithm "resolve" uses, give it a
different name, say "c-resolve", and call it internally instead of
spawning.  And keep "resolve" instead of replacing it with
"c-resolve".  You can duplicate the tests we have for "-s resolve"
so that the new "-s c-resolve" codepath gets tested to the same
degree.  Then we will not lose the value "resolve" has, which is to
serve as a testbed for external merge strategy.

But as I said already, I suspect that "-s resolve" is not of much
use in the real world, not because it is not implemented in C but
because there is a generally better alternative.  It makes us wonder
if we are making good use of our engineering effort by giving yet
another strategy, "-s c-resolve", to the users.

IOW, I am not sure there is value in rewriting resolve in C (except
for educational value for the developer who does the task, that is),
and it is doubly dubious to call it internally instead of spawning
it as an external command.

So, I dunno.  I think between octopus and resolve, the former might
still be used and it might make sense to have a more "performant"
version of it (there is no strong reason why it needs to use the
same resolve backend for repeated pairwise merges it does---it could
just call into recursive or ort machinery instead if the resolve
machinery is more cumbersome to use) by rewriting it in C.  But
rewriting "resolve" in C to call it internally looks to me a
regression overall to the value "resolve" gives to this project.
Stopping at rewriting it in C but still calling it externally might
make it more acceptable, though.

Thanks.

