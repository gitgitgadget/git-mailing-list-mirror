Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87154C001DB
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHCUUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHCUUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 16:20:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948B420F
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 13:20:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41E612BB36;
        Thu,  3 Aug 2023 16:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0s4pmW2X8/vsDWdekZEnfMZDvipJnav/K7PFtv
        PKtFE=; b=r2+zGON36jZSTnKRVrtj6uKyOaF48Ba/KcoDdV8gAl6Q3bdh/YEs6u
        d91+OmX7PRMvrqBo+MbKt79CfBmHNwD4SionZ/DEl/UQO2gRR13IzTmwf22ICCSH
        cOmBRPIPilE1as/EudzW5E6OpaUgtnjpWdlqjWe8T7XGHTe510hfY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A1F92BB35;
        Thu,  3 Aug 2023 16:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4FE32BB32;
        Thu,  3 Aug 2023 16:20:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase --skip: fix commit message clean up when
 skipping squash
References: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 13:20:01 -0700
In-Reply-To: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 03 Aug 2023 13:09:35 +0000")
Message-ID: <xmqqedkj515a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20B487B4-323B-11EE-8E4A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... The test is also updated to explicitly check
> the commit messages rather than relying on grep to ensure they do not
> contain any stay commit headers.

"stay" -> "stray" presumably.

> To check the commit message the function test_commit_message() is moved
> from t3437-rebase-fixup-options.sh to test-lib.sh. As the function is
> now publicly available it is updated to provide better error detection
> and avoid overwriting the commonly used files "actual" and "expect".
> Support for reading the expected commit message from stdin is also
> added.

It may make it cleaner to do the refactoring as a separate
preparatory patch, but the end-result is not so large from
the diffstat below, so it probably is OK.

I am not sure if deviating from expect vs actual is such a good
idea.  It is not like use of two temporary files are transparent to
the caller of the new test helper---indeed, expect and actual are
likely to be used by the caller in tests that comes before or after
the ones that use test_commit_message, and by using a pair of files
that are different, the caller will now see two extra untracked
files left in the working tree.

The only case such a renaming could help callers is when they do

	cat >expect <<\-EOF &&
	here to prepare some outcome
	EOF
	git do-something-to-make-commit &&
	test_commit_message HEAD <<\-EOF &&
	here is what we expect to see in HEAD
	EOF
	git some-other-thing >actual &&
	test_cmp expect actual
	
as use of files other than expect/actual in test_commit_message will
avoid stomping on the "expect" file that was already prepared.

I suspect that it would be rare, and something we can fix when need
arises by allowing test_commit_message to accept an option to use
non-standard filenames for its temporaries.  The current callers,
both the existing ones in t3437 and the new ones added by this
patch, would not benefit.  The only externally visible side effect
is that the existing ones will have two extra untracked files in
their working tree.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     rebase --skip: fix commit message clean up when skipping squash
>     
>     This patch is based on maint.
> ...
>  sequencer.c                     | 26 +++++++++++----
>  t/t3418-rebase-continue.sh      | 58 +++++++++++++++++++++++----------
>  t/t3437-rebase-fixup-options.sh | 15 ---------
>  t/test-lib-functions.sh         | 33 +++++++++++++++++++
>  4 files changed, 93 insertions(+), 39 deletions(-)

OK.

> diff --git a/sequencer.c b/sequencer.c
> index bceb6abcb6c..af271ab6fbd 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5038,19 +5038,31 @@ static int commit_staged_changes(struct repository *r,
>  				 * We need to update the squash message to skip
>  				 * the latest commit message.
>  				 */
> +				int res = 0;
>  				struct commit *commit;
> +				const char *msg;
>  				const char *path = rebase_path_squash_msg();
>  				const char *encoding = get_commit_output_encoding();
>  
> -				if (parse_head(r, &commit) ||
> -				    !(p = repo_logmsg_reencode(r, commit, NULL, encoding)) ||
> -				    write_message(p, strlen(p), path, 0)) {
> -					repo_unuse_commit_buffer(r, commit, p);
> -					return error(_("could not write file: "
> +				if (parse_head(r, &commit))
> +					return error(_("could not parse HEAD"));
> +
> +				p = repo_logmsg_reencode(r, commit, NULL, encoding);
> +				if (!p)  {
> +					res = error(_("could not parse commit %s"),
> +						    oid_to_hex(&commit->object.oid));
> +					goto unuse_commit_buffer;
> +				}
> +				find_commit_subject(p, &msg);
> +				if (write_message(msg, strlen(msg), path, 0)) {
> +					res = error(_("could not write file: "
>  						       "'%s'"), path);
> +					goto unuse_commit_buffer;
>  				}
> -				repo_unuse_commit_buffer(r,
> -							 commit, p);
> +			unuse_commit_buffer:
> +				repo_unuse_commit_buffer(r, commit, p);
> +				if (res)
> +					return res;
>  			}
>  		}

Just as described in the proposed log message.  Looking good.

Will queue.  Thanks.
