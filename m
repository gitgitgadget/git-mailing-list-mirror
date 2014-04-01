From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/27] refs: Add a concept of a reference transaction
Date: Tue, 01 Apr 2014 12:39:14 -0700
Message-ID: <xmqqtxaczvod.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:39:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4Wt-0000IX-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaDATjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:39:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaDATjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:39:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50AEA79716;
	Tue,  1 Apr 2014 15:39:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hS1MRc9Zrd3pcgw6qac57FBcNaQ=; b=cQFuS5
	LtY0IubbAHjjhdUoYBxwCtCQeMQ47gAc40SVzi0Rs1Y1EJwclC0JTbHbYR4uXSsx
	xIT1WoH9q2rDp+/SSYjqCvT6OXH6V7eNDkez3cyDqCes8qslfZLWOQ1zOSNt453x
	KSt6qQRkkBpP2xsVQzioepI1RpQVCpaKRbJLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTeZxA3tpfUY9V3SfYGGyWABccXWQUS1
	ZrsHYtMq/bisK/d0Ojl9NQfInegMyMRN9akFQd4jwsGD4kvVCZ6visQLLFjKdwDY
	idGhbdWAqkxf70DWVFpTqaHNkfALG0bLaZQVHSaPDBj2H8gfFO8KrEZG+yslRYk8
	FWqzVlPebA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40D1879715;
	Tue,  1 Apr 2014 15:39:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D86779713;
	Tue,  1 Apr 2014 15:39:16 -0400 (EDT)
In-Reply-To: <1395683820-17304-20-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F8FCAAA-B9D5-11E3-8183-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245638>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Build out the API for dealing with a bunch of reference checks and
> changes within a transaction.  Define an opaque ref_transaction type
> that is managed entirely within refs.c.  Introduce functions for
> beginning a transaction, adding updates to a transaction, and
> committing/rolling back a transaction.
>
> This API will soon replace update_refs().
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 1305eb1..e788c27 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3267,6 +3267,93 @@ static int update_ref_write(const char *action, const char *refname,
>  	return 0;
>  }
>  
> +/*
> + * Data structure for holding a reference transaction, which can
> + * consist of checks and updates to multiple references, carried out
> + * as atomically as possible.  This structure is opaque to callers.
> + */
> +struct ref_transaction {
> +	struct ref_update **updates;

Don't we try to name an array update[] (not plural updates[]) so
that we can say update[7] to mean the seventh update?

> +	size_t alloc;
> +	size_t nr;
> +};
> +
> +struct ref_transaction *ref_transaction_begin(void)
> +{
> +	return xcalloc(1, sizeof(struct ref_transaction));
> +}
> +
> +static void ref_transaction_free(struct ref_transaction *transaction)
> +{
> +	int i;
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +
> +		free((char *)update->ref_name);
> +		free(update);
> +	}
> +
> +	free(transaction->updates);
> +	free(transaction);
> +}

OK.

> +void ref_transaction_rollback(struct ref_transaction *transaction)
> +{
> +	ref_transaction_free(transaction);
> +}

OK.

> +static struct ref_update *add_update(struct ref_transaction *transaction,
> +				     const char *refname)
> +{
> +	struct ref_update *update = xcalloc(1, sizeof(*update));
> +
> +	update->ref_name = xstrdup(refname);
> +	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
> +	transaction->updates[transaction->nr++] = update;
> +	return update;
> +}
> +
> +void ref_transaction_update(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1, unsigned char *old_sha1,
> +			    int flags, int have_old)
> +{
> +	struct ref_update *update = add_update(transaction, refname);
> +
> +	hashcpy(update->new_sha1, new_sha1);
> +	update->flags = flags;
> +	update->have_old = have_old;
> +	if (have_old)
> +		hashcpy(update->old_sha1, old_sha1);
> +}
> +
> +void ref_transaction_create(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1,
> +			    int flags)
> +{
> +	struct ref_update *update = add_update(transaction, refname);
> +
> +	hashcpy(update->new_sha1, new_sha1);
> +	hashclr(update->old_sha1);
> +	update->flags = flags;
> +	update->have_old = 1;
> +}
> +
> +void ref_transaction_delete(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *old_sha1,
> +			    int flags, int have_old)
> +{
> +	struct ref_update *update = add_update(transaction, refname);
> +
> +	update->flags = flags;
> +	update->have_old = have_old;
> +	if (have_old)
> +		hashcpy(update->old_sha1, old_sha1);
> +}
> +

I can see that the chosen set of primitives update/create/delete
mirrors what update-ref allows us to do, but given the explanation
of "update" in refs.h, wouldn't it make more sense to implement the
others in terms of it?

>  int update_ref(const char *action, const char *refname,
>  	       const unsigned char *sha1, const unsigned char *oldval,
>  	       int flags, enum action_on_err onerr)
> @@ -3378,6 +3465,15 @@ cleanup:
>  	return ret;
>  }
>  
> +int ref_transaction_commit(struct ref_transaction *transaction,
> +			   const char *msg, enum action_on_err onerr)
> +{
> +	int ret = update_refs(msg, transaction->updates, transaction->nr,
> +			      onerr);
> +	ref_transaction_free(transaction);
> +	return ret;
> +}

OK.

>  char *shorten_unambiguous_ref(const char *refname, int strict)
>  {
>  	int i;
> diff --git a/refs.h b/refs.h
> index 08e60ac..476a923 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -24,6 +24,8 @@ struct ref_update {
>  	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>  };
>  
> +struct ref_transaction;
> +
>  /*
>   * Bit values set in the flags argument passed to each_ref_fn():
>   */
> @@ -220,6 +222,69 @@ enum action_on_err {
>  	UPDATE_REFS_QUIET_ON_ERR
>  };
>  
> +/*
> + * Begin a reference transaction.  The reference transaction must
> + * eventually be commited using ref_transaction_commit() or rolled
> + * back using ref_transaction_rollback().
> + */
> +struct ref_transaction *ref_transaction_begin(void);
> +
> +/*
> + * Roll back a ref_transaction and free all associated data.
> + */
> +void ref_transaction_rollback(struct ref_transaction *transaction);
> +
> +
> +/*
> + * The following functions add a reference check or update to a
> + * ref_transaction.  In all of them, refname is the name of the
> + * reference to be affected.  The functions make internal copies of
> + * refname, so the caller retains ownership of the parameter.  flags

Good to see the ownership rules described.

> + * can be REF_NODEREF; it is passed to update_ref_lock().
> + */
> +
> +
> +/*
> + * Add a reference update to transaction.  new_sha1 is the value that
> + * the reference should have after the update, or zeros if it should
> + * be deleted.  If have_old is true, then old_sha1 holds the value
> + * that the reference should have had before the update, or zeros if
> + * it must not have existed beforehand.
> + */
> +void ref_transaction_update(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1, unsigned char *old_sha1,
> +			    int flags, int have_old);
> +
> +/*
> + * Add a reference creation to transaction.  new_sha1 is the value
> + * that the reference should have after the update, or zeros if it
> + * should be deleted.  It is verified that the reference does not
> + * exist already.
> + */

Sounds a bit crazy that you can ask "create", which verifies the
absense of the thing, to delete a thing.

> +void ref_transaction_create(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *new_sha1,
> +			    int flags);
> +
> +/*
> + * Add a reference deletion to transaction.  If have_old is true, then
> + * old_sha1 holds the value that the reference should have had before
> + * the update.
> + */
> +void ref_transaction_delete(struct ref_transaction *transaction,
> +			    const char *refname,
> +			    unsigned char *old_sha1,
> +			    int flags, int have_old);
> +
> +/*
> + * Commit all of the changes that have been queued in transaction, as
> + * atomically as possible.  Return a nonzero value if there is a
> + * problem.  The ref_transaction is freed by this function.
> + */
> +int ref_transaction_commit(struct ref_transaction *transaction,
> +			   const char *msg, enum action_on_err onerr);
> +
>  /** Lock a ref and then write its file */
>  int update_ref(const char *action, const char *refname,
>  		const unsigned char *sha1, const unsigned char *oldval,
