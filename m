Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8544202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 04:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdJ3Ewr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 00:52:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53381 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751302AbdJ3Ewq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 00:52:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62D369555F;
        Mon, 30 Oct 2017 00:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8FhCBk5iFMv2viBI08ozzJ4ptTk=; b=x0Z3Td
        nfkn60c/QKQjwTTTId+2TeoK2Kn6rmFGh1LBozj1Ii3ANNGjxBl+L5HZm9fyH6nt
        5yIvD292qXmSZ/1f4AbI0aEgGzhTisFZs3oLzWQPWF0MlEFDAK8smq16VDlV1eMg
        aQRPYDz9SlQX4sRpHUQQXgueAz42Mf9ALauoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p5a4MjRqgZag5fAqk4vAE2RkvzjE80a3
        s3PfhmpjVe3Myn3nxMilVM9+sycuuU4ly8cAtmLRpHKwkSjAc2dnxnFQZbWO/aM7
        s/IhDav01lZjP1vQ8+w0zp4FUYnLoj34jjuRnrACs/tSso9doX2Rg2uOIfxH+wrm
        J5DGVPCqeLE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59BB59555E;
        Mon, 30 Oct 2017 00:52:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA8D89555D;
        Mon, 30 Oct 2017 00:52:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] files-backend: don't rewrite the `packed-refs` file unnecessarily
References: <cover.1509181545.git.mhagger@alum.mit.edu>
        <6004e1dea6af33cb41c523855757aa6b04b912bc.1509181545.git.mhagger@alum.mit.edu>
Date:   Mon, 30 Oct 2017 13:52:44 +0900
In-Reply-To: <6004e1dea6af33cb41c523855757aa6b04b912bc.1509181545.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 28 Oct 2017 11:16:02 +0200")
Message-ID: <xmqqzi895jab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BC2FC36-BD2E-11E7-A3B3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +int is_packed_transaction_needed(struct ref_store *ref_store,
> +				 struct ref_transaction *transaction)
> +{
> +	struct packed_ref_store *refs = packed_downcast(
> +			ref_store,
> +			REF_STORE_READ,
> +			"is_packed_transaction_needed");
> +	struct strbuf referent = STRBUF_INIT;
> +	size_t i;
> +	int ret;
> +
> +	if (!is_lock_file_locked(&refs->lock))
> +		BUG("is_packed_transaction_needed() called while unlocked");
> +
> +	/*
> +	 * We're only going to bother returning false for the common,
> +	 * trivial case that references are only being deleted, their
> +	 * old values are not being checked, and the old `packed-refs`
> +	 * file doesn't contain any of those reference(s). This gives
> +	 * false positives for some other cases that could
> +	 * theoretically be optimized away:

The way I understand "the old file does not contain these
references" part of the condition is "if there were any of these
refs, removing them from the loose ref storage may expose them,
which necessitates us to remove them from the packed-refs (and if
there is no loose ref for them, we do noeed to remove them from the
packed-refs)---so that definitely is not a no-op".

I was confused by the "is_noop?" version, especially about "do we
check the old value?" condition.  The above does not help me all
that much to reach the same level of understanding as I have for the
other condition; sorry.

Is the reason why we know we want to play safe when the caller wants
to check the old value because that could cause the transaction to
abort if it does not match?

Thanks.
