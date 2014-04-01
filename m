From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 23/27] struct ref_update: Store refname as a FLEX_ARRAY.
Date: Tue, 01 Apr 2014 12:54:52 -0700
Message-ID: <xmqqd2h0zuyb.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-24-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:55:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4lw-0001Ax-IR
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbaDATy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbaDATyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01183790BF;
	Tue,  1 Apr 2014 15:54:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQwnQL18PNX0Kw1OrXgXO6nrSJg=; b=xtNzbT
	BESGZOWYA0hqygU83JOMEN6fK7OgOyGHUHZVqshE+p6nvNUfMq553GBB6qZ8pXwe
	1br/AX09JyuHd5ZAYGMPu7x3FBEpkriy11Lsk28RLbyWCsC8TALWadcG1l5WN/gQ
	Clghdb9sb196RqPljTll8RqJ8JT9wnv5vi5uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1/M7M0xeD6PIzAfknZ23Yb6J+Ew87Jx
	kKL8O0ZYFikEygpzjzvX0pguM0WGitgPljO8R/1Iz10f+0GqHtD1oO/FmqPHPaSN
	tLemjf0h5/6382Dgn/tt4ldVNSTqs4z3Qg8f9lvy14HYIPX2benl7RLrX5+hGL+t
	vZ6HO4ndw1k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2805790BD;
	Tue,  1 Apr 2014 15:54:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD96C790BC;
	Tue,  1 Apr 2014 15:54:53 -0400 (EDT)
In-Reply-To: <1395683820-17304-24-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E556F8C-B9D7-11E3-B470-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245644>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d72d0ab..2b80f6d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3274,11 +3274,11 @@ static int update_ref_write(const char *action, const char *refname,
>   * value or to zero to ensure the ref does not exist before update.
>   */
>  struct ref_update {
> -	const char *refname;
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
>  	int flags; /* REF_NODEREF? */
>  	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
> +	const char refname[FLEX_ARRAY];
>  };

Yeah, as we no longer borrow a pointer but make our own copy since
the earlier patch in the series, this perfectly makes sense.

>  
>  /*
> @@ -3301,12 +3301,8 @@ static void ref_transaction_free(struct ref_transaction *transaction)
>  {
>  	int i;
>  
> -	for (i = 0; i < transaction->nr; i++) {
> -		struct ref_update *update = transaction->updates[i];
> -
> -		free((char *)update->refname);
> -		free(update);
> -	}
> +	for (i = 0; i < transaction->nr; i++)
> +		free(transaction->updates[i]);
>  
>  	free(transaction->updates);
>  	free(transaction);
> @@ -3320,9 +3316,10 @@ void ref_transaction_rollback(struct ref_transaction *transaction)
>  static struct ref_update *add_update(struct ref_transaction *transaction,
>  				     const char *refname)
>  {
> -	struct ref_update *update = xcalloc(1, sizeof(*update));
> +	size_t len = strlen(refname);
> +	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
>  
> -	update->refname = xstrdup(refname);
> +	strcpy((char *)update->refname, refname);
>  	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
>  	transaction->updates[transaction->nr++] = update;
>  	return update;
