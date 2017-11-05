Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB69202A0
	for <e@80x24.org>; Sun,  5 Nov 2017 02:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbdKECHD (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 22:07:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751508AbdKECHC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 22:07:02 -0400
Received: (qmail 14175 invoked by uid 109); 5 Nov 2017 02:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 05 Nov 2017 02:07:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11381 invoked by uid 111); 5 Nov 2017 02:07:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Nov 2017 22:07:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Nov 2017 22:07:00 -0400
Date:   Sat, 4 Nov 2017 22:07:00 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <20171104183643.akaazwswysphzuoq@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171104183643.akaazwswysphzuoq@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 04, 2017 at 07:36:43PM +0100, Simon Ruderich wrote:

> On Fri, Nov 03, 2017 at 03:13:10PM -0400, Jeff King wrote:
> > I think we've been gravitating towards error strbufs, which would make
> > it something like:
> 
> I like this approach to store the error in a separate variable
> and let the caller handle it. This provides proper error messages
> and is cleaner than printing the error on the error site (what
> error_errno does).
> 
> However I wouldn't use strbuf directly and instead add a new
> struct error which provides a small set of helper functions.
> Using a separate type also makes it clear to the reader that is
> not a normal string and is more extendable in the future.

Yes, I think what you've written here (and below) is quite close to the
error_context patches I linked elsewhere in the thread. In other
words, I think it's a sane approach.

> We could also store the error condition in the error struct and
> don't use the return value to indicate and error like this:
> 
>     void write_file_buf(const char *path, const char *buf, size_t len)
>     {
>             struct error err = ERROR_INIT;
>             write_file_buf_gently2(path, buf, len, &err);
>             if (err.error)
>                     error_die(&err);
>     }

I agree it might be nice for the error context to have a positive "there
was an error" flag. It's probably worth making it redundant with the
return code, though, so callers can use whichever style is most
convenient for them.

> > OTOH, if we went all-in on flexible error handling contexts, you could
> > imagine this function becoming:
> >
> >   void write_file_buf(const char *path, const char *buf, size_t len,
> >                       struct error_context *err)
> >   {
> > 	int fd = xopen(path, err, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> > 	if (fd < 0)
> > 		return -1;
> > 	if (write_in_full(fd, buf, len, err) < 0)
> > 		return -1;
> > 	if (xclose(fd, err) < 0)
> > 		return -1;
> > 	return 0;
> >   }
> 
> This looks interesting as well, but it misses the feature of
> custom error messages which is really useful.

Right, I didn't think that example through. The functions after the
open() don't have enough information to make a good message.

-Peff
