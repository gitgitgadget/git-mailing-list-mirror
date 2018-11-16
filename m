Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A1F1F97E
	for <e@80x24.org>; Fri, 16 Nov 2018 05:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeKPPqV (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 10:46:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55495 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeKPPqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 10:46:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86DC412A209;
        Fri, 16 Nov 2018 00:35:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mf7PiO5HMIKkYTl519dNbxK+T1I=; b=DeocXx
        T1ZSqPITHjik2nVXlpeIg4hqHNWc5Bc5sSDokxzVXy1O5QRuK3AnYosKWldPBdzR
        KC+EB0ZzxIvpGwbNe3ae1nvk8flBj17JG7m1B44yCCISQBjk+mRcGy9hRoF0Wt6y
        Ke/4qERcHw7GRnKlM3kuaoR7kWMu/vt3ng6M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D2YyXevLCbgQEtmLTrOOZwS+47YIhjcV
        jVzHWnT70x1GAOxdbs3gQiZgbgYuZLIrEzth7mA2O4ax9rWFeykqsg+yRv7tFr8b
        Xk8/ono6c8rSq0R5KaYNCOUvA4Bx57bKGiRnTh/S3aOP/BMGwdSOHKtsjpS2Xxco
        mXH/M5X85cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FE5312A208;
        Fri, 16 Nov 2018 00:35:24 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED97612A207;
        Fri, 16 Nov 2018 00:35:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH v2 2/2] [Outreachy] stash: tolerate missing user identity
References: <20181114221218.3112-1-slawica92@hotmail.com>
        <20181114222802.10928-1-slawica92@hotmail.com>
Date:   Fri, 16 Nov 2018 14:35:22 +0900
In-Reply-To: <20181114222802.10928-1-slawica92@hotmail.com> (Slavica Djukic's
        message of "Wed, 14 Nov 2018 23:28:02 +0100")
Message-ID: <xmqqwopdk2jp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A54CDDE-E961-11E8-BD82-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica Djukic <slavicadj.ip2018@gmail.com> writes:

>  git-stash.sh     | 17 +++++++++++++++++
>  t/t3903-stash.sh |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 94793c1a9..789ce2f41 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -55,6 +55,20 @@ untracked_files () {
>  	git ls-files -o $z $excl_opt -- "$@"
>  }
>  
> +prepare_fallback_ident () {
> +	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
> +	then
> +		GIT_AUTHOR_NAME="git stash"
> +		GIT_AUTHOR_EMAIL=git@stash
> +		GIT_COMMITTER_NAME="git stash"
> +		GIT_COMMITTER_EMAIL=git@stash
> +		export GIT_AUTHOR_NAME
> +		export GIT_AUTHOR_EMAIL
> +		export GIT_COMMITTER_NAME
> +		export GIT_COMMITTER_EMAIL
> +	fi
> +}
> +
>  clear_stash () {
>  	if test $# != 0
>  	then
> @@ -67,6 +81,9 @@ clear_stash () {
>  }
>  
>  create_stash () {
> +
> +	prepare_fallback_ident
> +
>  	stash_msg=
>  	untracked=
>  	while test $# != 0

That looks like a sensible implementation to me.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index bab8bec67..0b0814421 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1096,7 +1096,7 @@ test_expect_success 'stash -- <subdir> works with binary files' '
>  	test_path_is_file subdir/untracked
>  '
>  
> -test_expect_failure 'stash works when user.name and user.email are not set' '
> +test_expect_success 'stash works when user.name and user.email are not set' '

This line claims to the readers of patch that the known breakage
this known test piece demonstrated has been corrected, but they need
to refresh their memory by going back to the previous patch to see
if this "failure-to-success" flipping is done to the right test
piece, and what exactly the test piece tested to see the existing
breakage, because all the interesting part of the test are chomped
outside the post-context of this hunk.

Unless the fix is fairly complex, adding ought-to-succeed tests that
expect success that break when the code change gets omitted from the
patch in the same patch as the fix itself (i.e. squash patch 1/2 and
patch 2/2 into a single patch) would be more helpful for the readers
(it also helps cherry-picking the fix later to earlier maintenance
tracks if it becomes necessary).

>  	git reset &&
>  	git var GIT_COMMITTER_IDENT >expected &&
>  	>1 &&
