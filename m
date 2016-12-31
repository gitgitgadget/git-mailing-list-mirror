Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE971FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 06:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbcLaG0N (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 01:26:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:33478 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbcLaG0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 01:26:12 -0500
Received: (qmail 10379 invoked by uid 109); 31 Dec 2016 06:26:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 06:26:11 +0000
Received: (qmail 2100 invoked by uid 111); 31 Dec 2016 06:26:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 01:26:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 01:26:07 -0500
Date:   Sat, 31 Dec 2016 01:26:07 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 11/23] log_ref_setup(): separate code for create vs
 non-create
Message-ID: <20161231062607.uxftwujophv37ymb@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 04:12:51AM +0100, Michael Haggerty wrote:

> +	} else {
> +		logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
>  		if (logfd < 0) {
> -			strbuf_addf(err, "unable to append to '%s': %s",
> -				    logfile->buf, strerror(errno));
> -			return -1;
> +			if (errno == ENOENT || errno == EISDIR) {
> +				/*
> +				 * The logfile doesn't already exist,
> +				 * but that is not an error; it only
> +				 * means that we won't write log
> +				 * entries to it.
> +				 */
> +			} else {
> +				strbuf_addf(err, "unable to append to '%s': %s",
> +					    logfile->buf, strerror(errno));
> +				return -1;
> +			}
>  		}
>  	}
>  
> -	adjust_shared_perm(logfile->buf);
> -	close(logfd);
> +	if (logfd >= 0) {
> +		adjust_shared_perm(logfile->buf);
> +		close(logfd);
> +	}
> +

Hmm. I would have thought in the existing-logfile case that we would not
need to adjust_shared_perm(). But maybe we just do it anyway to pick up
potentially-changed config.

I also had to double-take at this close(). Aren't we calling this
function so we can actually write to the log? But I skipped ahead in
your series and see you address that confusion. :)

-Peff
