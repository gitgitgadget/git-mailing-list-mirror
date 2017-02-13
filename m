Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8632F1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbdBMTOg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:14:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:54323 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdBMTOf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:14:35 -0500
Received: (qmail 29957 invoked by uid 109); 13 Feb 2017 19:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 19:14:35 +0000
Received: (qmail 19477 invoked by uid 111); 13 Feb 2017 19:14:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 14:14:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 14:14:33 -0500
Date:   Mon, 13 Feb 2017 14:14:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clean: use warning_errno() when appropriate
Message-ID: <20170213191433.muwhz7zem64p3rxr@sigill.intra.peff.net>
References: <20170213092702.10462-1-pclouds@gmail.com>
 <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwpcudjoh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 10:34:06AM -0800, Junio C Hamano wrote:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > All these warning() calls are preceded by a system call. Report the
> > actual error to help the user understand why we fail to remove
> > something.
> 
> I think this patch is probably correct in the current code, but I
> say this only after following what quote_path_relative() and
> relative_path() that is called from it.  These warnings are preceded
> by a call to a system library function, but it is not apparent that
> they are immediately preceded without anything else that could have
> failed in between.
> 
>     Side note.  There are many calls into strbuf API in these two
>     functions.  Any calls to xmalloc() and friends made by strbuf
>     functions may see ENOMEM from underlying malloc() and recover by
>     releasing cached resources, by which time the original errno is
>     unrecoverable.  So the above "probably correct" is not strictly
>     true.
> 
> If we care deeply enough that we want to reliably show the errno we
> got from the preceding call to a system library function even after
> whatever comes in between, I think you'd need the usual saved_errno
> trick.  Is that worth it?---I do not offhand have an opinion.

I wonder if xmalloc() should be the one doing the saved_errno trick.
After all, it has only two outcomes: we successfully allocated the
memory, or we called die().

And that would transitively make most of the strbuf calls errno-safe
(except for obvious syscall-related ones like strbuf_read_file). And in
turn that makes quote_path_relative() pretty safe (at least when writing
to a strbuf).

-Peff
