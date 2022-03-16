Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3652C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352841AbiCPApe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPApc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 20:45:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A361C4EA37
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 17:44:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1A22116A8E;
        Tue, 15 Mar 2022 20:44:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nRsq7O6R25A4ehm8Y6fCq5U5OIUBd4BcjvGq2k
        tWlbA=; b=jHDh54IsLBLDkqIa421dSaVXyETmNHhAB2eHiGW/q7aiVLZoFD2KnW
        sYY3vmZN1mTR3cZxbEt4ZYvy12zd4OgnWdE8dMkFDlubLaiML+Kg0TtTkb3AUtKc
        idZmiSm4thaaFv6ZUn6HxMHqQU2F4imluJ2O66rFypEqnsbwwI1RE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C87C1116A8D;
        Tue, 15 Mar 2022 20:44:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3228F116A8B;
        Tue, 15 Mar 2022 20:44:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Cantrell <david@cantrell.org.uk>
Subject: Re: [PATCH v3] tab completion of filenames for 'git restore'
References: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
        <pull.1227.v3.git.git.1647382437475.gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 17:44:16 -0700
In-Reply-To: <pull.1227.v3.git.git.1647382437475.gitgitgadget@gmail.com>
        (David Cantrell via GitGitGadget's message of "Tue, 15 Mar 2022
        22:13:57 +0000")
Message-ID: <xmqqsfribuan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35A4B14C-A4C2-11EC-9C6C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"David Cantrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: David Cantrell <david@cantrell.org.uk>
> Subject: Re: [PATCH v3] tab completion of filenames for 'git restore'

Perhaps

    Subject: [PATCH v3] completion: complete modified files for 'git restore'

cf. Documentation/SubmittingPatches::[[summary-section]]


> If no --args are present after 'git restore' it assumes that you want
> to tab-complete one of the files with unstaged uncommitted changes.

Since it is our convention that the first paragraph talks about the
current behaviour, i.e. without the proposed changes applied, in the
present tense, I'd assume the above is what the current code does.

What do you mean by "--args" in this sentence?  Dashed-options?
I am getting the same set of files whose name begins with 'a' from
these two:

 $ git restore a<TAB>
 $ git restore --staged a<TAB>

so, with or without --dashed-options, we complete one of the files,
whether they have any modifications.

Perhaps you meant to say more like:

    When completing a non-option argument to 'git restore', the
    command line completion support offers names of the files
    present in the working tree as candidates.

to describe the status quo; to hint what the shortcoming of the
current behaviour is, we may want to add a bit more, perhaps
append the following at the end of that first paragraph:

    But many of these files may not have any changes, and running
    "restore" on them would be a no-op.  Listing only the files, to
    which doing "restore" is not a no-op, would reduce the clutter.
    
Then we'd continue with the solution, while explaining why the exact
choice between modified vs committable was made:

    Offer only the files that are different from the index, to match
    the default behaviour of "git restore" that checks out the
    contents last added to the index to the working tree.  We could
    instead show the files that are different between the index and
    HEAD, and that is more suittable if "git restore --staged" is
    being completed, but this should do for now.

or something.  The last part is written in such a way to explicitly
signal to future developers that we know we did not do a perfect job
and we do not mind if they extend the logic to use something other
than "--modified" when appropriate.  For example, they could build
on this solution to make it inspect the command line for "--staged"
and "--source" and drive "diff-index" differently to grab the paths
that are offered.  We just do not do that at least for now, but we
have no objection if other people do so in the future.

Thanks.  Will queue as-is for now.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 49a328aa8a4..ba5c395d2d8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2890,6 +2890,10 @@ _git_restore ()
>  	--*)
>  		__gitcomp_builtin restore
>  		;;
> +	*)
> +		if __git rev-parse --verify --quiet HEAD >/dev/null; then
> +			__git_complete_index_file "--modified"
> +		fi
>  	esac
>  }
>  
>
> base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
