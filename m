Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924241FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbdC0Wpk (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:45:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:52628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753247AbdC0Wog (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:44:36 -0400
Received: (qmail 18268 invoked by uid 109); 27 Mar 2017 22:44:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 22:44:11 +0000
Received: (qmail 24069 invoked by uid 111); 27 Mar 2017 22:44:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 18:44:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Mar 2017 18:44:08 -0400
Date:   Mon, 27 Mar 2017 18:44:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] read-cache: skip index SHA verification
Message-ID: <20170327224408.2bzh5vfa6deni6fm@sigill.intra.peff.net>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
 <1490648979-49580-2-git-send-email-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490648979-49580-2-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 09:09:38PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach git to skip verification of the index SHA in read_index().
> 
> This is a performance optimization.  The index file SHA verification
> can be considered an ancient relic from the early days of git and only
> useful for detecting disk corruption.  For small repositories, this
> SHA calculation is not that significant, but for gigantic repositories
> this calculation adds significant time to every command.
> 
> I added a global "skip_verify_index" variable to control this and
> allow it to be tested.
> 
> I did not create a config setting for this because of chicken-n-egg
> problems with the loading the config and the index.

Hrm, there shouldn't be any dependency of the config on the index (and
there are a handful of options which impact the index already). Did you
try it and run into problems?

In general, I'd much rather see us either:

  1. Rip the code out entirely if it is not meant to be configurable,
     and cannot be triggered by the actual git binary.

or

  2. Make it configurable, even if most people wouldn't use it. And then
     have a test to exercise it using a git command (unlike the one-off
     test helper, which isn't run at all).

-Peff
