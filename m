Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDEDF9E4
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PsQXd0Ab"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D60CC1E7CB;
	Thu, 28 Dec 2023 13:11:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OXfamkhqfbOBQ6MRO0BvpDxush7VOgaVs7bOlI
	daLJ4=; b=PsQXd0AbS/GOh/D9wYLgQTZqrZHaSqdyIN53RLAyzA/ZBATG1KRtMC
	PNO7915HwjfIh0uUdb7wUkoCcqkVKT7bKMjN0Ph9uau0F+nrCUDAJeYM5Ec3x4LO
	oj3TEQivGovjqXyugYX7n+jJ0NUNYznYpSxMKPEdRpI/dDgj142sk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CEDC61E7CA;
	Thu, 28 Dec 2023 13:11:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EC5A1E7C9;
	Thu, 28 Dec 2023 13:11:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] worktree: initialize refdb via ref backends
In-Reply-To: <cover.1703754513.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 28 Dec 2023 10:59:47 +0100")
References: <cover.1703754513.git.ps@pks.im>
Date: Thu, 28 Dec 2023 10:11:31 -0800
Message-ID: <xmqqedf6gpt8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8855BB38-A5AC-11EE-9053-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> when initializing worktrees we manually create the on-disk data
> structures required for the ref backend in "worktree.c". This works just
> fine right now where we only have a single user-exposed ref backend, but
> it will become unwieldy once we have multiple ref backends. This patch
> series thus refactors how we initialize worktrees so that we can use
> `refs_init_db()` to initialize required files for us.
>
> This patch series conflicts with ps/refstorage-extension. The conflict
> can be solved as shown below. I'm happy to defer this patch series
> though until the topic has landed on `master` in case this causes
> issues.

Resolution is not all that bad, but the change in function signature
means comments/explanations near both the caller and the callee of
the get_linked_worktree() function may need updating, I would think.
For example, ...

> diff --git a/worktree.h b/worktree.h
> index 8a75691eac..f14784a2ff 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -61,7 +61,8 @@ struct worktree *find_worktree(struct worktree **list,
>   * Look up the worktree corresponding to `id`, or NULL of no such worktree
>   * exists.
>   */
> -struct worktree *get_linked_worktree(const char *id);
> +struct worktree *get_linked_worktree(const char *id,
> +				     int skip_reading_head);

... this now needs to help developers who may want to add new
callers what to pass in "skip_reading_head" and why.

We may indeed want to build this on top of the refstorage-extansion
thing, as it seems to be relatively close to completion.

Thanks (and a happy new year).
