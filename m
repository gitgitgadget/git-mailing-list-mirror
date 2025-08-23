Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E9481DD
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966253; cv=none; b=bHugEfPP2TpCmIkg12KgjK96D8/wcf5SXooUMpyiud49aT9SkWwwOgIs8+KPSl6VCMTZhfGWNuZVbg0T/SHjiYhBKwR8gkc8pIwGyC3q+D8WXgSIF4MsVKr8DExZpHYVm1vQkF2TS4d+POlUFE51XuHJf5VhFG3/J3s9dBiZVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966253; c=relaxed/simple;
	bh=Bwbd7SXaGI1k/vqhInCgIZQq/Ekii9ersZSeJwB+Sn8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSNI5l/sOBdKg5sjpTK6V7mfWVDkY3vsofgL8T7KlVXKMZTCOhrvGjMWhzmopLnP/YZWJ7XQxLzHNQxDz5q1LDxLf8qmsCUgG98eN3fMkiQHQqXqAHlbEgAYj9eDVdOWxR7y7X9mXiJzYi2+J6/Y2MzP3g7MDnpNVYeLuHeZ72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=VDkfSiRD; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="VDkfSiRD"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:225b:cdf5:3223:8c9f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 56CF3780502;
	Sat, 23 Aug 2025 18:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755966248;
	bh=Bwbd7SXaGI1k/vqhInCgIZQq/Ekii9ersZSeJwB+Sn8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VDkfSiRDl2wxGmVRhn+3StrT6KwSJo9ng3TBtro2zRc3ufapiqyjPBmLizHeYdN23
	 TF3XzO7NpNUI9r6qEx73pIp7HUHv0B9N4S/By/rLHJ4trffQnaQHHmYB0bNKf8FEfF
	 +BfvRObr8bcZ+wExY500WmtUWQtn0ahBnbTtDuYpLOTkuzCTjjvdqyGGjLkD4eQBcq
	 clfeMUaVFUjc0AQ5BCoDNPsyq0o8GRZS4b5TqTp5jFHs0ErGVqJyEDWjfGgqZkZGXj
	 QcAxV0tnGK24rC3XJ3AmcMdX0ywJipnI4JlcJ57hQ2PQifSRCWV7OG3UJIvHngOkxc
	 rL4ZznTauFllA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH RFC 06/11] builtin/history: implement "reorder" subcommand
Date: Sat, 23 Aug 2025 18:24:07 +0200
Message-ID: <2320291.iZASKD2KPV@cayenne>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-6-9b77c32688fe@pks.im>
References:
 <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-6-9b77c32688fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 19 August 2025 12:56:02 CEST Patrick Steinhardt wrote:
> When working in projects where having nice commits matters it's quite
> common that developers end up reordering commits a lot. Tihs is
> typically done via interactive rebases, where they can then rearrange
> commits in the instruction sheet.
> 
> Still, this operation is a frequent-enough operation to provide a more
> direct of doing this imperatively. As such, introduce a new "reorder"
> subcommand where users can reorder a commit A to come after or before
> another commit B:
> 
>     $ git log --oneline
>     a978f73 fifth
>     57594ee fourth
>     04eb1c4 third
>     d535e30 second
>     bf7438d first
> 
>     $ git history reorder :/fourth --before=:/second
>     $ git log --oneline
>     1610fe0 fifth
>     444f97d third
>     2f90797 second
>     b0ae659 fourth
>     bf7438d first
> 
>     $ git history reorder :/fourth --after=:/second
>     $ git log --oneline
>     c48729d fifth
>     f44a46e third
>     26693b8 fourth
>     8cb4171 second
>     bf7438d first
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  32 ++++++
>  builtin/history.c              | 135 +++++++++++++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3451-history-reorder.sh     | 218 ++++++++++++++++++++++++++++++++++++++
+++
>  4 files changed, 386 insertions(+)
> 
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 3012445ddc..6e8b4e1326 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git history drop [<options>] <revision>
> +git history reorder [<options>] <revision> --(before|after)=<revision>
> 

Same here about <revision> vs <commit>/<commit-ish>. 

Also, the form --(foo|bar) has never been used in synopsis. I think it would 
better be unrolled, just like in the description. Can you rename each 
occurrence of placeholder <revision> on the line so that the description can 
refer to them differently?

>  DESCRIPTION
>  -----------
>@@ -40,6 +41,12 @@ Dropping the root commit converts the child of that commit 
>into the new
> root commit. It is invalid to drop a root commit that does not have any
> child commits, as that would lead to an empty branch.
> 
>+reorder <revision> (--before=<revision>|--after=<revision>)::
>+       Reorder the commit so that it becomes either the parent
>+       (`--before=`) or child (`--after=`) of the other specified
>+       commit. The commits must be related to one another and must be
>+       reachable from the current `HEAD` commit.

with the renamed placeholders, this can be turned into something like:

Move <commit> so that it becomes either the parent of <following-commit> or 
the child of <preceding-commit>.




