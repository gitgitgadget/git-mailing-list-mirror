Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088741E505
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633187; cv=none; b=Scuywv6u3GaIiYtVQ9ILOSXiHoXKNt4CtN2tPTGhQ4CX/Lfola+PE81TyVcFdj0F1ciV0mRJHBTl6LTwGJ3cZQs6CoEP/RW3I0k+qzYjk6uuqjUWQc5OdoTq2ZeApq0sh/5hubtNAY5QiIfWazmGogt4ZJWGVq0VeGYOgorhs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633187; c=relaxed/simple;
	bh=7sxkrPCICVlXSGO4LgZEd38nPDRQu63gI/1Olc6XOmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+Q6uyG14jLNxoX8r4SlAQIULaTXPeOqPysSZSQxkntLH4EIdnzFpuqJCq0VVUhzLZ9hL5sh8gmLtSV5TJVU4gXLtSGwhRIA+9ZuuyhxcgQisf36CoFp3abJQ9t8Uc4TvXy/umj2mxmqLdt3UgZ27lIkuo7r1Z5/724eYQ1wXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=M3S5Iqlx; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="M3S5Iqlx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744633177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32CfdtFovNPwmjV03ZZVzZH7uOEklVF48Wbg//IFhiM=;
	b=M3S5Iqlx7yp+6Y23SzB8SO/dJiUyBqYTOkOUWl6wHpSxap9PokdvgIqwFO0WA3r1HZFF8H
	HOOmUrj9Z40aDdoE3EywAfWZ47uBxemoiAARxN770vi3rcDzwuSLSR8nZIfLXV9uy+fO19
	Vzcwa+1RB++aqg1otKElmOzFy3ji+Tk=
From: Toon Claes <toon@iotcl.com>
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Scott Chacon
 <schacon@gmail.com>
Subject: Re: [PATCH v3 2/2] bundle-uri: add test for bundle-uri clones with
 tags
In-Reply-To: <Z9sD63+d+EQKSMXM@nand.local>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
 <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
 <d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
 <e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com>
 <Z9sD63+d+EQKSMXM@nand.local>
Date: Mon, 14 Apr 2025 14:19:27 +0200
Message-ID: <87cydf541c.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> I think we should be testing that all of the refs we expect to have made
> it over actually did so. This diff (applied on top of your series) does
> that:
>
> --- 8< ---
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index b1276ba295..9b211a626b 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -128,13 +128,12 @@ test_expect_success 'create bundle with tags' '
>  test_expect_success 'clone with tags bundle' '
>  	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
>  		clone-from-tags clone-tags-path &&
> -	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/tags/" refs >actual &&
> -	cat >expect <<-\EOF &&
> -	refs/bundles/tags/A
> -	refs/bundles/tags/B
> -	refs/bundles/tags/tag-A
> -	EOF
> +
> +	git -C clone-from-tags for-each-ref --format="%(refname:lstrip=1)" \
> +		>expect &&
> +	git -C clone-tags-path for-each-ref --format="%(refname:lstrip=2)" \
> +		refs/bundles >actual &&
> +
>  	test_cmp expect actual
>  '
> --- >8 ---
>
> While writing the above, I wasn't quite sure how to follow the test
> setup. It looks like it creates the following structure:
>
>     $ git log --oneline --graph
>     * d9df450 (HEAD -> base, tag: B) B
>     * 0ddfaf1 (tag: tag-A, tag: A) A
>
> , which we could do with just:
>
>     test_commit A &&
>     test_commit B
>
> But even then, I don't think we really need to have more than one tag
> here to exercise this functionality. So I think it would be fine to
> simplify the test to just create a single tag, which a simple
> "test_commit A" should do.

Hi Scott,

Are you planning to pick up this patch series again? I think it would be
really valuable to get this merged. The patch by Taylor above might be
worth integrating, other than that I think it should be good to go.

Let me know if I can provide any help.

-- 
Toon
