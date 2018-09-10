Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F56C1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 13:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeIJSTB (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 14:19:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:44712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727970AbeIJSTB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 14:19:01 -0400
Received: (qmail 5337 invoked by uid 109); 10 Sep 2018 13:24:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 13:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7087 invoked by uid 111); 10 Sep 2018 13:25:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 09:25:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 09:24:53 -0400
Date:   Mon, 10 Sep 2018 09:24:53 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     dylanyoungmeijer@gmail.com, Git Users <git@vger.kernel.org>
Subject: Re: [Possible GIT Bug]
Message-ID: <20180910132452.GB5233@sigill.intra.peff.net>
References: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
 <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
 <CAGyf7-EFiZ7ouUPDMtv3eb57QEiM2pkavyKQe7iNO7+eBeuZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-EFiZ7ouUPDMtv3eb57QEiM2pkavyKQe7iNO7+eBeuZ9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 09, 2018 at 12:04:58PM -0700, Bryan Turner wrote:

> Here, though, you've _explicitly limited_ Git to only the copied file.
> It's not allowed to consider any others, which means it can't "see"
> the source path anymore. As a result, the copy is detected as a
> straight add. Note that --find-copies-harder means the diff machinery
> is allowed to consider files that weren't modified in the commit as
> possible sources for copies, but that's still subject to your explicit
> filtering. In other words, if PATH_TO_SOURCE_FILE wasn't modified,
> running this would _not_ see a copy:
> 
> git show -C 055f6c89fa4506037d1621761f13430f469b8029  --
> PATH_TO_MY_COPIED_FILE PATH_TO_SOURCE_FILE
> 
> But running this would:
> 
> git show -C -C 055f6c89fa4506037d1621761f13430f469b8029  --
> PATH_TO_MY_COPIED_FILE PATH_TO_SOURCE_FILE
> 
> No bugs here. Everything is working as intended, if not, perhaps, as
> you expected.

Your explanation is correct. To be fair, though, it seems like
--find-copies-harder is made a lot less useful by the not considering
the larger set of sources, since that's kind of its point. I'm not sure
if this behavior actually is intentional, or simply what happens to
occur based on the combination of features.

You can do:

  git log -C C --full-diff $commit -- $path

to limit a traversal to commits touching $path, but still see the full
diff (including possible copy sources). But AFAIK there's no option to
limit the diff, but include extra copy sources.

I'd be tempted to say we should do that automatically when
--find-copies-harder is in effect, but it's possible that some people
actually do want the current behavior. For a single path it's silly, but
if you did something like this:

  git show -C -C $commit -- foo/

that would find differences in the foo/ directory, and find copies only
from sources in foo/. That limits the result, but also limits the
effort, which can be important given the cost of copy detection.

-Peff
