From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] refs.c: use packed refs when deleting refs during a
 transaction
Date: Fri, 25 Jul 2014 12:58:43 -0700
Message-ID: <20140725195843.GI12427@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
 <1406307521-10339-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAldi-0001jr-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbaGYT6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:58:47 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44885 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760894AbaGYT6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:58:46 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so6123508pdj.8
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B0PE26+HjIYLXCxaHvTxkdTq1HJCkmVdTnFGbTOf/yM=;
        b=Rbesuq5eL7Ikac0j9DT7EjuWfZZpTOJooIKpsidAz4sIpRoKayf4IuQugo0WR8FkDd
         6H2NeQ3LBSR50mLIWXzqAqeJDeFKazKTtkniK7AftOxN49dsq/rxZgXE3s6EXFGa7lf0
         fcp5E0bmvMpz2peUzzxE9uVY95pRukzzJuTgUvjS4n7fzJl+35aKAg53uPxaVzjitSlb
         N1mnD0Q7//6kxxgUJYNHYdCKTGOhiMAM70/GgjeEqlJeHPadh2mgy2U2YvJRrC7Tkl9o
         kVWe85XbSy7YUFrNxOTHkLfWA9EntUeW7nMTrxUUD51fMARmaws958PmQPmJPWrE/U7r
         7zOw==
X-Received: by 10.68.113.133 with SMTP id iy5mr20991155pbb.135.1406318326186;
        Fri, 25 Jul 2014 12:58:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:11c3:a287:a529:3c10])
        by mx.google.com with ESMTPSA id n3sm12837322pde.47.2014.07.25.12.58.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 12:58:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406307521-10339-4-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254266>

Ronnie Sahlberg wrote:

> Make the deletion of refs during a transaction more atomic.
> Start by first copying all loose refs we will be deleting to the packed
> refs file and then commit the packed refs file. Then re-lock the packed refs
> file to stop anyone else from modifying these refs and keep it locked until
> we are finished.
[...]
> By deleting all the loose refs at the start of the transaction we make make
> it possible to both delete one ref and then re-create a different ref in
> the same transaction even if the two refs would normally conflict.
>
> Example: rename m->m/m

Makes a lot of sense.

This can potentially slow down a single-ref deletion in a repository with
a huge amount of refs (e.g., a Gerrit server with lots of
refs/changes/* refs), right?  But the cost is not more than a factor
of 2 worse than if the ref had been packed (since you have to
repack_without_refs anyway) so I think this is acceptable.

[...]
> The exception is for refs that can not be resolved. Those refs are never
> added to the packed refs and will just be un-rollback-ably deleted during
> commit.

This also seems reasonable --- there's no need to be able to roll back
into an invalid state. :)

[...]
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -756,6 +756,8 @@ static int remove_branches(struct string_list *branches)
>  	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
>  	for (i = 0; i < branches->nr; i++)
>  		branch_names[i] = branches->items[i].string;
> +	if (lock_packed_refs(0))
> +		result |= unable_to_lock_error(git_path("packed-refs"), errno);
>  	result |= repack_without_refs(branch_names, branches->nr, NULL);

What should happen if lock_packed_refs fails?  Since
repack_without_refs is now documented to require a locked packed-refs
file, shouldn't the repack_without_refs call be guarded, like it is
below?

[...]
> @@ -1333,9 +1335,14 @@ static int prune_remote(const char *remote, int dry_run)
>  		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
>  		for (i = 0; i < states.stale.nr; i++)
>  			delete_refs[i] = states.stale.items[i].util;
> -		if (!dry_run)
> -			result |= repack_without_refs(delete_refs,
> -						      states.stale.nr, NULL);
> +		if (!dry_run) {
> +			if (lock_packed_refs(0))
> +				result |= unable_to_lock_error(
> +					git_path("packed-refs"), errno);
> +			else
> +				result |= repack_without_refs(delete_refs,
> +							states.stale.nr, NULL);
[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -1330,7 +1330,7 @@ static struct ref_entry *get_packed_ref(const char *refname)
>  
>  /*
>   * A loose ref file doesn't exist; check for a packed ref.  The
> - * options are forwarded from resolve_safe_unsafe().
> + * options are forwarded from resolve_ref_unsafe().

Unrelated changes snuck in?  (A good change, but it presumably belongs
as a separate patch.)

[...]
> @@ -1387,7 +1387,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
>  		}
>  
>  		git_snpath(path, sizeof(path), "%s", refname);
> -
>  		/*

Why?

[...]
> @@ -2532,6 +2531,9 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> +/*
> + * Must be called with packed refs already locked (and sorted)
> + */
>  int repack_without_refs(const char **refnames, int n, struct strbuf *err)

Aren't packed refs always sorted?  If it needs mentioning, that seems
more like an implementation comment.

The 'packed refs must be locked' kind of documentation belongs in
refs.h since this is part of the API.  Usually when there are API
changes like this we like to change the function name or signature to
make it easy to catch callers that were introduced without noticing
the change --- would that be easy to do here?

E.g. introducing a new repack_without_refs_locked (name is just a
placeholder, I'm bad at names) and keeping repack_without_refs with
the current semantics as a wrapper around that.

[...]
> @@ -2544,19 +2546,12 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>  		if (get_packed_ref(refnames[i]))
>  			break;
>  
> -	/* Avoid locking if we have nothing to do */
> +	/* Avoid processing if we have nothing to do */

This implies a small speed regression but I don't think anyone would
mind.

[...]
> @@ -3692,12 +3689,65 @@ int transaction_commit(struct ref_transaction *transaction,
>  		goto cleanup;
>  	}
>  
> -	/* Acquire all ref locks while verifying old values */
> +	/* Lock packed refs during commit */
> +	if (lock_packed_refs(0)) {

I stopped reviewing here but assume the rest is okay. :)

Thanks,
Jonathan
