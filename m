Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F26F1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJXEc0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:32:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725266AbeJXEc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:32:26 -0400
Received: (qmail 6535 invoked by uid 109); 23 Oct 2018 20:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Oct 2018 20:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26208 invoked by uid 111); 23 Oct 2018 20:06:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Oct 2018 16:06:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2018 16:07:30 -0400
Date:   Tue, 23 Oct 2018 16:07:30 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ben Peart <benpeart@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1] load_cache_entries_threaded: remove unused src_offset
 parameter
Message-ID: <20181023200730.GB15214@sigill.intra.peff.net>
References: <20181022150513.18028-1-peartben@gmail.com>
 <20181022201721.GD9917@sigill.intra.peff.net>
 <xmqqo9bltwdy.fsf@gitster-ct.c.googlers.com>
 <7a359876-7d36-5d01-5f47-76ef316b6386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a359876-7d36-5d01-5f47-76ef316b6386@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 03:13:06PM -0400, Ben Peart wrote:

> At one point I also had the additional #ifndef NO_PTHREADS lines but it was
> starting to get messy with the threaded vs non-threaded code paths so I
> removed them.  I'm fine with which ever people find more readable.
> 
> It does make me wonder if there are still platforms taking new build of git
> that don't support threads.  Do we still need to write/test/debug/read
> through the single threaded code paths?

I think the classic offenders here were old Unix systems like AIX, etc.

I've no idea what the current state is on those platforms. I would love
it if we could drop NO_PTHREADS. There's a lot of gnarly code there, and
I strongly suspect a lot of bugs lurk in the non-threaded halves (e.g.,
especially around bits like "struct async" which is "maybe a thread, and
maybe a fork" depending on your system, which introduces all kinds of
subtle process-state dependencies).

But I'm not really sure how to find out aside from adding a deprecation
warning and seeing if anybody screams.

See also this RFC from Duy, which might at least make the code itself a
little easier to follow:

	https://public-inbox.org/git/20181018180522.17642-1-pclouds@gmail.com/

-Peff
