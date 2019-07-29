Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65B01F462
	for <e@80x24.org>; Mon, 29 Jul 2019 10:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfG2KUL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 06:20:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726358AbfG2KUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 06:20:11 -0400
Received: (qmail 21841 invoked by uid 109); 29 Jul 2019 10:20:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 10:20:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27090 invoked by uid 111); 29 Jul 2019 10:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 06:21:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 06:20:10 -0400
From:   Jeff King <peff@peff.net>
To:     Christopher Head <bugs@chead.ca>
Cc:     git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
Message-ID: <20190729102009.GC2755@sigill.intra.peff.net>
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 27, 2019 at 09:54:40AM -0700, Christopher Head wrote:

> For each URL:
> 1. Read refs/heads/mybranch (call this commit X)
> 2. Read refs/remotes/myremote/mybranch (call this commit Y)
> 3. Send to the URL an atomic compare-and-swap, replacing Y with X.
> 4. If step 3 succeeded, change refs/remotes/myremote/mybranch to X.
> 
> This means that, assuming both URLs start out identical, the second URL
> will always fail because refs/remots/myremote/mybranch has been updated
> from Y to X, and therefore the second compare-and-swap fails. I can’t
> imagine any situation in which this behaviour is actually useful.

My general feeling is that having multiple push URLs for a remote is a
poorly designed feature in Git (and I think the discussion elsewhere in
this thread went there, as well).

But since we do have it, and if we are not going to deprecate it[1], it
seems like this case should pick the X value of myremote/mybranch ahead
of time, and then use it consistently for each push. There are questions
of partial push failures, etc, but as you note the current behavior
isn't ever useful. I think it just a case where two features do not
interact well (and since neither is used all that frequently, nobody has
noticed).

-Peff

[1] I would not be at all sad to see multiple URLs like this get
    deprecated in favor of multiple remotes with convenient grouping
    options. If that happens, then your original problem goes away. ;)
