Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E52701C5
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062220; cv=none; b=XdhSQyKJZsW1YsBBYfWt8iQg2WS+4jNvQCwAdY1V5TmugDxz3SVVj2OAI9XuOXK0raHxEBrisDe3Cd0W6x1OinoIyqY6qpf6dIuF2aTihmj6McyzqXc9Ic7r1OIsfg68vwYdAPFW46X7cvU1JLP8s23muQuHW6zgkueI6/1k0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062220; c=relaxed/simple;
	bh=1+dd/NvxMpwAw0nJUoVCGg5UahkH0acpuU5kVDzKKSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmEQIZuU44Ftufsj4fEjsQ7+oor9QyrgLy7RAGeSIReRa51b1yrnFcZ4b9SV4COfTlNk/PKFI8KOglTOYTwfWkfSdht0jghETED5Q5PRA7Y5wRXXyZeB/bujrtHHm06gkVQBIjyWdUl4PmRqlV87rwSXHbEoQwiKYTWjMRI8gyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=fDYP7vXm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="fDYP7vXm"
Date: Wed, 9 Jul 2025 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1752062214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yZmdpT4nhibaud3tXg8DYG4P3caaOUsVwsXsUmpIZ8=;
	b=fDYP7vXmoGTl1cQU8Ss/RUbDEwPmOypNpsZJSG6SGGS/Ju5YrrGoi06PwvRAv/mXnFwaj4
	j9sKtmwIJplSCUfp2oZMdzSnLtKVmZ8wumdXKeKItSXNU3/UpYO3ZaPtZ4kzE4qWBcLsGl
	T6dCbxCd0VYx2ZvFWbaXR4ZV4NLGMto=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Jeff King <peff@peff.net>
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
Message-ID: <xra2vj7fcdsieg4xkvxlctcoubdwalgmhyswub6dxi2pnb34e3@iadinufm23ez>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
 <20250705185842.GA2496172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705185842.GA2496172@coredump.intra.peff.net>
X-Migadu-Flow: FLOW_OUT

On 25/07/05 02:58PM, Jeff King wrote:
> When two remotes collide in the destinations of their fetch refspecs,
> the results can be confusing. For example, in this silly example:
> 
>   git config remote.one.url [...]
>   git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
>   git config remote.two.url [...]
>   git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*
>   git fetch --all
> 
> we may try to write to the same ref twice (once for each remote we're
> fetching). There's also a more subtle version of this. If you have
> remotes "outer/inner" and "outer", then the ref "inner/branch" on the
> second remote will conflict with just "branch" on the former (they both
> want to write to "refs/remotes/outer/inner/branch").

I can give my thoughts from the perspective of someone with an affected
workflow, if no one else is doing that.

I would expect '/' in remote names to be fairly common among people who
name remotes at all (a minority compared to those who have one remote
autonamed 'origin', probably); many things, from kernel.org to Github,
use path-like names (often username/reponame) to name repositories,
and the most relevant subset of that path is a natural thing to name a
remote. But that part doesn't seem controversial, despite the initial
message in this thread. So that's not a problem for me.

What this patch disallows, at least in porcelain, is something like
(these names are just examples) my naming a remote for gregkh/linux.git
"gregkh" and also naming a remote for gregkh/scsi.git "gregkh/scsi",
because it might lead to colliding names if gregkh makes a branch named
"scsi" on the former.

I've probably ever named remotes like this before, though I don't see
any examples in repositories I'm actively using this week. It's
plausible that other people have done this, or are doing it, though if I
had ever shot myself in the foot doing so I would have stopped.

Because it does seem prone to annoying mishaps, I think a change like
this is probably a good idea. It's not a confusing concept, because it's
familiar from how branch names with '/' in them already work.

What would the 'git remote' porcelain do in cases where remotes like
this already exist? I think, from this patch, nothing, since it's
only changing add()?
