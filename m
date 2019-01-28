Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328281F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfA1VXI (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:23:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:52036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726744AbfA1VXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:23:07 -0500
Received: (qmail 16263 invoked by uid 109); 28 Jan 2019 21:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 21:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29359 invoked by uid 111); 28 Jan 2019 21:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 16:23:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 16:23:05 -0500
Date:   Mon, 28 Jan 2019 16:23:05 -0500
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: protocol v2: More data transmitted between client and server
 since v2.20.0
Message-ID: <20190128212305.GA23587@sigill.intra.peff.net>
References: <CA+ARAtpAN_DJ-zgiwPEBqV1EotgsmggRRQWB59u8O_OPR_kFrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ARAtpAN_DJ-zgiwPEBqV1EotgsmggRRQWB59u8O_OPR_kFrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 11:45:20AM +0530, Kaartic Sivaraam wrote:

> I recently came across a blog[1] about how protocol v2 speeds up the
> transfer between the client and the server. It states that the amount
> of data transmitted between the client and the server is less when
> using the protocol v2.

Yes, but...

> # Git version: 2.19.0
> $ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote
> git@gitlab.com:gitlab-org/gitlab-ce.git master
> 2>git_protocol_2_git_2.19.0_stderr.txt
> d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master
> 
> $ wc -l
> 22 git_protocol_2_git_2.19.0_stderr.txt
> 
> 
> # Git version: 2.20.0
> $ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote
> git@gitlab.com:gitlab-org/gitlab-ce.git master
> 2>git_protocol_2_git_2.20.0_stderr.txt
> d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master
> 04845fdeae75ba5de7c93992a5d55663edf647e0
> refs/remotes/remote_mirror_630f74462b3b08a952486da866d5e702/master
> 04845fdeae75ba5de7c93992a5d55663edf647e0
> refs/remotes/remote_mirror_655ad545056a2ad17e7ebc5461a986e4/master
> d4d4ebadfb373518013382560b1f505eb6217f13
> refs/remotes/remote_mirror_d612bbe5bee4fbc624df371bc7caa759/master
> 
> $ wc -l git_protocol_2_git_2.20.0_stderr.txt
> 160971 git_protocol_2_git_2.20.0_stderr.txt

v2.19, etc, were buggy. The rules for ls-remote's pattern matching do
not permit us to use ref prefixes (because the documentation specifies
that it matches "master" at the end of _any_ ref, not just in the usual
spots). But we did anyway. The fix is in 631f0f8c4b (ls-remote: do not
send ref prefixes for patterns, 2018-10-31).

That should explain the extra refs, as well (they all match "master",
too, and it was wrong that v2.19 did not show them).

It's rather unfortunate, since otherwise ls-remote makes for a nice test
of the advertisement code. ;) You can see some difference with
"ls-remote --heads", as explained in 6a139cdd74 (ls-remote: pass
heads/tags prefixes to transport, 2018-10-31).

The best test is to do a noop git-fetch. E.g.:

  # just make sure we have all the objects. You still see the benefit
  # without it, but if you really want to count bytes, it makes sure
  # you're comparing apples to apples.
  git fetch

  # this has a big useless ref advertisement
  GIT_TRACE_PACKET=$PWD/v0 git -c protocol.version=0 fetch origin master

  # and this is much smaller. Unfortunately it's not just a single line
  # (for "master"), because tag-following requires that the other side
  # tell us about tags, too.
  GIT_TRACE_PACKET=$PWD/v2 git -c protocol.version=2 fetch origin master

  # this one is really tiny
  GIT_TRACE_PACKET=$PWD/v2-notags git -c protocol.version=2 fetch --no-tags origin master

With my origin as https://github.com/gitster/git (which has more heads
than the regular git.git), I get:

  $ wc v[02]* | head -n -1
  2441  17098 340884 v0
   733   5828 130263 v2
    22    141   2037 v2-notags

-Peff
