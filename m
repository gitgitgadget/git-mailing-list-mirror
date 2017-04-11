Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D16420970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbdDKUF1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:05:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60293 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbdDKUFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:05:25 -0400
Received: (qmail 1655 invoked by uid 109); 11 Apr 2017 20:05:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 20:05:23 +0000
Received: (qmail 6603 invoked by uid 111); 11 Apr 2017 20:05:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 16:05:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 16:05:20 -0400
Date:   Tue, 11 Apr 2017 16:05:20 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two
 separate functions
Message-ID: <20170411200520.oivytvlzkdu7bfh5@sigill.intra.peff.net>
References: <20170407120354.17736-1-benpeart@microsoft.com>
 <20170407120354.17736-4-benpeart@microsoft.com>
 <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net>
 <FD58071A-4DC7-4AB7-8B6B-56B71E715144@gmail.com>
 <20170411193709.w5tz3i3vg5mnnhfe@sigill.intra.peff.net>
 <629B2192-FD64-422E-9361-C182303582DC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <629B2192-FD64-422E-9361-C182303582DC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 10:01:02PM +0200, Lars Schneider wrote:

> > If you initialize errno to 0 right before a syscall, then yes, you can
> > trust it without checking the return value of the syscall. I wouldn't
> > trust it before calling more complicated functions, though. Not even
> > xwrite(), which may see EINTR and keep going (which is OK for checking
> > for EPIPE, but not checking generally for errno values).
> 
> Should we remove all the errno checks here as we don't have any direct 
> "write" etc syscalls anyways then?

Yeah, you should be trusting the return value from the various
sub-functions. Usually you'd check "errno == EPIPE" only when you saw an
error return but you want to _ignore_ EPIPE. This is what
filter_buffer_or_fd() is doing.

But the code here is the opposite case. It definitely wants to treat
EPIPE as an error. But that should be happening already because any
EPIPE we get would come with an error-return from one of the
packet_write() functions.

So I would say that "err || errno == EPIPE" here can just become "err",
and ditto in apply_multi_file_filter().

-Peff
