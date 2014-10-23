From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Thu, 23 Oct 2014 10:42:20 -0700
Message-ID: <xmqqy4s6smwz.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 19:42:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMPC-00039G-Bm
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 19:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbaJWRma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 13:42:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbaJWRm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 13:42:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D7E616C05;
	Thu, 23 Oct 2014 13:42:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOmpUS7D0IBGlUm4q2O6NK3emIA=; b=jQpqyu
	NBAdcITtLSfnhoK97Qhv9QM4cvraeVLFhDsJLwaemSlaXnIUZ/kwI2jJGB9ZoLeW
	wQGShJOilUUo09qT2srQDocT2Ouq0uM9RqWYSGQBqOv7oZWJkAVCchJSiSH4CrG5
	hUnTF0uxOHvIT4+wU74WsBwS1obj1Y51rKj54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SIJ29F8t4yLhlJ9CukeJEMlQP79Pv1E7
	2nI02cpWVmXgoZIqND45yrhpHRl6gwQyNoe2eJK5FxTM4GN1CTRNjgbBwUbSpCtW
	p1sdR5Z4923yLyZNXZYslithBi8+IjDZUCXn9MpcSpapKwhRRBw9w8c177B8J0co
	dwpwqlhJuAk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44FD816C04;
	Thu, 23 Oct 2014 13:42:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B205D16C02;
	Thu, 23 Oct 2014 13:42:21 -0400 (EDT)
In-Reply-To: <1413919462-3458-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 12:24:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F11B0B94-5ADB-11E4-B6D1-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> Subject: Re: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update

Missing colon after "refs.c"

> commit 03001144a015f81db5252005841bb78f57d62774 upstream.

Huh?

> The ref_transaction_update function can already be used to create refs by
> passing null_sha1 as the old_sha1 parameter. Simplify by replacing
> transaction_create with a thin wrapper.

Nice code reduction.

> Change-Id: I687dd47cc4f4e06766e8313b4fd1b07cd4a56c1a

Please don't leak local housekeeping details into the official
history.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  refs.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 0368ed4..ed0485e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  			   int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	struct ref_update *update;
> -
> -	assert(err);
> -
> -	if (transaction->state != REF_TRANSACTION_OPEN)
> -		die("BUG: create called for transaction that is not open");
> -
> -	if (!new_sha1 || is_null_sha1(new_sha1))
> -		die("BUG: create ref with null new_sha1");
> -
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> -		strbuf_addf(err, "refusing to create ref with bad name %s",
> -			    refname);
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
>  
>  int ref_transaction_delete(struct ref_transaction *transaction,
