Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559DE1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757283AbcK3XcI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:32:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:49350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757153AbcK3XcH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:32:07 -0500
Received: (qmail 24917 invoked by uid 109); 30 Nov 2016 23:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:32:07 +0000
Received: (qmail 26827 invoked by uid 111); 30 Nov 2016 23:32:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 18:32:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 18:32:04 -0500
Date:   Wed, 30 Nov 2016 18:32:04 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161130232823.GA192901@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 03:28:23PM -0800, Brandon Williams wrote:

> So I couldn't find a race condition in the code.  I tracked the problem
> to grep_source_load_file which attempts to run lstat on the file so that
> it can read it into a buffer.  The lstat call fails with ENOENT (which
> conveniently is skipped by the if statement which calls error_errno).  So
> for some reason the file cannot be found and read into memory resulting
> in nothing being grep'ed for that particular file (since the buffer is
> NULL).

That's definitely weird. Is it possible that any of the underlying calls
from another thread are using chdir()? I think realpath() make do that
behind the scenes, and there may be others.

A full strace from a failing case would be interesting reading. In
theory we should be able to get that by running the stress script for
long enough. :)

-Peff
