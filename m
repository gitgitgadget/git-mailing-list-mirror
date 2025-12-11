Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF101B7903
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462614; cv=none; b=T41GWN4eMb9hj6y/W3GeyW2SFWfp3nr88fbNjKD1RrR1xf/WD2TNi+AsfzupPm+f/Vfqb3fE9AtBaVjsCkXix7IeaFn1tXERke8Phh4gWcbqKTJa8JoIek6hHrvzIKKzHqA+zvlnGUXJiJhTvTHn05zWn/mR6WkeJkK0fwKF2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462614; c=relaxed/simple;
	bh=1x9+KjRWbAqFCqZZ6HTLni4X6lBtFbxVyyq1GKTVl4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N54651HXqrMXZI8v+nzJn4ocTYaSvC/7IaU/wwWUG/jcmWIbq4+PlCVGh9kW3EyXH67zdqevtf4EOS3A4KFzB2371kQjb2ITnkcXl+0vYqHlyP8Vs3/T5P1J2D4gfgHZNJCCxUmWG/lhSzT9MKx0SiuQ1V26xSH4NnVdGZt3sMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2gnNqNp2; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2gnNqNp2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765462609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41LFOfK3hPP+00NTRK/2wBkoBApwET4lS3fy9jkAbAk=;
	b=2gnNqNp2KS5jlq0M9HoUghJENLxevZzyXtTvjVJrlf27rjFaTl6RjCJGaj6LVjRJXviw36
	6mZSJ5w5Vw8kRVfZmDuYGr7DA6ZOmpQFCJ0xpf1mL5UpLQ81a29rKm89y12aMzGTEF5d4L
	ltRTnQ+Nx0H2EvXoSSgzNQHaI6e935Q=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] builtin/gc: fix condition for whether to write
 commit graphs
In-Reply-To: <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im>
References: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
 <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im>
Date: Thu, 11 Dec 2025 15:16:36 +0100
Message-ID: <87ecp1gl2z.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The root cause of this memory leak is our use of `commit_list_append()`.
> This function expects as parameters the item to append and the _tail_ of
> the list to append. This tail will then be overwritten with the new tail
> of the list so that it can be used in subsequent calls. But we call it
> with `commit_list_append(parent->item, &stack)`, so we end up losing
> everything but the new item.
>
> This issue only surfaces when counting merge commits. Next to being a
> memory leak, it also shows that we're in fact miscounting as we only
> respect children of the last parent. All previous parents are discarded,
> so their children will be disregarded unless they are hit via another
> reference.
>
> While crafting a test case for the issue I was puzzled that I couldn't
> establish the proper border at which the auto-condition would be
> fulfilled. As it turns out, there's another bug: if an object is at the
> tip of any reference we don't mark it as seen. Consequently, if it is
> reachable via any other reference, we'd count that object twice.
>
> Fix both of these bugs so that we properly count objects without leaking
> any memory.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c           |  8 +++++---
>  t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..17ff68cbd9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1130,8 +1130,10 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  		return 0;
>  
>  	commit = lookup_commit(the_repository, maybe_peeled);
> -	if (!commit)
> +	if (!commit || commit->object.flags & SEEN)
>  		return 0;
> +	commit->object.flags |= SEEN;
> +
>  	if (repo_parse_commit(the_repository, commit) ||
>  	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
>  		return 0;
> @@ -1141,7 +1143,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  	if (data->num_not_in_graph >= data->limit)
>  		return 1;
>  
> -	commit_list_append(commit, &stack);
> +	commit_list_insert(commit, &stack);

commit_list_insert() prepends the commit to the beginning of the list,
while commit_list_append() appends it at the end. Because the list is
only used for counting, we don't care about the order. So this fix looks
good to me.

I also approve the other changes in this series.

-- 
Cheers,
Toon
