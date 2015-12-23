From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 12/16] refs: always handle non-normal refs in files
 backend
Date: Wed, 23 Dec 2015 09:02:30 +0100
Message-ID: <567A5516.9070209@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-13-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 09:10:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBeUl-0001Ud-0J
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 09:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387AbbLWIJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 03:09:37 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52115 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887AbbLWIJg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 03:09:36 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2015 03:09:36 EST
X-AuditID: 12074413-f79bd6d000007ac2-e5-567a5518a46d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.07.31426.8155A765; Wed, 23 Dec 2015 03:02:32 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBN82U2Z012326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 03:02:32 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <1449102921-7707-13-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1JUIrQoz+HhT12L+phOMFl1Xupkc
	mDwWPL/P7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8aNm1tZC2aGVxzfP4mlgfGpSxcjJ4eEgInE
	m9UPWSBsMYkL99azdTFycQgJXGaUODjrIBOEc4FJou3yBHaQKmGBQIn7TZMZQWwRAQeJy7uO
	MoPYQgJtjBI7jnOC2GwCuhKLepqZIKbKSfR2TwLbwCugLXHq8Vwwm0VAVeJwSyeYLSoQIrF3
	ZwdUjaDEyZlPwGxOAU+JhafvsoHYzAJ6Ejuu/2KFsOUlmrfOZp7AKDALScssJGWzkJQtYGRe
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESqsI7GHedlDvEKMDBqMTD69BW
	GSbEmlhWXJl7iFGSg0lJlNffqipMiC8pP6UyI7E4I76oNCe1+BCjBAezkghv+jugct6UxMqq
	1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/+YKChgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aBYjS8GRitIigdor0oQUDtvcUFiLlAUovUUo6KUOO92kLkCIImM
	0jy4sbAE9IpRHOhLYd4DIFU8wOQF1/0KaDAT0OA/68pBBpckIqSkGhgZzI4IN52W4/HxPHpJ
	YCbrcYdMP+HVPffYdpS0vd/yJsNqyxsLifcL9m1aJ2PosfRCCPdZsbsyjt07JyRYdaskrt77
	JTPkosqW/4sF3CIPKJ1x3iNpY6zYaf2+6NUUZ+fl3C/2uDTfb1fPWiwbOV2gh73M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282927>

On 12/03/2015 01:35 AM, David Turner wrote:
> Always handle non-normal (per-worktree or pseudo) refs in the files
> backend instead of alternate backends.
> 
> Sometimes a ref transaction will update both a per-worktree ref and a
> normal ref.  For instance, an ordinary commit might update
> refs/heads/master and HEAD (or at least HEAD's reflog).
> 
> We handle three cases here:
> 
> 1. updates to normal refs continue to go through the chosen backend
> 
> 2. updates to non-normal refs with REF_NODEREF or to non-symbolic refs
> are moved to a separate files backend transaction.
> 
> 3. updates to symbolic refs are dereferenced to their base ref.  The
> update to the base ref then goes through the ordinary backend, while
> the files backend is directly called to update the symref's reflog.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 808053f..e48e43a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -9,6 +9,11 @@
>  #include "object.h"
>  #include "tag.h"
>  
> +const char split_transaction_fail_warning[] =
> +	"A ref transaction was split across two refs backends.  Part of the "
> +	"transaction succeeded, but then the update to the per-worktree refs "
> +	"failed.  Your repository may be in an inconsistent state.";
> +
>  /*
>   * We always have a files backend and it is the default.
>   */
> @@ -784,6 +789,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  	free(transaction);
>  }
>  
> +static void add_update_obj(struct ref_transaction *transaction,
> +			   struct ref_update *update)
> +{
> +	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
> +	transaction->updates[transaction->nr++] = update;
> +}
> +
>  static struct ref_update *add_update(struct ref_transaction *transaction,
>  				     const char *refname)
>  {
> @@ -791,8 +803,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>  	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
>  
>  	memcpy((char *)update->refname, refname, len); /* includes NUL */
> -	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
> -	transaction->updates[transaction->nr++] = update;
> +	add_update_obj(transaction, update);
>  	return update;
>  }
>  
> @@ -1130,11 +1141,87 @@ int refs_init_db(struct strbuf *err, int shared)
>  	return the_refs_backend->init_db(err, shared);
>  }
>  
> +/*
> + * Special case for non-normal refs.  For symbolic-refs when
> + * REF_NODEREF is not turned on, we dereference them here and replace
> + * updates to the symbolic refs with updates to the underlying ref.
> + * Then we do our own reflogging for the symbolic ref.
> + *
> + * We move other non-normal ref updates with into a specially-created
> + * files-backend transaction
> + */

Extra word? s/with//?

> +static int move_abnormal_ref_updates(struct ref_transaction *transaction,
> +				     struct ref_transaction *files_transaction,
> +				     struct string_list *symrefs)
> +{
> +	int i;
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +		const char *resolved;
> +		int flags = 0;
> +		unsigned char sha1[20];
> +
> +		if (ref_type(update->refname) == REF_TYPE_NORMAL)
> +			continue;
> +
> +		resolved = resolve_ref_unsafe(update->refname, 0, sha1, &flags);
> +
> +		if (update->flags & REF_NODEREF || !(flags & REF_ISSYMREF)) {
> +			int last;
> +
> +			add_update_obj(files_transaction, update);
> +			/*
> +			 * Replace this transaction with the
> +			 * last transaction, removing it from
> +			 * the list of backend transactions
> +			 */
> +			last = --transaction->nr;
> +			transaction->updates[i] = transaction->updates[last];

The "last" temporary variable could be trivially inlined.

> +			continue;
> +		}
> +
> +		if (resolved) {
> +			struct ref_update *new_update;
> +			struct string_list_item *item;
> +
> +			if (ref_type(resolved) != REF_TYPE_NORMAL)
> +				die("Non-normal symbolic ref `%s` points to non-normal ref `%s`", update->refname, resolved);

We don't usually use backticks in error messages. Please use "'" instead.

Also, please store this error message into a "strbuf *err" and report it
via the usual mechanism.

> +			new_update = xmalloc(sizeof(*new_update) +
> +					     strlen(resolved) + 1);
> +			memcpy(new_update, update, sizeof(*update));

Wouldn't it be preferable to replace this messy replacement code
(including the memcpy(), which can't be checked by the type system) with
a call to ref_transaction_update() followed by moving the new update to
this position in the list and possibly tweaking some of its fields?

> +			if (update->flags & REF_HAVE_OLD &&
> +			    hashcmp(sha1, update->old_sha1)) {
> +				/* consistency check failed */
> +				free(new_update);
> +				return -1;

We need an error message to be reported in this case; i.e., via a
"struct strbuf *err" argument.

But actually, I don't understand why this check is needed here at all.
Isn't it redundant with a similar check that will be done later (and
properly, under lock) as part of the main ref_transaction_commit()?

> +			} else {
> +				hashcpy(update->old_sha1, sha1);
> +			}
> +
> +			strcpy((char *)new_update->refname, resolved);
> +			transaction->updates[i] = new_update;
> +
> +			item = string_list_append(symrefs, update->refname);
> +			item->util = new_update;
> +			free(update);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
>  	int ret = -1;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list files_affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list symrefs = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +	struct ref_transaction *files_transaction = NULL;
>  
>  	assert(err);
>  
> @@ -1146,6 +1233,26 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		return 0;
>  	}
>  
> +	if (the_refs_backend != &refs_be_files) {
> +		files_transaction = ref_transaction_begin(err);
> +		if (!files_transaction)
> +			die("%s", err->buf);

I think dying here is too abrupt. Some callers try to recover from a
failed ref_transaction_commit(). Couldn't you "goto done" and let the
caller deal with err?

> +		ret = move_abnormal_ref_updates(transaction, files_transaction,
> +						&symrefs);
> +		if (ret)
> +			goto done;
> +
> +		/* files backend commit */
> +		if (ref_update_reject_duplicates(files_transaction,
> +						 &files_affected_refnames,
> +						 err)) {
> +			ret = TRANSACTION_GENERIC_ERROR;
> +			goto done;
> +		}

Is it correct to reject_duplicates among "abnormal" references and
"normal" references separately? ***

> +	}
> +
> +	/* main backend commit */
>  	if (ref_update_reject_duplicates(transaction, &affected_refnames, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
>  		goto done;
> @@ -1153,8 +1260,35 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  	ret = the_refs_backend->transaction_commit(transaction,
>  						   &affected_refnames, err);
> +	if (ret)
> +		goto done;
> +
> +	if (the_refs_backend != &refs_be_files) {

This conditional would perhaps be more to the point if expressed as "if
(files_transaction)".

> +		ret = refs_be_files.transaction_commit(files_transaction,
> +						       &files_affected_refnames,
> +						       err);
> +		if (ret) {
> +			warning(split_transaction_fail_warning);
> +			goto done;
> +		}
> +
> +		/* reflogging for dereferenced symbolic refs */
> +		for_each_string_list_item(item, &symrefs) {
> +			struct ref_update *update = item->util;
> +			if (files_log_ref_write(item->string, update->old_sha1,
> +						update->new_sha1,
> +						update->msg, update->flags, err))
> +				warning("failed to log ref update for symref %s",
> +					item->string);
> +		}

I think this code is incorrect because it doesn't lock the symbolic
reference before modifying its reflog (though I seem to recall that the
old code was buggy in this respect, too).

I wonder whether it would be simpler overall to leave the ref_update for
the symbolic ref in the files_transaction, but set a special internal
internal flag like REF_LOG_ONLY which tells the usual transaction_commit
code to add a reflog entry for update->old_sha1 to update->new_sha1,
without actually changing the reference.

> +	}
> +
>  done:
>  	string_list_clear(&affected_refnames, 0);
> +	string_list_clear(&files_affected_refnames, 0);
> +	if (files_transaction)
> +		ref_transaction_free(files_transaction);
> +	string_list_clear(&symrefs, 0);
>  	return ret;
>  }
>  
> @@ -1210,6 +1344,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
>  int create_symref(const char *ref_target, const char *refs_heads_master,
>  		  const char *logmsg)
>  {
> +	if (ref_type(ref_target) != REF_TYPE_NORMAL)
> +		return refs_be_files.create_symref(ref_target, refs_heads_master,
> +						   logmsg);
>  	return the_refs_backend->create_symref(ref_target, refs_heads_master,
>  					       logmsg);
>  }
> 

I very much like the idea of introducing special handling for symbolic
reference updates within a transaction. In fact, I think I would go even
farther:

Let's take the example of an update to HEAD, which currently points at
refs/heads/master. I think it would *always* be a good idea (i.e., even
when only the files backend is in use) to split that ref_update into two
ref_updates:

1. One to update refs/heads/master and add a reflog entry for that
   reference.

2. One to add a reflog entry for HEAD (i.e. using the new REF_LOG_ONLY
   flag suggested above).

Why?

* It ensures that both references are locked correctly while their
  reflogs are updated. (I believe the current code gets this wrong.)

* It improves the reject_duplicates coverage, which (I think) currently
  wouldn't detect the conflict between a direct update of
  refs/heads/master with a simultaneous update of the same reference
  via HEAD.

* It could later be generalized to an update that goes through multiple
  layers of symref indirection (though this would be a very low
  priority).

This might benefit the split-backend situation that you are implementing
here. You could first do the symref-splitting step I just described, and
*then* separate the non-normal from the normal refs. I think the net
result would be simpler.

This patch is a lot to digest. I'm not yet confident that I have thought
through all of the ramifications of this patch. I guess a few iterations
will be needed in any case.

By the way, all of the patches preceding this one that I haven't
commented on look OK to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
