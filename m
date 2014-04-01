From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 24/27] ref_transaction_commit(): Introduce temporary variables
Date: Tue, 01 Apr 2014 12:26:25 -0700
Message-ID: <xmqqy4zozw9q.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-25-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4Ko-0002cR-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbaDAT0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbaDAT02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:26:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D3F790CA;
	Tue,  1 Apr 2014 15:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AnjdQENXlY7XR+Pvxr/fJYu34pI=; b=f56PL8
	yljIcUtf2MmN00MRdoaDjfOrQiP5Fg+vAbSeWjC7vTAGvjjBJp3abZSQLJBBJ4aT
	8QfYeIepOKgPDVqxlMjHuuz5l5fggqQEBz1ki0SFkRQkeT7EYHKFY8evNwW8tNPv
	aOiD1tbUuSrKFJXX0mSEMnu3vU7XXgIIfrOV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OqVS4ohMjRkJP4zfkijzPGjs3/TUI4e4
	8oGKZSo2Ueb1SRbBhXZgO/6+kJsI7HFDcITs9Ings/C2x2l1DQSMV75Fo9c1vnMI
	t/3c8lIiKHNagjLLW2AYWylFMe07GQ6+MN2ehmAyZhR4yRVxJWribaZLHBhOF9Tr
	D6ln1dr51As=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB4D5790C9;
	Tue,  1 Apr 2014 15:26:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69CFA790C5;
	Tue,  1 Apr 2014 15:26:26 -0400 (EDT)
In-Reply-To: <1395683820-17304-25-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84989F76-B9D3-11E3-874C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245636>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Use temporary variables in the for-loop blocks to simplify expressions
> in the rest of the loop.

Shouldn't the summary of the change "simplify expressions"?  Use of
temporary variables is a means to the end.  If you have enough room
to say "achieve X by doing Y", please do so; otherwise "achieve X"
is more important part than "do Y".

Other than that, this looks good.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 2b80f6d..d51566c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3432,10 +3432,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  	/* Acquire all locks while verifying old values */
>  	for (i = 0; i < n; i++) {
> -		locks[i] = update_ref_lock(updates[i]->refname,
> -					   (updates[i]->have_old ?
> -					    updates[i]->old_sha1 : NULL),
> -					   updates[i]->flags,
> +		struct ref_update *update = updates[i];
> +
> +		locks[i] = update_ref_lock(update->refname,
> +					   (update->have_old ?
> +					    update->old_sha1 : NULL),
> +					   update->flags,
>  					   &types[i], onerr);
>  		if (!locks[i]) {
>  			ret = 1;
> @@ -3444,16 +3446,19 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	}
>  
>  	/* Perform updates first so live commits remain referenced */
> -	for (i = 0; i < n; i++)
> -		if (!is_null_sha1(updates[i]->new_sha1)) {
> +	for (i = 0; i < n; i++) {
> +		struct ref_update *update = updates[i];
> +
> +		if (!is_null_sha1(update->new_sha1)) {
>  			ret = update_ref_write(msg,
> -					       updates[i]->refname,
> -					       updates[i]->new_sha1,
> +					       update->refname,
> +					       update->new_sha1,
>  					       locks[i], onerr);
>  			locks[i] = NULL; /* freed by update_ref_write */
>  			if (ret)
>  				goto cleanup;
>  		}
> +	}
>  
>  	/* Perform deletes now that updates are safely completed */
>  	for (i = 0; i < n; i++)
