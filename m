Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77251F404
	for <e@80x24.org>; Wed,  7 Feb 2018 14:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeBGOmy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 09:42:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:43692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754026AbeBGOmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 09:42:53 -0500
Received: (qmail 11912 invoked by uid 109); 7 Feb 2018 14:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 14:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30610 invoked by uid 111); 7 Feb 2018 14:43:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 09:43:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 09:42:51 -0500
Date:   Wed, 7 Feb 2018 09:42:51 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Mathias Rav <m@git.strova.dk>
Subject: Re: [PATCH] files-backend: unlock packed store only if locked
Message-ID: <20180207144251.GB27420@sigill.intra.peff.net>
References: <20180206203615.68504-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180206203615.68504-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 12:36:15PM -0800, Jonathan Tan wrote:

> In commit 42c7f7ff9685 ("commit_packed_refs(): remove call to
> `packed_refs_unlock()`", 2017-06-23), a call to packed_refs_unlock() was
> added to files_initial_transaction_commit() in order to compensate for
> removing that call from commit_packed_refs(). However, that call was
> added in the cleanup section, which is run even if the packed_ref_store
> was never locked (which happens if an error occurs earlier in the
> function).
> 
> Create a new cleanup goto target which runs packed_refs_unlock(), and
> ensure that only goto statements after a successful invocation of
> packed_refs_lock() jump there.

The explanation and patch look good to me.

But this all seemed strangely familiar... I think this is the same bug
as:

  https://public-inbox.org/git/20180118143841.1a4c674d@novascotia/

which is queued as mr/packed-ref-store-fix. It's listed as "will merge
to next" in the "what's cooking" from Jan 31st.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f75d960e1..89bc5584a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2931,13 +2931,14 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
>  
>  	if (initial_ref_transaction_commit(packed_transaction, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
> -		goto cleanup;
> +		goto locked_cleanup;
>  	}
>  
> +locked_cleanup:
> +	packed_refs_unlock(refs->packed_ref_store);
>  cleanup:
>  	if (packed_transaction)
>  		ref_transaction_free(packed_transaction);
> -	packed_refs_unlock(refs->packed_ref_store);

I actually like this double-label a bit more than what is queued on
mr/packed-ref-store-fix, though I am OK with either solution.

-Peff
