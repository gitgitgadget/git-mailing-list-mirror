Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A9C1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJXUvC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:51:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727338AbfJXUvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 16:51:02 -0400
Received: (qmail 21743 invoked by uid 109); 24 Oct 2019 20:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 20:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5378 invoked by uid 111); 24 Oct 2019 20:54:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 16:54:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 16:51:00 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and
 `is_directory()`
Message-ID: <20191024205100.GB30715@sigill.intra.peff.net>
References: <20191024092745.97035-1-mirucam@gmail.com>
 <20191024114148.GK4348@szeder.dev>
 <20191024181344.GD12892@sigill.intra.peff.net>
 <20191024204500.GG9323@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024204500.GG9323@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 01:45:00PM -0700, Emily Shaffer wrote:

> > Yes, that's the reason for the funny name (and the fact that it was
> > never re-factored to use is_directory() in the first place). There's
> > some more discussion in:
> > 
> >   https://public-inbox.org/git/xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com/
> > 
> > and its subthread.
> 
> Hm. Then, is the solution to use dir_exists() for "a directory exists
> here" and also add path_exists() for "literally anything exists here"?
> That seems like it's still a pretty minor change. It'd be nice to
> un-stick our Outreachy applicant :)

Yeah, I think one path forward could be:

  - add path_exists(); this will work the same as file_exists(), but is
    a better name. Keep file_exists() for now, but put a comment that
    new calls should use path_exists().

  - use path_exists() in builtin/clone.c, ditching its custom
    dir_exists()

  - (optional) start converting file_exists() calls to path_exists(),
    after confirming what each call wants (just files, or any path)

    I one really does want to check for a regular file, then we'd need
    to figure out what the "does this regular file exist" function is
    called. I have a suspicion that there won't be any such callers, so
    we can punt on it until then.

-Peff
