Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9E1547E7
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875293; cv=none; b=cAhX5qWmy/6P/J0gGnZdgRXz3hXK2doRzKZUHoHR6W4I6HApd9843S08C7FKjt7uRmtv2noHfouAmYxf28g0kSaSPXeEtrJvFnSAmkRw1afjnxGDbvAr4NNN5L9aBo00D5SsF4KrVNc7HY+w6CsVDdeauQkWPAA0wIo55GbQ4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875293; c=relaxed/simple;
	bh=PDkQ2GApMiJ02TaY2b7kF0LfTAYUiz7Jg3rjIsNEZP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ou091o5SuFVwju9tfvHIRGgt486MV2iq5b8Izvo8oNchRsWG+6VAPoGIXQEq1nubrY4E5WgMwIo5+SHLXsBQUmylWFWHjZ0TMhImGjT1dNVVtqgmJHNkd81hRqtf1i8mgO8xhazkJzg9zbsP/lb6VgHxdENnW2Z3IOWoJgUY9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AR5eX6tq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AR5eX6tq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE9132EA4B;
	Mon,  5 Aug 2024 12:28:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PDkQ2GApMiJ02TaY2b7kF0LfTAYUiz7Jg3rjIs
	NEZP4=; b=AR5eX6tqk+W/sWbUWy46AncfsqNAfaLTH8Ht4n77lJ/Xy/1+Dgzz2S
	DQ83BpmndZLSedKkz/OaUrvJAUT/p2IJHOBXUdfPexKdVGtQi9uqSxqeWFIxt7UY
	3kTaXAJCBmCrynpnmQqKlVDUEtakjp9kq8fktggurwL8hQhNeD4kw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 98A662EA4A;
	Mon,  5 Aug 2024 12:28:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 719AD2EA49;
	Mon,  5 Aug 2024 12:28:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Sven Strickroth via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Sven Strickroth
 <email@cs-ware.de>
Subject: Re: [PATCH] repository: prevent memory leak when releasing ref stores
In-Reply-To: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com> (Sven
	Strickroth via GitGitGadget's message of "Mon, 05 Aug 2024 10:56:04
	+0000")
References: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 09:28:04 -0700
Message-ID: <xmqq34nj3pez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B1EF6A2C-5347-11EF-A254-BF444491E1BC-77302942!pb-smtp20.pobox.com

"Sven Strickroth via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sven Strickroth <email@cs-ware.de>
>
> `ref_store_release` does not free the ref_store allocated in
> `ref_store_init`.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

This may certainly plug the two leaking callers, but stepping back a
bit and looking at other existing calls to ref_store_release(), I
wonder if many existing and more importantly future callers benefit
if ref_store_release() did the freeing of the surrounding shell, as
we can see in these existing calls:

refs.c:2851:	ref_store_release(new_refs);
refs.c-2852-	FREE_AND_NULL(new_refs);

refs.c:2890:	ref_store_release(old_refs);
refs.c-2891-	FREE_AND_NULL(old_refs);

refs.c:2904:		ref_store_release(new_refs);
refs.c-2905-		free(new_refs);

If we change the type of ref_store_release() to take a pointer to a
pointer to ref_store, so that the above callers can just become

	ref_store_release(&new_refs);

to release the resources and new_refs variable cleared, the
callsites in this patch can do the same.

However, I am fuzzy on the existing uses in the backend
implementation.  For example:

        static void files_ref_store_release(struct ref_store *ref_store)
        {
                struct files_ref_store *refs = files_downcast(ref_store, 0, "release");
                free_ref_cache(refs->loose);
                free(refs->gitcommondir);
                ref_store_release(refs->packed_ref_store);
        }

The packed-ref-store is "released" here, as part of "releasing" the
files-ref-store that uses it as a fallback backend.  The caller of
files_ref_store_release() is refs.c:ref_store_release()

        void ref_store_release(struct ref_store *ref_store)
        {
                ref_store->be->release(ref_store);
                free(ref_store->gitdir);
        }

So if you have a files based ref store, when you are done you'd be
calling ref_store_release() on it, releasing the resources held by
the files_ref_store structure, but I do not know who frees the
packed_ref_store allocated by files_ref_store_init().  Perhaps it is
already leaking?  If that is the case then an API update like I
suggested above would make even more sense to make it less likely
for such a leak to be added to the system in the future, I suspect.

I dunno.

Thanks.

>     repository: prevent memory leak when releasing ref stores
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1758%2Fcsware%2Frepository-memory-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1758/csware/repository-memory-leak-v1
> Pull-Request: https://github.com/git/git/pull/1758
>
>  repository.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/repository.c b/repository.c
> index 9825a308993..46f1eadfe95 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -366,12 +366,16 @@ void repo_clear(struct repository *repo)
>  		FREE_AND_NULL(repo->remote_state);
>  	}
>  
> -	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
> +	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e) {
>  		ref_store_release(e->value);
> +		free(e->value);
> +	}
>  	strmap_clear(&repo->submodule_ref_stores, 1);
>  
> -	strmap_for_each_entry(&repo->worktree_ref_stores, &iter, e)
> +	strmap_for_each_entry(&repo->worktree_ref_stores, &iter, e) {
>  		ref_store_release(e->value);
> +		free(e->value);
> +	}
>  	strmap_clear(&repo->worktree_ref_stores, 1);
>  
>  	repo_clear_path_cache(&repo->cached_paths);
>
> base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
