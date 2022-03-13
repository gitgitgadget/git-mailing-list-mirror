Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA43C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 06:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiCMGqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 01:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCMGqt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 01:46:49 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E776E2BE
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 22:45:41 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 541F8120739;
        Sun, 13 Mar 2022 01:45:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CSLw3L/BY7dkFlCTM/NfFfPInWOLZxsUpe+HhS
        vHjRs=; b=quWGhjniR0IG+ozez9tGmdft6D1S1k27yMFoqK093BeGZ4sf5H6VXv
        n+Ddx5gE+vakTSgVgEgcDYuZXbKwGek0T4bYj8joJPgBxqqNjCNjhRmSYS2+1yC6
        I+jq/z7X8cpwIA3WTsrTcfFmrhzq+Y+E6PpzibGwdc2BO+9UiCGu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B409120738;
        Sun, 13 Mar 2022 01:45:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.78.140.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0D07120737;
        Sun, 13 Mar 2022 01:45:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Cantrell <david@cantrell.org.uk>
Subject: Re: [PATCH] tab completion of filenames for 'git restore'
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 22:45:36 -0800
In-Reply-To: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com> (David
        Cantrell via GitGitGadget's message of "Fri, 11 Mar 2022 21:07:36
        +0000")
Message-ID: <xmqqlexel59r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30FFEDB2-A299-11EC-99A3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"David Cantrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: David Cantrell <david@cantrell.org.uk>
>
> If no --args are present after 'git restore' it assumes that you want
> to tab-complete one of the files with uncommitted changes
>
> Signed-off-by: David Cantrell <david@cantrell.org.uk>
> ---
>     Improved bash tab completion for 'git restore' - adds support for
>     auto-completing filenames
>     
>     This adds tab-completion of filenames to the bash completions for git
>     restore.

Two questions

 - "restore" is a castrated half "checkout"; shouldn't the latter
   also be getting the same feature?

 - is "complete_index_file --committable" the right thing to use?

   It boils down to running "diff-index HEAD", which means path with
   differences from the HEAD commit is listed.  By default "restore"
   checks out the contents of the given path from the index to the
   working tree, so after "edit F && git add F", "diff-index HEAD"
   may show F in its output (i.e. F is "committable"), but "restore
   F" would be a no-op.  Which feels a bit iffy.

   Modelling it after "git add" completion, where we look for paths
   that are different between the index and the working tree, feels
   more appropriate, but I haven't thought things through.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1227%2FDrHyde%2Ffilename-completion-for-git-restore-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1227/DrHyde/filename-completion-for-git-restore-v1
> Pull-Request: https://github.com/git/git/pull/1227
>
>  contrib/completion/git-completion.bash | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 49a328aa8a4..7ccad8ff4b1 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2883,14 +2883,21 @@ _git_restore ()
>  	case "$cur" in
>  	--conflict=*)
>  		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
> +		return
>  		;;
>  	--source=*)
>  		__git_complete_refs --cur="${cur##--source=}"
> +		return
>  		;;
>  	--*)
>  		__gitcomp_builtin restore
> +		return
>  		;;
>  	esac
> +
> +	if __git rev-parse --verify --quiet HEAD >/dev/null; then
> +		__git_complete_index_file "--committable"
> +	fi
>  }

Do you need to sprinkle return's?  Instead you could just add
another case arm, like

	case "$cur" in
	--conflict=*)
		... all the existing code ...
	--*)
		__gitcomp_builtin restore
		;;
+	*)
+		... whatever you want to do when
+		... $cur is not a --dashed-option
+		;;
	esac

