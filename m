Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10319EEC6
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766272; cv=none; b=mXbjWarCX0VFc0QSaQ0hpU567EWsJtOFJy4aZgsBmH+2V/SQRPESaBynPo8GQALqx1IQ7Y4J3NJcFQVDrtuK/VZ84TI7maYI7w/YBYMmmTW7s402IEd8EgCBFnQ4AY3nm+g5leLM4CL1bZm78kgcT2PraAki3xz3jC5bP8XnzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766272; c=relaxed/simple;
	bh=Kx+dngzsVDGlFfyZormSzstxw5aR8SJUehnUHO+/pdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6heTsrvs8Vdr0DN4PfHQamZD3dfyA/7UwzO4HF3VmsBWkJNjtCYET1Z4lOITMuMOazMAW9c6NiCTTQGWsCplDwRqyxuj5+SOmZtXjvphMnCw/rgrNtDvGTnEbUSRdzP4ABmNs/GQf7OJgOOSc9sVOGnSfVhiMVkLiRPx6HWY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q0D3oaVH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0D3oaVH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5741128E35;
	Thu, 19 Sep 2024 13:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Kx+dngzsVDGlFfyZormSzstxw5aR8SJUehnUHO
	+/pdQ=; b=Q0D3oaVHBDOS3EpgP7LbOj1H1EzwdHtYJju3gwAEx1xrWacuRsNZ3T
	MosNYZWVnqaGE63UkHaRebt/nU3Yfk31rXK0KAL6BKRtiFMwL9aZM8j3Pd0OLN93
	po603FjNmuIuzHhAu+QLVNNmGqV0c9dNxDgjCNsZgNCkuhv0r7FUo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D8B828E34;
	Thu, 19 Sep 2024 13:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A446228E33;
	Thu, 19 Sep 2024 13:17:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 22/23] revision: fix leaking parents when simplifying
 commits
In-Reply-To: <2a23df9a6869f58a231cfe4947b322690d48cb1a.1726484308.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 13:46:28 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<2a23df9a6869f58a231cfe4947b322690d48cb1a.1726484308.git.ps@pks.im>
Date: Thu, 19 Sep 2024 10:17:46 -0700
Message-ID: <xmqq34lv8sw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 177678D2-76AB-11EF-89A2-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When simplifying commits, e.g. because they are treesame with their
> parents, we unset the commit's parent pointers but never free them. Plug
> the resulting memory leaks.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  revision.c                        | 5 +++++
>  t/t1414-reflog-walk.sh            | 1 +
>  t/t5310-pack-bitmaps.sh           | 1 +
>  t/t5326-multi-pack-bitmaps.sh     | 2 ++
>  t/t6004-rev-list-path-optim.sh    | 1 +
>  t/t6019-rev-list-ancestry-path.sh | 1 +
>  t/t6111-rev-list-treesame.sh      | 1 +
>  7 files changed, 12 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 2d7ad2bddff..e79f39e5555 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1071,7 +1071,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  					ts->treesame[nth_parent] = 1;
>  				continue;
>  			}
> +
> +			free_commit_list(parent->next);
>  			parent->next = NULL;

We have been walking commit->parents linked list, "parent" is the
current parent we are looking at.  We are simplifying the history
and decided that later parents are not needed, hence we discard the
remaining commit_list entries starting from parents->next.  But we
didn't discard; we just updated parent->next pointer and made the
pointed data unreachable, leaking.  So we free_commit_list().

> +			while (commit->parents != parent)
> +				pop_commit(&commit->parents);
>  			commit->parents = parent;

And this is the other direction, discarding the parents before the
current one we are looking at.

Of course it makes me wonder if we can just free_commit_list() the
whole thing and then add the current parent commit (in "p", which
was taken with "p = parent->item" before) as the sole parent, with
something like

	free_commit_list(commit->parents);
        commit->parents = NULL;
        /* parent = */ commit_list_insert(p, &commit->parents);

to replace the 5-line (2 to discard later parents, 3 to discard
earlier ones) code, but I do not think it becomes particularly
easier to read, so let's drop that.

> @@ -1103,6 +1107,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  					die("cannot simplify commit %s (invalid %s)",
>  					    oid_to_hex(&commit->object.oid),
>  					    oid_to_hex(&p->object.oid));
> +				free_commit_list(p->parents);
>  				p->parents = NULL;
>  			}
>  		/* fallthrough */

Looking good.

Thanks.
