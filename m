Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7421F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfJCWXA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:23:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61099 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfJCWXA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:23:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1320523916;
        Thu,  3 Oct 2019 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GZQ5v9ZF7VNdBjqZ+jFxzVXnaG8=; b=s2oufg
        6IET6CLCLwveUoGftygmon44QOZjPzHfb/0E8tvEFWxXkju1T0TX1mZpkeessHfG
        860H38RWaefdETwLhp0XPTeFCEgHV3i1WLmX54t5hcRWnnQ43Y9aCXCOq6FSckce
        JbdkmEk7wML7qWTnE4vvIJAxv6oMTwSbCg38g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VbS1jBa3ZN1iYws5ld30wUAqPnZltlX1
        rliZZSdn6ZzKP1jAkeAXcnIb4PIERNk403L+EVgsuMzWvshB+Bo20cLnJc+heXPm
        P5tU73NFcaDYiLmWhSQEzxD11uozFX3/F7bWuAOJCyzNOQnGYHpdSUpL4u4MNRc6
        aJRiyQ7hzw8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0950123915;
        Thu,  3 Oct 2019 18:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 583B123914;
        Thu,  3 Oct 2019 18:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] stash apply: report status correctly even in a worktree's subdirectory
References: <pull.354.git.gitgitgadget@gmail.com>
        <a687c16b824ec9ab45d1e2c39a5470ed89153fc0.1569415522.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 07:22:57 +0900
In-Reply-To: <a687c16b824ec9ab45d1e2c39a5470ed89153fc0.1569415522.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 25 Sep 2019
        05:45:24 -0700 (PDT)")
Message-ID: <xmqqk19lbha6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A8EBD88-E62C-11E9-809E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index b5a301f24d..a1e2e7ae7e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -497,6 +497,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  		 */
>  		cp.git_cmd = 1;
>  		cp.dir = prefix;
> +		argv_array_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
> +				 absolute_path(get_git_work_tree()));
>  		argv_array_push(&cp.args, "status");
>  		run_command(&cp);
>  	}

Nicely spotted.  Exporting GIT_WORK_TREE alone without GIT_DIR feels
a bit disturbing, at least to me, though.

I wondered if this misbehaves when the end user has GIT_WORK_TREE
environment exported, but in such a case, get_git_work_tree() would
return that directory, and by re-exporting it to the child process,
we would honor the end user's intention, so all is good, I think.

Thanks.

> diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.sh
> new file mode 100755
> index 0000000000..2b2b366ef9
> --- /dev/null
> +++ b/t/t3908-stash-in-worktree.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Johannes E Schindelin
> +#
> +
> +test_description='Test git stash in a worktree'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit initial &&
> +	git worktree add wt &&
> +	test_commit -C wt in-worktree
> +'
> +
> +test_expect_success 'apply in subdirectory' '
> +	mkdir wt/subdir &&
> +	(
> +		cd wt/subdir &&
> +		echo modified >../initial.t &&
> +		git stash &&
> +		git stash apply >out
> +	) &&
> +	grep "\.\.\/initial\.t" wt/subdir/out
> +'
> +
> +test_done
