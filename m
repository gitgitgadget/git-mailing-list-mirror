Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4931B949
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253940; cv=none; b=a0gR6BTekLzBCPxuOKHyZwByg4S5kA4r/2HoRum6KCqFONVdpsHfbr3KrhvGPl5wWX0UUVNeeVPPBPn5Vv73D+HGSmcCVRUaCXb+s/c6456PdBLbK/QVvRAuMssqxk8Ajn0rCz9/YwZF3t6yHiqgdb6lv5Dz32g72SNeIkGvBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253940; c=relaxed/simple;
	bh=THVWepmIL1PfRpwWlKGfwv/As4hSm5g2vvdNc+MVGP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZEvanOC6FmwVvgN68leIoTDxEsjqDfQBEprZVOhZZv6XbEYowfN1mZ8z9epEJ+GvJA/UtLntvPjGZi22TtDNfYkfvd65aEDy4136jBojOBKiYWx5+iaU7c6LC2NrgAvm0+FyD8PRnqu6wvWpiuswEXQy3y05o+LG0Cq3hbXm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sphmtSTj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sphmtSTj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A286F1CE3BE;
	Tue,  6 Feb 2024 16:12:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=THVWepmIL1PfRpwWlKGfwv/As4hSm5g2vvdNc+
	MVGP0=; b=sphmtSTjf1+u1C4MZ9RYS61lPZi/2ZBTfM6xxDlPO2t/xAI0WKcmM6
	ETCIemR8DztiM/LP9dF1d1a8lX+thVikLObcxr821X0lc9g07sSXmcUGSadCy0oW
	CPRzJmVw2XIUD6RcaS0KgRPzho3snwCpbKjl6+QOAlS931fNauTUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AE211CE3BD;
	Tue,  6 Feb 2024 16:12:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3E6E1CE3BC;
	Tue,  6 Feb 2024 16:12:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] merge-tree: handle missing objects correctly
In-Reply-To: <pull.1651.git.1707212981.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 06 Feb 2024 09:49:37
	+0000")
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 13:12:15 -0800
Message-ID: <xmqq7cjhguvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68136328-C534-11EE-9B50-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I recently looked into issues where git merge-tree calls returned bogus data
> (in one instance returning an empty tree for non-empty merge parents). By
> the time I had a look at the corresponding repository, the issue was no
> longer reproducible, but a closer look at the code combined with some manual
> experimenting turned up the fact that missing tree objects aren't handled as
> errors by git merge-tree.
>
> While at it, I added a commit on top that tries to catch all remaining
> unchecked parse_tree() calls.
>
> This patch series is based on js/merge-tree-3-trees because I introduced
> three unchecked parse_tree() calls in that topic branch.

Thanks.  All the added checks looked reasonable to me.

Will queue.

>
> Johannes Schindelin (4):
>   merge-tree: fail with a non-zero exit code on missing tree objects
>   merge-ort: do check `parse_tree()`'s return value
>   t4301: verify that merge-tree fails on missing blob objects
>   Always check `parse_tree*()`'s return value
>
>  builtin/checkout.c               | 19 ++++++++++++++++---
>  builtin/clone.c                  |  3 ++-
>  builtin/commit.c                 |  3 ++-
>  builtin/merge-tree.c             |  6 ++++++
>  builtin/read-tree.c              |  3 ++-
>  builtin/reset.c                  |  4 ++++
>  cache-tree.c                     |  4 ++--
>  merge-ort.c                      | 16 +++++++++++-----
>  merge-recursive.c                |  3 ++-
>  merge.c                          |  5 ++++-
>  reset.c                          |  5 +++++
>  sequencer.c                      |  4 ++++
>  t/t4301-merge-tree-write-tree.sh | 24 ++++++++++++++++++++++++
>  13 files changed, 84 insertions(+), 15 deletions(-)
>
>
> base-commit: 5f43cf5b2e4b68386d3774bce880b0f74d801635
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1651%2Fdscho%2Fmerge-tree-and-missing-objects-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1651/dscho/merge-tree-and-missing-objects-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1651
