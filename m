Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98CD1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbcH2U2C (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:28:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63029 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753436AbcH2U2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:28:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D37237445;
        Mon, 29 Aug 2016 16:28:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mr1oeYGEChNRN7NIio8Do137Mmo=; b=GY8y0Q
        jjvAP8tNeVI4kKQuNu/cL/rZjsZzrgvq2h6mQ09mBVcgjQ2rklT+5H1fcK9B2GGT
        Nhsxn7ajGfSurxG3StgqSct7s/bEboric1fbWNIm8f5x+ENM2v/QPagL3YItcMYT
        5iKb+SB9zb7BLl3XdcgOMHvwOOrg6wuwCqnpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u6q6aPzF+KtcDBqgxOPVPvHWx2QFvMGB
        ILfiphe6b1Sb2Ety1GcuSI5+LhF5vZjFD3ZEVTlBxcDwnManJs9qqB2/fR/40c4+
        H5be6zbPZTMOAx36aP0HGl2jPTC/bRxGZfKSC8Um+PLOcwRmuh+VZKkKsqVHqhxq
        3a+rwKyxCes=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E13237444;
        Mon, 29 Aug 2016 16:28:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C134337442;
        Mon, 29 Aug 2016 16:27:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/14] sequencer: lib'ify write_message()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <6cc2e834ae9e595625fbbc6922613994098fd7dc.1472219214.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 13:27:57 -0700
In-Reply-To: <6cc2e834ae9e595625fbbc6922613994098fd7dc.1472219214.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 26 Aug 2016 15:47:17 +0200
        (CEST)")
Message-ID: <xmqqfupn9v76.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13E89438-6E27-11E6-ABC4-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of dying there, let the caller high up in the callchain
> notice the error and handle it (by dying, still).
>
> The only caller of write_message(), do_pick_commit() already checks
> the return value and passes it on to its callers, so its caller must
> be already prepared to handle error returns, and with this step, we
> make it notice an error return from this function.
> ...
> @@ -223,7 +226,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  
>  	read_cache();
>  	if (checkout_fast_forward(from, to, 1))
> -		exit(128); /* the callee should have complained already */
> +		return -1; /* the callee should have complained already */

This hunk does not seem to have anything to do with write_message()
conversion, other than that its only caller, do_pick_commit(), also
calls write_message().  checkout_fast_forward() itself can die when
it cannot write the index, though, so this hunk may deserve to be in
its own patch that teaches checkout_fast_forward() to instead return
an error if/when its caller desires.

With the updated message, the series has become far easier to review,
and the reordering them to sequencer-pick-revisions at the beginning
makes quite a lot of sense.
