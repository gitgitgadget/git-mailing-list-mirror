From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] receive-pack.c: use a single ref_transaction for atomic pushes
Date: Mon, 15 Dec 2014 13:37:37 -0800
Message-ID: <xmqqiohcd272.fsf@gitster.dls.corp.google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
	<1418673368-20785-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0dKr-0007us-3J
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 22:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbaLOVhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 16:37:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbaLOVhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 16:37:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B085127A90;
	Mon, 15 Dec 2014 16:37:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SeExVS6Po4aR7bpf0aXiCTqaADE=; b=cr+9rv
	4w/DvZBiY1Tw4mX6BDwS6C0iSxE9Y/svOV1T3GW4UPdX4/vPixgn9np8aOKq5tcO
	i1rrU3FH0AvKxn7SZ5Aoz9Vgt/xpWHoJWLJRR87CMDwc/KCyEEqMxTvtfvBLdB64
	Z0INM6yldf6vmXBG4e9OFCarYkh+/Q6gSDX8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l7VsfR8xgDECbn6UEqHUafs7qS8IRjHU
	V9PzVyrH9cpejK0aaRZ1+09Dels1Ktgijvj6DuPzXMDDs9bXn758zUyYmH+KzU58
	J5MTdMvRP3BPfB3gxvwqlKY2r/zp1jWsoXeD/UEZjKLxXfbReiI5rYTqG10FygRc
	T11vxJmA/sg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A70CE27A8F;
	Mon, 15 Dec 2014 16:37:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE0C527A8E;
	Mon, 15 Dec 2014 16:37:38 -0500 (EST)
In-Reply-To: <1418673368-20785-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 11:56:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 978947E4-84A2-11E4-B1D2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261424>

Stefan Beller <sbeller@google.com> writes:

> @@ -832,34 +834,56 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  				cmd->did_not_exist = 1;
>  			}
>  		}
> -		if (delete_ref(namespaced_name, old_sha1, 0)) {
> -			rp_error("failed to delete %s", name);
> -			return "failed to delete";
> +		if (!use_atomic_push) {
> +			if (delete_ref(namespaced_name, old_sha1, 0)) {
> +				rp_error("failed to delete %s", name);
> +				return "failed to delete";
> +			}
> +		} else {
> +			if (ref_transaction_delete(transaction,
> +						   namespaced_name,
> +						   old_sha1,
> +						   0, old_sha1 != NULL,
> +						   "push", &err)) {
> +				rp_error("%s", err.buf);
> +				strbuf_release(&err);
> +				return "failed to delete";
> +			}

Doesn't the asymmetry between the above (if transaction is there,
use it, otherwise call delete_ref() which conceptually has its sole
operation inside a single transaction by itself) and below (if
transaction is not there, create it and do its thing, and close the
transaction if we created it) bother you?

The above look much simpler, and if it does not switch on
use_atomic_push but on the presense of transaction, it would have
been even better, i.e.

	if (transaction
            ? ref_transaction_delete(transaction, ...)
            : delete_ref(...)) {
		error(...);
                return "failed to delete";
	}

I think it makes the code harder to read and maintain if you forced
a caller of the ref API that happen to touch only a single ref to
make three calls to

	ref_transaction_begin();
        ref_transaction_do_one_thing();
        ref_transaction_commit();

instead of making a single call to a simple wrapper

	ref_do_one_thing();

I think that I saw Michael make a similar observation in a near-by
thread.

Even if you insist using transactions explicitly in the user of the
ref API, I think a better code organization is possible in this
particular codepath.  Because execute_commands() has the loop over
all the proposed updates, why should the update() even need to know
how to open a new transaction and when?  In other words, can't the
code be more like this?

	static update(transaction, ...)
        {
		/* do my thing in the transaction given to me */
                compute what kind of update is needed;
                switch (kind) {
		case delete:
			ref_transaction_delete(transaction, ...);
			break;
		case update:
			ref_transaction_update(transaction, ...);
			break;
		...
		}
	}

	execute_commands(...)
        {
		if (atomic)
                	transaction = ref_transaction_begin(...);
        	for (cmd = commands; cmd; cmd = cmd->next) {
			if (!atomic)        	
                        	transaction = ref_transaction_begin(...);
			update(transaction, ...);
			if (!atomic)
                        	ref_transaction_commit(transaction);
		}
		if (atomic)
                       	ref_transaction_commit(transaction);
	}

That is, update() assumes it is always in _some_ transaction, and
execute_commands(), which is what drives multi-ref updates, knows
if it wants its repeated calls to update() to be in a single
transaction or separate transactions.
