Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592331D39F
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009427; cv=none; b=lSl2say0Li5YL76Ldn+MVgACLJ6RFNhtj4kpSrsUsQSTx4Au5Njg7GHav5vkJDhRakuPs6HF6WLf3tZMmdocZLBoTlbWH3tUYGvOkw3CINdFxraHOG+Vdy9cqmlZHwyd8rsFrjxXwXq4DgYrLR1Pl7vGtUuh9QjVxCY8xLFveyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009427; c=relaxed/simple;
	bh=bTLzZTDzlIME3/wWLO6+z8R0Bv7Jt8rYDY+yM/traRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FwpfmSA6/70+WX3gE7KS/wnBNVPQhUIXT7wezwVWmepLcuUW3ui8d1FKboX/gYWNp9DGHXB6s9r76nxEdbnQl5PpA4oxi3ArFA/OD0fP/VxDSSCleB7fKGdVrfp54zLtVSjuoshMkN+eoKV0JxTL+u0DxHEwuIRoMcbgXugpLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=g9H/b/29; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="g9H/b/29"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1772009422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6wZ1TDl9bZv66paqHHZGvgN2rw0gMVbQtRBAdgDaVo=;
	b=g9H/b/29vb947tWRng+yJvL1+DwLFOmnbhW7P217IKb547YrcRDlxvqV8xws0pq9id4Csj
	3GqVyPqJ5BBz5M8UJFbVTsTuXwCv4fFoZD4Nntl5NFsx4fbXbTmukYQNLzKOZ0IK4e5zND
	ICfGHQ4BRDpeh1NATjdg8Bb0nb/wpwY=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
 Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-6-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-6-0509c132a203@gmail.com>
Date: Wed, 25 Feb 2026 09:50:10 +0100
Message-ID: <874in5nr5p.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> index 9912433b8c..1a7b8eadba 100755
> --- a/t/t1423-ref-backend.sh
> +++ b/t/t1423-ref-backend.sh
> @@ -138,22 +189,92 @@ do
>  				git refs migrate --dry-run --ref-format=$to_format >out &&
>  				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
>  
> -				git config set core.repositoryformatversion 1 &&
> -				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
> -
> -				git worktree add ../wt 2
> -			) &&
> +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
> +					"worktree add ../wt 2" "$method" &&
>  
> -			git -C repo for-each-ref --include-root-refs >expect &&
> -			git -C wt for-each-ref --include-root-refs >expect &&
> -			! test_cmp expect actual &&
> +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
> +					"for-each-ref --include-root-refs" "$method" >actual &&
> +				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
> +					"for-each-ref --include-root-refs" "$method" >expect &&
> +				! test_cmp expect actual &&
>  
> -			git -C wt rev-parse 2 >expect &&
> -			git -C wt rev-parse HEAD >actual &&
> -			test_cmp expect actual
> +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
> +					"rev-parse 2" "$method" >actual &&
> +				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
> +					"rev-parse HEAD" "$method" >expect &&
> +				test_cmp expect actual
> +			)
>  		'
>  	done # closes dir
> +
> +	test_expect_success "migrating repository to $to_format with alternate refs directory" '
> +		test_when_finished "rm -rf repo refdir" &&
> +		mkdir refdir &&
> +		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
> +		(
> +			cd repo &&
> +
> +			test_commit 1 &&
> +			test_commit 2 &&
> +			test_commit 3 &&
> +
> +			git refs migrate --ref-format=$to_format &&
> +			git refs list >out &&
> +			test_grep "refs/tags/1"	out &&
> +			test_grep "refs/tags/2"	out &&
> +			test_grep "refs/tags/3"	out
> +		)
> +	'
> +
>  done # closes to_format
>  done # closes from_format
>  
> +done # closes method
> +
> +test_expect_success 'initializing repository with alt ref directory' '
> +	test_when_finished "rm -rf repo refdir" &&
> +	mkdir refdir &&
> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
> +	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
> +	verify_files_exist repo/.git refdir &&
> +	(
> +		cd repo &&
> +
> +		git config get extensions.refstorage >expect &&
> +		echo $BACKEND >actual &&

Shouldn't these two be swapped, like:

		git config get extensions.refstorage >actual &&
		echo $BACKEND >expect &&

> +		test_cmp expect actual &&
> +
> +		test_commit 1 &&
> +		test_commit 2 &&
> +		test_commit 3 &&
> +		git refs list >out &&
> +		test_grep "refs/tags/1"	out &&
> +		test_grep "refs/tags/2"	out &&
> +		test_grep "refs/tags/3"	out
> +	)
> +'
> +
> +test_expect_success 'cloning repository with alt ref directory' '
> +	test_when_finished "rm -rf source repo refdir" &&
> +	mkdir refdir &&
> +
> +	git init source &&
> +	test_commit -C source 1 &&
> +	test_commit -C source 2 &&
> +	test_commit -C source 3 &&
> +
> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
> +	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
> +
> +	git -C repo config get extensions.refstorage >expect &&
> +	echo $BACKEND >actual &&
> +	test_cmp expect actual &&

Same here.

> +
> +	verify_files_exist repo/.git refdir &&
> +
> +	git -C source for-each-ref refs/tags/ >expect &&
> +	git -C repo for-each-ref refs/tags/ >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
>
> -- 
> 2.53.GIT
>
>

-- 
Cheers,
Toon
