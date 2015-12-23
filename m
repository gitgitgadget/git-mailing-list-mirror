From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 11/16] refs: move duplicate check to common code
Date: Wed, 23 Dec 2015 07:27:02 +0100
Message-ID: <567A3EB6.9000405@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-12-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 07:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBctf-0002pO-LF
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 07:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbLWG1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 01:27:10 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60061 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147AbbLWG1I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 01:27:08 -0500
X-AuditID: 1207440f-f79df6d000007c0f-e7-567a3eb85d15
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.3C.31759.8BE3A765; Wed, 23 Dec 2015 01:27:04 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBN6R238008618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 01:27:03 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <1449102921-7707-12-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqLvDrirMYM1KTov5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmrOy+wFeyUr5g/+zhLA+NjiS5GTg4JAROJ
	K6tXMUPYYhIX7q1n62Lk4hASuMwoMeHUHhYI5wKTxMupq1hBqoQFXCR+PuplA7FFBBwkLu86
	CtYtJNDGKHH9tiGIzSagK7Gop5kJYqqcRG/3JBYQm1dAW2L2y81gvSwCqhKXfuwCs0UFQiT2
	7uyAqhGUODnzCZjNKeApseveWzCbWUBPYsf1X6wQtrxE89bZzBMYBWYhaZmFpGwWkrIFjMyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3MUJClX8HY9d6mUOMAhyMSjy8Dm2V
	YUKsiWXFlbmHGCU5mJREef2tqsKE+JLyUyozEosz4otKc1KLDzFKcDArifCmvwMq501JrKxK
	LcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CyWpwcAjMODd3OpMUS15+XqqSBG+1LdACwaLU
	9NSKtMycEoRSJg5OkEVcUiLFqXkpqUWJpSUZ8aAYji8GRjFIigfohmKQdt7igsRcoChE6ylG
	RSlxXh2QhABIIqM0D24sLDG9YhQH+liYdxpIFQ8wqcF1vwIazAQ0+M+6cpDBJYkIKakGRm/P
	BzrrS3/bXZu4nn2pwLHVEisFlFeWWUX3Xt++NM9tf+7PcjGtbd+/dmUW3O1ODvJv+1gySyXO
	5XHOgXcRvAyJYT9qBJRqsmRWtn2b7FP6ZatAnPw096xAFW6xaUoSp5u8r3Hfr1E6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282924>

On 12/03/2015 01:35 AM, David Turner wrote:
> The check for duplicate refnames in a transaction is needed for
> all backends, so move it to the common code.
> 
> ref_transaction_commit_fn gains a new argument, the sorted
> string_list of affected refnames.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c               | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  refs/files-backend.c | 57 ++++-------------------------------------
>  refs/refs-internal.h |  1 +
>  3 files changed, 75 insertions(+), 54 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 1b79630..808053f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1093,6 +1093,37 @@ const char *find_descendant_ref(const char *dirname,
>  	return NULL;
>  }
>  
> +/*
> + * Return 1 if there are any duplicate refnames in the updates in
> + * `transaction`, and fill in err with an appropriate error message.
> + * Fill in `refnames` with the refnames from the transaction.
> + */
> +
> +static int ref_update_reject_duplicates(struct ref_transaction *transaction,
> +					struct string_list *refnames,
> +					struct strbuf *err)

I like that you extract this code into a function. Though it feels
awkward to have a function called "ref_update_reject_duplicates()" that
has a side effect of filling the names into a string list. I think it
would feel more natural to call the function get_affected_refnames(),
and treat the duplicate check as an extra bonus.

You could go even farther and split it into two functions,

void get_affected_refnames(struct ref_transaction *transaction,
                           struct string_list *refnames);
int ref_update_reject_duplicates(struct string_list *refnames,
                                 struct strbuf *err);

> +{
> +	int i, n = transaction->nr;
> +	struct ref_update **updates;
> +
> +	assert(err);
> +
> +	updates = transaction->updates;
> +	/* Fail if a refname appears more than once in the transaction: */
> +	for (i = 0; i < n; i++)
> +		string_list_append(refnames, updates[i]->refname);
> +	string_list_sort(refnames);
> +
> +	for (i = 1; i < n; i++)
> +		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
> +			strbuf_addf(err,
> +				    "Multiple updates for ref '%s' not allowed.",
> +				    refnames->items[i].string);
> +			return 1;
> +		}
> +	return 0;
> +}
> +
>  /* backend functions */
>  int refs_init_db(struct strbuf *err, int shared)
>  {
> @@ -1102,7 +1133,29 @@ int refs_init_db(struct strbuf *err, int shared)
>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
> -	return the_refs_backend->transaction_commit(transaction, err);
> +	int ret = -1;
> +	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +
> +	assert(err);
> +
> +	if (transaction->state != REF_TRANSACTION_OPEN)
> +		die("BUG: commit called for transaction that is not open");
> +
> +	if (!transaction->nr) {
> +		transaction->state = REF_TRANSACTION_CLOSED;
> +		return 0;
> +	}
> +
> +	if (ref_update_reject_duplicates(transaction, &affected_refnames, err)) {
> +		ret = TRANSACTION_GENERIC_ERROR;
> +		goto done;
> +	}
> +
> +	ret = the_refs_backend->transaction_commit(transaction,
> +						   &affected_refnames, err);
> +done:
> +	string_list_clear(&affected_refnames, 0);
> +	return ret;
>  }

Here you are avoiding a small amount of code duplication by calling
ref_update_reject_duplicates() here rather than in the backend-specific
code. But you are doing so at the cost of having to compute
affected_refnames here and pass it (redundantly) to the backend's
transaction_commit function. This increases the coupling between these
functions, which in my opinion is worse than the small amount of code
duplication. But maybe it's just me.

The check of transaction->state, on the other hand, makes sense here.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
