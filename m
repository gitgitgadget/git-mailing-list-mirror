Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2328020282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbdFWTqO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:46:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:51058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754781AbdFWTqN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:46:13 -0400
Received: (qmail 13790 invoked by uid 109); 23 Jun 2017 19:46:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 19:46:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18414 invoked by uid 111); 23 Jun 2017 19:46:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 15:46:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 15:46:10 -0400
Date:   Fri, 23 Jun 2017 15:46:10 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 22/29] commit_packed_refs(): use a staging file
 separate from the lockfile
Message-ID: <20170623194610.o2eyte4xmlsscrlz@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <d8fa8dec13eb095c0c39ef0de2ee8987d6bf9d77.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8fa8dec13eb095c0c39ef0de2ee8987d6bf9d77.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:40AM +0200, Michael Haggerty wrote:

> @@ -522,10 +529,16 @@ int lock_packed_refs(struct ref_store *ref_store, int flags)
>  		timeout_configured = 1;
>  	}
>  
> +	/*
> +	 * Note that we close the lockfile immediately because we
> +	 * don't write new content to it, but rather to a separate
> +	 * tempfile.
> +	 */
>  	if (hold_lock_file_for_update_timeout(
>  			    &refs->lock,
>  			    refs->path,
> -			    flags, timeout_value) < 0)
> +			    flags, timeout_value) < 0 ||
> +	    close_lock_file(&refs->lock))
>  		return -1;

I was wondering whether we'd catch a case which accidentally wrote to
the lockfile (instead of the new tempfile, but this close() is a good
safety check).

> -	if (commit_lock_file(&refs->lock)) {
> -		strbuf_addf(err, "error overwriting %s: %s",
> +	if (rename_tempfile(&refs->tempfile, refs->path)) {
> +		strbuf_addf(err, "error replacing %s: %s",
>  			    refs->path, strerror(errno));
>  		goto out;
>  	}

So our idea of committing now is the tempfile rename, and then...

> @@ -617,9 +640,10 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
>  	goto out;
>  
>  error:
> -	rollback_lock_file(&refs->lock);
> +	delete_tempfile(&refs->tempfile);
>  
>  out:
> +	rollback_lock_file(&refs->lock);

We always rollback the lockfile regardless, because committing it would
overwrite our new content with an empty file. There's no real safety
against somebody calling commit_lock_file() on it, but it also seems
like an uncommon error to make.

So this all looks good to me.

-Peff
