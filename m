Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A3C433E2
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20566206C3
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbgFSTrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:47:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390375AbgFSTrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:47:52 -0400
Received: (qmail 5893 invoked by uid 109); 19 Jun 2020 19:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 19:47:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18549 invoked by uid 111); 19 Jun 2020 19:47:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 15:47:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 15:47:50 -0400
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with
 write_in_full
Message-ID: <20200619194750.GA722967@coredump.intra.peff.net>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
 <20200619150445.4380-2-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619150445.4380-2-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 11:04:43AM -0400, randall.s.becker@rogers.com wrote:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> The strbuf_write_fd method did not provide checks for buffers larger
> than MAX_IO_SIZE. Replacing with write_in_full ensures the entire
> buffer will always be written to disk or report an error and die.

This also fixes problems with EINTR, etc.

> -	strbuf_write_fd(&buffer, report);
> +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
> +		die(_("couldn't write report contents '%s' to file '%s'"),
> +			buffer.buf, report_path.buf);
> +	}

I agree with the other comment not to bother reporting the contents. But
it is worth using die_errno() so we can see what happened. I.e.:

  die_errno(_("unable to write to %s"), report_path.buf);

would match our usual messages, and you'd get:

  unable to write to foo.out: No space left on device

or similar.

-Peff
