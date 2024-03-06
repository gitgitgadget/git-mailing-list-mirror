Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6E132C36
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746030; cv=none; b=Al71fi8ShIDEGfa15XK8aRqY9oOn4ZoGreL+PM8Elq44pZE9E5Nxi/R3glfkfjRoN9Ppv2vB34c2FxYBhZ/kKDeVMS+gVAVPIkDumg6+ZgP2s9yfpDRt3TkWacyB/L6GGO9OBLOTUJvNcfh2z77JVGCdZ3EB5izyf5fCo6iz4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746030; c=relaxed/simple;
	bh=oRIAUPIQq42OdwjlO3grA60VqkYJc22u37r8EXZ6xng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K21C48fWTLmVBkzhvRhS7vPGxKqqBUWu7ICxJOOC2zoKrLaGpLDUEI8EGmlGFXndnXKsHhCBuKeozrBOegnOGyObeuRIjPutX8LwXB1DRyjMZ/ShbzJ+79PbBUQHwwNZPEtIUYAJR8fk6plBd6AzJ4jvG95iox1gj0mp0NRbyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nhpvFYAJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhpvFYAJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF1851E428C;
	Wed,  6 Mar 2024 12:27:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oRIAUPIQq42OdwjlO3grA60VqkYJc22u37r8EX
	Z6xng=; b=nhpvFYAJ0W+QQSX6jx+BE/4nO4krlS5SBLr/29b5C4FW6qHCKdj9H5
	y4ocV8mvua9uZRkQXisSF0ULrnpLQfMEw9O6s34ZK9SDWjocWUUTN6u5lbVyhbI8
	GNYSqOeAJP4xbOfTOl5nrck24jmviWquLBY24ht9gUNl6cgeLs9sM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D54A91E428B;
	Wed,  6 Mar 2024 12:27:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 277861E428A;
	Wed,  6 Mar 2024 12:27:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] setup: allow cwd=.git w/ bareRepository=explicit
In-Reply-To: <pull.1645.git.1705709303098.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Sat, 20 Jan 2024 00:08:22
	+0000")
References: <pull.1645.git.1705709303098.gitgitgadget@gmail.com>
Date: Wed, 06 Mar 2024 09:27:05 -0800
Message-ID: <xmqqv85zqniu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C190F24C-DBDE-11EE-8E55-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Teach git to not reject uses of git inside of the .git directory: check
> if cwd is .git (or a subdirectory of it) and allow it even if
> safe.bareRepository=explicit.

> diff --git a/setup.c b/setup.c
> index b38702718fb..b095e284979 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1371,7 +1371,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  
>  		if (is_git_directory(dir->buf)) {
>  			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
> -			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
> +			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT &&
> +			    !ends_with_path_components(dir->buf, ".git"))
>  				return GIT_DIR_DISALLOWED_BARE;
>  			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
>  				return GIT_DIR_INVALID_OWNERSHIP;

I wish we had caught it much before we added DISALLOWED_BARE thing,
but I wonder how well would this escape-hatch interact with
secondary worktrees, where their git directory is not named ".git"
and not immediately below the root level of the working tree?

In a secondary worktree the root level of its working tree has a
file ".git", whose contents may look like

    gitdir: /home/gitster/git.git/.git/worktrees/git.old

where

 - /home/gitster/git.git/ is the primary worktree with the
   repository.

 - /home/gitster/git.git/.git/worktrees/git.old looks like a bare
   repository.

 - /home/gitster/git.git/.git/worktrees/git.old/gitdir gives a way
   to discover the secondary worktree, whose contents just records
   the path to the ".git" file, e.g., "/home/gitster/git.old/.git"
   that had "gitdir: ..." in it.

So perhaps we can also use the presence of "gitdir" file, check the
contents of it tn ensure that ".git" file there takes us back to
this (not quite) bare repository we are looking at, and allow access
to it, or something?

Thoughts?

