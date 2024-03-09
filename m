Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F1171AA
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709954437; cv=none; b=vCEgSt2MrN4bCTOHVov93CzbehUzOd3KXdUy4sB/CASVNmlNkrWsXa9Uv7OyXiNfbIUNcT3fxpQ0FG8I7j8DBCiTTiDqqQ7pNHBIBA68Qoepiuh43Cj8XiZJ3ifJJCsMR/jl2oobHu3vH7wvNVZU0DWmNDhlYX/lRJpAG86IELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709954437; c=relaxed/simple;
	bh=nuy2c1d5s0Y/o/u9DqzLNR7rnbWVZTDWAa+BQS6zxzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBPosylmss3W860NT6KLXeyWufAjhnWuMZjpTRX3G23XvFz1vI8OKQkXfMb3cu0GNdihvGjd6qxJvimDc2Y3h9T+jP4/FaTRaI+W+lssGwFfpm5dvPoejlyjII4Cu1TNItV9c5xXR1aJ0tt8LuyJHJRjt9e9UiS51Mj8cKleUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyleam.com; spf=pass smtp.mailfrom=kyleam.com; dkim=pass (2048-bit key) header.d=kyleam.com header.i=@kyleam.com header.b=NMfa3fdF; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyleam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyleam.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="NMfa3fdF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
	t=1709954431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxekKE0xEa0vmMWDqrtBYfyFLA0RvqyXp7BbDV+a7/c=;
	b=NMfa3fdFFYv1n4ECWpfzmy5WYKGrhg2707Q6+YNmTRS7Y1WPzWgNxud2gRQHEtn6Yz+SRq
	ywaNKuPXSy5S1wzm31V8M4hxs1blyRLqHiX+2Z557DpRc/5mhNQp3LQ2hnhpx9djLU888H
	SZk1RGps0vbtkMNsmiDw1yMT2sPNO6w6KCfrlRC9iqQODrOs9VkEifN/W7ma98TZ+ybiAE
	dkE3IefeEFjnFGxcj7Wnqw0r2wvBlBnYuth5eoCW7mzIzwIEJgPGcii2lIpdY/BMLNqgRF
	/jRo/6l6NvkqvZl+8SwnPwJW4R3mt83mInPXs/J29nnu06x7h+4zx9W6YVMNDA==
From: Kyle Meyer <kyle@kyleam.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
In-Reply-To: <20240308211957.3758770-3-gitster@pobox.com>
References: <xmqqv85zqniu.fsf@gitster.g>
 <20240308211957.3758770-1-gitster@pobox.com>
 <20240308211957.3758770-3-gitster@pobox.com>
Date: Fri, 08 Mar 2024 22:20:26 -0500
Message-ID: <87msr8qef9.fsf@kyleam.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano writes:

> Now, for the same reason, let's allow command execution from within
> the $GIT_DIR directory of a secondary worktree.  This is useful for
> tools working with secondary worktrees when the 'bareRepository'
> setting is set to 'explicit'.

Does the same reason also apply to .git/modules/$name ?

> In the previous commit, we created a helper function to house the
> logic that checks if a directory that looks like a bare repository
> is actually a part of a non-bare repository.  Extend the helper
> function to also check if the apparent bare-repository is a $GIT_DIR
> of a secondary worktree, by checking three things:
>
>  * The path to the $GIT_DIR must be a subdirectory of
>    ".git/worktrees/", which is the primary worktree [*].
>
>  * Such $GIT_DIR must have file "gitdir", that records the path of
>    the ".git" file that is at the root level of the secondary
>    worktree.
>
>  * That ".git" file in turn points back at the $GIT_DIR we are
>    inspecting.
>
> The latter two points are merely for checking sanity.  The security
> lies in the first requirement.

In the case of .git/modules/, the second point doesn't apply because
there's no gitdir file.  But perhaps the core.worktree setting could be
used for the same purpose.

  $ pwd
  /path/to/super/.git/modules/sub
  $ git config core.worktree
  ../../../sub
