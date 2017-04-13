Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A9720960
	for <e@80x24.org>; Thu, 13 Apr 2017 23:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbdDMXLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 19:11:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51925 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752040AbdDMXLe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 19:11:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ED1D88012;
        Thu, 13 Apr 2017 19:11:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zc0VJjQuXOAwa7Ihm5Rlz4a/wk8=; b=MX0uVe
        icIiTEqLEyAFkRMr4hCbRIh8Y3f9B/xeRg2ZY5SlQoLNw9JvIVo4nAF0fl/Bn9de
        IeT86m7iyIe09yatXiufFYaReFakRv/grQl703QsPyT5oFdUxsn/uJpywyR48Mj9
        Ii1UZWOUBRlhCxzW4V3ntJv2SRWNzZ4KoU9TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e7fz+y+xxpI4dfkFwgxSQBaBjcHvbZgn
        +hdg21hNzug7+SjL1aNCShLrxYnDNK4W6bGlkNJuWHzAukPe733c0x+12/tvzDbl
        6VXxlHKzoW0hlfxtbB+KiQ8d5GR/+yflBioDWRbob8xNMbKEkVdfVkReedTEmcmh
        cI7unvnAb80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2633D88011;
        Thu, 13 Apr 2017 19:11:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9248E88010;
        Thu, 13 Apr 2017 19:11:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] unpack-trees: avoid duplicate ODB lookups during checkout
References: <20170413155852.4281-1-git@jeffhostetler.com>
        <20170413155852.4281-2-git@jeffhostetler.com>
Date:   Thu, 13 Apr 2017 16:11:31 -0700
In-Reply-To: <20170413155852.4281-2-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Thu, 13 Apr 2017 15:58:52 +0000")
Message-ID: <xmqqtw5roqcc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88901DCC-209E-11E7-B5D1-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> +	/*
> +	 * Fetch the tree from the ODB for each peer directory in the
> +	 * n commits.
> +	 *
> +	 * For 2- and 3-way traversals, we try to avoid hitting the
> +	 * ODB twice for the same OID.  This should yield a nice speed
> +	 * up in checkouts and merges when the commits are similar.
> +	 *
> +	 * We don't bother doing the full O(n^2) search for larger n,
> +	 * because wider traversals don't happen that often and we
> +	 * avoid the search setup.
> +	 *
> +	 * When 2 peer OIDs are the same, we just copy the tree
> +	 * descriptor data.  This implicitly borrows the buffer
> +	 * data from the earlier cell.

This "borrowing" made me worried, but it turns out that this is
perfectly OK.

fill_tree_descriptor() uses read_sha1_file() to give a tree_desc its
own copy of the tree object data, so the code that calls into the
tree traversal API is responsible for freeing the buffer returned
from fill_tree_descriptor().  The updated code avoids double freeing
by setting buf[i] to NULL for borrowing [i].

> +	 */
>  	for (i = 0; i < n; i++, dirmask >>= 1) {
> -		const unsigned char *sha1 = NULL;
> -		if (dirmask & 1)
> -			sha1 = names[i].oid->hash;
> -		buf[i] = fill_tree_descriptor(t+i, sha1);
> +		if (i > 0 && are_same_oid(&names[i], &names[i - 1])) {
> +			t[i] = t[i - 1];
> +			buf[i] = NULL;
> +		} else if (i > 1 && are_same_oid(&names[i], &names[i - 2])) {
> +			t[i] = t[i - 2];
> +			buf[i] = NULL;
> +		} else {
> +			const unsigned char *sha1 = NULL;
> +			if (dirmask & 1)
> +				sha1 = names[i].oid->hash;
> +			buf[i] = fill_tree_descriptor(t+i, sha1);
> +		}
>  	}
>  
>  	bottom = switch_cache_bottom(&newinfo);
