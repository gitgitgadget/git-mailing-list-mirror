Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB84358A1
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IufAhq58"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEED5B8
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 09:28:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 438841FA5B;
	Wed, 18 Oct 2023 12:28:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qfOlkDy4iyYtug9WeShKAvHj4OgEgODQRSguGx
	2qBB0=; b=IufAhq58oQgHSObGvPuU+w0Dz+4uPAjjuItcluxTpZBuNswgoB5oq1
	PadsFRJ+bGRtu8LU0i/HRzxWWyz+EPWnyyjnIKTCegOdBOLYYDFL00sllPIdApj5
	d/aj8tfVrpWKzk+/iysoaDabLtQj+T7VcWkaBKHA1wXIX8G+x7Ol4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BC681FA5A;
	Wed, 18 Oct 2023 12:28:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4CB91FA12;
	Wed, 18 Oct 2023 12:28:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 03/11] t: convert tests to use helpers for reference
 existence
In-Reply-To: <ac6a49c7c84ad2b836f099557dd6989703ebda8f.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:16 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<ac6a49c7c84ad2b836f099557dd6989703ebda8f.1697607222.git.ps@pks.im>
Date: Wed, 18 Oct 2023 09:28:50 -0700
Message-ID: <xmqqcyxbuc71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C6A9F58-6DD3-11EE-8970-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> Convert tests that use `test_path_is_file` and `test_path_is_missing` to
> instead use our new helpers `test_ref_exists` and `test_ref_missing`.
> These hook into the reference database directly and thus work indepently
> of the actual reference backend that is being used.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1430-bad-ref-name.sh | 27 ++++++++++++++++++---------
>  t/t3200-branch.sh       | 33 ++++++++++++++++++---------------
>  t/t5521-pull-options.sh |  4 ++--
>  t/t5605-clone-local.sh  |  2 +-
>  4 files changed, 39 insertions(+), 27 deletions(-)

I scanned through the changes, and all of them looked sensible.  I
also very much liked the added "now we have done something to create
'badname' branch, let's make sure it exists, before trying to see if
the machinery to delete it works correctly" tests.

Looking good.

Thanks.

> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index ff1c967d550..7b7d6953c62 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -205,8 +205,9 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
>  	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
> +	test_ref_exists refs/heads/badname &&
>  	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
> -	test_path_is_missing .git/refs/heads/badname &&
> +	test_ref_missing refs/heads/badname &&
>  	test_must_be_empty output &&
>  	test_must_be_empty error
>  '
> @@ -216,8 +217,9 @@ test_expect_success 'branch -d can delete symref to broken name' '
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
>  	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
> +	test_ref_exists refs/heads/badname &&
>  	git branch -d badname >output 2>error &&
> -	test_path_is_missing .git/refs/heads/badname &&
> +	test_ref_missing refs/heads/badname &&
>  	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
>  	test_must_be_empty error
>  '
> @@ -225,8 +227,9 @@ test_expect_success 'branch -d can delete symref to broken name' '
>  test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
>  	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
> +	test_ref_exists refs/heads/badname &&
>  	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
> -	test_path_is_missing .git/refs/heads/badname &&
> +	test_ref_missing refs/heads/badname &&
>  	test_must_be_empty output &&
>  	test_must_be_empty error
>  '
> @@ -234,8 +237,9 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
>  test_expect_success 'branch -d can delete dangling symref to broken name' '
>  	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
> +	test_ref_exists refs/heads/badname &&
>  	git branch -d badname >output 2>error &&
> -	test_path_is_missing .git/refs/heads/badname &&
> +	test_ref_missing refs/heads/badname &&
>  	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
>  	test_must_be_empty error
>  '
> @@ -245,8 +249,9 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
>  	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
> +	test_ref_exists refs/heads/broken...ref &&
>  	git update-ref -d refs/heads/badname >output 2>error &&
> -	test_path_is_missing .git/refs/heads/broken...ref &&
> +	test_ref_missing refs/heads/broken...ref &&
>  	test_must_be_empty output &&
>  	test_must_be_empty error
>  '
> @@ -254,8 +259,9 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
>  test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
>  	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
> +	test_ref_exists refs/heads/broken...symref &&
>  	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
> -	test_path_is_missing .git/refs/heads/broken...symref &&
> +	test_ref_missing refs/heads/broken...symref &&
>  	test_must_be_empty output &&
>  	test_must_be_empty error
>  '
> @@ -263,8 +269,9 @@ test_expect_success 'update-ref --no-deref -d can delete symref with broken name
>  test_expect_success 'branch -d can delete symref with broken name' '
>  	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
> +	test_ref_exists refs/heads/broken...symref &&
>  	git branch -d broken...symref >output 2>error &&
> -	test_path_is_missing .git/refs/heads/broken...symref &&
> +	test_ref_missing refs/heads/broken...symref &&
>  	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" output &&
>  	test_must_be_empty error
>  '
> @@ -272,8 +279,9 @@ test_expect_success 'branch -d can delete symref with broken name' '
>  test_expect_success 'update-ref --no-deref -d can delete dangling symref with broken name' '
>  	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
> +	test_ref_exists refs/heads/broken...symref &&
>  	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
> -	test_path_is_missing .git/refs/heads/broken...symref &&
> +	test_ref_missing refs/heads/broken...symref &&
>  	test_must_be_empty output &&
>  	test_must_be_empty error
>  '
> @@ -281,8 +289,9 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref with br
>  test_expect_success 'branch -d can delete dangling symref with broken name' '
>  	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
> +	test_ref_exists refs/heads/broken...symref &&
>  	git branch -d broken...symref >output 2>error &&
> -	test_path_is_missing .git/refs/heads/broken...symref &&
> +	test_ref_missing refs/heads/broken...symref &&
>  	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
>  	test_must_be_empty error
>  '
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 080e4f24a6e..bde4f1485b7 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -25,7 +25,7 @@ test_expect_success 'prepare a trivial repository' '
>  
>  test_expect_success 'git branch --help should not have created a bogus branch' '
>  	test_might_fail git branch --man --help </dev/null >/dev/null 2>&1 &&
> -	test_path_is_missing .git/refs/heads/--help
> +	test_ref_missing refs/heads/--help
>  '
>  
>  test_expect_success 'branch -h in broken repository' '
> @@ -40,7 +40,8 @@ test_expect_success 'branch -h in broken repository' '
>  '
>  
>  test_expect_success 'git branch abc should create a branch' '
> -	git branch abc && test_path_is_file .git/refs/heads/abc
> +	git branch abc &&
> +	test_ref_exists refs/heads/abc
>  '
>  
>  test_expect_success 'git branch abc should fail when abc exists' '
> @@ -61,11 +62,13 @@ test_expect_success 'git branch --force abc should succeed when abc exists' '
>  '
>  
>  test_expect_success 'git branch a/b/c should create a branch' '
> -	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
> +	git branch a/b/c &&
> +	test_ref_exists refs/heads/a/b/c
>  '
>  
>  test_expect_success 'git branch mb main... should create a branch' '
> -	git branch mb main... && test_path_is_file .git/refs/heads/mb
> +	git branch mb main... &&
> +	test_ref_exists refs/heads/mb
>  '
>  
>  test_expect_success 'git branch HEAD should fail' '
> @@ -78,14 +81,14 @@ EOF
>  test_expect_success 'git branch --create-reflog d/e/f should create a branch and a log' '
>  	GIT_COMMITTER_DATE="2005-05-26 23:30" \
>  	git -c core.logallrefupdates=false branch --create-reflog d/e/f &&
> -	test_path_is_file .git/refs/heads/d/e/f &&
> +	test_ref_exists refs/heads/d/e/f &&
>  	test_path_is_file .git/logs/refs/heads/d/e/f &&
>  	test_cmp expect .git/logs/refs/heads/d/e/f
>  '
>  
>  test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
>  	git branch -d d/e/f &&
> -	test_path_is_missing .git/refs/heads/d/e/f &&
> +	test_ref_missing refs/heads/d/e/f &&
>  	test_must_fail git reflog exists refs/heads/d/e/f
>  '
>  
> @@ -213,7 +216,7 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
>  		test_commit initial &&
>  		git checkout --orphan lonely &&
>  		grep lonely .git/HEAD &&
> -		test_path_is_missing .git/refs/head/lonely &&
> +		test_ref_missing refs/head/lonely &&
>  		git branch -M main mistress &&
>  		grep lonely .git/HEAD
>  	)
> @@ -799,8 +802,8 @@ test_expect_success 'deleting a symref' '
>  	git symbolic-ref refs/heads/symref refs/heads/target &&
>  	echo "Deleted branch symref (was refs/heads/target)." >expect &&
>  	git branch -d symref >actual &&
> -	test_path_is_file .git/refs/heads/target &&
> -	test_path_is_missing .git/refs/heads/symref &&
> +	test_ref_exists refs/heads/target &&
> +	test_ref_missing refs/heads/symref &&
>  	test_cmp expect actual
>  '
>  
> @@ -809,16 +812,16 @@ test_expect_success 'deleting a dangling symref' '
>  	test_path_is_file .git/refs/heads/dangling-symref &&
>  	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
>  	git branch -d dangling-symref >actual &&
> -	test_path_is_missing .git/refs/heads/dangling-symref &&
> +	test_ref_missing refs/heads/dangling-symref &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'deleting a self-referential symref' '
>  	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
> -	test_path_is_file .git/refs/heads/self-reference &&
> +	test_ref_exists refs/heads/self-reference &&
>  	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
>  	git branch -d self-reference >actual &&
> -	test_path_is_missing .git/refs/heads/self-reference &&
> +	test_ref_missing refs/heads/self-reference &&
>  	test_cmp expect actual
>  '
>  
> @@ -826,8 +829,8 @@ test_expect_success 'renaming a symref is not allowed' '
>  	git symbolic-ref refs/heads/topic refs/heads/main &&
>  	test_must_fail git branch -m topic new-topic &&
>  	git symbolic-ref refs/heads/topic &&
> -	test_path_is_file .git/refs/heads/main &&
> -	test_path_is_missing .git/refs/heads/new-topic
> +	test_ref_exists refs/heads/main &&
> +	test_ref_missing refs/heads/new-topic
>  '
>  
>  test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
> @@ -1142,7 +1145,7 @@ EOF
>  test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
>  	GIT_COMMITTER_DATE="2005-05-26 23:30" \
>  	git checkout -b g/h/i -l main &&
> -	test_path_is_file .git/refs/heads/g/h/i &&
> +	test_ref_exists refs/heads/g/h/i &&
>  	test_path_is_file .git/logs/refs/heads/g/h/i &&
>  	test_cmp expect .git/logs/refs/heads/g/h/i
>  '
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 079b2f2536e..3681859f983 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -143,7 +143,7 @@ test_expect_success 'git pull --dry-run' '
>  		cd clonedry &&
>  		git pull --dry-run ../parent &&
>  		test_path_is_missing .git/FETCH_HEAD &&
> -		test_path_is_missing .git/refs/heads/main &&
> +		test_ref_missing refs/heads/main &&
>  		test_path_is_missing .git/index &&
>  		test_path_is_missing file
>  	)
> @@ -157,7 +157,7 @@ test_expect_success 'git pull --all --dry-run' '
>  		git remote add origin ../parent &&
>  		git pull --all --dry-run &&
>  		test_path_is_missing .git/FETCH_HEAD &&
> -		test_path_is_missing .git/refs/remotes/origin/main &&
> +		test_ref_missing refs/remotes/origin/main &&
>  		test_path_is_missing .git/index &&
>  		test_path_is_missing file
>  	)
> diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
> index 1d7b1abda1a..946c5751885 100755
> --- a/t/t5605-clone-local.sh
> +++ b/t/t5605-clone-local.sh
> @@ -69,7 +69,7 @@ test_expect_success 'local clone of repo with nonexistent ref in HEAD' '
>  	git clone a d &&
>  	(cd d &&
>  	git fetch &&
> -	test ! -e .git/refs/remotes/origin/HEAD)
> +	test_ref_missing refs/remotes/origin/HEAD)
>  '
>  
>  test_expect_success 'bundle clone without .bundle suffix' '
