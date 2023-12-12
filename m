Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nxsmttJz"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E507B7
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 12:24:30 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A90AD2C170;
	Tue, 12 Dec 2023 15:24:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xdLksKGTBD57ghDYU7quWyIDjfdP0d4nQ09C64
	aQKBw=; b=nxsmttJzRkpvRLDwqfrddnUgu35NkfG+AaeEobSEOiF7muwZnLpx5p
	IxlsT7W7bnoExYYF6aGW4uFJTFvyymLG8okkVAjcookT72Q84xBDOn9DnTdR8s7U
	RMfB0bOa0KjH3Im3jO0Xw1NYOzwKuMDwCr7Hlk9WbqPQJ/U0g79Ak=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A18872C16F;
	Tue, 12 Dec 2023 15:24:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C9B22C16D;
	Tue, 12 Dec 2023 15:24:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
In-Reply-To: <1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 12 Dec 2023 08:18:48 +0100")
References: <cover.1701243201.git.ps@pks.im> <cover.1702365291.git.ps@pks.im>
	<1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
Date: Tue, 12 Dec 2023 12:24:24 -0800
Message-ID: <xmqqle9zqidj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71E17644-992C-11EE-9346-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The current code only works by chance because we only have a single
> reference backend implementation. Refactor it to instead read both refs
> via the refdb layer so that we'll also be compatible with alternate
> reference backends.

"via the refdb" -> "via the refs API" or something here and on the
title, and possibly elsewhere in the proposed log messages and
in-code comments in patches in this series, as I've never seen a
word "refdb" used in the context of this project.

I agree it is bad manners to be intimate with the implementation
details of the how files-backend stores HEAD and ORIG_HEAD.

> Note that we pass `RESOLVE_REF_NO_RECURSE` to `read_ref_full()`. This is
> because we didn't resolve symrefs before either, and in practice none of
> the refs in "rebase-merge/" would be symbolic. We thus don't want to
> resolve symrefs with the new code either to retain the old behaviour.

Good to see a rewrite being careful like this.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  wt-status.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 9f45bf6949..fe9e590b80 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1295,26 +1295,27 @@ static char *read_line_from_git_path(const char *filename)
>  static int split_commit_in_progress(struct wt_status *s)
>  {
>  	int split_in_progress = 0;
> -	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
> +	struct object_id head_oid, orig_head_oid;
> +	char *rebase_amend, *rebase_orig_head;
>  
>  	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
>  	    !s->branch || strcmp(s->branch, "HEAD"))
>  		return 0;
>  
> -	head = read_line_from_git_path("HEAD");
> -	orig_head = read_line_from_git_path("ORIG_HEAD");
> +	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
> +	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oid, NULL))
> +		return 0;
> +

This made me wonder if we have changed behaviour when on an unborn
branch.  In such a case, the original most likely would have read
"ref: blah" in "head" and compared it with "rebase_amend", which
would be a good way to ensure they would not match.  I would not
know offhand what the updated code would do, but head_oid would be
uninitialized in such a case, so ...?

>  	rebase_amend = read_line_from_git_path("rebase-merge/amend");
>  	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
>  
> -	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
> +	if (!rebase_amend || !rebase_orig_head)
>  		; /* fall through, no split in progress */
>  	else if (!strcmp(rebase_amend, rebase_orig_head))
> -		split_in_progress = !!strcmp(head, rebase_amend);
> -	else if (strcmp(orig_head, rebase_orig_head))
> +		split_in_progress = !!strcmp(oid_to_hex(&head_oid), rebase_amend);
> +	else if (strcmp(oid_to_hex(&orig_head_oid), rebase_orig_head))
>  		split_in_progress = 1;
>  
> -	free(head);
> -	free(orig_head);
>  	free(rebase_amend);
>  	free(rebase_orig_head);
