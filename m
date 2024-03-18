Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DB54BD5
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783096; cv=none; b=tE+VoxOO/TmWbqohylCuruprLWRgfeHQ1FMDv5wRcdrJK7CAiPklZ4XAT3fsD60PKatlFBFNwgnao+xsnDEkj/gidyOZeWJi4q6QCw9pAb7ocwr4E47G6vk7i6sGRtdzpWlcE/nDpueIOyCRoFdMhnwWApa/WjprH3fcN6jaTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783096; c=relaxed/simple;
	bh=KowxKy6GqhL9gzxSdZ8Jp1agnmr45+vDH0hJnT/LMTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVPkXC1GsZOWlZ+8mxs151Vt3BSm7z2WmAths3RssCESB1HJNiI/dbdyNKS4A1MaYskzi5jS2p1y0LH4mYqe9MfQ9usfMpE1yqIBJ3MndEcj+FaGFVwJeMV/569P8X0+Pv+n7yWhj+/Le6AzpFTljY8mx/Qx5MWGfyubNJU/c5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DUDBpXxW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DUDBpXxW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 898F22E91D;
	Mon, 18 Mar 2024 13:31:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KowxKy6GqhL9gzxSdZ8Jp1agnmr45+vDH0hJnT
	/LMTY=; b=DUDBpXxWWodaEtk7zcSp/z619WlekSjy8V57DPJs8zcZ3XSITvfZ66
	ekW9z01bVOEKoAQrC30d0nrE1GsUCXTZ2jGXopg7W+5vDQgkTN6zpPCbPrJBYjXJ
	bNKYYZHMhBzryYyT5l5vnOH8wDDtItemwn2ATTutpU+4yseNeAxo4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 811A82E91B;
	Mon, 18 Mar 2024 13:31:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E4B22E91A;
	Mon, 18 Mar 2024 13:31:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/add: error out when passing untracked path
 with -u
In-Reply-To: <20240318155219.494206-6-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Mon, 18 Mar 2024 21:22:01 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240318155219.494206-6-shyamthakkar001@gmail.com>
Date: Mon, 18 Mar 2024 10:31:29 -0700
Message-ID: <xmqqa5mvh2fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BDB0E9C-E54D-11EE-8151-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Currently when we pass a pathspec which does not match any tracked path
> along side --update, it silently succeeds, unlike without --update. As
> --update only touches known paths, match the pathspec against the index
> and error out when no match found. And ensure that the index is fully
> expanded before matching the pathspec. Also add a testcase to check
> for the error.
>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  builtin/add.c         | 16 ++++++++++++++++
>  t/t2200-add-update.sh |  5 +++++
>  2 files changed, 21 insertions(+)

Exactly the same comment applies here.  If we are using pathspec, we
should already have a loop that calls ce_path_match() for each and
every path we know about, and we should be updating the code to
collect "have we used all pathspec elements?" information at the
same time if it is not doing so already.  Let's not make another
loop that checks what we should already be doing elsewhere.

Thanks.

> diff --git a/builtin/add.c b/builtin/add.c
> index 393c10cbcf..7ec5ea4a3e 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -24,6 +24,7 @@
>  #include "strvec.h"
>  #include "submodule.h"
>  #include "add-interactive.h"
> +#include "sparse-index.h"
>  
>  static const char * const builtin_add_usage[] = {
>  	N_("git add [<options>] [--] <pathspec>..."),
> @@ -536,6 +537,21 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  			}
>  		}
>  
> +		if (take_worktree_changes && pathspec.nr) {
> +			int i, ret;
> +			char *ps_matched = xcalloc(pathspec.nr, 1);
> +
> +			/* TODO: audit for interaction with sparse-index. */
> +			ensure_full_index(&the_index);
> +			for (i = 0; i < the_index.cache_nr; i++)
> +				ce_path_match(&the_index, the_index.cache[i],
> +					      &pathspec, ps_matched);
> +
> +			ret = report_path_error(ps_matched, &pathspec);
> +			free(ps_matched);
> +			if (ret)
> +				exit(1);
> +		}
>  
>  		if (only_match_skip_worktree.nr) {
>  			advise_on_updating_sparse_paths(&only_match_skip_worktree);
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index c01492f33f..f6a9615d1b 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -65,6 +65,11 @@ test_expect_success 'update did not touch untracked files' '
>  	test_must_be_empty out
>  '
>  
> +test_expect_success 'error out when given untracked path' '
> +	test_must_fail git add -u dir2/other 2>err &&
> +	test_grep -e "error: pathspec .dir2/other. did not match any file(s) known to git" err
> +'
> +
>  test_expect_success 'cache tree has not been corrupted' '
>  
>  	git ls-files -s |
