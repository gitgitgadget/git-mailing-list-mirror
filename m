Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74552202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbdKATrf (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:47:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:43038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754971AbdKATre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:47:34 -0400
Received: (qmail 24510 invoked by uid 109); 1 Nov 2017 19:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 19:47:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14759 invoked by uid 111); 1 Nov 2017 19:47:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 15:47:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 15:47:32 -0400
Date:   Wed, 1 Nov 2017 15:47:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 10:54:21AM +0100, René Scharfe wrote:

> Reduce code duplication by extracting a function for rewriting an
> existing file.

These patches look like an improvement on their own, but I wonder if we
shouldn't just be using the existing write_file_buf() for this?

Compared to your new function:

> +static int rewrite_file(const char *path, const char *buf, size_t len)
> +{
> +	int rc = 0;
> +	int fd = open(path, O_WRONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s' for writing"), path);
> +	if (write_in_full(fd, buf, len) < 0)
> +		rc = error_errno(_("could not write to '%s'"), path);
> +	if (!rc && ftruncate(fd, len) < 0)
> +		rc = error_errno(_("could not truncate '%s'"), path);
> +	close(fd);
> +	return rc;
> +}

  - write_file_buf() uses O_TRUNC instead of ftruncate (but you end up
    there in your second patch)

  - it uses O_CREAT, which I think would be OK (we do not expect to
    create the file, but it would work fine when the file does exist).

  - it calls die() rather than returning an error. Looking at the
    callsites, I'm inclined to say that would be fine. Failing to write
    to the todo file is essentially a fatal error for sequencer code.

-Peff
