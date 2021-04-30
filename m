Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11307C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 03:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03BF610EA
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 03:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhD3Df1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 23:35:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52166 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3Df0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 23:35:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCA84A8601;
        Thu, 29 Apr 2021 23:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u8yc6Z3tfFnBYrPd0KlP8wcb5rbZO0dG/Urrb0
        QkYes=; b=gDRpOwskbzO5SQt4BxnXSmvUpOsFTDHWNtO4MsGhy3eXG3K6Z9YNqP
        sI59ceJJvQxqipozglFx78mEH1TkvFCB5nlHC/0CZjRXGrNZgTsl8XdmV4SjTbKb
        yY4OhGd/Fm6wViVP65NEowEeyTrFKDAWoMQOWRG7ijytUP5c9sIwk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2E4EA8600;
        Thu, 29 Apr 2021 23:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B2DFA85FE;
        Thu, 29 Apr 2021 23:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/8] refs: make errno output explicit for read_raw_ref_fn
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
Date:   Fri, 30 Apr 2021 12:34:37 +0900
In-Reply-To: <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 29 Apr 2021
        15:32:03 +0000")
Message-ID: <xmqq35v8e982.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDBEEAB2-A964-11EB-843A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> read_raw_ref_fn needs to supply a credible errno for a number of cases. These
> are primarily:
>
> 1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
> resulting error codes to create/remove directories as needed.
>
> 2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
> returning the last successfully resolved symref. This is necessary so
> read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
> du-jour), and we know on which branch to create the first commit.
>
> Make this information flow explicit by adding a failure_errno to the signature
> of read_raw_ref. All errnos from the files backend are still propagated
> unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
> relevant.

I like the general direction to move away from errno, which may make
sense only in the context of files backend (e.g. ENOENT would be
left in errno, only because the original "loose ref" implementation
used one file per ref, when a ref we wanted to see did not exist)
and having other backends use the same errno would not make much
sense, as it is not the goal to make other backends like reftable
emulate files backend.

I wonder if in the ideal world, we'd rather want to define our own
enum, not <errno.h>, that is specific to failure modes of ref API
functions and signal failures by returning these values (and the
enum includes 0 as a value to signal success, all other errors are
negative values).

What I am really getting at is if we need an extra "failure"
out-parameter-pointer in the internal API.  I do not mind if it
helps the transition to the ideal world, but I offhand do not see if
we need result and failure as separate variables.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c                |  7 +++++--
>  refs/debug.c          |  4 ++--
>  refs/files-backend.c  | 24 ++++++++++++------------
>  refs/packed-backend.c |  8 ++++----
>  refs/refs-internal.h  | 16 +++++++++-------
>  5 files changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 261fd82beb98..43e2ad6b612a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1675,13 +1675,16 @@ int refs_read_raw_ref(struct ref_store *ref_store,
>  		      const char *refname, struct object_id *oid,
>  		      struct strbuf *referent, unsigned int *type)
>  {
> +	int result, failure;
>  	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
>  		return refs_read_special_head(ref_store, refname, oid, referent,
>  					      type);
>  	}
>  
> -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> -					   type);
> +	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> +					     type, &failure);
> +	errno = failure;
> +	return result;
>  }
>  
>  /* This function needs to return a meaningful errno on failure */
> diff --git a/refs/debug.c b/refs/debug.c
> index 922e64fa6ad9..887dbb14be6e 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -238,14 +238,14 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
>  
>  static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  			      struct object_id *oid, struct strbuf *referent,
> -			      unsigned int *type)
> +			      unsigned int *type, int *failure_errno)
>  {
>  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
>  	int res = 0;
>  
>  	oidcpy(oid, &null_oid);
>  	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
> -					    type);
> +					    type, failure_errno);
>  
>  	if (res == 0) {
>  		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c9511da1d387..efe493ca1425 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -341,9 +341,9 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
>  	return refs->loose;
>  }
>  
> -static int files_read_raw_ref(struct ref_store *ref_store,
> -			      const char *refname, struct object_id *oid,
> -			      struct strbuf *referent, unsigned int *type)
> +static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
> +			      struct object_id *oid, struct strbuf *referent,
> +			      unsigned int *type, int *failure_errno)
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
> @@ -354,7 +354,6 @@ static int files_read_raw_ref(struct ref_store *ref_store,
>  	struct stat st;
>  	int fd;
>  	int ret = -1;
> -	int save_errno;
>  	int remaining_retries = 3;
>  
>  	*type = 0;
> @@ -459,10 +458,10 @@ static int files_read_raw_ref(struct ref_store *ref_store,
>  	ret = parse_loose_ref_contents(buf, oid, referent, type);
>  
>  out:
> -	save_errno = errno;
> +	if (failure_errno)
> +		*failure_errno = errno;
>  	strbuf_release(&sb_path);
>  	strbuf_release(&sb_contents);
> -	errno = save_errno;
>  	return ret;
>  }
>  
> @@ -541,6 +540,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  	struct strbuf ref_file = STRBUF_INIT;
>  	int attempts_remaining = 3;
>  	int ret = TRANSACTION_GENERIC_ERROR;
> +	int failure_errno = 0;
>  
>  	assert(err);
>  	files_assert_main_repository(refs, "lock_raw_ref");
> @@ -629,9 +629,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  	 * fear that its value will change.
>  	 */
>  
> -	if (files_read_raw_ref(&refs->base, refname,
> -			       &lock->old_oid, referent, type)) {
> -		if (errno == ENOENT) {
> +	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
> +			       type, &failure_errno)) {
> +		if (failure_errno == ENOENT) {
>  			if (mustexist) {
>  				/* Garden variety missing reference. */
>  				strbuf_addf(err, "unable to resolve reference '%s'",
> @@ -655,7 +655,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  				 *   reference named "refs/foo/bar/baz".
>  				 */
>  			}
> -		} else if (errno == EISDIR) {
> +		} else if (failure_errno == EISDIR) {
>  			/*
>  			 * There is a directory in the way. It might have
>  			 * contained references that have been deleted. If
> @@ -693,13 +693,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  					goto error_return;
>  				}
>  			}
> -		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
> +		} else if (failure_errno == EINVAL && (*type & REF_ISBROKEN)) {
>  			strbuf_addf(err, "unable to resolve reference '%s': "
>  				    "reference broken", refname);
>  			goto error_return;
>  		} else {
>  			strbuf_addf(err, "unable to resolve reference '%s': %s",
> -				    refname, strerror(errno));
> +				    refname, strerror(failure_errno));
>  			goto error_return;
>  		}
>  
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index dfecdbc1db60..a457f18e93c8 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -724,9 +724,9 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
>  	return refs->snapshot;
>  }
>  
> -static int packed_read_raw_ref(struct ref_store *ref_store,
> -			       const char *refname, struct object_id *oid,
> -			       struct strbuf *referent, unsigned int *type)
> +static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
> +			       struct object_id *oid, struct strbuf *referent,
> +			       unsigned int *type, int *failure_errno)
>  {
>  	struct packed_ref_store *refs =
>  		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
> @@ -739,7 +739,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
>  
>  	if (!rec) {
>  		/* refname is not a packed reference. */
> -		errno = ENOENT;
> +		*failure_errno = ENOENT;
>  		return -1;
>  	}
>  
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 29728a339fed..ac8a14086724 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -617,10 +617,12 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
>   * properly-formatted or even safe reference name. NEITHER INPUT NOR
>   * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
>   *
> - * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
> - * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
> - * broken; set REF_ISBROKEN in type, and return -1. If there is another error
> - * reading the ref, set errno appropriately and return -1.
> + * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT
> + * and return -1. If the ref exists but is neither a symbolic ref nor an object
> + * ID, it is broken; set REF_ISBROKEN in type, and return -1. For the files
> + * backend, EISDIR and ENOTDIR may be set if the ref name is a directory. If
> + * there is another error reading the ref, set failure_errno appropriately and
> + * return -1.
>   *
>   * Backend-specific flags might be set in type as well, regardless of
>   * outcome.
> @@ -634,9 +636,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
>   * - in all other cases, referent will be untouched, and therefore
>   *   refname will still be valid and unchanged.
>   */
> -typedef int read_raw_ref_fn(struct ref_store *ref_store,
> -			    const char *refname, struct object_id *oid,
> -			    struct strbuf *referent, unsigned int *type);
> +typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
> +			    struct object_id *oid, struct strbuf *referent,
> +			    unsigned int *type, int *failure_errno);
>  
>  struct ref_storage_be {
>  	struct ref_storage_be *next;
