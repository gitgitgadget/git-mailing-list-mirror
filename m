Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DB01F5820
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965729; cv=none; b=ZJKu9ObKOlgZ8eMijoYCEV5GRUPcQYhTW3gBhMI9Cf52q2fd6GaF5iHDZWrP03u9LKYnQT49URmujApx+WyteESLEgw24uyH9kDL41hixSniQdG0kQaa+zyZwLYDTRrMvMu6hroUlAP8Zkpa7fWcEc3rrJcIn5JKsMxNin7mYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965729; c=relaxed/simple;
	bh=716nIKC9F+x4kY5CT8c6uGaZLQryZeOUJ/ieGah64Ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzuOQq5eZUMVsBOhoxgVUeKYjnaf0qbMH+QyzThDZuSVWCfYjyaOFOojOnEZCcMLMym+4wHkxoVefA2E2RRVpmnrikVbcfyLLCrMao7EJ0NUhv5rZHlvNEfUTnTLkWuZj1IucbqoIjakWjeua9CnWGbqc44/zurhoTHJ+aCtj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=nweHIh0j; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="nweHIh0j"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 75E644D284
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 18:15:17 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:225b:cdf5:3223:8c9f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id CA101780505;
	Sat, 23 Aug 2025 18:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755965709;
	bh=716nIKC9F+x4kY5CT8c6uGaZLQryZeOUJ/ieGah64Ko=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nweHIh0j/9kSR6ibTfeG15NL2SHPG+PJdzDsyzbOsnfEXZAOGI3Zv27GIf4EdOL5I
	 UPj26vA+iEVUJzpUepnGXaR9dBJtSs1E++/j219hHN8bbiVcoZDWwoQDmX8ivcKnMH
	 I0mVMeD+NYMKSX4T2y48ocx9fB1eA1XXM3pgo+DcAxIqc5U5fAuCBIKKgPAEadoMOH
	 cKpiku2WkEWnPGbYpxSpCRPlSymud0lCQCrBgN/pBSLVoIUwUBw+jot2bFpf01n3MM
	 SPkBIykGgXrMbJw+gOYxX5e8arPij2eRK2jBw2VpS6Ynu3F41gdF9zO9gR+hUP6zFe
	 LgNCxWO7l1OVQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH RFC 05/11] builtin/history: implement "drop" subcommand
Date: Sat, 23 Aug 2025 18:15:08 +0200
Message-ID: <3005363.e9J7NaK4W3@cayenne>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-5-9b77c32688fe@pks.im>
References:
 <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-5-9b77c32688fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 19 August 2025 12:56:01 CEST Patrick Steinhardt wrote:
> It is a fairly common operation to perform an interactive rebase so that
> one of the commits can be dropped from history. Doing this is not very
> hard in general, but still requires the user to perform multiple steps:
> 
>   1. Identify the commit in question that is to be dropped.
> 
>   2. Perform an interactive rebase on top of that commit's parent.
> 
>   3. Edit the instruction sheet to drop that commit.
> 
> This is needlessly complex for such a supposedly-trivial operation.
> Furthermore, the second step doesn't account for certain edge cases like
> for example dropping the root commit.
> 
> Introduce a new "drop" subcommand to make this use case significantly
> simpler: all the user needs to do is to say `git history drop $COMMIT`
> and they're done.
> 
> Note that for now, this command only allows users to drop a single
> commit at once. It should be easy enough though to expand the command at
> a later point in time to support dropping whole commit ranges.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  27 +++-
>  builtin/history.c              | 297 ++++++++++++++++++++++++++++++++++++++
++-
>  t/meson.build                  |   3 +-
>  t/t3450-history-drop.sh        | 127 ++++++++++++++++++
>  4 files changed, 449 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 9dafb8fc16..3012445ddc 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -8,7 +8,7 @@ git-history - Rewrite history of the current branch
>  SYNOPSIS
>  --------
>  [synopsis]
> -git history [<options>]
> +git history drop [<options>] <revision>
> 

Grepping through the documentation for the <revision> placeholder does not 
yield a lot of matches. Can <revision> be replaced by <commit> or <commit-ish>  
in this context; these ones seem widely used.


>  DESCRIPTION
>  -----------
> @@ -31,6 +31,31 @@ COMMANDS
>  This command requires a subcommand. Several subcommands are available to
>  rewrite history in different ways.
> 
> +drop <revision>::

My linting patch series[1] does not catch this kind of synopsis miss, but 
here, backticks are missing because this is a part of synopsis:

`drop <revision>`::


> +	Drop a commit from the history and reapply all children of that
> +	commit on top of the commit's parent. The commit that is to be
> +	dropped must be reachable from the current `HEAD` commit.
> ++
> +Dropping the root commit converts the child of that commit into the new
> +root commit. It is invalid to drop a root commit that does not have any
> +child commits, as that would lead to an empty branch.
> +
> +EXAMPLES
> +--------
> +
> +* Drop a commit from history.
> ++

As the examples are quite long, it would make sense to declare each example as 
a sub-section:

Drop a commit from history
~~~~~~~~~~~~~~~~~~~~~~~~~~

> +----------
> +$ git log --oneline
> +2d4cd6d third
> +125a0f3 second
> +e098c27 first
> +$ git history drop HEAD~
> +$ git log
> +b1bc1bd third
> +e098c27 first
> +----------
> +
>  CONFIGURATION
>  -------------
> 



