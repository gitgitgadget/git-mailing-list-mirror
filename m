Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733532027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbdFBTpL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:45:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:34047 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBTpL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:45:11 -0400
Received: (qmail 22187 invoked by uid 109); 2 Jun 2017 18:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:45:09 +0000
Received: (qmail 30312 invoked by uid 111); 2 Jun 2017 18:45:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 14:45:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 14:45:07 -0400
Date:   Fri, 2 Jun 2017 14:45:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
Message-ID: <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
References: <20170602103330.25663-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170602103330.25663-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 10:33:30AM +0000, Ævar Arnfjörð Bjarmason wrote:

> When the tested repo has an index.lock file it should be removed. This
> file may be present if e.g. git-status previously crashed in that
> repo, and it will make a lot of git commands fail. Let's try harder
> and remove the lock.

If your git-status is crashing, you probably have bigger problems (and
need to clean up the original, too).

But I think a more compelling case is that there may be an ongoing
operation in the original repo (e.g., say you are in the middle of
writing a commit message) when we do a blind copy of the filesystem
contents. You might racily pick up a lockfile.

Should we find and delete all *.lock files in the copied directory? That
would get ref locks, etc. Half-formed object files are OK. Technically
if you want to get an uncorrupted repository you'd also want to copy
refs before objects (in case somebody makes a new object and updates a
ref while you're copying).

I don't know how careful it's worth being. I don't really _object_ to
this patch exactly, but it does seem like it's picking up one random
case (that presumably you hit) and ignoring all of the related cases.

-Peff
