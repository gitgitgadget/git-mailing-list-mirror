From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 14/21] refs: always handle non-normal refs in files
 backend
Date: Fri, 12 Feb 2016 16:07:29 +0100
Message-ID: <56BDF531.7010909@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-15-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 16:07:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUFK3-0005rj-13
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 16:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbcBLPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 10:07:47 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52325 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbcBLPHq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 10:07:46 -0500
X-AuditID: 1207440c-c0bff70000002d40-f1-56bdf53378de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 59.7F.11584.335FDB65; Fri, 12 Feb 2016 10:07:31 -0500 (EST)
Received: from [192.168.69.130] (p548D685F.dip0.t-ipconnect.de [84.141.104.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1CF7TkK018551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Feb 2016 10:07:31 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-15-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqGvydW+YwffNzBbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDMmdq5jLHhqUbFpXxdzA2O3bhcjJ4eEgInE
	lumL2LoYuTiEBLYyStw/OZ0dwjnPJLF//g7GLkYODmGBEIntS8NBGkQEHCQu7zrKDFHTxihx
	b/I0ZpAEm4CuxKKeZiaIqXISvd2TWEBsXgFtid6D09lA5rAIqEo83m4EEhYFGvn+63NWiBJB
	iZMzn4CVcwp4SjSc/wI2hllAT2LH9V+sELa8RPPW2cwTGPlnIWmZhaRsFpKyBYzMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCApJnB+O3dTKHGAU4GJV4eA1u7QkTYk0s
	K67MPcQoycGkJMrb+GxvmBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXoMmoBxvSmJlVWpRPkxK
	moNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYLX6AtQo2BRanpqRVpmTglCmomDE2Q4l5RI
	cWpeSmpRYmlJRjwoIuOLgTEJkuIB2lsO0s5bXJCYCxSFaD3FqCglzqsHkhAASWSU5sGNhaWZ
	V4ziQF8K804HqeIBpii47ldAg5mABu/4vgtkcEkiQkqqgTFii5v+Bu5oXXGelKkr/ol/EdpX
	rntj2YqXsQ9ynF8o+jiH6zf+5UtqXpoZ+9IkSaNd93rBDSOzXSce/PKJ8nL8LpN//POhswWt
	fI+mBK3h4M8qym9yEOsR+pf6PI6191/G5m177ULKldeXK/hMT8t2fa97ZJGu/MRV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286051>

On 02/05/2016 08:44 PM, David Turner wrote:
> Always handle non-normal (per-worktree or pseudo) refs in the files
> backend instead of alternate backends.
> 
> Sometimes a ref transaction will update both a per-worktree ref and a
> normal ref.  For instance, an ordinary commit might update
> refs/heads/master and HEAD (or at least HEAD's reflog).
> 
> Updates to normal refs continue to go through the chosen backend.
> 
> Updates to non-normal refs are moved to a separate files backend
> transaction.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 227c018..18ba356 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -9,6 +9,11 @@
>  #include "object.h"
>  #include "tag.h"
>  
> +static const char split_transaction_fail_warning[] = N_(
> +	"A ref transaction was split across two refs backends.  Part of the "
> +	"transaction succeeded, but then the update to the per-worktree refs "
> +	"failed.  Your repository may be in an inconsistent state.");
> +
>  /*
>   * We always have a files backend and it is the default.
>   */
> @@ -791,6 +796,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
> @@ -798,8 +810,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>  	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
>  
>  	memcpy((char *)update->refname, refname, len); /* includes NUL */
> -	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
> -	transaction->updates[transaction->nr++] = update;
> +	add_update_obj(transaction, update);
>  	return update;
>  }
>  
> @@ -1217,11 +1228,38 @@ static int dereference_symrefs(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> +/*
> + * Move all non-normal ref updates into a specially-created
> + * files-backend transaction
> + */
> +static int move_abnormal_ref_updates(struct ref_transaction *transaction,
> +				     struct ref_transaction *files_transaction,
> +				     struct strbuf *err)
> +{
> +	int i;
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		int last;
> +		struct ref_update *update = transaction->updates[i];
> +
> +		if (ref_type(update->refname) == REF_TYPE_NORMAL)
> +			continue;
> +
> +		last = --transaction->nr;
> +		transaction->updates[i] = transaction->updates[last];
> +		add_update_obj(files_transaction, update);
> +	}
> +
> +	return 0;
> +}
> +

I think this function is incorrect. The update that was previously at
transaction->updates[i] never gets checked for abnormality. You could
fix that and also avoid gratuitously changing the order of the updates
like this:

static int move_abnormal_ref_updates(struct ref_transaction *transaction,
				     struct ref_transaction *files_transaction,
				     struct strbuf *err)
{
	int i, normal_nr = 0;

	for (i = 0; i < transaction->nr; i++) {
		struct ref_update *update = transaction->updates[i];

		if (ref_type(update->refname) == REF_TYPE_NORMAL)
			transaction->updates[normal_nr++] = update;
		else
			add_update_obj(files_transaction, update);
	}

	transaction->nr = normal_nr;
	return 0;
}

Another alternative would be to set

    update->flags |= REF_ABNORMAL

for the abnormal references and *leave them* in the original transaction
while also adding them to files_transactions. Then teach non-files
backends to skip over updates with REF_ABNORMAL.

The reason I thought of this is that long-term I'd like to make it
possible for some reference updates to fail without aborting the
transaction. To implement that, we would want a way for
ref_transaction_commit() to report back to its caller *which* updates
failed, and an obvious way to do that would be to store the
reference-specific errors in struct ref_update. If you leave the
abnormal ref_updates in the main transaction, then my hoped-for change
would be easier.

But that's a separate and hypothetical idea, so you don't have to let it
influence how you implement this patch.

>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
>  	int ret = -1;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list files_affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct ref_transaction *files_transaction = NULL;
>  
>  	assert(err);
>  
> @@ -1237,6 +1275,26 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	if (ret)
>  		goto done;
>  
> +	if (the_refs_backend != &refs_be_files) {
> +		files_transaction = ref_transaction_begin(err);
> +		if (!files_transaction)
> +			goto done;
> +
> +		ret = move_abnormal_ref_updates(transaction, files_transaction,
> +						err);
> +		if (ret)
> +			goto done;
> +
> +		/* files backend commit */
> +		if (get_affected_refnames(files_transaction,
> +						 &files_affected_refnames,
> +						 err)) {
> +			ret = TRANSACTION_GENERIC_ERROR;
> +			goto done;
> +		}
> +	}
> +
> +	/* main backend commit */
>  	if (get_affected_refnames(transaction, &affected_refnames, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
>  		goto done;
> @@ -1244,8 +1302,24 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  	ret = the_refs_backend->transaction_commit(transaction,
>  						   &affected_refnames, err);
> +	if (ret)
> +		goto done;
> +
> +	if (files_transaction) {
> +		ret = refs_be_files.transaction_commit(files_transaction,
> +						       &files_affected_refnames,
> +						       err);
> +		if (ret) {
> +			warning(split_transaction_fail_warning);
> +			goto done;
> +		}
> +	}
> +
>  done:
>  	string_list_clear(&affected_refnames, 0);
> +	string_list_clear(&files_affected_refnames, 0);
> +	if (files_transaction)
> +		ref_transaction_free(files_transaction);
>  	return ret;
>  }
>  
> @@ -1285,6 +1359,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
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

Does initial_ref_transaction_commit() need the same treatment?

I think files_rename_ref() will break if one of the references is normal
and one is abnormal. I think it would be OK to prohibit renaming
abnormal refs entirely (can anybody think of an important use case?),
but that function should at least do the checks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
