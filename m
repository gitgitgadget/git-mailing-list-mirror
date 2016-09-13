Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A150D20984
	for <e@80x24.org>; Tue, 13 Sep 2016 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759111AbcIMP02 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 11:26:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:42628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1758993AbcIMP02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 11:26:28 -0400
Received: (qmail 28413 invoked by uid 109); 13 Sep 2016 15:26:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 15:26:26 +0000
Received: (qmail 23329 invoked by uid 111); 13 Sep 2016 15:26:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 11:26:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 08:26:23 -0700
Date:   Tue, 13 Sep 2016 08:26:23 -0700
From:   Jeff King <peff@peff.net>
To:     Swift Geek <swiftgeek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-am includes escape characters from 'From' field
Message-ID: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
References: <op.yno0zli7ig5ot5@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <op.yno0zli7ig5ot5@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 10:10:23PM +0200, Swift Geek wrote:

> git-am seems to add backslash that escapes double quote character, example
> git format-patch
> 
> From 63da989a5295214f9bd06cd7b409a86a65241eea Mon Sep 17 00:00:00 2001
> From: "Sebastian \"Swift Geek\" Grzywna" <swiftgeek@gmail.com>

This looks correct; the output of format-patch is an rfc2822 message,
and it requires this quoting.

The part you don't show, and that I think is wrong, is that if you then
"git am" this patch, it pulls the backslashes into the commit object.
The culprit looks like "parse_mail()" in builtin/am.c (or possibly
mailinfo() that it calls), which blindly picks up the name portion
without doing any rfc2822 de-quoting.

I don't think we have any existing de-quoting routines to plug in, so
fixing it would probably start with writing one.

-Peff
