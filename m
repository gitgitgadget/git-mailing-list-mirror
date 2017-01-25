Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7FB1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdAYSA6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:00:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:44570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdAYSA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:00:57 -0500
Received: (qmail 22459 invoked by uid 109); 25 Jan 2017 18:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:00:56 +0000
Received: (qmail 13643 invoked by uid 111); 25 Jan 2017 18:00:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 13:00:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 13:00:54 -0500
Date:   Wed, 25 Jan 2017 13:00:54 -0500
From:   Jeff King <peff@peff.net>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, novalis@novalis.org, pclouds@gmail.com
Subject: Re: [PATCH] tag: add tag.createReflog option
Message-ID: <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125001906.13916-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 01:19:06AM +0100, cornelius.weig@tngtech.com wrote:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
> 
> Git does not create a history for tags, in contrast to common
> expectation to simply version everything. This can be changed by using
> the `--create-reflog` flag when creating the tag. However, a config
> option to enable this behavior by default is missing.

Hmm, I didn't even know we had "tag --create-reflog". Looks like it was
added by 144c76fa39 (update-ref and tag: add --create-reflog arg,
2015-07-21).

IMHO it is a mistake. The "update-ref --create-reflog" variant makes
sense to me as a plumbing operation. But are there end users who want to
create a reflog for just _one_ tag?

As your patch shows, the more likely variant is "I want reflogs for all
tags". But that raises two questions with your patch:

  - yours isn't "reflogs for all tags". It's "reflogs for tags I created
    with git-tag". What about other operations that create tags, like
    fetching (or even just a script that uses update-ref under the
    hood).

    IOW, instead of tag.createReflog, should this be tweaing
    core.logallrefupdates to have a mode that includes tags?

  - Is that the end of it, or is the desire really "I want reflogs for
    _everything_"? That seems like a sane thing to want.

    If so, then the update to core.logallrefupdates should turn it into
    a tri-state:

      - false; no reflogs

      - true; reflogs for branches, remotes, notes, as now

      - always; reflogs for all refs under "refs/"

I made a lot of suppositions about your desires there, so maybe you
really do want just tag.createReflog. But "core.logallrefupdates =
always" sounds a lot more useful to me.

-Peff
