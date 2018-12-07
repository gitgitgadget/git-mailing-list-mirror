Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6173E20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 07:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGH0s (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 02:26:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:33730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725978AbeLGH0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 02:26:48 -0500
Received: (qmail 25287 invoked by uid 109); 7 Dec 2018 07:26:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Dec 2018 07:26:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25041 invoked by uid 111); 7 Dec 2018 07:19:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Dec 2018 02:19:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2018 02:20:04 -0500
Date:   Fri, 7 Dec 2018 02:20:04 -0500
From:   Jeff King <peff@peff.net>
To:     biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Cc:     bturner@atlassian.com, git@vger.kernel.org
Subject: Re: Retrieving a file in git that was deleted and committed
Message-ID: <20181207072004.GA32603@sigill.intra.peff.net>
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 11:07:00PM -0800, biswaranjan panda wrote:

> Thanks! Strangely git log --follow does work.

I suspect it would work even without --follow. When you limit a log
traversal with a pathspec, like:

  git log foo

that is not about following some continuous stream of content, but
rather just applying that pathspec to the diff of each commit, and
pruning ones where it did not change. So even if there are gaps where
the file did not exist, we continue to apply the pathspec to the older
commits.

Tools like git-blame will _not_ work, though, as they really are trying
to track the content as they walk back through history. And Once all of
the content seems to appear from nowhere in your new commit, that seems
like a dead end.

In theory there could be some machine-readable annotation in the commit
object (or in a note created after the fact) to say "even though 'foo'
is a new file here, it came from $commit:foo".  And then git-blame could
keep following the content there. But such a feature does not yet exist.

-Peff
