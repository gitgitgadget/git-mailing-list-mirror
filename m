From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/14] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Wed, 18 Jun 2014 13:34:41 -0700
Message-ID: <xmqqha3ihs7y.fsf@gitster.dls.corp.google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
	<1403111346-18466-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMZI-00052c-PO
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbaFRUet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:34:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62964 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbaFRUes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:34:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B57A31E60A;
	Wed, 18 Jun 2014 16:34:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8tkwj6Ycr/OPWoJvP4kK/9pYevk=; b=NFjn1T
	DjqZ1cpaNdk5X8S6stksxfjclxKY6lYIn1TOdP4I+K6FEfpi4op/zNK3WR1zwxWj
	BmkWxPDJHiTjJpBUcAfKU611H+AUJHDkBc6cyauyo3zE8JZD0M6dQ2C9hvaKQXRK
	LvCxCRxQwACHFSsCAHJ9BnHizOfYdRvyhIUco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X4k5XWUzLHYUZGvgKocsBqsyeA2BaD8S
	xTqHBcBydnnRJlOdMe1bVStcGc4GMe4x2elvFklSI5Awyyqx2UOlPBz6QCW+nIZk
	IsFYdI4AQadsdeQsuVa9taW29lv38M6nI8MDCrs2oJ7kaFShX7GIGOoI7j0M0wBb
	amEfidwi8kA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA93E1E609;
	Wed, 18 Jun 2014 16:34:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2C931E602;
	Wed, 18 Jun 2014 16:34:40 -0400 (EDT)
In-Reply-To: <1403111346-18466-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 18 Jun 2014 10:08:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F949D650-F727-11E3-9F5D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252062>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 13 ++-----------
>  refs.h |  7 ++++---
>  2 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index dfbf003..a9f91ab 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3487,23 +3487,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  			   int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	struct ref_update *update;
> -
>  	if (transaction->state != REF_TRANSACTION_OPEN)
>  		die("BUG: create called for transaction that is not open");
>  
>  	if (!new_sha1 || is_null_sha1(new_sha1))
>  		die("BUG: create ref with null new_sha1");
>  
> -	update = add_update(transaction, refname);
> -
> -	hashcpy(update->new_sha1, new_sha1);
> -	hashclr(update->old_sha1);
> -	update->flags = flags;
> -	update->have_old = 1;
> -	if (msg)
> -		update->msg = xstrdup(msg);
> -	return 0;
> +	return ref_transaction_update(transaction, refname, new_sha1,
> +				      null_sha1, flags, 1, msg, err);
>  }

Hmmm.

This probably logically belongs to the end of the previous series
and not necessarily tied to reflog transaction, no?

At the beginning of ref_transaction_update() there also is the same
guard on transaction->state, and having both feels somewhat iffy.
Of course it will give a wrong BUG message if we removed the check
from this function, so perhaps the code is OK as-is.

>  int ref_transaction_delete(struct ref_transaction *transaction,
> diff --git a/refs.h b/refs.h
> index db463d0..495740d 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -283,9 +283,10 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>  /*
>   * Add a reference update to transaction.  new_sha1 is the value that
>   * the reference should have after the update, or zeros if it should
> - * be deleted.  If have_old is true, then old_sha1 holds the value
> - * that the reference should have had before the update, or zeros if
> - * it must not have existed beforehand.
> + * be deleted.  If have_old is true and old_sha is not the null_sha1
> + * then the previous value of the ref must match or the update will fail.
> + * If have_old is true and old_sha1 is the null_sha1 then the ref must not
> + * already exist and a new ref will be created with new_sha1.
>   * Function returns 0 on success and non-zero on failure. A failure to update
>   * means that the transaction as a whole has failed and will need to be
>   * rolled back.
