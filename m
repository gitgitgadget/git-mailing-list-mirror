Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF1020372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755566AbdJJAAd (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:00:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755461AbdJJAAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:00:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4559B1F46;
        Mon,  9 Oct 2017 20:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c0sVs6SOXIDI4koA38NSyVQWs50=; b=Mj6V0/
        Tyj0UmUoXCQFNCBNo1loA2lcjpdgiPYM5HSSdqZaYpFvlB1K/CrtA/EqzfO15OCz
        Mc6fawbiaW1Zv1hvLE3e3agxTiLKj5mcTBxHACUaey4X/LgNcWZ+OWRyXHQeLdNi
        uMQ60O93E8iJzyv69ncHLQzywyL+rgS9sLqBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EH80YtsiV3Y5vz710PGIm13sgnSKfpVE
        UCDmjiMyNDFwJojJMZdSEkvxvqoGdrmQJJ4h5mk8wRDG90zFIn6g1iRWe67IeNah
        ZNo+ooAat9D/It+3tGTVPRgPZFvC9tWg9+ttp3qel8ZGoducM0ouMe9+57thTRBW
        KFn4NLQru+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA883B1F45;
        Mon,  9 Oct 2017 20:00:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0824B1F1C;
        Mon,  9 Oct 2017 20:00:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] write_entry: fix leak when retrying delayed filter
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
        <20171009174824.tt5tpxdvcvzbyvnl@sigill.intra.peff.net>
Date:   Tue, 10 Oct 2017 09:00:09 +0900
In-Reply-To: <20171009174824.tt5tpxdvcvzbyvnl@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 9 Oct 2017 13:48:24 -0400")
Message-ID: <xmqq7ew3swhi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC7B8ECE-AD4D-11E7-96D3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When write_entry() retries a delayed filter request, we
> don't need to send the blob content to the filter again, and
> set the pointer to NULL. But doing so means we leak the
> contents we read earlier from read_blob_entry(). Let's make
> sure to free it before dropping the pointer.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  entry.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/entry.c b/entry.c
> index ab79f1f69c..637c5958b0 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -283,6 +283,7 @@ static int write_entry(struct cache_entry *ce,
>  			if (dco && dco->state != CE_NO_DELAY) {
>  				/* Do not send the blob in case of a retry. */
>  				if (dco->state == CE_RETRY) {
> +					free(new);
>  					new = NULL;
>  					size = 0;
>  				}

Looks good to me.  Thanks.
