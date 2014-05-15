From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 15 May 2014 11:51:45 -0700
Message-ID: <xmqqvbt6euym.fsf@gitster.dls.corp.google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<20140515180618.GA26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:52:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0lP-0002n7-9r
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbaEOSwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:52:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64278 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbaEOSwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:52:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E3151772B;
	Thu, 15 May 2014 14:52:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jZ/cfHvJWTXGjwHbuI5tIXKPhE8=; b=sizx8i
	T4kUal8mo06WBAN/gFf4YmupLzXKtBC/uMqygqDpPt6e/n6OmHppLKudXOAqCXO1
	l0zPYpaVCr+fwGE2FyJGOqzjosnXm199oE8WZz45CFopC+VhptTV67L/zpRnidVw
	9zhoRzaXTIwfAnIkPsftBCn4OIEK+umW4hjFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TCyuMpcgqYqxc+Sv/H4DJ//ZWSyl3J14
	KpnrHNPOXe76Et7eqyTcCmcXsFR6yNuxe3E3T7xcbMPI7qiwjzbtlFHEW2G/Ifoe
	ZxnkLg584e/NcpcIaqUIo9mi53KVS8dgMyIGzh6KQPbFKk0RKL+Opo5DGQ324tqC
	PYLat1tmH1I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 249F617729;
	Thu, 15 May 2014 14:52:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1B83176A7;
	Thu, 15 May 2014 14:51:46 -0400 (EDT)
In-Reply-To: <20140515180618.GA26471@google.com> (Jonathan Nieder's message of
	"Thu, 15 May 2014 11:06:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7222C6E-DC61-11E3-B532-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249181>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ronnie Sahlberg wrote:
>
>> This patch series is based on next and expands on the transaction API.
>
> Thanks.  Will pick up in v8 where I left off with v6.
>
> Applies with just one minor conflict on top of a merge of
> mh/ref-transaction, rs/ref-update-check-errors-early, and
> rs/reflog-exists.  Here's an interdiff against version 6 for those
> following along.

The interdiffs look mostly sensible.  Thanks.

>> Version 8:
>>  - Updates after review by JN
>>  - Improve commit messages
>>  - Add a patch that adds an err argument to repack_without_refs
>>  - Add a patch that adds an err argument to delete_loose_ref
>>  - Better document that a _update/_delete/_create failure means the whole
>>    transaction has failed and needs rollback.
>>
>> Version 7:
>>  - Updated commit messages per JNs review comments.
>>  - Changed REF_ISPRUNING and REF_ISPACKONLY to be private flags and not
>>    exposed through refs.h
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0f4e1fc..07ccc97 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1684,7 +1684,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  				   0, !!current_head, sb.buf) ||
>  	    ref_transaction_commit(transaction, &err)) {
>  		rollback_index_files();
> -		die(_("HEAD: cannot update ref: %s"), err.buf);
> +		die("%s", err.buf);
>  	}
>  	ref_transaction_free(transaction);
>  
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 47c360c..952b589 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -163,7 +163,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	    ref_transaction_update(transaction, ref, repl, prev,
>  				   0, !is_null_sha1(prev), NULL) ||
>  	    ref_transaction_commit(transaction, &err))
> -		die(_("%s: failed to replace ref: %s"), ref, err.buf);
> +		die("%s: failed to replace ref: %s", ref, err.buf);
>  
>  	ref_transaction_free(transaction);
>  	return 0;
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index c5aff92..bd7e96f 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -228,7 +228,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>  
>  	if (ref_transaction_create(transaction, refname, new_sha1,
>  				   update_flags, msg))
> -		die("failed transaction create for %s", refname);
> +		die("cannot create ref '%s'", refname);
>  
>  	update_flags = 0;
>  	free(refname);
> diff --git a/refs.c b/refs.c
> index 302a2b3..ed93b75 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -29,6 +29,15 @@ static inline int bad_ref_char(int ch)
>  	return 0;
>  }
>  
> +/** Used as a flag to ref_transaction_delete when a loose ref is beeing
> + *  pruned.
> + */
> +#define REF_ISPRUNING	0x0100
> +/** Deletion of a ref that only exists as a packed ref in which case we do not
> + *  need to lock the loose ref during the transaction.
> + */
> +#define REF_ISPACKONLY	0x0200
> +
>  /*
>   * Try to read one refname component from the front of refname.  Return
>   * the length of the component found, or -1 if the component is not
> @@ -2447,12 +2456,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> -static int repack_without_refs(const char **refnames, int n)
> +static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>  {
>  	struct ref_dir *packed;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>  	struct string_list_item *ref_to_delete;
> -	int i, removed = 0;
> +	int i, ret, removed = 0;
>  
>  	/* Look for a packed ref */
>  	for (i = 0; i < n; i++)
> @@ -2465,6 +2474,9 @@ static int repack_without_refs(const char **refnames, int n)
>  
>  	if (lock_packed_refs(0)) {
>  		unable_to_lock_error(git_path("packed-refs"), errno);
> +		if (err)
> +			strbuf_addf(err, "cannot delete '%s' from packed refs",
> +				    refnames[i]);
>  		return error("cannot delete '%s' from packed refs", refnames[i]);
>  	}
>  	packed = get_packed_refs(&ref_cache);
> @@ -2490,20 +2502,28 @@ static int repack_without_refs(const char **refnames, int n)
>  	}
>  
>  	/* Write what remains */
> -	return commit_packed_refs();
> +	ret = commit_packed_refs();
> +	if (ret && err)
> +		strbuf_addf(err, "unable to overwrite old ref-pack file");
> +	return ret;
>  }
>  
> -static int delete_ref_loose(struct ref_lock *lock, int flag)
> +static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  {
>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>  		/* loose */
> -		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> +		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
>  
>  		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> +		res = unlink_or_warn(lock->lk->filename);
>  		lock->lk->filename[i] = '.';
> -		if (err && errno != ENOENT)
> +		if (res && errno != ENOENT) {
> +			if (err)
> +				strbuf_addf(err,
> +					    "failed to delete loose ref '%s'",
> +					    lock->lk->filename);
>  			return 1;
> +		}
>  	}
>  	return 0;
>  }
> @@ -3483,7 +3503,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  						   delnames, delnum);
>  		if (!update->lock) {
>  			if (err)
> -				strbuf_addf(err ,"Cannot lock the ref '%s'.",
> +				strbuf_addf(err, "Cannot lock the ref '%s'.",
>  					    update->refname);
>  			ret = 1;
>  			goto cleanup;
> @@ -3516,13 +3536,14 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  			continue;
>  
>  		if (update->lock) {
> -			ret |= delete_ref_loose(update->lock, update->type);
> +			ret |= delete_ref_loose(update->lock, update->type,
> +						err);
>  			if (!(update->flags & REF_ISPRUNING))
>  				delnames[delnum++] = update->lock->ref_name;
>  		}
>  	}
>  
> -	ret |= repack_without_refs(delnames, delnum);
> +	ret |= repack_without_refs(delnames, delnum, err);
>  	for (i = 0; i < delnum; i++)
>  		unlink_or_warn(git_path("logs/%s", delnames[i]));
>  	clear_loose_ref_cache(&ref_cache);
> diff --git a/refs.h b/refs.h
> index 03b4a7e..0e6d416 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -134,10 +134,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
>  
>  /** Locks any ref (for 'HEAD' type refs). */
>  #define REF_NODEREF	0x01
> -/** Deleting a loose ref during prune */
> -#define REF_ISPRUNING	0x02
> -/** Deletion of a ref that only exists as a packed ref */
> -#define REF_ISPACKONLY	0x04
>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>  						const unsigned char *old_sha1,
>  						int flags, int *type_p);
> @@ -240,6 +236,9 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>   * be deleted.  If have_old is true, then old_sha1 holds the value
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
> + * Function returns 0 on success and non-zero on failure. A failure to update
> + * means that the transaction as a whole has failed and will need to be
> + * rolled back.
>   */
>  int ref_transaction_update(struct ref_transaction *transaction,
>  			   const char *refname,
> @@ -252,6 +251,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>   * that the reference should have after the update; it must not be the
>   * null SHA-1.  It is verified that the reference does not exist
>   * already.
> + * Function returns 0 on success and non-zero on failure. A failure to create
> + * means that the transaction as a whole has failed and will need to be
> + * rolled back.
>   */
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
> @@ -262,6 +264,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
>   * Add a reference deletion to transaction.  If have_old is true, then
>   * old_sha1 holds the value that the reference should have had before
>   * the update (which must not be the null SHA-1).
> + * Function returns 0 on success and non-zero on failure. A failure to delete
> + * means that the transaction as a whole has failed and will need to be
> + * rolled back.
>   */
>  int ref_transaction_delete(struct ref_transaction *transaction,
>  			   const char *refname,
> @@ -272,7 +277,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>   * Commit all of the changes that have been queued in transaction, as
>   * atomically as possible.  Return a nonzero value if there is a
>   * problem. If err is non-NULL we will add an error string to it to explain
> - * why the transaction failed.
> + * why the transaction failed. The string does not end in newline.
>   */
>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err);
