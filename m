From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Thu, 23 Oct 2014 10:43:04 -0700
Message-ID: <xmqqtx2usmvr.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:43:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMPo-0003SZ-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbaJWRnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:43:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbaJWRnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:43:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB9116C22;
	Thu, 23 Oct 2014 13:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6z0iUnJY1J5Bo8jkMN7osTyTOg=; b=hw/TnR
	46SJgSzSzy0JuE6HziwzQnBpw+uxz2aXB7t+hrBUs/SASUihlTW3Qm1l9SZZTR3x
	nsbx5gUyhJP+Ubfbb489mzGZ1++4TQ2ZJ2xR4Dj19IWUUR2uApB22nHWjOQ3hbAf
	pwq/4gIr5wLvfgsoORCrN09Fn5f4ZKPbKcx60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2GlR1V1UOD0V7cpO7gGzjOLWIDj6Q92
	xf4RiAtWskObN4IJ1gIqc0tlcJ/4veExVEQeJ+ICzwCwWf1uBTBlrg8kqOeF+mk6
	KItZd9dOrq5PqnVUN3uTt5o2MnuSbGg/cAjtl5zWd6bQd2zwiH/ZGV+xVzIBuAYX
	pY1RL3GAyE0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3E7016C21;
	Thu, 23 Oct 2014 13:43:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6879516C1F;
	Thu, 23 Oct 2014 13:43:05 -0400 (EDT)
In-Reply-To: <1413919462-3458-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 12:24:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B271E6A-5ADC-11E4-90AB-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> commit 0beeda259297c92d411ecc92fa508ec7cfd87cc5 upstream.
>
> Change-Id: I685291986e544a8dc14f94c73b6a7c6400acd9d2
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  refs.c | 22 ++--------------------
>  refs.h |  2 +-
>  2 files changed, 3 insertions(+), 21 deletions(-)

Nice code reduction.

>
> diff --git a/refs.c b/refs.c
> index ed0485e..c607ab7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3633,26 +3633,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>  			   int flags, int have_old, const char *msg,
>  			   struct strbuf *err)
>  {
> -	struct ref_update *update;
> -
> -	assert(err);
> -
> -	if (transaction->state != REF_TRANSACTION_OPEN)
> -		die("BUG: delete called for transaction that is not open");
> -
> -	if (have_old && !old_sha1)
> -		die("BUG: have_old is true but old_sha1 is NULL");
> -
> -	update = add_update(transaction, refname);
> -	update->flags = flags;
> -	update->have_old = have_old;
> -	if (have_old) {
> -		assert(!is_null_sha1(old_sha1));
> -		hashcpy(update->old_sha1, old_sha1);
> -	}
> -	if (msg)
> -		update->msg = xstrdup(msg);
> -	return 0;
> +	return ref_transaction_update(transaction, refname, null_sha1,
> +				      old_sha1, flags, have_old, msg, err);
>  }
>  
>  int update_ref(const char *action, const char *refname,
> diff --git a/refs.h b/refs.h
> index 2bc3556..7d675b7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -283,7 +283,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>  
>  /*
>   * Add a reference update to transaction.  new_sha1 is the value that
> - * the reference should have after the update, or zeros if it should
> + * the reference should have after the update, or null_sha1 if it should
>   * be deleted.  If have_old is true, then old_sha1 holds the value
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
