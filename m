From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2] refs.c: enable large transactions
Date: Wed, 22 Apr 2015 16:11:12 +0200
Message-ID: <5537AC00.5060208@alum.mit.edu>
References: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com> <1429643171-27530-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 16:11:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkvN6-0001vH-Au
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 16:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbbDVOLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 10:11:20 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43005 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964935AbbDVOLR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 10:11:17 -0400
X-AuditID: 12074413-f79f26d0000030e7-62-5537ac02d68e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.AB.12519.20CA7355; Wed, 22 Apr 2015 10:11:14 -0400 (EDT)
Received: from [192.168.69.130] (p4FC971D5.dip0.t-ipconnect.de [79.201.113.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3MEBCo9016165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 22 Apr 2015 10:11:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1429643171-27530-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42IRYndR1GVaYx5qsPCTiUXXlW4mi4beK8wW
	mze3szgweyzYVOpx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGcf7Z7MUnFesOHTkIXsD4z7J
	LkZODgkBE4lZD+YxQthiEhfurWcDsYUELjNKvPlc1cXIBWRfYJLoWvaFqYuRg4NXQFui9W0d
	SA2LgKrEilknWEBsNgFdiUU9zUwgtqhAkETrtalgM3kFBCVOznwCViMi4Cex7+IVMFtYwELi
	/PmTrBC7CiUeN9wCszkFnCV2n5oLVsMsoCex4/ovVghbXqJ562zmCYz8s5CMnYWkbBaSsgWM
	zKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQsJTeAfjrpNyhxgFOBiVeHhX
	sJuHCrEmlhVX5h5ilORgUhLlfVYOFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCK7oUKMebklhZ
	lVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuCNXwXUKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+Kx/hiYESCpHiA9u4FaectLkjMBYpCtJ5iVJQS510GkhAASWSU
	5sGNhSWdV4ziQF8K8x4GqeIBJiy47ldAg5mABsdtMwEZXJKIkJJqYPTif5Vg/cPyHUPrmmUP
	jqkkHvnBc/Ld5a7Xt2ac2TaBxU3I76XRisBP7hq9DPJsHd8S9kySa8ja+n1BU/6/96++qq74
	7/R587sTDxY2frOOfJtY/OvdHgubCZcYdDu/7uL5z+XPkPxU9aXC76xPi6Ya+07U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267591>

On 04/21/2015 09:06 PM, Stefan Beller wrote:
> This is another attempt on enabling large transactions
> (large in terms of open file descriptors). We keep track of how many
> lock files are opened by the ref_transaction_commit function.
> When more than a reasonable amount of files is open, we close
> the file descriptors to make sure the transaction can continue.
> 
> Another idea I had during implementing this was to move this file
> closing into the lock file API, such that only a certain amount of
> lock files can be open at any given point in time and we'd be 'garbage
> collecting' open fds when necessary in any relevant call to the lock
> file API. This would have brought the advantage of having such
> functionality available in other users of the lock file API as well.
> The downside however is the over complication, you really need to always
> check for (lock->fd != -1) all the time, which may slow down other parts
> of the code, which did not ask for such a feature.

Aside from a missing error check (see below), this looks good to me.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> * Removed unneeded braces in the condition to check if we want to close
>   the lock file.
> * made the counter for the remaining fds an unsigned int. That is what   
>   get_max_fd_limit() returns, so there are no concerns for an overflow.
>   Also it cannot go below 0 any more.
> * moved the initialisation of the remaining_fds a bit down and added a comment  
>   
>  refs.c                | 21 +++++++++++++++++++++
>  t/t1400-update-ref.sh |  4 ++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>  
>  
> 
> diff --git a/refs.c b/refs.c
> index 4f495bd..34cfcdf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3041,6 +3041,8 @@ static int write_ref_sha1(struct ref_lock *lock,
>  		errno = EINVAL;
>  		return -1;
>  	}
> +	if (lock->lk->fd == -1)
> +		reopen_lock_file(lock->lk);

You should check that reopen_lock_file() was successful.

>  	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
>  	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
>  	    close_ref(lock) < 0) {
> @@ -3718,6 +3720,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
>  	int ret = 0, i;
> +	unsigned int remaining_fds;
>  	int n = transaction->nr;
>  	struct ref_update **updates = transaction->updates;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
> @@ -3733,6 +3736,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		return 0;
>  	}
>  
> +	/*
> +	 * We need to open many files in a large transaction, so come up with
> +	 * a reasonable maximum. We still keep some spares for stdin/out and
> +	 * other open files. Experiments determined we need more fds when
> +	 * running inside our test suite than directly in the shell. It's
> +	 * unclear where these fds come from. 32 should be a reasonable large
> +	 * number though.
> +	 */
> +	remaining_fds = get_max_fd_limit();
> +	if (remaining_fds > 32)
> +		remaining_fds -= 32;
> +	else
> +		remaining_fds = 0;
> +
>  	/* Copy, sort, and reject duplicate refs */
>  	qsort(updates, n, sizeof(*updates), ref_update_compare);
>  	if (ref_update_reject_duplicates(updates, n, err)) {
> @@ -3762,6 +3779,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  				    update->refname);
>  			goto cleanup;
>  		}
> +		if (remaining_fds > 0)
> +			remaining_fds--;
> +		else
> +			close_lock_file(update->lock->lk);

I consider this code a stopgap, and simplicity is more important than
optimization. But just for the sake of discussion, if we planned to keep
this code around, it could be improved by not wasting open file
descriptors for references that are only being verified or deleted, like so:

                if (!(flags & REF_HAVE_NEW) ||
                    is_null_sha1(update->new_sha1) ||
                    remaining_fds == 0)
                        close_lock_file(update->lock->lk);
                else
                        remaining_fds--;

>  	}
>  
>  	/* Perform updates first so live commits remain referenced */
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
