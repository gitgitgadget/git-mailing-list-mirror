Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521033AF65A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503189; cv=none; b=uh3PH+MTg/g5eZ0cctzuuS5UCgShpsjlOsGL2K51tgj3btElPMCcIY4KzDhCpUfOOMTxTCCEI8/LC8atlvQmIaijhwsrjd+oahGDwzuWvQNL5Xr6r9gmRr5+3G3lBJtA8QHy/Tob4cU8x7lYywf4io8/BSMeQ4CO+muNGB6xVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503189; c=relaxed/simple;
	bh=t17FVQ9ASPDOikpip2ErdGfrySM5v47uQin8sdaZoAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvX5+67ekSAUzn3rsoSyxn7iS3nNt5m38dHVMnsSZgwGj10RrKw/ED8BdTtk4bKwkm+dd/xULM/xsW1PYGQqjE90DzJ6NlJFSpeYfEHvY4a+hmZgoNd3LpSMb0XZTuRA485EqodSMKE1sY4lla7X7zcxSwK2U/wzbaggkHFKpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=V+lxzwTc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="V+lxzwTc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783503175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7/nWP0AfkDemCvEKES5Pqt0wcCCI3xK9nRIsc2Jmf8=;
	b=V+lxzwTczjYBeEGRcpWkqSI9ezZl9VyQvMGvkX+5Bd1qodupcv9lclU6TJS6ngiR/D1cKR
	UZbcqVqvO7sKfKorpsbslit+mgMNXVjzqGHvHNDSsVBL6Z/ALVvg8lxSnNcunXeGL7r1aE
	MFyRsCdV4kXZgNAYIphGcwLGAsi+XFI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/13] setup: introduce explicit repository discovery
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-5-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
 <20260707-pks-setup-split-discovery-and-setup-v2-5-aab372cd227c@pks.im>
Date: Wed, 08 Jul 2026 11:32:40 +0200
Message-ID: <87ldblomh3.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When setting up the global repository we intermix repository discovery
> and repository configuration: we repeatedly call `set_git_work_tree()`
> and `apply_and_export_relative_gitdir()` until we're happy with the
> result. The result of this is then a partially-configured repository
> that we use for further setup.
>
> This process is quite hard to follow, as it's never quite clear which
> parts of the repository have been configured already and which haven't.
> Furthermore, it means that the repository configuration is distributed
> across many different places instead of having it neatly contained in a
> single location. Ultimately, this is the reason that we cannot use a
> central function like `repo_init()`.
>
> Refactor the logic so that we stop partially-configuring a repository
> and instead populate a new `struct repo_discovery`. This allow us to
> essentially split repository setup into two phases:
>
>   - The first phase only figures out parameters required to configure
>     the repository.
>
>   - The second phase then takes these parameters and applies them to the
>     repository.
>
> Like this, we'll never end up with a partially-configured repository and
> can eventually extend `repo_init()` to handle the full initialization
> for us.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 155 ++++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 98 insertions(+), 57 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 324a235dd1..f713d024f7 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1090,14 +1090,47 @@ static void apply_and_export_relative_gitdir(struct repository *repo, const char
>  	strbuf_release(&realpath);
>  }
>  
> -static const char *setup_explicit_git_dir(struct repository *repo,
> -					  const char *gitdirenv,
> -					  struct strbuf *cwd,
> -					  struct repository_format *repo_fmt,
> -					  int *nongit_ok)
> +struct repo_discovery {
> +	char *gitdir;
> +	char *worktree;
> +};

I like where you're going with this. It's nicer to have a struct that
captures what we know and has accurate data, instead of having a
`repository` that's only partly initialized.

-- 
Cheers,
Toon
