Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A34436
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159201; cv=none; b=r98dR9MiURzsRKsVL285gGsns59ocPdnIx4usu1IYMY4rtgivpKJ57udQLPSeMxcMJkH0/FVSf0gDHCGwMbSD+j282Qq9WvdGJLiI6xAmFtvbq51ZofAKWRslNe8HAzXDbgTHxPdrcuacUdndsZBbPlIhRjGmWLH/utTjYt5siQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159201; c=relaxed/simple;
	bh=jMapII45azoOp7LJkJyUXTorYbORbSRfNi1MI4uTtPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HIPLc74zwjJeLlvHWBgWDjuICOwfaQ5lyuMZxx9hFuUxRPl9Ie1UW9ec3t5mdvKX6e3++UL6sQ7XUJTtbYA5sfZfOB7uIapKSmSy11VKuSJzR/Ri+5fqibfP+ThqRDP/HpgW8mgS8yQ6X3aVBG9Ktr6s8aYoQzqVyCY3MmqZ2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RtfgH5Qm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RtfgH5Qm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DA12D29C9E;
	Tue, 11 Jun 2024 22:26:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jMapII45azoOp7LJkJyUXTorYbORbSRfNi1MI4
	uTtPU=; b=RtfgH5QmwP967mYYyUogHy+f/ZHQ4fwtwYchnQIa0brPgjm49fIaSj
	ShHY/DZ96x/8YLWyrQH8T1DlzFBiip7Pds2kp3bwk6M66119wdh9z+jGFcM7JA8E
	HLXtpPwCh8yQ3fRCMsxn+Rr8J1fq/81bneTj6pUi+IHJi9HvmXFJE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D21B129C9D;
	Tue, 11 Jun 2024 22:26:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3352E29C9C;
	Tue, 11 Jun 2024 22:26:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 09/16] mktree: validate paths more carefully
In-Reply-To: <4f9f77e693cfc4fbe72a2ae739bc7e236a3b82d3.1718130288.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 11 Jun 2024 18:24:41
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<4f9f77e693cfc4fbe72a2ae739bc7e236a3b82d3.1718130288.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 19:26:34 -0700
Message-ID: <xmqq34pirj51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 31175D24-2863-11EF-B151-C38742FD603B-77302942!pb-smtp20.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Use 'verify_path' to validate the paths provided as tree entries, ensuring
> we do not create entries with paths not allowed in trees (e.g.,
> .git).

Sensible.

> Also,
> remove trailing slashes on directories before validating, allowing users to
> provide 'folder-name/' as the path for a tree object entry.

Is that a good idea for a plumbing like this command?  We would
silently accept these after silently stripping the trailing slash?

040000 tree 82a33d5150d9316378ef1955a49f2a5bf21aaeb2    templates/
100644 blob 1f89ffab4c32bc02b5d955851401628a5b9a540e    thread-utils.c/

The former _might_ count as "usability improvement", but if we are
doing the same for the latter we might be going a bit too lenient.

Let's see what really happens in the code.

> @@ -49,10 +50,23 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
>  {
>  	struct tree_entry *ent;
>  	size_t len = strlen(path);
> -	if (!literally && strchr(path, '/'))
> -		die("path %s contains slash", path);
>  
> -	FLEX_ALLOC_MEM(ent, name, path, len);
> +	if (literally) {
> +		FLEX_ALLOC_MEM(ent, name, path, len);
> +	} else {
> +		/* Normalize and validate entry path */
> +		if (S_ISDIR(mode)) {
> +			while(len > 0 && is_dir_sep(path[len - 1]))
> +				len--;
> +		}

Leave a single SP after "while", please.

We do this only to subtree entries, and all trailing slashes, not
just a single one.  OK, but I am not sure if the extra leniency is a
good idea to begin with.  "ls-tree" output does not have such a
trailing slashes, so it is unclear whom we are trying to be extra
nice with this.

> +		FLEX_ALLOC_MEM(ent, name, path, len);
> +
> +		if (!verify_path(ent->name, mode))
> +			die(_("invalid path '%s'"), path);

This is the crux of the change.  And it is so simple.  Very nice.

> +		if (strchr(ent->name, '/'))
> +			die("path %s contains slash", path);
> +	}

> diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
> index e0687cb529f..e0263cb2bf8 100755
> --- a/t/t1010-mktree.sh
> +++ b/t/t1010-mktree.sh
> @@ -173,4 +173,37 @@ test_expect_success '--literally can create invalid trees' '
>  	grep "not properly sorted" err
>  '
>  
> +test_expect_success 'mktree validates path' '
> +	tree_oid="$(cat tree)" &&
> +	blob_oid="$(git rev-parse $tree_oid:a/one)" &&
> +	head_oid="$(git rev-parse HEAD)" &&
> +
> +	# Valid: tree with or without trailing slash, blob without trailing slash
> +	{
> +		printf "040000 tree $tree_oid\tfolder1/\n" &&
> +		printf "040000 tree $tree_oid\tfolder2\n" &&
> +		printf "100644 blob $blob_oid\tfile.txt\n"
> +	} | git mktree >actual &&
> +
> +	# Invalid: blob with trailing slash
> +	printf "100644 blob $blob_oid\ttest/" |
> +	test_must_fail git mktree 2>err &&
> +	grep "invalid path ${SQ}test/${SQ}" err &&
> +
> +	# Invalid: dotdot
> +	printf "040000 tree $tree_oid\t../" |
> +	test_must_fail git mktree 2>err &&
> +	grep "invalid path ${SQ}../${SQ}" err &&
> +
> +	# Invalid: dot
> +	printf "040000 tree $tree_oid\t." |
> +	test_must_fail git mktree 2>err &&
> +	grep "invalid path ${SQ}.${SQ}" err &&
> +
> +	# Invalid: .git
> +	printf "040000 tree $tree_oid\t.git/" |
> +	test_must_fail git mktree 2>err &&
> +	grep "invalid path ${SQ}.git/${SQ}" err
> +'
> +
>  test_done
