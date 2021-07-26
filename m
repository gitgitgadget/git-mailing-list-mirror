Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B6C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E112760EB2
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhGZWRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:17:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 18:17:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FAEDDEBA2;
        Mon, 26 Jul 2021 18:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L8EYN9ofl3xmRFNYQNhYggHrBYy9wzOaL9hIlH
        pNqXQ=; b=dulRzzNFuLOve1tcqujtGAByiMCbCUORu/mLCwou8W6hPHXDi6UDsl
        7cyPUc3PpL2q/j+//ujXNXD9yN9T6Tbv8L6wkOgyTI+30jhy793lz9+oIJoIJZYn
        VemEYtPflec8hTIY4w+cYAnfUnFl6dNvjtNzPPHFev01Wqjo15/2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 165AEDEBA1;
        Mon, 26 Jul 2021 18:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F673DEBA0;
        Mon, 26 Jul 2021 18:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff --submodule=diff: do not fail on
 ever-initialied deleted submodules
References: <20210726183358.3255233-1-dturner@twosigma.com>
        <20210726183358.3255233-2-dturner@twosigma.com>
Date:   Mon, 26 Jul 2021 15:57:27 -0700
In-Reply-To: <20210726183358.3255233-2-dturner@twosigma.com> (David Turner's
        message of "Mon, 26 Jul 2021 14:33:57 -0400")
Message-ID: <xmqqv94wfzu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9F90EC4-EE64-11EB-8FC0-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> If you have ever initialized a submodule, open_submodule will open it.
> If you then delete the submodule's worktree directory (but don't
> remove it from .gitmodules), git diff --submodule=diff would crash as
> it attempted to chdir into the now-deleted working tree directory.

Hmph.  So what does the failure look like?  The child process inside
start_command() attempts chdir() and reports CHILD_ERR_CHDIR back,
and we catch it as an error by reading from notify_pipe[0] and report
failure from start_command()?  Or are we talking about a more severe
"crash" of an uncontrolled kind?

Bypassing the execution of diff in the submodule like this patch
does may avoid such a failure, but is that all we need to "fix" this
issue?  What does the user expect after removing a submodule that
way and runs "diff" with the "--submodule=diff" option?  Shouldn't
we be giving "all lines from all files have been removed" patch?

Thanks.

> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  submodule.c                                  |  3 ++
>  t/t4060-diff-submodule-option-diff-format.sh | 45 ++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 0b1d9c1dde..9031527a16 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -673,6 +673,9 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
>  	    !(right || is_null_oid(two)))
>  		goto done;
>  
> +	if (!is_directory(path))
> +		goto done;
> +
>  	if (left)
>  		old_oid = one;
>  	if (right)
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index 69b9946931..10e330c08a 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -703,10 +703,26 @@ test_expect_success 'path filter' '
>  	diff_cmp expected actual
>  '
>  
> -commit_file sm2
> +cat >.gitmodules <<-EOF
> +[submodule "sm2"]
> +	path = sm2
> +	url = bogus_url
> +EOF
> +git add .gitmodules
> +commit_file sm2 .gitmodules
> +
>  test_expect_success 'given commit' '
>  	git diff-index -p --submodule=diff HEAD^ >actual &&
>  	cat >expected <<-EOF &&
> +	diff --git a/.gitmodules b/.gitmodules
> +	new file mode 100644
> +	index 1234567..89abcde
> +	--- /dev/null
> +	+++ b/.gitmodules
> +	@@ -0,0 +1,3 @@
> +	+[submodule "sm2"]
> +	+path = sm2
> +	+url = bogus_url
>  	Submodule sm1 $head7...0000000 (submodule deleted)
>  	Submodule sm2 0000000...$head9 (new submodule)
>  	diff --git a/sm2/foo8 b/sm2/foo8
> @@ -728,15 +744,21 @@ test_expect_success 'given commit' '
>  '
>  
>  test_expect_success 'setup .git file for sm2' '
> -	(cd sm2 &&
> -	 REAL="$(pwd)/../.real" &&
> -	 mv .git "$REAL" &&
> -	 echo "gitdir: $REAL" >.git)
> +	git submodule absorbgitdirs sm2
>  '
>  
>  test_expect_success 'diff --submodule=diff with .git file' '
>  	git diff --submodule=diff HEAD^ >actual &&
>  	cat >expected <<-EOF &&
> +	diff --git a/.gitmodules b/.gitmodules
> +	new file mode 100644
> +	index 1234567..89abcde
> +	--- /dev/null
> +	+++ b/.gitmodules
> +	@@ -0,0 +1,3 @@
> +	+[submodule "sm2"]
> +	+path = sm2
> +	+url = bogus_url
>  	Submodule sm1 $head7...0000000 (submodule deleted)
>  	Submodule sm2 0000000...$head9 (new submodule)
>  	diff --git a/sm2/foo8 b/sm2/foo8
> @@ -757,6 +779,19 @@ test_expect_success 'diff --submodule=diff with .git file' '
>  	diff_cmp expected actual
>  '
>  
> +mv sm2 sm2-bak
> +
> +test_expect_success 'deleted submodule with .git file' '
> +	git diff-index -p --submodule=diff HEAD >actual &&
> +	cat >expected <<-EOF &&
> +	Submodule sm1 $head7...0000000 (submodule deleted)
> +	Submodule sm2 $head9...0000000 (submodule deleted)
> +	EOF
> +	diff_cmp expected actual
> +'
> +
> +mv sm2-bak sm2
> +
>  test_expect_success 'setup nested submodule' '
>  	git submodule add -f ./sm2 &&
>  	git commit -a -m "add sm2" &&
