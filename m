From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] refs.c: add a new update_type field to ref_update
Date: Thu, 23 Oct 2014 10:47:53 -0700
Message-ID: <xmqqppdismnq.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:48:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMUW-0005fT-E7
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbaJWRr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:47:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbaJWRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:47:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 306A816D98;
	Thu, 23 Oct 2014 13:47:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u8I8uhGzm3XmGVjefgqUC16CraI=; b=bqa/1a
	+20CMgQpuppe+AQZZSmv2vx24ya6a7sADI3i/Msvry0ppOOBvcdRFVYV6IKbOxXL
	6D6wq5BVI7euup8QRSAkBtzaGEFz/Xo7isSopnqwsnj/v+fuyMhNYtIu9AGM8o2q
	vA+EQC832fPkOEFkX/TmdaJboBwAY02A/2utw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ItSlodfUVqMeaPqsByfAnfWkfHqZ5aNA
	QFrONAuWd6+DVTbwKIChbpOvx7oCPoz+fruzGS5bpeo8jkJHKOXVgrPBx8miWXFr
	vK2JWelZcGhcAaQTarVGKh1kPKzV3jhElQbO3Y7ghI60aLwsof39bBzhpuyZo+0i
	ZQpTehvGETc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27CCC16D97;
	Thu, 23 Oct 2014 13:47:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8802416D95;
	Thu, 23 Oct 2014 13:47:55 -0400 (EDT)
In-Reply-To: <1413919462-3458-5-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 12:24:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8165BFE-5ADC-11E4-B580-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> commit 1bfd3091a3d95a6268894182117eed823217dd9d upstream.
>
> Add a field that describes what type of update this refers to. For now
> the only type is UPDATE_SHA1 but we will soon add more types.

OK, so the idea is that 03/15 and 07/15 that let callers to say
transaction_update_REF or transaction_update_REFLOG are nicety
wrappers and the underlying machinery will use UPDATE_SHA1 (added
here) and UPDATE_LOG (added in 07/15), which I find is a nice
layering.

Going in a good direction.

> Change-Id: I9bf76454d1c789877a6aeb360cbb309971c9b5c4
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  refs.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index a1bfaa2..8803b95 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3504,6 +3504,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>  	return retval;
>  }
>  
> +enum transaction_update_type {
> +	UPDATE_SHA1 = 0
> +};
> +
>  /**
>   * Information needed for a single ref update.  Set new_sha1 to the
>   * new value or to zero to delete the ref.  To check the old value
> @@ -3511,6 +3515,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>   * value or to zero to ensure the ref does not exist before update.
>   */
>  struct ref_update {
> +	enum transaction_update_type update_type;
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
>  	int flags; /* REF_NODEREF? */
> @@ -3571,12 +3576,14 @@ void transaction_free(struct transaction *transaction)
>  }
>  
>  static struct ref_update *add_update(struct transaction *transaction,
> -				     const char *refname)
> +				     const char *refname,
> +				     enum transaction_update_type update_type)
>  {
>  	size_t len = strlen(refname);
>  	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
>  
>  	strcpy((char *)update->refname, refname);
> +	update->update_type = update_type;
>  	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
>  	transaction->updates[transaction->nr++] = update;
>  	return update;
> @@ -3606,7 +3613,7 @@ int transaction_update_ref(struct transaction *transaction,
>  		return -1;
>  	}
>  
> -	update = add_update(transaction, refname);
> +	update = add_update(transaction, refname, UPDATE_SHA1);
>  	hashcpy(update->new_sha1, new_sha1);
>  	update->flags = flags;
>  	update->have_old = have_old;
> @@ -3684,13 +3691,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  
>  	assert(err);
>  
> -	for (i = 1; i < n; i++)
> +	for (i = 1; i < n; i++) {
> +		if (updates[i - 1]->update_type != UPDATE_SHA1 ||
> +		    updates[i]->update_type != UPDATE_SHA1)
> +			continue;
>  		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
>  			strbuf_addf(err,
>  				    "Multiple updates for ref '%s' not allowed.",
>  				    updates[i]->refname);
>  			return 1;
>  		}
> +	}
>  	return 0;
>  }
>  
> @@ -3722,13 +3733,17 @@ int transaction_commit(struct transaction *transaction,
>  		goto cleanup;
>  	}
>  
> -	/* Acquire all locks while verifying old values */
> +	/* Acquire all ref locks while verifying old values */
>  	for (i = 0; i < n; i++) {
>  		struct ref_update *update = updates[i];
>  		int flags = update->flags;
>  
> +		if (update->update_type != UPDATE_SHA1)
> +			continue;
> +
>  		if (is_null_sha1(update->new_sha1))
>  			flags |= REF_DELETING;
> +
>  		update->lock = lock_ref_sha1_basic(update->refname,
>  						   (update->have_old ?
>  						    update->old_sha1 :
> @@ -3750,6 +3765,8 @@ int transaction_commit(struct transaction *transaction,
>  	for (i = 0; i < n; i++) {
>  		struct ref_update *update = updates[i];
>  
> +		if (update->update_type != UPDATE_SHA1)
> +			continue;
>  		if (!is_null_sha1(update->new_sha1)) {
>  			if (write_ref_sha1(update->lock, update->new_sha1,
>  					   update->msg)) {
> @@ -3767,6 +3784,8 @@ int transaction_commit(struct transaction *transaction,
>  	for (i = 0; i < n; i++) {
>  		struct ref_update *update = updates[i];
>  
> +		if (update->update_type != UPDATE_SHA1)
> +			continue;
>  		if (update->lock) {
>  			if (delete_ref_loose(update->lock, update->type, err)) {
>  				ret = TRANSACTION_GENERIC_ERROR;
