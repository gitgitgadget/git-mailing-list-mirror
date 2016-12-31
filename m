Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116DD1FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 06:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbcLaGcR (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 01:32:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:33485 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbcLaGcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 01:32:17 -0500
Received: (qmail 10850 invoked by uid 109); 31 Dec 2016 06:32:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 06:32:16 +0000
Received: (qmail 2127 invoked by uid 111); 31 Dec 2016 06:33:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 01:33:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 01:32:12 -0500
Date:   Sat, 31 Dec 2016 01:32:12 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 13/23] log_ref_setup(): pass the open file descriptor
 back to the caller
Message-ID: <20161231063211.tqsiafg3iahcuotz@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <ef2355e9d5ccaa53928c821530bae59f2b118013.1483153436.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef2355e9d5ccaa53928c821530bae59f2b118013.1483153436.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 04:12:53AM +0100, Michael Haggerty wrote:

> This function will most often be called by log_ref_write_1(), which
> wants to append to the reflog file. In that case, it is silly to close
> the file only for the caller to reopen it immediately. So, in the case
> that the file was opened, pass the open file descriptor back to the
> caller.

Sounds like a much saner interface.

>  /*
> - * Create a reflog for a ref.  If force_create = 0, the reflog will
> - * only be created for certain refs (those for which
> - * should_autocreate_reflog returns non-zero.  Otherwise, create it
> - * regardless of the ref name.  Fill in *err and return -1 on failure.
> + * Create a reflog for a ref. Store its path to *logfile. If
> + * force_create = 0, only create the reflog for certain refs (those
> + * for which should_autocreate_reflog returns non-zero). Otherwise,
> + * create it regardless of the reference name. If the logfile already
> + * existed or was created, return 0 and set *logfd to the file
> + * descriptor opened for appending to the file. If no logfile exists
> + * and we decided not to create one, return 0 and set *logfd to -1. On
> + * failure, fill in *err, set *logfd to -1, and return -1.
>   */
> -static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
> +static int log_ref_setup(const char *refname,
> +			 struct strbuf *logfile, int *logfd,
> +			 struct strbuf *err, int force_create)

The return value is always "0" or "-1". It seems like it would be
simpler to just return the descriptor instead of 0.

I guess that makes it hard to identify the case when we chose not to
create a descriptor. I wonder if more "normal" semantics would be:

  1. ret >= 0: file existed or was created, and ret is the descriptor

  2. ret < 0, err is empty: we chose not to create

  3. ret < 0, err is non-empty: a real error

I dunno. This may just be bikeshedding, and I can live with it either
way (especially because you documented it!).

-Peff
