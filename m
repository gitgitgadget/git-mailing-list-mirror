Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881B51F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 05:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfKLFRk (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 00:17:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50667 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLFRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 00:17:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EA7C8F890;
        Tue, 12 Nov 2019 00:17:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8XkEWzxCkQlvsquVKdmie+aa2OI=; b=S8cYPr
        G92kjddWVJMHLJBFYDD77RfjQ1Du47TvgRJLlm18KKI+SPKULOblt51BpE4PZTkj
        DXLF/O1DyzimiLN/OGWutWgmN+pGt0bHV0aw6ahOk0B9meGrpirYHrlzOuJ5ZN0x
        5TkTxOpIExMJ/fJf2bS9HxUdwMhA4ZG4OBsVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sZyQxjERegEBr1wSr1uONQ4wjrEd/NJH
        ZrEnMautjseLUMMdRG62OiUt8zz1/TqE24PZwz6Rg2fT85AqOJ3eWPipyT6edrlr
        pbA8IS+F92ZDyGosj/zPf1dvbvrZdTpWOtx6dnHDH3X+fNdL1kFXTzDk878Ae9wT
        Dq8FoJqY6BU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 543AE8F88F;
        Tue, 12 Nov 2019 00:17:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F59A8F88D;
        Tue, 12 Nov 2019 00:17:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 10/14] t5520: test single-line files by git with test_cmp
References: <cover.1573152598.git.liu.denton@gmail.com>
        <cover.1573517561.git.liu.denton@gmail.com>
        <2f9052fd94ebb6fe93ea6fe2e7cd3c717635c822.1573517561.git.liu.denton@gmail.com>
Date:   Tue, 12 Nov 2019 14:17:33 +0900
In-Reply-To: <2f9052fd94ebb6fe93ea6fe2e7cd3c717635c822.1573517561.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 11 Nov 2019 16:14:02 -0800")
Message-ID: <xmqqh839fzbm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC9CBB44-050B-11EA-92D0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In case an invocation of a Git command fails within the subshell, the
> failure will be masked. Replace the subshell with a file-redirection and
> a call to test_cmp.

I.e.

    test "$(git cmd args)" = "expected-string"

=>

    git cmd args >actual && echo "expected-string" >expect &&
    test_cmp expect actual

which makes sense.  It may break if expected-string begins with a
dash or something silly like that, but a quick eyeballing over the
patch tells me that we are safe there.

Technically, "$(git cmd args)" used as a command line option of
another command is called "command substitution", not "subshell".
The proposed log message may need to be updated.

> This change was done with the following GNU sed expressions:
>
> 	s/\(\s*\)test \([^ ]*\) = "$(\(git [^)]*\))"/\1echo \2 >expect \&\&\n\1\3 >actual \&\&\n\1test_cmp expect actual/
> 	s/\(\s*\)test "$(\(git [^)]*\))" = \([^ ]*\)/\1echo \3 >expect \&\&\n\1\2 >actual \&\&\n\1test_cmp expect actual/
>
> A future patch will clean up situations where we have multiple duplicate
> statements within a test case. This is done to keep this patch purely
> mechanical.

OK.  One thing that worries me is if the existing tests are not
expecting (no pun intended) to see 'expect' or 'actual' (e.g. if
they somehow rely on output of "ls-files -u", we are now adding two
untracked files in the working tree).  Another is if the git command
is expected to produce nothing, possibly after failing, and the test
is expecting to see an empty string---in such a case, the hiding of
the exit status would have been intentional ;-)  We'd want to be sure
that we aren't breaking the tests like that by reading through the
result of applying this patch.

Since this is just a single file, I trust you have already done such
sanity checking ;-)

The mechanical conversion procedure itself looks OK.

Thanks.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t5520-pull.sh | 64 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 16 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 1af6ea06ee..8b7e7ae55d 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -255,7 +255,9 @@ test_expect_success '--rebase' '
>  	git tag before-rebase &&
>  	git pull --rebase . copy &&
>  	test_cmp_rev HEAD^ copy &&
> -	test new = "$(git show HEAD:file2)"
> +	echo new >expect &&
> +	git show HEAD:file2 >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success '--rebase fast forward' '
> @@ -330,7 +332,9 @@ test_expect_success '--rebase fails with multiple branches' '
>  	test_must_fail git pull --rebase . copy master 2>err &&
>  	test_cmp_rev HEAD before-rebase &&
>  	test_i18ngrep "Cannot rebase onto multiple branches" err &&
> -	test modified = "$(git show HEAD:file)"
> +	echo modified >expect &&
> +	git show HEAD:file >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
> @@ -381,7 +385,9 @@ test_expect_success 'pull.rebase' '
>  	test_config pull.rebase true &&
>  	git pull . copy &&
>  	test_cmp_rev HEAD^ copy &&
> -	test new = "$(git show HEAD:file2)"
> +	echo new >expect &&
> +	git show HEAD:file2 >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'pull --autostash & pull.rebase=true' '
> @@ -399,7 +405,9 @@ test_expect_success 'branch.to-rebase.rebase' '
>  	test_config branch.to-rebase.rebase true &&
>  	git pull . copy &&
>  	test_cmp_rev HEAD^ copy &&
> -	test new = "$(git show HEAD:file2)"
> +	echo new >expect &&
> +	git show HEAD:file2 >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
> @@ -408,14 +416,18 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>  	test_config branch.to-rebase.rebase false &&
>  	git pull . copy &&
>  	test_cmp_rev ! HEAD^ copy &&
> -	test new = "$(git show HEAD:file2)"
> +	echo new >expect &&
> +	git show HEAD:file2 >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'pull --rebase warns on --verify-signatures' '
>  	git reset --hard before-rebase &&
>  	git pull --rebase --verify-signatures . copy 2>err &&
>  	test_cmp_rev HEAD^ copy &&
> -	test new = "$(git show HEAD:file2)" &&
> +	echo new >expect &&
> +	git show HEAD:file2 >actual &&
> +	test_cmp expect actual &&
>  	test_i18ngrep "ignoring --verify-signatures for rebase" err
>  '
>  
> @@ -423,7 +435,9 @@ test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
>  	git reset --hard before-rebase &&
>  	git pull --rebase --no-verify-signatures . copy 2>err &&
>  	test_cmp_rev HEAD^ copy &&
> -	test new = "$(git show HEAD:file2)" &&
> +	echo new >expect &&
> +	git show HEAD:file2 >actual &&
> +	test_cmp expect actual &&
>  	test_i18ngrep ! "verify-signatures" err
>  '
>  
> @@ -445,7 +459,9 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
>  	git pull . copy &&
>  	test_cmp_rev HEAD^1 before-preserve-rebase &&
>  	test_cmp_rev HEAD^2 copy &&
> -	test file3 = "$(git show HEAD:file3.t)"
> +	echo file3 >expect &&
> +	git show HEAD:file3.t >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'pull.rebase=true flattens keep-merge' '
> @@ -453,7 +469,9 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
>  	test_config pull.rebase true &&
>  	git pull . copy &&
>  	test_cmp_rev HEAD^^ copy &&
> -	test file3 = "$(git show HEAD:file3.t)"
> +	echo file3 >expect &&
> +	git show HEAD:file3.t >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
> @@ -461,7 +479,9 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
>  	test_config pull.rebase 1 &&
>  	git pull . copy &&
>  	test_cmp_rev HEAD^^ copy &&
> -	test file3 = "$(git show HEAD:file3.t)"
> +	echo file3 >expect &&
> +	git show HEAD:file3.t >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success REBASE_P \
> @@ -507,7 +527,9 @@ test_expect_success '--rebase=false create a new merge commit' '
>  	git pull --rebase=false . copy &&
>  	test_cmp_rev HEAD^1 before-preserve-rebase &&
>  	test_cmp_rev HEAD^2 copy &&
> -	test file3 = "$(git show HEAD:file3.t)"
> +	echo file3 >expect &&
> +	git show HEAD:file3.t >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success '--rebase=true rebases and flattens keep-merge' '
> @@ -515,7 +537,9 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
>  	test_config pull.rebase preserve &&
>  	git pull --rebase=true . copy &&
>  	test_cmp_rev HEAD^^ copy &&
> -	test file3 = "$(git show HEAD:file3.t)"
> +	echo file3 >expect &&
> +	git show HEAD:file3.t >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success REBASE_P \
> @@ -537,7 +561,9 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
>  	test_config pull.rebase preserve &&
>  	git pull --rebase . copy &&
>  	test_cmp_rev HEAD^^ copy &&
> -	test file3 = "$(git show HEAD:file3.t)"
> +	echo file3 >expect &&
> +	git show HEAD:file3.t >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success '--rebase with rebased upstream' '
> @@ -622,10 +648,16 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
>  		cd empty_repo2 &&
>  		echo staged-file >staged-file &&
>  		git add staged-file &&
> -		test "$(git ls-files)" = staged-file &&
> +		echo staged-file >expect &&
> +		git ls-files >actual &&
> +		test_cmp expect actual &&
>  		test_must_fail git pull --rebase .. master 2>err &&
> -		test "$(git ls-files)" = staged-file &&
> -		test "$(git show :staged-file)" = staged-file &&
> +		echo staged-file >expect &&
> +		git ls-files >actual &&
> +		test_cmp expect actual &&
> +		echo staged-file >expect &&
> +		git show :staged-file >actual &&
> +		test_cmp expect actual &&
>  		test_i18ngrep "unborn branch with changes added to the index" err
>  	)
>  '
