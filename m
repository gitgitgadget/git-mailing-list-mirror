From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Fri, 29 Apr 2016 01:19:03 -0700
Message-ID: <xmqq4mak3k08.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	<xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
	<1461788637.11504.3.camel@twopensource.com>
	<xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
	<xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
	<5723059C.5080406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 10:19:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw3eD-0007fQ-He
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 10:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbcD2IT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 04:19:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750925AbcD2ITH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 04:19:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A8B8E103FC;
	Fri, 29 Apr 2016 04:19:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AbFWlD3WWoGQnHNNGSJFQvs/Ij8=; b=hjwgvR
	1odkLJii6njDl47UXtgnGmoC1SjT9ftkv8+kNObO6DVJvFa43G0cG8V5XVkmXJrG
	gfsspYPV2hZfZ/5HF1mUpMJkVGosg2B8/b8QiHxyRRx5VHdbVD2EBs4QYlIgkS59
	8Pp0J6LWCwO+sB0P2lR3ke4tA0LKuq3u0MHgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AQZqEv4JeWu5N3rrwcVq6EJrrU7xH0Uc
	b1XdUQKKTD+oJ1ZXVOLOXXmM25OFFDUtvgwZG5mDwF/2TYJO9xal0wGWpireHHVw
	RBzwGe25PU9IBx9+8IIB6Z40Ue4XdmNgVrP6HvkioXyW5dPkzSaqcv/gcnKMfztu
	dfBcNBqMhb4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98D68103FB;
	Fri, 29 Apr 2016 04:19:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1A2D103FA;
	Fri, 29 Apr 2016 04:19:04 -0400 (EDT)
In-Reply-To: <5723059C.5080406@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 29 Apr 2016 08:56:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 096A8948-0DE3-11E6-9DE3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292979>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> But I think it would be cleaner to achieve that goal with the following
> change:
>
> diff --git a/refs.c b/refs.c
> index 5dc2473..1d4c12a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -790,8 +790,10 @@ int ref_transaction_update(struct ref_transaction
> *transaction,
>  	if (transaction->state != REF_TRANSACTION_OPEN)
>  		die("BUG: update called for transaction that is not open");
>
> -	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
> -		die("BUG: REF_ISPRUNING set without REF_NODEREF");
> +	if (flags & REF_ISPRUNING) {
> +		/* Pruning is always non-recursive */
> +		flags |= REF_NODEREF;
> +	}
>
>  	if (new_sha1 && !is_null_sha1(new_sha1) &&
>  	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8fcbd7d..9faf17c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2116,7 +2116,7 @@ static void prune_ref(struct ref_to_prune *r)
>  	transaction = ref_transaction_begin(&err);
>  	if (!transaction ||
>  	    ref_transaction_delete(transaction, r->name, r->sha1,
> -				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
> +				   REF_ISPRUNING, NULL, &err) ||
>  	    ref_transaction_commit(transaction, &err)) {
>  		ref_transaction_free(transaction);
>  		error("%s", err.buf);
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 37a1a37..704eea7 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -15,7 +15,7 @@
>
>  /*
>   * Used as a flag in ref_update::flags when a loose ref is being
> - * pruned.
> + * pruned. This flag implies REF_NODEREF.
>   */
>  #define REF_ISPRUNING	0x04
>
>
> Note that patch "add_update(): initialize the whole ref_update" should
> then be adjusted to do the flag-tweak in the add_update() function.
> ...
> If there are no objections, I will implement these changes in v2.

One worrysome point the above approach leaves is that nothing
guarantees that nobody in the codepath from the callsite of
ref-transaction-delete to ref-transaction-update looks at the flag
and acts differently depending on REF_NODEREF bit.  During that
time, REF_ISPRUNING call would not trigger (flag & REF_NODEREF)
check, because "pruning implies no-deref" is done only after you
reach transaction-update (i.e. the code you added in the first
hunk), but any code after that "implie no-deref" happens will see
REF_NODEREF bit in the flag word.

As long as you can add some mechanism to make that a non-issue, I am
fine with that approach.

Thanks.
