From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Wed, 23 Jul 2014 16:07:12 -0700
Message-ID: <xmqq4my7brof.fsf@gitster.dls.corp.google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
	<1406135035-26441-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:07:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA5d8-0004Rx-4e
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970AbaGWXHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 19:07:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63193 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbaGWXHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 19:07:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F9E12AB5D;
	Wed, 23 Jul 2014 19:07:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tDhlmijgWicko/hOAluD2dxxRGU=; b=b6wVks
	NBaSqwBBGrLXi04jmgrH4AM1b8btdIUHCHGYtpgTQqKoLopAi1jDRGKEDVEDX3CI
	YaUVHMthOwaLfO0ADaQpwoPC2Vdu9QQ37fS0z//W7QWhp8vv6VsiMdNPtBd5FpGZ
	/n823a2WuT3boorZ2JLDVDDJs26CECSkvvXmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tROqpRGkGsNyxXK/tFC5EB+MFHWg8K6P
	B8rlKGYoHODgdhJRp9a6y3gdknkdvt8Jpm9bbFmrjrDyHJ6Z86Cl9wDQNb6TSSWb
	o/Otq7dXf23L6y6BtVIFOLeV6MR+oXt9klUoOI5lR9uTRBlobQULFzxlmUbHiwxt
	oszdPSlW9iE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 633DE2AB5C;
	Wed, 23 Jul 2014 19:07:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4BC462AB4E;
	Wed, 23 Jul 2014 19:07:14 -0400 (EDT)
In-Reply-To: <1406135035-26441-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 23 Jul 2014 10:03:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1595DDAC-12BE-11E4-BE4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254137>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 18 ++----------------
>  refs.h |  7 ++++---
>  2 files changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 6dcb920..8f2aa3a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3490,28 +3490,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> -		strbuf_addf(err, "Bad refname: %s", refname);
> -		return -1;
> -	}
> -
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

Makes sense, but at the same time makes me wonder why no code is
moved to ref_transaction_update() while removing code from here,
which would only mean that code in ref_transaction_update() was
added redundantly in the first place.

An ideal series would have had only "update" code in _update() when
the function is added, and later with a patch like this would lose
code from _create() while adding some code to _update(), I would
think.

Or if all the code in _update() was necessary from day one, then
perhaps this change should have been part of the same patch.

It's not a big deal either way, though.

Thanks.

>  int ref_transaction_delete(struct ref_transaction *transaction,
> diff --git a/refs.h b/refs.h
> index b0476c1..1c08cfd 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -276,9 +276,10 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
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
