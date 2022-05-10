Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83FC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 00:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiEJAtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiEJAtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 20:49:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4E20130A
        for <git@vger.kernel.org>; Mon,  9 May 2022 17:45:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EA921842AF;
        Mon,  9 May 2022 20:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sPEPHAoji22kbMiqUPvx/9kqEdPgU+lS2oG58N
        /Jxbo=; b=OoaFS6v7ir3op178dOteyPmiZExzRFFVqZUbBAlMyLPAMnmO6QWE99
        yJW645R5Hp7EznbS2ypT5WKBZsc21w0LGLVWCN5mNgVqP5iaWhJDMIJOVIIzzemW
        OOpV/934z0I56o8JyTOjvdS0x2Yfq5auQmBRUvWeXrCH2qK88qbw4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 874AB1842AE;
        Mon,  9 May 2022 20:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24ACE1842A7;
        Mon,  9 May 2022 20:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
Date:   Mon, 09 May 2022 17:44:59 -0700
In-Reply-To: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 09 May 2022 23:27:34 +0000")
Message-ID: <xmqq7d6u9px0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C8E1DF2-CFFA-11EC-8C63-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Fix a bug in "git pull" where `submodule.recurse` is preferred over
> `fetch.recurseSubmodules` (Documentation/config/fetch.txt says that
> `fetch.recurseSubmodules` should be preferred.). Do this by passing the
> value of the "--recurse-submodules" CLI option to the underlying fetch,
> instead of passing a value that combines the CLI option and config
> variables.
> ...

Do we know if this ever worked correctly or it once used to work but
we broke it?

>  builtin/pull.c            | 10 +++++++---
>  t/t5572-pull-submodule.sh | 14 ++++++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)

The reason I ask is because applying this patch to maint-2.35 and
then reverting the builtin/pull.c part still allow the new test in
t5572 this patch introduces to pass.  So either it used to work
without the change to builtin/pull.c back in v2.35.x days (but in a
newer codebase we need the change to builtin/pull.c), or the new
test is not testing the alleged breakage at all.

It seems that applying only the test part to 'master' does not detect
any test failure, so perhaps the test is faulty?

> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index fa6b4cca65c..65aaa7927fb 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -107,6 +107,20 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
>  	test_path_is_file super/sub/merge_strategy_4.t
>  '
>  
> +test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
> +	test_commit -C child merge_strategy_5 &&
> +	git -C parent submodule update --remote &&
> +	git -C parent add sub &&
> +	git -C parent commit -m "update submodule" &&
> +
> +	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
> +	# Check that the submodule commit was fetched
> +	sub_oid=$(git -C super rev-parse FETCH_HEAD:sub) &&
> +	git -C super/sub cat-file -e $sub_oid &&
> +	# Check that the submodule worktree did not update
> +	! test_path_is_file super/sub/merge_strategy_5.t
> +'
> +
>  test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
>  	# This tests the following scenario :
>  	# - local submodule has new commits
>
> base-commit: e8005e4871f130c4e402ddca2032c111252f070a
