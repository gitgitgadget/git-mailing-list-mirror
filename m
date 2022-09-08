Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F075C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 18:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiIHSOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIHSOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 14:14:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36CE559B
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 11:14:08 -0700 (PDT)
Received: (qmail 28230 invoked by uid 109); 8 Sep 2022 18:14:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 18:14:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23296 invoked by uid 111); 8 Sep 2022 18:14:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 14:14:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 14:14:07 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
 <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev>
 <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
 <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
 <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
 <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 12:46:14PM -0400, Lana Deere wrote:

> With an explicit -c protocol.version=0 on the 2.37.2 git command line,
> the pull is successful.  For what it's worth, the server git is still
> 2.18.0 in all of these cases.  Only the client side is being tested so
> far.  I will try to gather the packet traces and see if there's a
> problem sharing them.  Will this mailing list allow attachments?

You can send attachments to the list as long as the total mail size is
under 100kb. But to keep the list in the loop: Lana sent me the traces
off-list, because naturally they have a bunch of semi-private ref names.

I was able to see the problem from the traces: the v2 protocol has an
extension to tell the server to limit the advertisement only to branches
we're interested in. And it does so based on the configured refspec. As
Dscho noted earlier in the thread, the upstream branch you want isn't in
the refspec. We try to add that branch explicitly to what we're
fetching, but I think that happens too late to affect the ref-prefix
limiting. So the server is asked not to advertise the ref, and from the
client's perspective, it looks like the branch does not exist on the
server.

Here's a minimal reproduction:

  # a server with two branches
  git init server
  (
    cd server
    git checkout -b branch1
    git commit --allow-empty -m foo
    git branch branch2
  )

  # and a client which points its origin there,
  # and has local copies of both branches, tracking
  # the upstream versions
  git clone server client
  cd client
  git checkout branch1
  git checkout branch2

  # but afterwards, the client narrows its refspec to only fetch branch1
  git config remote.origin.fetch +refs/heads/branch1:refs/remotes/origin/branch1

  # pulling branch2 with v0 works
  git -c protocol.version=0 pull

  # but does not with v2, because the ref-prefix extension tells the
  # server not to advertise anything outside of branch1
  git -c protocol.version=2 pull

This is a bug which we should fix. But in the meantime the obvious
workaround is to expand the default refspec to cover both branches.
Obviously the default of fetching "refs/heads/*" would work, but if you
want to keep it limited for some reason, you can add the second branch
explicitly. In the example above, it would be:

  git config --add remote.origin.fetch +refs/heads/branch2:refs/remotes/origin/branch2

-Peff
