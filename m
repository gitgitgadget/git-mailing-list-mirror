Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B771F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeDCS2t (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:28:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:52424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751469AbeDCS2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:28:48 -0400
Received: (qmail 11801 invoked by uid 109); 3 Apr 2018 18:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 18:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30026 invoked by uid 111); 3 Apr 2018 18:29:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 14:29:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 14:28:46 -0400
Date:   Tue, 3 Apr 2018 14:28:46 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH 1/6] object.c: parse commit in graph first
Message-ID: <20180403182846.GB8377@sigill.intra.peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-2-dstolee@microsoft.com>
 <20180403112136.db2aeda65afe0c09f262dfb9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403112136.db2aeda65afe0c09f262dfb9@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 11:21:36AM -0700, Jonathan Tan wrote:

> On Tue,  3 Apr 2018 12:51:38 -0400
> Derrick Stolee <dstolee@microsoft.com> wrote:
> 
> > Most code paths load commits using lookup_commit() and then
> > parse_commit(). In some cases, including some branch lookups, the commit
> > is parsed using parse_object_buffer() which side-steps parse_commit() in
> > favor of parse_commit_buffer().
> > 
> > Before adding generation numbers to the commit-graph, we need to ensure
> > that any commit that exists in the graph is loaded from the graph, so
> > check parse_commit_in_graph() before calling parse_commit_buffer().
> > 
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> Modifying parse_object_buffer() is the most pragmatic way to accomplish
> this, but this also means that parse_object_buffer() now potentially
> reads from the local object store (instead of only relying on what's in
> memory and what's in the provided buffer). parse_object_buffer() is
> called by several callers including in builtin/fsck.c. I would feel more
> comfortable if the relevant [1] caller to parse_object_buffer() was
> modified instead of parse_object_buffer(), but I'll let others give
> their opinions too.

It's not just you. This seems like a really odd place to put it.
Especially because if we have the buffer to pass to this function, then
we'd already have incurred the cost to inflate the object.

-Peff
