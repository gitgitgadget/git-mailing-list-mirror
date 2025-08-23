Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578C78F58
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967048; cv=none; b=alIskZmU/PyCmLDMDBjAWK7lyZGiEUCzSD3t1APh3CgxWSk0rFouO5orwWdfBJhX39Hzn35ojeb7dTRQx666uSlK0z0DsVA0+L6Dm/b5m6X1cvCM+HWRxJh+Wx19Dw4UQbLIUrAzrAtiBCBVWE+I4/0cPbd9jE7jLny1+/69Eqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967048; c=relaxed/simple;
	bh=1n33/a0kMTNTadpCYXAfnKUqFKs66dQQnQwlEX383sA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCWTqidX7pbB51jrzOumzEnSvhH561nE2/+S5xhKRnFjDY6VXyD3KHfXuCbpryErpFfwj72vmbqxV+ky3LRYeB9njTdvPsruGshC4UDaa4ew3n25WgwHL5ilElfOMS4L2fB3BsUEYStanS/pgNpSkEYmvKXRiXZVKHJkT7GCoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=I2tavrDz; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="I2tavrDz"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:225b:cdf5:3223:8c9f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 494EE780368;
	Sat, 23 Aug 2025 18:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755967044;
	bh=1n33/a0kMTNTadpCYXAfnKUqFKs66dQQnQwlEX383sA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I2tavrDz6TpfmsVIgiD3EhW2KCt4s7HTDqEEzionzvj1koSQw/EAKRWqpH1+/RTAt
	 A1iftxF4MAA3cH28Mirp/4EIR9d/r/DKlNbG59Li/6K1SuaZ6CH2sw18lFuJeSbX9t
	 3BQ8RJtpIcMaQZQAIuCzZF4DzI7Rgfk1aMo3xN2fY1KpK7A2BefUjYBG/l05eHGaOC
	 Qaw5MEMITUG4bzEYLacutWaE2vK9Nc1h4oEtNnAllaZ2hSL7r9e2ESpjT4OamZEkGY
	 7eoQonwvKD1Kk52ypuTNXFUOB8PCdzGG9a37nMNE1iBJjdXNvdsYLBp9DFzWGx05QZ
	 +HgDcQONbZ9vw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
Date: Sat, 23 Aug 2025 18:37:23 +0200
Message-ID: <3298210.5fSG56mABF@cayenne>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
References:
 <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 19 August 2025 12:56:07 CEST Patrick Steinhardt wrote:
> It is quite a common use case that one wants to split up one commit into
> multiple commits by moving parts of the changes of the original commit
> out of it into a separate commit. This is quite an involved operation
> though:
> 
>   1. Identify the commit in question that is to be dropped.
> 
>   2. Perform an interactive rebase on top of that commit's parent.
> 
>   3. Modify the instruction sheet to "edit" the commit that is to be
>      split up.
> 
>   4. Drop the commit via "git reset HEAD~".
> 
>   5. Stage changes that should go into the first commit and commit it.
> 
>   6. Stage changes that should go into the second commit and commit it.
> 
>   7. Finalize the rebase.
> 
> This is quite complex, and overall I would claim that most people who
> are not experts in Git would struggle with this flow.
> 
> Introduce a new "split" subcommand for git-history(1) to make this way
> easier. All the user needs to do is to say `git history split $COMMIT`.
> From hereon, Git asks the user which parts of the commit shall be moved
> out into a separate commit and, once done, asks the user for the commit
> message. Git then creates that split-out commit and applies the original
> commit on top of it.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  59 ++++++++
>  builtin/history.c              | 245 +++++++++++++++++++++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3452-history-split.sh       | 304 ++++++++++++++++++++++++++++++++++++++
+++
>  4 files changed, 609 insertions(+)
> 
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 6e8b4e1326..f0f1f2a093 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -10,6 +10,7 @@ SYNOPSIS
>  [synopsis]
>  git history drop [<options>] <revision>
>  git history reorder [<options>] <revision> --(before|after)=<revision>
> +git history split [<options>] <revision> [--] [<pathspec>...]

I just realized that there are no other <options> available for the first two 
commands! So maybe simplify the synopsis for the time being.

The --message is specific to split, so maybe also cite is specifically here.
I 
> 
>  DESCRIPTION
>  -----------
> @@ -47,6 +48,26 @@ reorder <revision> (--before=<revision>|--
after=<revision>)::
>  	commit. The commits must be related to one another and must be
>  	reachable from the current `HEAD` commit.
> 
> +split <revision> [--message=<message>] [--] [<pathspec>...]::

missing backticks. Also the order of options and <commit> are different from 
the general synopsis. Is this order allowed?

> +	Interactively split up the commit into two commits by choosing

You can use the placeholder in this sentence: "Interactively split up 
<commit>..."

> +	hunks introduced by it that will be moved into the new split-out
> +	commit. These hunks will then be written into a new commit that
> +	becomes the parent of the previous commit. The original commit
> +	stays intact, except that its parent will be the newly split-out
> +	commit.
> ++
> +The commit message of the new commit will be asked for by launching the
> +configured editor. Authorship of the commit will be the same as for the
> +original commit.
> ++

I guess this only happens if --message is not passed?

> +If passed, _<pathspec>_ can be used to limit which changes shall be split 
out
> +of the original commit. Files not matching any of the pathspecs will remain
> +part of the original commit. For more details about the _<pathspec>_ 
syntax,
> +see the 'pathspec' entry.

You may have meant: 
+
For more details, see the 'pathspec' entry in linkgit:gitglossary[7].

> ++
> +It is invalid to select either all or no hunks, as that would lead to
> +one of the commits becoming empty.
> +
>  EXAMPLES
>  --------
> 
> @@ -88,6 +109,44 @@ f44a46e third
>  bf7438d first
>  ----------
> 
> +* Split a commit.
> ++
> +----------
> +$ git log --stat --oneline
> +3f81232 (HEAD -> main) original
> + bar | 1 +
> + foo | 1 +
> + 2 files changed, 2 insertions(+)
> +
> +$ git history split HEAD --message="split-out commit"
> +diff --git a/bar b/bar
> +new file mode 100644
> +index 0000000..5716ca5
> +--- /dev/null
> ++++ b/bar
> +@@ -0,0 +1 @@
> ++bar
> +(1/1) Stage addition [y,n,q,a,d,e,p,?]? y
> +
> +diff --git a/foo b/foo
> +new file mode 100644
> +index 0000000..257cc56
> +--- /dev/null
> ++++ b/foo
> +@@ -0,0 +1 @@
> ++foo
> +(1/1) Stage addition [y,n,q,a,d,e,p,?]? n
> +
> +$ git log --stat --oneline
> +7cebe64 (HEAD -> main) original
> + foo | 1 +
> + 1 file changed, 1 insertion(+)
> +d1582f3 split-out commit
> + bar | 1 +
> + 1 file changed, 1 insertion(+)
> +----------
> +
> +
>  CONFIGURATION
>  -------------



