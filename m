Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA63EE1DD
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975510; cv=none; b=NDt4wZaudHxqnxXqIsGsJ5Gw/qX2NZbJpoORc24lx72X6gi865ZKSHbhCV19AqwUjmz8ZBXBVEfFpci3K91RvXAvht4gWvJcg9lZ04GYNxzKJHRfADdbgRXsNAPsqgqEnICyMS1cDIFqJmQ1b75yh9YqhmYBK8n31MavFbXJAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975510; c=relaxed/simple;
	bh=qfMi9UhUMRcavvEocL2QOogGS0Yrt1Z8colHCYNTQMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv9+GojpbXzVYTQTbsCg6Fdu0zFxHVlj36BqG7pASfG/c5t24r18eZ/Oo1Il/4z8NEVrX2IDHP/JQlRDRW6L8seD87e3sZXfkKO4kOZwkwFNdUJxzPyDzhpps9tgIjwRflMHfeYqIkC70KsVuC/y0vUBN9ZskrMdEyZS/Uybk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 77D3842C7ED
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 18:44:59 +0200 (CEST)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0B3A8B005C1;
	Tue, 31 Mar 2026 18:44:49 +0200 (CEST)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject:
 Re: [PATCH 2/2] fetch: add fetch.submoduleErrors to make submodule fetch
 errors non-fatal
Date: Tue, 31 Mar 2026 18:44:49 +0200
Message-ID: <2285132.irdbgypaU6@piment-oiseau>
In-Reply-To: <20260330173938.3792358-3-paulius.zaleckas@gmail.com>
References:
 <20260330173938.3792358-1-paulius.zaleckas@gmail.com>
 <20260330173938.3792358-3-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 30 March 2026 19:39:38 CEST Paulius Zaleckas wrote:
> When fetching with --recurse-submodules, a submodule commit that is not
> yet reachable from any of the submodule's remote refs causes the entire
> fetch to fail.  This is overly strict when the missing commit belongs to
> an upstream branch that is still being prepared (e.g. an in-progress
> merge topic): the local branch does not need that commit, so there is no
> reason to treat its absence as fatal.
> 
> Add a new config key fetch.submoduleErrors (values: fail/warn) and a
> corresponding --submodule-errors=<fail|warn> command-line option that
> control this behaviour.  The default remains fail (existing behaviour);
> setting the value to warn causes submodule fetch failures to be reported
> on stderr without affecting the overall exit status of git fetch / git
> pull.
> 
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
>  Documentation/config/fetch.adoc | 14 +++++
>  builtin/fetch.c                 | 39 +++++++++++++-
>  submodule.c                     |  8 ++-
>  submodule.h                     |  7 ++-
>  t/t5526-fetch-submodules.sh     | 96 +++++++++++++++++++++++++++++++++
>  5 files changed, 160 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config/fetch.adoc b/Documentation/config/
fetch.adoc
> index cd40db0cad..8a6b68e57e 100644
> --- a/Documentation/config/fetch.adoc
> +++ b/Documentation/config/fetch.adoc
> @@ -1,3 +1,17 @@
> +`fetch.submoduleErrors`::
> +	Controls how errors from submodule fetches are handled when
> +	`--recurse-submodules` is in effect. When set to `fail` (the 
default),
> +	any submodule fetch error causes the overall `git fetch` or `git 
pull`
> +	to exit with a non-zero status. When set to `warn`, submodule fetch
> +	errors are reported to stderr but do not affect the exit status of 
the
> +	command. This is useful when working in repositories where some
> +	branches reference submodule commits that are not yet available on 
the
> +	submodule remote, but those commits are not needed for the currently
> +	checked-out branch.
> ++
> +The value of this option can be overridden on the command line with
> +`--submodule-errors=<fail|warn>`.

These `fail` and `warn` are keywords, so the alternatives must be expressed in 
synopsis style as `--submodule-errors=(fail|warn)`


I also failed to find the documentation for this `--submodule-errors` option. 
Could you add it in the relevant manual pages?

> +
>  `fetch.recurseSubmodules`::
>  	This option controls whether `git fetch` (and the underlying fetch
>  	in `git pull`) will recursively fetch into populated submodules.



