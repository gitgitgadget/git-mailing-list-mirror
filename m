Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956615AFD
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yn9HGJFZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6340527E75;
	Fri, 12 Jan 2024 15:11:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8+e+aI8XJVB8lWZmFbKfK21SYVIsA/F66PmBqu
	xX/kk=; b=Yn9HGJFZwdGeYQ45NhNbOCX5LdLvc991MrxekBY1on5uz6r3WS7Gl2
	42/vUeZzBcTCwyPkSA0hEE7knw9Jr4LZvwqWUSVvprB1ejYyYDEdyLlLpy8MvYww
	EOzIS1eCSPjbHz45AzPZrnIY+jKErTZrrcxdyRUB+JPbkLpirmwqY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AD2927E74;
	Fri, 12 Jan 2024 15:11:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 807F527E73;
	Fri, 12 Jan 2024 15:10:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
In-Reply-To: <20240112155033.77204-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Fri, 12 Jan 2024 16:50:32 +0100")
References: <xmqqy1cvcsp3.fsf@gitster.g>
	<20240112155033.77204-1-mi.al.lohmann@gmail.com>
Date: Fri, 12 Jan 2024 12:10:54 -0800
Message-ID: <xmqqzfxa9usx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2043898-B186-11EE-8650-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

>> but we may want to tighten the original's use of repo_get
>> > -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
>> > -		die("--merge without MERGE_HEAD?");
>> > -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
>> 
>> ... so that we won't be confused in a repository that has a tag
>> whose name happens to be MERGE_HEAD.  We probably should be using
>> refs.c:refs_resolve_ref_unsafe() instead to _oid() here ...
>
> Here I am really at the limit of my understanding of the core functions.
> Is this roughly what you had in mind? From my testing it seems to do the
> job, but I don't understand the details "refs_resolve_ref_unsafe"...

Perhaps there are others who are more familiar with the ref API than
I am, but I was just looking at refs.h today and wonder if something
along the lines of this ...

    if (read_ref_full("MERGE_HEAD",
    		      RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
		      &oid, NULL))
	die("no MERGE_HEAD");
    if (is_null_oid(&oid))
	die("MERGE_HEAD is a symbolic ref???");

... would be simpler.

With the above, we are discarding the refname read_ref_full()
obtains from its refs_resolve_ref_unsafe(), but I think that is
totally fine.  We expect it to be "MERGE_HEAD" in the good case.
The returned value can be different from "MERGE_HEAD" if it is
a symbolic ref, but if the comment in refs.h on NO_RECURSE is to be
trusted, we should catch that case with the NULL-ness check on oid.

Which would mean that we do not need a separate "other_head"
variable, and instead can use "MERGE_HEAD".


>  revision.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 2424c9bd67..786e1a3e89 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1967,17 +1967,23 @@ static void prepare_show_merge(struct rev_info *revs)
>  	struct commit *head, *other;
>  	struct object_id oid;
>  	const char **prune = NULL;
> +	const char *other_head;
>  	int i, prune_num = 1; /* counting terminating NULL */
>  	struct index_state *istate = revs->repo->index;
>  
>  	if (repo_get_oid(the_repository, "HEAD", &oid))
>  		die("--merge without HEAD?");
>  	head = lookup_commit_or_die(&oid, "HEAD");
> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> +	other_head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +					     "MERGE_HEAD",
> +					     RESOLVE_REF_READING,
> +					     &oid,
> +					     NULL);
> +	if (!other_head)
>  		die("--merge without MERGE_HEAD?");
> -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
> +	other = lookup_commit_or_die(&oid, other_head);
>  	add_pending_object(revs, &head->object, "HEAD");
> -	add_pending_object(revs, &other->object, "MERGE_HEAD");
> +	add_pending_object(revs, &other->object, other_head);
>  	bases = repo_get_merge_bases(the_repository, head, other);
>  	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
>  	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
