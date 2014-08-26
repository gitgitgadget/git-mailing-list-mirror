From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/23] refs-be-files.c: add a backend method structure with transaction functions
Date: Tue, 26 Aug 2014 14:38:42 -0700
Message-ID: <xmqq8umbgcd9.fsf@gitster.dls.corp.google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
	<1408465847-30384-20-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMOS9-0005Er-5q
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 23:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbaHZVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 17:38:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53071 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbaHZViw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 17:38:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2AFB3440F;
	Tue, 26 Aug 2014 17:38:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0vyVfPRDvRJJY1m8vX89sLEVGvc=; b=sHk0ws
	ebkyPVJyM7h6FqKcNQwdyV3+tthaaRUvY7U2YqvtR05eU8ZjzYStS7ZtYaNPe/8F
	Doo30IrQ6VIPcjTkVb1vjQhaY4ral8jcMQDbBWQTLSnjhOP2p+i+dBbPQmR0GlpM
	0OsY8ZTBd7rRhhuRHGlP12WAHRODlOdfjAwbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSMVbX/mY2PX3M1fjJlRh+tBNVZKDcCn
	7dp/MAaPpiko4GHLrJBujkRYbo3LdCx6E3safmTSc9pAA1t9NRKJnAPMVVVKMU4G
	ycb11dSx+UTH0IJE425U8v8IJ8JMZyilQ0j61eGI/zpHJZLGk6qKtZugnSABZMc4
	xyGfXr7avYo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B68C73440E;
	Tue, 26 Aug 2014 17:38:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E3A4334406;
	Tue, 26 Aug 2014 17:38:43 -0400 (EDT)
In-Reply-To: <1408465847-30384-20-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 19 Aug 2014 09:30:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5A66A1DA-2D69-11E4-9081-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255947>

Ronnie Sahlberg <sahlberg@google.com> writes:

> diff --git a/refs-be-files.c b/refs-be-files.c
> index e58a7e1..27eafd0 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> ...
> +struct ref_be refs_files = {
> +	files_transaction_begin,
> +	files_transaction_update_sha1,
> +	files_transaction_create_sha1,
> +	files_transaction_delete_sha1,
> +	files_transaction_update_reflog,
> +	files_transaction_commit,
> +	files_transaction_free,
> +};
> +
> +struct ref_be *refs = &refs_files;

> diff --git a/refs.c b/refs.c
> index 6b434ad..b8c942f 100644
> --- a/refs.c
> +++ b/refs.c
> ...
> +void transaction_free(struct ref_transaction *transaction)
> +{
> +	return refs->transaction_free(transaction);
> +}
> diff --git a/refs.h b/refs.h
> index a14fc5d..4b669f5 100644
> --- a/refs.h
> +++ b/refs.h
> ...
> +struct ref_be {
> +	transaction_begin_fn transaction_begin;
> +	transaction_update_sha1_fn transaction_update_sha1;
> +	transaction_create_sha1_fn transaction_create_sha1;
> +	transaction_delete_sha1_fn transaction_delete_sha1;
> +	transaction_update_reflog_fn transaction_update_reflog;
> +	transaction_commit_fn transaction_commit;
> +	transaction_free_fn transaction_free;
> +};
> +
> +extern struct ref_be *refs;
> +
>  #endif /* REFS_H */

The overall structure is certainly nice, but this means you only can
LINK with one backend.  Is that what we really want?

I would have expected something like this:

  * In refs.c, there is a "static struct ref_be *the_refs_backend"
    that points at the chosen singleton backend;

  * Upon start-up, set_refs_backend() function that is exported from
    refs.c can be used to set the_refs_backend;

  * Each refs-be-frotz.c will export "struct ref_be refs_frotz" (or
    perhaps "struct refs_be refs_be_frotz") to the outside world, so
    that the start-up code can call set_refs_backend() with it.

  * It is probably sensible to keep the_refs_backend default to
    &refs_be_files.
