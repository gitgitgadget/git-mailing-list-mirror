Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9820D1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161873AbdD0FTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:19:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:41014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161866AbdD0FS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:18:58 -0400
Received: (qmail 21027 invoked by uid 109); 27 Apr 2017 05:18:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 05:18:53 +0000
Received: (qmail 11693 invoked by uid 111); 27 Apr 2017 05:19:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 01:19:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 01:18:51 -0400
Date:   Thu, 27 Apr 2017 01:18:51 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question re testing configuration
Message-ID: <20170427051850.kb77hy64ttsr46cs@sigill.intra.peff.net>
References: <CAJZjrdWPezo6=JHcp9mp8C5Pm1uJodSj3Mbgn7ix78MAqpUUXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdWPezo6=JHcp9mp8C5Pm1uJodSj3Mbgn7ix78MAqpUUXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 10:56:23PM -0500, Samuel Lijin wrote:

> I *know* that the changes I'm working on are causing the tests to
> fail, but I can't figure out how to induce the failure manually (so
> that I can throw gdb at the problem).
> 
> Specifically I'm seeing t5000-tar-tree.sh fail (as a result of adding
> extra diff_populate_filespec() calls before the estimate_similarity()
> loop in diffcore_rename()) on #52 "set up repository with huge blob"
> and #55 "set up repository with far-future commit".
> 
> If I run the commands fed into test_expect_success in t5000, though
> (in an empty repo initialized with git init), making sure to use the
> binary compiled with the breaking changes, the command doesn't fail,
> so I'm clearly missing something in the testing environment setup when
> I try to manually reproduce it.
> 
> Can someone point me in the right direction? I've spent some time now
> going through t/test-lib.sh and I haven't figured it out yet.

I'd usually start by stopping the script at the failed test, going into
the repository directory, and then running from there. Like:

  $ cd t
  $ ./t5000-tar-tree.sh -v -i -x
  $ cd trash\ directory.t5000-tar-tree
  $ gdb --args ../../git whatever-failed

That's usually enough to re-create the broken state. Sometimes there are
things in the environment, or the test is impacted by your user-level
config (test-lib resets $HOME, so it should have no user config). But
it's usually easier to just stick a "gdb" temporarily into the test.
Note there are some tricks there with redirections and the bin-wrappers
script; see the debug() helper in test-lib-functions.sh.

-Peff
