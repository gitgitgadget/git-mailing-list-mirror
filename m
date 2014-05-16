From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/31] refs.c: allow multiple reflog updates during a single transaction
Date: Fri, 16 May 2014 14:35:04 -0700
Message-ID: <xmqqppjd8l13.fsf@gitster.dls.corp.google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-10-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 23:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlPmg-0002gZ-5o
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 23:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbaEPVfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 17:35:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61534 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbaEPVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 17:35:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DEE914D99;
	Fri, 16 May 2014 17:35:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zbT1EIBzz3gKnwbcV7k1kbMobY8=; b=mVx56p
	kNnUMI/AiNEJtcxxY3OPRODmiMBhJdvOf3yucb0BUlOXaK23r8sI710Y8HKi3/F9
	yCZRMFa/wcmcZMZ0ce2wvggpw3IbBPovifLWRbr+xZV/HNZhuULM3psQasSKBdtP
	Ckq6aE/AfIqDKI56SAV3OSCT8ggXf/Y6SuJKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YAh5tf5BTLenNKPREVOp3h7lh5KirQc5
	V96kAd6uueUCaYS6NEup8AZyIoZ1oHNEwVQkm0sVTvuzZ1V+kCpbfIGjZXHDAXgG
	3/DhWcsa9XQIeYCDp0cpfQGc2TqEuahbaDVfyLQqkhZRtIlvR9OjneaqlX4qt2tY
	eGUOdd9V71g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84CF114D98;
	Fri, 16 May 2014 17:35:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 54DD014D8F;
	Fri, 16 May 2014 17:35:06 -0400 (EDT)
In-Reply-To: <1400105610-21194-10-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 14 May 2014 15:13:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F292F49A-DD41-11E3-BB84-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249421>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Allow to make multiple reflog updates to the same ref during a transaction.
> This means we only need to lock the reflog once, during the first update that
> touches the reflog, and that all further updates can just write the reflog
> entry since the reflog is already locked.
>
> This allows us to write code such as:
>
> t = transaction_begin()
> transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
> loop-over-somehting...
>    transaction_reflog_update(t, "foo", 0, <message>);
> transaction_commit(t)

OK, so you are now doing not just "refs" but also "reflogs", you
felt that "ref_transaction()" does not cover the latter.  Is that
the reason for the rename in the earlier step?

I am sort-of on the fence.

Calling the begin "ref_transaction_begin" and then calling the new
function "ref_transaction_log_update" would still allow us to
differentiate transactions on refs and reflogs, while allowing other
kinds of transactions that are not related to refs at all to employ
a mechanism that is different from the one that is used to implement
the transactions on refs and reflogs you are building here.

But I think I am OK with the generic "transaction-begin" now.
Having one mechanism for refs and reflogs, and then having another
completely different mechanism for other things, will not let us
coordinate between the two easily, so "allow transactions that are
not related to refs at all to be built on a different mechanism" may
not be a worthwhile goal to pursue in the first place.  Please
consider the question on the naming in the earlier one dropped.

>
> where we first truncate the reflog and then build the new content one line at a
> time.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index a3f60ad..e7ede03 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -37,6 +37,10 @@ static inline int bad_ref_char(int ch)
>   *  need to lock the loose ref during the transaction.
>   */
>  #define REF_ISPACKONLY	0x0200
> +/** Only the first reflog update needs to lock the reflog file. Further updates
> + *  just use the lock taken by the first update.
> + */

Style.

> @@ -3349,8 +3355,23 @@ int transaction_update_reflog(struct ref_transaction *transaction,
>  			      int flags)
>  {
>  	struct ref_update *update;
> +	int i;
>  
>  	update = add_update(transaction, refname, UPDATE_LOG);
> +	update->flags = flags;
> +	for (i = 0; i < transaction->nr - 1; i++) {
> +		if (transaction->updates[i]->update_type != UPDATE_LOG)
> +			continue;
> +		if (!strcmp(transaction->updates[i]->refname,
> +			    update->refname)) {
> +			update->flags |= UPDATE_REFLOG_NOLOCK;
> +			update->orig_update = transaction->updates[i];
> +			break;
> +		}
> +	}
> +	if (!(update->flags & UPDATE_REFLOG_NOLOCK))
> +	  update->reflog_lock = xcalloc(1, sizeof(struct lock_file));

So with two calls to transaction-update-reflog, we make two calls to
add-update, and each holds a separate lock?  If we write two entries
to record two updates of the same ref, would we still want to do so?

> +	/* Rollback any reflog files that are still open */
> +	for (i = 0; i < n; i++) {
> +		struct ref_update *update = updates[i];
> +
> +		if (update->update_type != UPDATE_LOG)
> +			continue;
> +		if (update->flags & UPDATE_REFLOG_NOLOCK)
> +			continue;
> +		if (update->reflog_fd == -1)
> +			continue;
> +		rollback_lock_file(update->reflog_lock);
> +	}
>  	transaction->status = ret ? REF_TRANSACTION_ERROR
>  	  : REF_TRANSACTION_CLOSED;
