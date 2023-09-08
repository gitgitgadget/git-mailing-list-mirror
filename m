Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D8EEE8013
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 15:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbjIHPwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjIHPwG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 11:52:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FAACCA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 08:52:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 314E038C89;
        Fri,  8 Sep 2023 11:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=uwnmDF7HS6zJP+lshk6o/3X1KAZ9blbdNaLCep
        8NmPo=; b=ANpD7kDasPf70WTzUxlH8IfUdFTIhCwwoz4/I38amuQVtWtJPPNaIs
        AJuubqVvYqGsiamITynXj9x7stirVn7hbscxYkuqhOVcluU7fbhtNRYPkl9JAxDH
        wKYjIwcJqvbZXM8hY5YXOG1G1O1DZ9q0ebPvJawlMKQZFiAzh2e54=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29B4038C88;
        Fri,  8 Sep 2023 11:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBD3338C86;
        Fri,  8 Sep 2023 11:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] completion(switch/checkout): treat --track and -t the same
In-Reply-To: <pull.1584.git.1694176123471.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 08 Sep 2023 12:28:43
        +0000")
References: <pull.1584.git.1694176123471.gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 08:51:57 -0700
Message-ID: <xmqq1qf8vf1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4D1A942-4E5F-11EE-984B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When `git switch --track ` is to be completed, only remote refs are
> eligible because that is what the `--track` option targets.

OK.  Presumably that is the same for "checkout --track".

> And when the short-hand `-t` is used instead, the same _should_ happen.

That sounds sensible.  The code change for _git_checkout() and
_git_switch() is surprisingly simple ;-)  "-t" was not handled any
specially at all and fell through to "refs" complation.

> Let's make it so.

Sounds good.

> Note that the bug exists both in the completions of `switch` and
> `completion`, even if it manifests in slightly different ways: While
> the completion of `git switch -t ` will not even look at remote refs,
> the completion of `git checkout -t ` will look at both remote _and_
> local refs. Both should look only at remote refs.

Correct.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 133ec92bfae..745dc901fbe 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1607,7 +1607,7 @@ _git_checkout ()
>  
>  		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
>  			__git_complete_refs --mode="refs"
> -		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
> +		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
>  			__git_complete_refs --mode="remote-heads"
>  		else
>  			__git_complete_refs $dwim_opt --mode="refs"
> @@ -2514,7 +2514,7 @@ _git_switch ()
>  
>  		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach")" ]; then
>  			__git_complete_refs --mode="refs"
> -		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
> +		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
>  			__git_complete_refs --mode="remote-heads"
>  		else
>  			__git_complete_refs $dwim_opt --mode="heads"

The fallback behaviours are different, which was adequately
described in the proposed log message.  As "switch" does not want to
auto-detach upon receiving a ref that is not a local branch, while
"checkout" does, the difference is justifiable.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 8835e16e811..df8bc44c285 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1622,14 +1622,22 @@ test_expect_success 'git checkout - with -d, complete only references' '
>  '
>  
>  test_expect_success 'git switch - with --track, complete only remote branches' '
> -	test_completion "git switch --track " <<-\EOF
> +:	test_completion "git switch --track " <<-\EOF &&
> +	other/branch-in-other Z
> +	other/main-in-other Z
> +	EOF
> +	test_completion "git switch -t " <<-\EOF
>  	other/branch-in-other Z
>  	other/main-in-other Z
>  	EOF
>  '

So, this demonstrates that '-t' behaves the same way as '--track'.

>  test_expect_success 'git checkout - with --track, complete only remote branches' '
> -	test_completion "git checkout --track " <<-\EOF
> +	test_completion "git checkout --track " <<-\EOF &&
> +	other/branch-in-other Z
> +	other/main-in-other Z
> +	EOF
> +	test_completion "git checkout -t " <<-\EOF
>  	other/branch-in-other Z
>  	other/main-in-other Z
>  	EOF

This is, too.  If we had a test for "-t" without the code fix, we
would have seen local branches in its output, but now we can see the
candidates are limited to the remote ones.

Good.

Will queue.  Thanks.
