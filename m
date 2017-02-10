Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B9E1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdBJVca (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:32:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:53243 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbdBJVc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:32:29 -0500
Received: (qmail 5669 invoked by uid 109); 10 Feb 2017 21:32:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 21:32:29 +0000
Received: (qmail 27535 invoked by uid 111); 10 Feb 2017 21:32:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 16:32:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 16:32:27 -0500
Date:   Fri, 10 Feb 2017 16:32:27 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] gc: ignore old gc.log files
Message-ID: <20170210213227.wviuppcqb42kk3ww@sigill.intra.peff.net>
References: <20170210205931.5348-1-dturner@twosigma.com>
 <20170210211510.zbustcl5ickfiqdy@sigill.intra.peff.net>
 <069b229470204235b7155b33da52421c@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <069b229470204235b7155b33da52421c@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 09:23:15PM +0000, David Turner wrote:

> > Speaking of stderr, I wonder if this function should be calling
> > fflush(stderr) before looking at the fstat result. There could be contents buffered
> > there that haven't been written out yet (not from child processes, but perhaps
> > ones written in this process itself).
> > Probably unlikely in practice, since stderr is typically unbuffered by default.
> 
> Process_log_file_at_exit calls fflush.  Will fix the other.

Ah, good. That makes sense, since we might deadlock if we do it in a
signal handler. Perhaps that is a reason not to use stderr here again
(though if we want to be that careful, a new fdopen() call is also a bad
idea, as we can deadlock over the malloc() lock; you'd have to snprintf
to a small buffer and dump it with write()).

-Peff
