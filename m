Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D01201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbdEQNUB (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:20:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753543AbdEQNUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:20:01 -0400
Received: (qmail 5119 invoked by uid 109); 17 May 2017 13:20:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:20:01 +0000
Received: (qmail 9464 invoked by uid 111); 17 May 2017 13:20:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:20:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:19:58 -0400
Date:   Wed, 17 May 2017 09:19:58 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 11/23] files_transaction_cleanup(): new helper function
Message-ID: <20170517131958.nxb5ol3wrtwyskss@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:34PM +0200, Michael Haggerty wrote:

> Extract function from `files_transaction_commit()`. It will soon have
> another caller.
> [...]
> @@ -2868,10 +2889,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
>  	if (transaction->state != REF_TRANSACTION_OPEN)
>  		die("BUG: commit called for transaction that is not open");
>  
> -	if (!transaction->nr) {
> -		transaction->state = REF_TRANSACTION_CLOSED;
> -		return 0;
> -	}
> +	if (!transaction->nr)
> +		goto cleanup;

This is slightly more than it says on the tin. I guess the reason is
that the cleanup function is going to learn about more than just
iterating over the transaction, and we'll want to trigger it even for
empty transactions.

-Peff
