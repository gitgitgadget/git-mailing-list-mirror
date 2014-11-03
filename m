From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/17] refs.c: add transaction support for replacing a reflog
Date: Mon, 03 Nov 2014 13:06:42 -0800
Message-ID: <xmqqk33cq9i5.fsf@gitster.dls.corp.google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
	<1415041339-18450-6-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 22:06:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOpz-00047O-BM
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 22:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaKCVGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 16:06:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752335AbaKCVGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 16:06:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16B2B1BCCD;
	Mon,  3 Nov 2014 16:06:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=531ItXosmTm/XDaF8eisf7khYQM=; b=pBEuaG
	/3qnY/wLDEOLkZyufwYu7BcfO9XGnoLoBR/IB13Q0JD0ZwabRtfJ4HgF40fACeFI
	FlZtglE5OoenLnpgmCgZOUFyDjrbK3N7BLest2blBNMjuxqUw5z2PSVcfA50lkgR
	9Hpig+eiNYwJ2krIlULizcZ10A4fEb8xKXErc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l3c+xkj7Ww+5l0YLZEFfgsiKq5RDqUiT
	FXhPkFHw+tAczvmDouxD1QkPJX40a3ibsJ4oJKaN/srTK0U/4n5r6UE8cWSfAerg
	nn+/u9FodZjCBo49iRVQRbG974c+O0SSGH7gMcrEh/NQEEJtjR9miX0QlkrtxQIF
	+vj9iGyCIRU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B60A1BCCC;
	Mon,  3 Nov 2014 16:06:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 660E61BCC4;
	Mon,  3 Nov 2014 16:06:44 -0500 (EST)
In-Reply-To: <1415041339-18450-6-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 3 Nov 2014 11:02:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 50C827CE-639D-11E4-8DE9-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> Add a new transaction function transaction_replace_reflog.
> This function takes a blob and replaces the new or existing reflog with the
> content of this blob. This will be used by rename_ref where we basically want
> to copy the existing blob as is.

Hmph, I find that "let's give backends an interface to tell them
that we want to use the whole reflog for ref A for ref B by
renaming" a sensible higher level abstraction, but forcing all the
backends to have the reflog data as a series of reflog entries as
series of text lines does not look like a sensible abstraction at
all to me.  Imagine a backend that uses a reflog_<refname> table (in
a database) to store reflog entries for that named ref---should it
give you a textual dump of the table and accept from you another
textual dump?  Wouldn't you rather tell it to rename A to B and have
it decide the best way to do so (namely, rename table reflog_A to
reflog_B in the case of such a hypothetical implementation)?

>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 38 +++++++++++++++++++++++++++++++++++++-
>  refs.h | 16 ++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index e9e321e..3d13624 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -35,6 +35,11 @@ static unsigned char refname_disposition[256] = {
>   * just use the lock taken by the first update.
>   */
>  #define UPDATE_REFLOG_NOLOCK 0x0200
> +/*
> + * This update is used to replace a new or existing reflog with new content
> + * held in update->new_reflog.
> + */
> +#define REFLOG_REPLACE 0x0400
>  
>  /*
>   * Try to read one refname component from the front of refname.
> @@ -3561,6 +3566,7 @@ struct ref_update {
>  	struct lock_file *reflog_lock;
>  	char *committer;
>  	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
> +	struct strbuf new_reflog;
>  
>  	const char refname[FLEX_ARRAY];
>  };
> @@ -3607,6 +3613,7 @@ void transaction_free(struct transaction *transaction)
>  		return;
>  
>  	for (i = 0; i < transaction->nr; i++) {
> +		strbuf_release(&transaction->updates[i]->new_reflog);
>  		free(transaction->updates[i]->msg);
>  		free(transaction->updates[i]->committer);
>  		free(transaction->updates[i]);
> @@ -3622,6 +3629,7 @@ static struct ref_update *add_update(struct transaction *transaction,
>  	size_t len = strlen(refname);
>  	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
>  
> +	strbuf_init(&update->new_reflog, 0);
>  	strcpy((char *)update->refname, refname);
>  	update->update_type = update_type;
>  	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
> @@ -3681,6 +3689,24 @@ int transaction_update_reflog(struct transaction *transaction,
>  	return 0;
>  }
>  
> +int transaction_replace_reflog(struct transaction *transaction,
> +			       const char *refname,
> +			       struct strbuf *buf,
> +			       struct strbuf *err)
> +{
> +	struct ref_update *update;
> +
> +	if (transaction->state != TRANSACTION_OPEN)
> +		die("BUG: replace_reflog called for transaction that is "
> +		    "not open");
> +
> +	update = add_update(transaction, refname, UPDATE_LOG);
> +	update->flags = REFLOG_REPLACE;
> +	strbuf_swap(&update->new_reflog, buf);
> +	update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
> +	return 0;
> +}
> +
>  int transaction_update_ref(struct transaction *transaction,
>  			   const char *refname,
>  			   const unsigned char *new_sha1,
> @@ -4012,7 +4038,7 @@ int transaction_commit(struct transaction *transaction,
>  			continue;
>  		if (update->reflog_fd == -1)
>  			continue;
> -		if (update->flags & REFLOG_TRUNCATE)
> +		if (update->flags & (REFLOG_TRUNCATE|REFLOG_REPLACE))
>  			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
>  				ftruncate(update->reflog_fd, 0)) {
>  				error("Could not truncate reflog: %s. %s",
> @@ -4030,6 +4056,16 @@ int transaction_commit(struct transaction *transaction,
>  			rollback_lock_file(update->reflog_lock);
>  			update->reflog_fd = -1;
>  		}
> +		if (update->flags & REFLOG_REPLACE)
> +			if (write_in_full(update->reflog_fd,
> +					  update->new_reflog.buf,
> +					  update->new_reflog.len) !=
> +			    update->new_reflog.len) {
> +				error("Could write to reflog: %s. %s",
> +				      update->refname, strerror(errno));
> +				rollback_lock_file(update->reflog_lock);
> +				update->reflog_fd = -1;
> +			}
>  	}
>  
>  	/* Commit all reflog files */
> diff --git a/refs.h b/refs.h
> index d174380..ec4965f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -354,6 +354,22 @@ int transaction_update_reflog(struct transaction *transaction,
>  			      struct strbuf *err);
>  
>  /*
> + * Replace the reflog with the content of buf.
> + * This function can be used when replacing the whole content of the reflog
> + * during for example a rename operation. For these cases we do not want
> + * to have to spend time processing and marshaling each entry individually
> + * if instead we can just pass one single blob to the transaction system and
> + * say "write this blob, it is the new reflog".
> + *
> + * When successful, this function will take over ownership of buf.
> + * Thus meaning that buf will become cleared from the callers view.
> + */
> +int transaction_replace_reflog(struct transaction *transaction,
> +			       const char *refname,
> +			       struct strbuf *buf,
> +			       struct strbuf *err);
> +
> +/*
>   * Commit all of the changes that have been queued in transaction, as
>   * atomically as possible.
>   *
