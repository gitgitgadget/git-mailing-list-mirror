Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853521E86E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191836; cv=none; b=H2bzvVsx/GEX9PcK8kGpYbGQKSBTyMPLMFhgWXBttlKRjddpUUmvgDz2bTtFisKVlRuOAC1IjBxTjZT9NwhRmDO1LHh9uJMMJ1Iq0367qSOSCMvSndD+WpLZxENqT0agCp8XDlexzqdCtLKsicqUPaLbGWPi6zgQwqf16DA6IEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191836; c=relaxed/simple;
	bh=5pPaYLjjTHnnN2Zh1bZq2l+QFmsbIKLWDr/M3zJs4ZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ifHBXuiPauhObb4ZF1b1CSVgbrS/czZtdvrDKCivi/bXVjgB9QLn0bHDUTrRWHwlvTeig5hAVhYseAJ+sNhKBDjKV9X/fcHxY4mCZWfsLkXW2PiJY+ihvxpOJ4TaEdMYF0g9Ph0Tp/26tgZ54uhKMpmVI8WJo/2+MYQDIxYa6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dj7LbPT6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dj7LbPT6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 405C42EF6B;
	Tue, 20 Aug 2024 18:10:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5pPaYLjjTHnnN2Zh1bZq2l+QFmsbIKLWDr/M3z
	Js4ZA=; b=Dj7LbPT6UYYlU2r5XboZEGe8zcf6YwRgeO5ItllR87SjSPkC/GNwZI
	bn3Hsz285p+vVodla+7WM1Pf662Jac9HOsvUW0D27lxuZb0BeYsemKFvDx4+ZQy3
	kejw0srgmTeVrTMQ3ERK+hzco+IKrQ6xE4DoXd7hQ2wxob1C+aMaw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 361F12EF5D;
	Tue, 20 Aug 2024 18:10:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9668D2EF55;
	Tue, 20 Aug 2024 18:10:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/20] builtin/merge-tree: fix leaking `-X` strategy
 options
In-Reply-To: <53db2fc7206cc11cae4930eba8c413fce4715afb.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:12 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<53db2fc7206cc11cae4930eba8c413fce4715afb.1724159575.git.ps@pks.im>
Date: Tue, 20 Aug 2024 15:10:31 -0700
Message-ID: <xmqqseuy4zhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 04972FBC-5F41-11EF-BA63-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `-X` switch for git-merge-tree(1) will push each option into a local
> `xopts` vector that we then end up parsing. The vector never gets freed
> though, causing a memory leak. Plug it.

It is unfortunate that the ownership rules of the second parameter
to parse_merge_opt() lets the string borrowed by the merge_options
struct.  Otherwise we could have just cleared xopts immediately
after we are done with calling it.

The clean-up looks correct.  Will queue.
Thanks.


>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/merge-tree.c             | 13 ++++++++++---
>  t/t4301-merge-tree-write-tree.sh |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 9bca9b5f33c..c00469ed3db 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -533,6 +533,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  	int expected_remaining_argc;
>  	int original_argc;
>  	const char *merge_base = NULL;
> +	int ret;
>  
>  	const char * const merge_tree_usage[] = {
>  		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
> @@ -625,7 +626,9 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  			strbuf_list_free(split);
>  		}
>  		strbuf_release(&buf);
> -		return 0;
> +
> +		ret = 0;
> +		goto out;
>  	}
>  
>  	/* Figure out which mode to use */
> @@ -664,7 +667,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  
>  	/* Do the relevant type of merge */
>  	if (o.mode == MODE_REAL)
> -		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
> +		ret = real_merge(&o, merge_base, argv[0], argv[1], prefix);
>  	else
> -		return trivial_merge(argv[0], argv[1], argv[2]);
> +		ret = trivial_merge(argv[0], argv[1], argv[2]);
> +
> +out:
> +	strvec_clear(&xopts);
> +	return ret;
>  }
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index eea19907b55..37f1cd7364c 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -2,6 +2,7 @@
>  
>  test_description='git merge-tree --write-tree'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  # This test is ort-specific
