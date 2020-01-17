Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED89C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F50D20842
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAQS6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:58:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:39038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726603AbgAQS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 13:58:37 -0500
Received: (qmail 12814 invoked by uid 109); 17 Jan 2020 18:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Jan 2020 18:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18777 invoked by uid 111); 17 Jan 2020 19:05:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2020 14:05:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jan 2020 13:58:36 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
Message-ID: <20200117185836.GA11358@coredump.intra.peff.net>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
 <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
 <20200113170417.GK32750@szeder.dev>
 <20200117143236.GA11737@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117143236.GA11737@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 03:32:36PM +0100, SZEDER Gábor wrote:

> On Mon, Jan 13, 2020 at 06:04:17PM +0100, SZEDER Gábor wrote:
> > and 'GIT_TEST_ADD_I_USE_BUILTIN=1 ./t3701-add-interactive.sh -r 39,49'
> > fails with:
> > 
> >   + test_must_fail force_color git add -p
> >   about to run diffFilter
> >   attempting to xwrite() 224 bytes to a fd with revents flags 0x4
> >   test_must_fail: died by signal 13: force_color git add -p
> > 
> > I don't understand why we get SIGPIPE right away instead of some error
> > that we can act upon (ECONNRESET?).
> 
> Doh', because it's a pipe, not a socket, that's why.  pipe(7):
> 
>   "If all file descriptors referring to the read end of a pipe have
>    been closed, then a write(2) will cause a SIGPIPE signal to be
>    generated for the calling process."
> 
> So ECONNRESET is definitely not the right error to set on POLLERR,
> though I'm still not sure what the right one would be (perhaps
> EPIPE?).

Yes, if SIGPIPE is ignored, then that write() would produce EPIPE. So if
you're trying to emulate it via POLLERR, that would be accurate. Of
course it could fail for _other_ reasons, and I don't think we'd know
what those are without actually calling write(). Practically speaking,
though, if we know it's a pipe with a valid descriptor then any error is
basically equivalent to EPIPE (we don't care how, but for whatever
reason we couldn't write to the other end).

-Peff
