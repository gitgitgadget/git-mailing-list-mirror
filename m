Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078901F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756201AbdLVUBL (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:01:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52615 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755940AbdLVUBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:01:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0493BE269;
        Fri, 22 Dec 2017 15:01:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CDDv/x6murcz+ec7GEK/e5XLsIE=; b=Ug17rs
        BxvlrQG6Xzjr3dCyAPStab6EPkM8rdJWLbtydAYPpsRSTp+jFy8fwhcZycPejbkI
        Rh2pnIjTIs/h23LqH2iLLXT0+I/jbsknPH7OptWjU69z9wFxcRHFDcODKH5nqPTt
        MfidzCfHOCI3RtJzsrZpk2gssp81fgWGhIi0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IekCSLXj6zxGAOvyC6YaqQd/ct+D5kax
        wq4rH8+w7HaxlEWZ9WePyUcPqCZRvFqWQaAjBeHbb0GD8ZWrGWnCm1q8t3JXw6i+
        FG0HBVHEP1dHdSHDZpzbFFq4u9nx+VxGKvVGSlrv8JbcsBrf8DHpyj9tiHcoED4V
        eaJm033xaik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B65D9BE268;
        Fri, 22 Dec 2017 15:01:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 383F5BE265;
        Fri, 22 Dec 2017 15:01:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 4/4] submodule: submodule_move_head omits old argument in forced case
References: <20171220221725.129162-1-sbeller@google.com>
        <20171220221725.129162-5-sbeller@google.com>
Date:   Fri, 22 Dec 2017 12:01:08 -0800
In-Reply-To: <20171220221725.129162-5-sbeller@google.com> (Stefan Beller's
        message of "Wed, 20 Dec 2017 14:17:25 -0800")
Message-ID: <xmqqy3lur0qj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA37032C-E752-11E7-AD65-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When using hard reset or forced checkout with the option to recurse into
> submodules, the submodules need to be reset, too.
>
> It turns out that we need to omit the duplicate old argument to read-tree
> in all forced cases to omit the 2 way merge and use the more assertive
> behavior of reading the specific new tree into the index and updating
> the working tree.

The phrase "the more assertive" made me imagine something like
"reset --hard", which resurrect lost paths and also get rid of added
paths.  "reading the specific new tree into the index" smells more
like "checkout $tree-ish $paths" that has an overlay semantics, that
resurrects lost paths but does not get rid of added paths.

Perhaps not just "rm sub1/file1" but also add a new file that is not
in HEAD to ensure that it will be blown away when $command is run
to ensure that we got the distinction between the two right?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               |  4 +++-
>  t/lib-submodule-update.sh | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index fa25888783..db0f7ac51e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1653,7 +1653,9 @@ int submodule_move_head(const char *path,
>  	else
>  		argv_array_push(&cp.args, "-m");
>  
> -	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
> +	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
> +		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
> +
>  	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
>  
>  	if (run_command(&cp)) {
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index fb0173ea87..380ef4b4ae 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -1015,4 +1015,15 @@ test_submodule_forced_switch_recursing_with_args () {
>  			test_submodule_content sub1 origin/modify_sub1
>  		)
>  	'
> +
> +	test_expect_success "$command: changed submodule worktree is reset" '
> +		prolog &&
> +		reset_work_tree_to_interested add_sub1 &&
> +		(
> +			cd submodule_update &&
> +			rm sub1/file1 &&
> +			$command HEAD &&
> +			test_path_is_file sub1/file1
> +		)
> +	'
>  }
