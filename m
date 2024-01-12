Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B70361
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IGGwoFyI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D9A5217A6;
	Thu, 11 Jan 2024 19:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GKWAH0n1be7TjlxSIJ5X8HeZSxtvBc/HUOX8hT
	b4Fs8=; b=IGGwoFyIlcHtxpO+ko/SODgCXUVv0FzbQmSJuAYk6x6EmwvoBTyBbZ
	unFM5YZZ+Rm9uRhtlKoL3vlIOzb6E/8kQ8yRxC+iADE4FkaX9tlDp69Zm4LFg4eL
	DpcdAKukDd6h9NLqnlXCtkOhH0qAp+M7VzUJ4vIlJck9njKHvq9LE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75B03217A5;
	Thu, 11 Jan 2024 19:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 627F9217A1;
	Thu, 11 Jan 2024 19:15:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com, Elijah Newren
 <newren@gmail.com>
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
In-Reply-To: <20240111233311.64734-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Fri, 12 Jan 2024 00:33:11 +0100")
References: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
Date: Thu, 11 Jan 2024 16:15:52 -0800
Message-ID: <xmqqy1cvcsp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0381CCE-B0DF-11EE-827E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

> This extends the functionality of `git log --merge` to also work with
> conflicts for rebase, cherry pick and revert.
>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>  ... It is basically the counterpart to
> `git show ${ACTION}_HEAD` for understanding the source of the conflict.

I do not know about the validity of that approach to use *_HEAD, but
we may want to tighten the original's use of repo_get_oid() here ...

> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> -		die("--merge without MERGE_HEAD?");
> -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");

... so that we won't be confused in a repository that has a tag
whose name happens to be MERGE_HEAD.  We probably should be using
refs.c:refs_resolve_ref_unsafe() instead to 

 (1) ensure MERGE_HEAD is a ref, 
 (2) obtain the oid without any prefixing by refs.c:repo_dwim_ref(),
     and optionally
 (3) error out when MERGE_HEAD is a symref.

As your patch makes the problem even worse, if we were to do such a
tightening (and I do not see a reason not to), it may want to be
done before, not after, this patch.

I won't comment on the coding style violations in the patch below in
this message.

Thanks.

> diff --git a/revision.c b/revision.c
> index 2424c9bd67..2e5c00dabd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1961,23 +1961,37 @@ static void add_pending_commit_list(struct rev_info *revs,
>  	}
>  }
>  
> +static char* get_action_head_name(struct object_id* oid)
> +{
> +	if (!repo_get_oid(the_repository, "MERGE_HEAD", oid)) {
> +		return "MERGE_HEAD";
> +	} else if (!repo_get_oid(the_repository, "REBASE_HEAD", oid)) {
> +		return "REBASE_HEAD";
> +	} else if (!repo_get_oid(the_repository, "CHERRY_PICK_HEAD", oid)) {
> +		return "CHERRY_PICK_HEAD";
> +	} else if (!repo_get_oid(the_repository, "REVERT_HEAD", oid)) {
> +		return "REVERT_HEAD";
> +	} else
> +		die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
> +}
> +
>  static void prepare_show_merge(struct rev_info *revs)
>  {
>  	struct commit_list *bases;
>  	struct commit *head, *other;
>  	struct object_id oid;
>  	const char **prune = NULL;
> +	const char *action_head_name;
>  	int i, prune_num = 1; /* counting terminating NULL */
>  	struct index_state *istate = revs->repo->index;
>  
>  	if (repo_get_oid(the_repository, "HEAD", &oid))
>  		die("--merge without HEAD?");
>  	head = lookup_commit_or_die(&oid, "HEAD");
> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> -		die("--merge without MERGE_HEAD?");
> -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
> +	action_head_name = get_action_head_name(&oid);
> +	other = lookup_commit_or_die(&oid, action_head_name);
>  	add_pending_object(revs, &head->object, "HEAD");
> -	add_pending_object(revs, &other->object, "MERGE_HEAD");
> +	add_pending_object(revs, &other->object, action_head_name);
>  	bases = repo_get_merge_bases(the_repository, head, other);
>  	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
>  	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
