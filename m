Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB06C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGUQJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGUQJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:09:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BE84EDE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:09:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BE6F13534D;
        Thu, 21 Jul 2022 12:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LfwYHgH8fgCo54hYwOjBNREaDIkfA50NWMwllb
        tG0Lo=; b=LYQ9OfkMMxunmw5TbAMSxbvSrCqgRajn0p3qGDm2uSlp6lqz4BT6Cs
        T37AYJwe16eWV3fJLzQz2xFQkgjjTf08TxrpOvI0kKoOSaF2QXQ8h/9wweJTwz0w
        +8tPKZwqB3HcLKT8YKF9qXiPDyGufk8jbBgYYhu45LEC2oOScIFDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 726D113534C;
        Thu, 21 Jul 2022 12:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3D5E13534B;
        Thu, 21 Jul 2022 12:09:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/7] merge: do not abort early if one strategy fails
 to handle the merge
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <b41853e3f9908ab458bcb28684d817677e32367b.1658391391.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:09:32 -0700
In-Reply-To: <b41853e3f9908ab458bcb28684d817677e32367b.1658391391.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 21 Jul 2022
        08:16:27 +0000")
Message-ID: <xmqqlesmla6b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8293CACC-090F-11ED-9D07-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  		else
>  			clean = merge_recursive(&o, head, remoteheads->item,
>  						reversed, &result);
> -		if (clean < 0)
> -			exit(128);
> +		if (clean < 0) {
> +			rollback_lock_file(&lock);
> +			return 2;
> +		}

Very good find.  I however wonder if negative returns are signaling
a situation where they cannot cleanly recover from (but even if it
is the case, if we are willing to do the save-restore dance, then it
is probably OK).

> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> index 3a32b1a45cf..772238e582c 100755
> --- a/t/t6402-merge-rename.sh
> +++ b/t/t6402-merge-rename.sh
> @@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
>  	echo >>M one line addition &&
>  	cat M >M.saved &&
>  	git update-index M &&
> -	test_expect_code 128 git pull --no-rebase . yellow &&
> +	test_expect_code 2 git pull --no-rebase . yellow &&
>  	test_cmp M M.saved &&
>  	rm -f M.saved
>  '

Understandable.

> diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
> index f35d3182b86..8b749e19083 100755
> --- a/t/t6424-merge-unrelated-index-changes.sh
> +++ b/t/t6424-merge-unrelated-index-changes.sh
> @@ -268,4 +268,20 @@ test_expect_success 'subtree' '
>  	test_path_is_missing .git/MERGE_HEAD
>  '
>  
> +test_expect_success 'resolve && recursive && ort' '
> +	git reset --hard &&
> +	git checkout B^0 &&
> +
> +	test_seq 0 10 >a &&
> +	git add a &&
> +
> +	sane_unset GIT_TEST_MERGE_ALGORITHM &&
> +	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
> +
> +	grep "Trying merge strategy resolve..." output &&
> +	grep "Trying merge strategy recursive..." output &&
> +	grep "Trying merge strategy ort..." output &&
> +	grep "No merge strategy handled the merge." output
> +'

Makes sense.

>  test_done
> diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
> index 5bfb027099a..52cf0c87690 100755
> --- a/t/t6439-merge-co-error-msgs.sh
> +++ b/t/t6439-merge-co-error-msgs.sh
> @@ -47,6 +47,7 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
>  		export GIT_MERGE_VERBOSITY &&
>  		test_must_fail git merge branch 2>out2
>  	) &&
> +	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>expect &&
>  	test_cmp out2 expect &&
>  	git reset --hard HEAD^
>  '
