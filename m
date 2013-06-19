From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the packed-refs file
Date: Wed, 19 Jun 2013 12:18:59 -0700
Message-ID: <7vfvwdzz6k.fsf@alter.siamese.dyndns.org>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
	<1371628293-28824-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 19 21:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNuQ-0001rF-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 21:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935109Ab3FSTTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 15:19:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935074Ab3FSTTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 15:19:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DCA729F07;
	Wed, 19 Jun 2013 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NadZQyEnIE+Nd6JBQUu+ogj1ZVc=; b=lac1Kn
	uA87IaSreqGShV5HFTE0XD6npfr3GchrHcJzb7EFiYG/AzD6botbGNs0v+YIEdYK
	7pTzF6zqyaiBsYOq/oKrqEFc4JB7joECCNpx/8vxI2te6U2JQFdOhGylaFzQrbIb
	364eXe5OjWSJBpDUpaHBwdreKIXXOWFLhFtc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AVuj5k+hltm33y7cfwnjMYD8xVTXSeYI
	5AdTq+KHRZ9kqrsoOyOHGtnnocAxwYWP+RX5p1u1LtKQ4wWHsHDGsW18OHjFAxjs
	TIGUFzOcwXvZQgTzHjZWuv6g+2YPHBJK2lqhWs3+nFCH94KLw/KqMFU3j0daD5ST
	V1LjObdmIy4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8014C29F05;
	Wed, 19 Jun 2013 19:19:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 830EB29F01;
	Wed, 19 Jun 2013 19:19:01 +0000 (UTC)
In-Reply-To: <1371628293-28824-5-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 19 Jun 2013 09:51:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 193C8868-D915-11E2-B44C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228415>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Handle simple transactions for the packed-refs file at the
> packed_ref_cache level via new functions lock_packed_refs(),
> commit_packed_refs(), and rollback_packed_refs().
>
> Only allow the packed ref cache to be modified (via add_packed_ref())
> while the packed refs file is locked.
>
> Change clone to add the new references within a transaction.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/clone.c |  7 ++++-
>  refs.c          | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----------
>  refs.h          | 27 +++++++++++++++++--
>  3 files changed, 98 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 66bff57..b0c000a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -489,17 +489,22 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
>  	return local_refs;
>  }
>  
> +static struct lock_file packed_refs_lock;
> +
>  static void write_remote_refs(const struct ref *local_refs)
>  {
>  	const struct ref *r;
>  
> +	lock_packed_refs(&packed_refs_lock, LOCK_DIE_ON_ERROR);
> +
>  	for (r = local_refs; r; r = r->next) {
>  		if (!r->peer_ref)
>  			continue;
>  		add_packed_ref(r->peer_ref->name, r->old_sha1);
>  	}
>  
> -	pack_refs(PACK_REFS_ALL);
> +	if (commit_packed_refs())
> +		die_errno("unable to overwrite old ref-pack file");
>  }

The calling convention used here looks somewhat strange.  You allow
callers to specify which lock-file structure is used when locking,
but when you are done, commit_packed_refs() does not take any
parameter.

lock_packed_refs() make the singleton in-core packed-ref-cache be
aware of which lock it is under, so commit_packed_refs() does not
need to be told (the singleton already knows what lockfile is in
effect), so I am not saying the code is broken, though.

Does the caller need to even have an access to this lock_file
instance?

>  static void write_followtags(const struct ref *refs, const char *msg)
> diff --git a/refs.c b/refs.c
> index 373d95b..ad73251 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -808,6 +808,13 @@ static int is_refname_available(const char *refname, const char *oldrefname,
>  
>  struct packed_ref_cache {
>  	struct ref_entry *root;
> +
> +	/*
> +	 * Iff the packed-refs file associated with this instance is
> +	 * currently locked for writing, this points at the associated
> +	 * lock (which is owned by somebody else).
> +	 */
> +	struct lock_file *lock;
>  };
>  
>  /*
> @@ -829,6 +836,8 @@ static struct ref_cache {
>  static void clear_packed_ref_cache(struct ref_cache *refs)
>  {
>  	if (refs->packed) {
> +		if (refs->packed->lock)
> +			die("internal error: packed-ref cache cleared while locked");
>  		free_ref_entry(refs->packed->root);
>  		free(refs->packed);
>  		refs->packed = NULL;
> @@ -1038,7 +1047,12 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
>  
>  void add_packed_ref(const char *refname, const unsigned char *sha1)
>  {
> -	add_ref(get_packed_refs(&ref_cache),
> +	struct packed_ref_cache *packed_ref_cache =
> +		get_packed_ref_cache(&ref_cache);
> +
> +	if (!packed_ref_cache->lock)
> +		die("internal error: packed refs not locked");
> +	add_ref(get_packed_ref_dir(packed_ref_cache),
>  		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
>  }
>  
> @@ -2035,6 +2049,52 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> +int lock_packed_refs(struct lock_file *lock, int flags)
> +{
> +	struct packed_ref_cache *packed_ref_cache;
> +
> +	/* Discard the old cache because it might be invalid: */
> +	clear_packed_ref_cache(&ref_cache);
> +	if (hold_lock_file_for_update(lock, git_path("packed-refs"), flags) < 0)
> +		return -1;
> +	/* Read the current packed-refs while holding the lock: */
> +	packed_ref_cache = get_packed_ref_cache(&ref_cache);
> +	packed_ref_cache->lock = lock;
> +	return 0;
> +}
> +
> +int commit_packed_refs(void)
> +{
> +	struct packed_ref_cache *packed_ref_cache =
> +		get_packed_ref_cache(&ref_cache);
> +	int error = 0;
> +
> +	if (!packed_ref_cache->lock)
> +		die("internal error: packed-refs not locked");
> +	write_or_die(packed_ref_cache->lock->fd,
> +		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
> +
> +	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
> +				 0, write_packed_entry_fn,
> +				 &packed_ref_cache->lock->fd);
> +	if (commit_lock_file(packed_ref_cache->lock))
> +		error = -1;
> +	packed_ref_cache->lock = NULL;
> +	return error;
> +}
> +
> +void rollback_packed_refs(void)
> +{
> +	struct packed_ref_cache *packed_ref_cache =
> +		get_packed_ref_cache(&ref_cache);
> +
> +	if (!packed_ref_cache->lock)
> +		die("internal error: packed-refs not locked");
> +	rollback_lock_file(packed_ref_cache->lock);
> +	packed_ref_cache->lock = NULL;
> +	clear_packed_ref_cache(&ref_cache);
> +}
> +
>  struct ref_to_prune {
>  	struct ref_to_prune *next;
>  	unsigned char sha1[20];
> @@ -2153,23 +2213,19 @@ static struct lock_file packlock;
>  int pack_refs(unsigned int flags)
>  {
>  	struct pack_refs_cb_data cbdata;
> -	int fd;
>  
>  	memset(&cbdata, 0, sizeof(cbdata));
>  	cbdata.flags = flags;
>  
> -	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
> -				       LOCK_DIE_ON_ERROR);
> +	lock_packed_refs(&packlock, LOCK_DIE_ON_ERROR);
>  	cbdata.packed_refs = get_packed_refs(&ref_cache);
>  
>  	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
>  				 pack_if_possible_fn, &cbdata);
>  
> -	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
> -	do_for_each_entry_in_dir(cbdata.packed_refs, 0, write_packed_entry_fn, &fd);
> -
> -	if (commit_lock_file(&packlock) < 0)
> +	if (commit_packed_refs())
>  		die_errno("unable to overwrite old ref-pack file");
> +
>  	prune_refs(cbdata.ref_to_prune);
>  	return 0;
>  }
> @@ -2233,7 +2289,6 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  
>  static int repack_without_ref(const char *refname)
>  {
> -	int fd;
>  	struct ref_dir *packed;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>  	struct string_list_item *ref_to_delete;
> @@ -2241,12 +2296,10 @@ static int repack_without_ref(const char *refname)
>  	if (!get_packed_ref(refname))
>  		return 0; /* refname does not exist in packed refs */
>  
> -	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
> -	if (fd < 0) {
> +	if (lock_packed_refs(&packlock, 0)) {
>  		unable_to_lock_error(git_path("packed-refs"), errno);
>  		return error("cannot delete '%s' from packed refs", refname);
>  	}
> -	clear_packed_ref_cache(&ref_cache);
>  	packed = get_packed_refs(&ref_cache);
>  
>  	/* Remove refname from the cache: */
> @@ -2255,7 +2308,7 @@ static int repack_without_ref(const char *refname)
>  		 * The packed entry disappeared while we were
>  		 * acquiring the lock.
>  		 */
> -		rollback_lock_file(&packlock);
> +		rollback_packed_refs();
>  		return 0;
>  	}
>  
> @@ -2267,9 +2320,7 @@ static int repack_without_ref(const char *refname)
>  	}
>  
>  	/* Write what remains: */
> -	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
> -	do_for_each_entry_in_dir(packed, 0, write_packed_entry_fn, &fd);
> -	return commit_lock_file(&packlock);
> +	return commit_packed_refs();
>  }
>  
>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
> diff --git a/refs.h b/refs.h
> index 246bf60..b275124 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -77,12 +77,35 @@ extern int for_each_rawref(each_ref_fn, void *);
>  extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
>  
>  /*
> - * Add a reference to the in-memory packed reference cache.  To actually
> - * write the reference to the packed-refs file, call pack_refs().
> + * Lock the packed-refs file for writing using the specified lock_file
> + * instance.  Flags is passed to hold_lock_file_for_update().  Return
> + * 0 on success.
> + */
> +extern int lock_packed_refs(struct lock_file *lock, int flags);
> +
> +/*
> + * Add a reference to the in-memory packed reference cache.  This may
> + * only be called while the packed-refs file is locked (see
> + * lock_packed_refs()).  To actually write the packed-refs file, call
> + * commit_packed_refs().
>   */
>  extern void add_packed_ref(const char *refname, const unsigned char *sha1);
>  
>  /*
> + * Write the current version of the packed refs cache from memory to
> + * disk.  The packed-refs file must already be locked for writing (see
> + * lock_packed_refs()).  Return zero on success.
> + */
> +extern int commit_packed_refs(void);
> +
> +/*
> + * Rollback the lockfile for the packed-refs file, and discard the
> + * in-memory packed reference cache.  (The packed-refs file will be
> + * read anew if it is needed again after this function is called.)
> + */
> +extern void rollback_packed_refs(void);
> +
> +/*
>   * Flags for controlling behaviour of pack_refs()
>   * PACK_REFS_PRUNE: Prune loose refs after packing
>   * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
