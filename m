Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF6A1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 18:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbcI1SCx (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 14:02:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750726AbcI1SCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 14:02:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20E5240A9D;
        Wed, 28 Sep 2016 14:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iwEUZTtocDzd+Gyl9SUH8V/xjvo=; b=dT0hSk
        k6zolYjPO3dZito9V9JjbTmsXZSgRQDaURKQniEXoZKEIo8AlhZndM5YvJs/i4fs
        4X1ETv0sAJAv1VNp+uct8UpT8sFFBheosknsL2GG6g+Y3DbuMnVE9GLmQo1y8ump
        +iepbwlOQj5fqBuZRWVp4aTxF7EzHy4A7q7TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n+mf4w6vGXQ26/QbbiReTmti0jRPcURY
        oB7v8lhyh8WVzUnDWA/3VKadeAit8/NCx4PBY5Upp4jWbJiCkzYQ+Dve9jnIoSGV
        RqoXJJ/+kVEHT3rGkPJT5LutQ7hxpMuk738bmcxhMI84vfWGWdT7m3WfAdEL9IBt
        fmfHXYhwAyQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1885440A9C;
        Wed, 28 Sep 2016 14:02:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35AA540A9A;
        Wed, 28 Sep 2016 14:02:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        David Turner <dturner@twosigma.com>
Subject: Re: thoughts on error passing, was Re: [PATCH 2/2] fsck: handle bad trees like other errors
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
        <1474918365-10937-3-git-send-email-novalis@novalis.org>
        <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
        <1474989574.26902.7.camel@frank>
        <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
        <06b1a3bc-18dc-bd9e-4200-a2eedbec7b97@alum.mit.edu>
        <20160928085841.aoisson3fnuke47q@sigill.intra.peff.net>
Date:   Wed, 28 Sep 2016 11:02:27 -0700
In-Reply-To: <20160928085841.aoisson3fnuke47q@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 28 Sep 2016 04:58:41 -0400")
Message-ID: <xmqqh98zkimk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C168BF30-85A5-11E6-9D68-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  	if (!dont_change_ref) {
>  		struct ref_transaction *transaction;
> -		struct strbuf err = STRBUF_INIT;
> -
> -		transaction = ref_transaction_begin(&err);
> -		if (!transaction ||
> -		    ref_transaction_update(transaction, ref.buf,
> -					   sha1, forcing ? NULL : null_sha1,
> -					   0, msg, &err) ||
> -		    ref_transaction_commit(transaction, &err))
> -			die("%s", err.buf);
> +
> +		transaction = ref_transaction_begin(&error_die);
> +		ref_transaction_update(transaction, ref.buf,
> +				       sha1, forcing ? NULL : null_sha1,
> +				       0, msg, &error_die);
> +		ref_transaction_commit(transaction, &error_die);
>  		ref_transaction_free(transaction);
> -		strbuf_release(&err);
>  	}
>  
>  	if (real_ref && track)
>
> which is much shorter and to the point (it does rely on the called
> functions always calling report_error() and never just returning NULL or
> "-1", but that should be the already. If it isn't, we'd be printing
> "fatal: " with no message).

Yes but... grepping for die() got a lot harder, which may not be a
good thing.

I do like the flexibility such a mechanism offers, but
wrapping/hiding die in it is probably an example that the
flexibility went a bit too far.
