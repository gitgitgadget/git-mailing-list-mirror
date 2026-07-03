Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9D3E5EF4
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089119; cv=none; b=oLA6o9i9LiNt/G4gqy4rmniQ30HPpItYFVLIhR3W0doEw45XS9k5USYYXayK7nnk/+FeWoBCr67tZqeNJuZ6v9xk49+qct0IgRP3pOSCrALvvmX+73WJlaw6jq5Sx84v8AxokqbdeYY/WPdJ0YfQFnDbLF7oPUMluos5gTTXOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089119; c=relaxed/simple;
	bh=a72HfgYoL2vDXWpLtBV+imUxYRwND0gHcpmbd+wT4nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XB+n+56dxbaku5YAiD4544agcNgB7Dh3dsq9BN8P6LcogPrDfF/6DcHi9tBa6NQTQga2xITWuirXaNRgiqlIoYMIrv7tT8PY1Q8R6Bazfu7/x8MevpJXnZtxao/5OC0k0mZvEBZrAyg93JwtyVhw0gz1EIaMPC9+MEj1zvWKMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OXWgjRVi; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OXWgjRVi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783089111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BWyO4iEFrm2YotLpybGrsdiMKiaCvMas087cvp4M6NE=;
	b=OXWgjRViDjLrCNGf2TtkGKS6PtUs3Ixown4KuTlQqzJATP5gZ1jlekVP326lYhFaCNqDGm
	7nJB17WvPTURfx/9cQZQUyjesuj0xV7/mthQT80biCMAUFbeGKlSzfCHJ/cgi88bPlCvKM
	mzuMRwbDCw8kT2MCiz+qHxNuDtfETxE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] builtin/refs: add "rename" subcommand
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-5-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-5-deb04de1ecef@pks.im>
Date: Fri, 03 Jul 2026 16:31:46 +0200
Message-ID: <87o6go2lgt.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Add a "rename" subcommand to git-refs(1) with the syntax:
>
>   $ git refs rename <oldref> <newref>
>
> It renames <oldref> together with its reflog to <newref>; even when used
> on a local branch ref, the current value and the reflog of the ref are
> the only things that are renamed. Document it and redirect casual users
> to "git branch -m" if that is what they wanted to do.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-refs.adoc |   6 ++
>  builtin/refs.c              |  49 +++++++++++++++++
>  t/meson.build               |   1 +
>  t/t1467-refs-rename.sh      | 131 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 187 insertions(+)
>
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index e6a3528349..ce278c59bf 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -23,6 +23,7 @@ git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude
>  git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
>  git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
>  git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
> +git refs rename [--message=<reason>] <old-ref> <new-ref>

So symrefs cannot be renamed with this command?

-- 
Cheers,
Toon
