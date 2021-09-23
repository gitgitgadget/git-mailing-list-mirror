Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3BC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49A46109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhIWBC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:02:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63091 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhIWBCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 21:02:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1B64D0413;
        Wed, 22 Sep 2021 21:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FlgHNzADTbRM20PA7aYirfHhihwJGh/Zi5kzMx
        jUpJ4=; b=FUP/XxbXbV1uCYIN0O8UTrln+ocYvtUbHXeQ9I4nHFZJFph+BUp+aw
        3BztSB2L3AvduFGo0jIzUBfgusZNMCbOuZHKdQ4noeJ3aECiqD0H5Su0TFuSfd3Q
        4qHDYOTUqDaTSbIpISt496SUcqJ380QUM/hQpcysESR6NreO7zGzg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A83E5D0412;
        Wed, 22 Sep 2021 21:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E84ED0411;
        Wed, 22 Sep 2021 21:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/9] refs: make _advance() check struct repo, not flag
References: <cover.1632242495.git.jonathantanmy@google.com>
        <493fff7f4716d889da751b5f8c6740cc1e3aa360.1632242495.git.jonathantanmy@google.com>
Date:   Wed, 22 Sep 2021 18:00:52 -0700
In-Reply-To: <493fff7f4716d889da751b5f8c6740cc1e3aa360.1632242495.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 21 Sep 2021 09:51:03 -0700")
Message-ID: <xmqq1r5g3y2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F96D18-1C09-11EC-99FF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> As a first step in resolving both these problems, replace the
> DO_FOR_EACH_INCLUDE_BROKEN flag with a struct repository pointer. This
> commit is a mechanical conversion - whenever DO_FOR_EACH_INCLUDE_BROKEN
> is set, a NULL repository (representing access to no object store) is
> used instead, and whenever DO_FOR_EACH_INCLUDE_BROKEN is unset, a
> non-NULL repository (representing access to that repository's object
> store) is used instead.

Hmph, so the lack of "include broken" is a signal to validate the
object the ref points at, and the new parameter is "if this pointer
is not NULL, then expect to find the object in this repository and
validate it" that replaces the original "validate it" with a bit
more detailed instruction (i.e. "how to validate--use the object
store associated to this repository")?

> Right now, the locations in which
> non-the_repository support needs to be added are marked with BUG()
> statements - in a future patch, these will be replaced. (NEEDSWORK: in
> this RFC patch set, this has not been done)

> - Change the _advance() callback to also have a repository object
>   parameter, and either skip or not skip depending on whether that
>   parameter is NULL. This burdens callers to have to carry this
>   information along with the iterator, and such calling code may be
>   unclear as to why that parameter can be NULL in some cases and cannot
>   in others.

Hmph.  

> diff --git a/refs.c b/refs.c
> index 8b9f7c3a80..49ddcdac53 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1413,16 +1413,16 @@ int head_ref(each_ref_fn fn, void *cb_data)
>  
>  struct ref_iterator *refs_ref_iterator_begin(
>  		struct ref_store *refs,
> -		const char *prefix, int trim, int flags)
> +		const char *prefix, int trim, struct repository *repo,
> +		int flags)
>  {
>  	struct ref_iterator *iter;
>  
>  	if (ref_paranoia < 0)
>  		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
> -	if (ref_paranoia)
> -		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
>  
>  	iter = refs->be->iterator_begin(refs, prefix, flags);
> +	iter->repo = ref_paranoia ? NULL : repo;

OK.  "flags" is still kept because there are bits other than
"include broken" that need to be propagated.

> @@ -1442,13 +1442,16 @@ struct ref_iterator *refs_ref_iterator_begin(
>   * Call fn for each reference in the specified submodule for which the
>   * refname begins with prefix. If trim is non-zero, then trim that
>   * many characters off the beginning of each refname before passing
> - * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
> - * include broken references in the iteration. If fn ever returns a
> + * the refname to fn. If fn ever returns a
>   * non-zero value, stop the iteration and return that value;
>   * otherwise, return 0.
> + *
> + * See the documentation of refs_ref_iterator_begin() for more information on
> + * the repo parameter.
>   */
>  static int do_for_each_repo_ref(struct repository *r, const char *prefix,
> -				each_repo_ref_fn fn, int trim, int flags,
> +				each_repo_ref_fn fn, int trim,
> +				struct repository *repo, int flags,
>  				void *cb_data)

Confusing.  We are iterating refs that exists in the repository "r",
right?  Why do we need to have an extra "repo" parameter?  Can they
ever diverge (beyond repo could be NULL to signal now-lost "include
broken" bit wanted to convey)?  It's not like a valid caller can
pass the superproject in 'r' and a submodule in 'repo', right?

Enhancing an interface this way, and allowing an arbitrary
repository instance to be passed only to convey one bit of
information, by adding a "repo" smells like inviting bugs in the
future.

I have a feeling that the function signature for this one should
stay as before, and "repo" should be a local variable that is
initialized as

	struct repository *repo = (flags & DO_FOR_EACH_INCLUDE_BROKEN)
				? r
				: NULL;

to avoid such a future bug, but given that there is only one caller
to this helper, I do not mind

	if (repo && r != repo)
		BUG(...);

to catch any such mistake.

>  int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
>  				    strlen(git_replace_ref_base),
> -				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +				    NULL, 0, cb_data);
>  }

And this is the only such caller, if I am reading the code right.

Do we ever pass non-NULL "repo" to do_for_each_repo_ref() in future
steps?

If not, perhaps we do not even have to add "repo" as a new parameter
to do_for_each_repo_ref(), and instead always pass NULL down to
refs_ref_iterator_begin() from do_for_each_repo_ref()?

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 677b7e4cdd..cd145301d0 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -744,12 +744,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
>  			continue;
>  
> -		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
> -		    !ref_resolves_to_object(iter->iter0->refname,
> -					    iter->iter0->oid,
> -					    iter->iter0->flags))
> -			continue;
> -
>  		iter->base.refname = iter->iter0->refname;
>  		iter->base.oid = iter->iter0->oid;
>  		iter->base.flags = iter->iter0->flags;
> @@ -801,9 +795,6 @@ static struct ref_iterator *files_ref_iterator_begin(
>  	struct ref_iterator *ref_iterator;
>  	unsigned int required_flags = REF_STORE_READ;
>  
> -	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
> -		required_flags |= REF_STORE_ODB;
> -
>  	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
>  
>  	/*

Hmph, I am not sure where the lossage in these two hunks are
compensated.  Perhaps in the backend independent layer in
refs/iterator.c?  Let's read on.

> @@ -836,10 +827,13 @@ static struct ref_iterator *files_ref_iterator_begin(
>  	 * references, and (if needed) do our own check for broken
>  	 * ones in files_ref_iterator_advance(), after we have merged
>  	 * the packed and loose references.
> +	 *
> +	 * Do this by not supplying any repo, regardless of whether a repo was
> +	 * supplied to files_ref_iterator_begin().
>  	 */
>  	packed_iter = refs_ref_iterator_begin(
>  			refs->packed_ref_store, prefix, 0,
> -			DO_FOR_EACH_INCLUDE_BROKEN);
> +			NULL, 0);

OK.

> diff --git a/refs/iterator.c b/refs/iterator.c
> index a89d132d4f..5af6554887 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -10,7 +10,23 @@
>  
>  int ref_iterator_advance(struct ref_iterator *ref_iterator)
>  {
> -	return ref_iterator->vtable->advance(ref_iterator);
> +	int ok;
> +
> +	if (ref_iterator->repo && ref_iterator->repo != the_repository)

OK. refs_ref_interator_begin() assigned the "repo" parameter that
tells which repository to consult to validate the objects at the tip
of refs to the .repo member of the iterator object, and we check it
here.

It is a bit surprising that ref_iterator does not know which
repository it is working in (regardless of "include broken" bit).
Do you think it will stay that way?  I have this nagging feeling
that it won't, and having "struct repository *repository" pointer
that always points at the repository the ref-store belongs to in a
ref_iterator instance would become necessary in the longer run.

In which case, this .repo member this patch adds would become a big
problem, no?  If we were to validate objects at the tip of the refs
against object store, we will always use the object store that
belongs to the iterator->repository, so the only valid states for
iterator->repo are either NULL or iterator->repository.  That again
is the same problem I pointed out already about the parameter the
do_for_each_repo_ref() helper that is inviting future bugs, it seems
to me.  Wouldn't it make more sense to add

 * iterator->repository that points at the repository in which we
   are iterating the refs

 * a bit in iterator that chooses between "do not bother checking"
   and "do check the tip of refs against the object store of
   iterator->repository

to avoid such a mess?  Perhaps we already have such a bit in the
flags word in the ref_iterator but I didn't check.

Thanks.
