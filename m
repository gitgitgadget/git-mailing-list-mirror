Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E61C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469B7610E8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhIGR3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:29:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:40782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhIGR3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 13:29:39 -0400
Received: (qmail 19734 invoked by uid 109); 7 Sep 2021 17:28:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 17:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15581 invoked by uid 111); 7 Sep 2021 17:28:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 13:28:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 13:28:31 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
Message-ID: <YTehP58NfcnDSWEc@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <CAOLTT8RzHb5zWUm1psZRTP=iST-jP4DBmG2Zh1UPdo6z+QyHcg@mail.gmail.com>
 <YTS8yiYwR+eeZf4+@coredump.intra.peff.net>
 <CAOLTT8SYx4f8x-0zjXLJVOpW4-Mj34mjsfwr6tWo0PbZAV9B0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8SYx4f8x-0zjXLJVOpW4-Mj34mjsfwr6tWo0PbZAV9B0w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 06, 2021 at 09:30:45PM +0800, ZheNing Hu wrote:

> Jeff King <peff@peff.net> 于2021年9月5日周日 下午8:49写道：
> >
> > On Sun, Sep 05, 2021 at 04:19:53PM +0800, ZheNing Hu wrote:
> >
> > > > In this version there are 2 patches, tested against 'git for-each-ref
> > > > --format="%(objectname) %(refname)"' on a fully packed repo with 500k
> > > > refs:
> > > >
> > >
> > > Regarding this 500k refs, is there any way I can reproduce it?
> >
> > Try this in a clone of linux.git (or any other repo):
> >
> >   git rev-list HEAD |
> >   head -500000 |
> >   perl -lne 'print "create refs/foo/$. $_"' |
> >   git update-ref --stdin
> >
> >   git pack-refs --all --prune
> >
> 
> Sorry, It seems that the above command is difficult to complete on my
> machine (it took more than ten minutes). It may be stuck on git update-ref.
> So I tried to reproduce it in a repo which containing 76K refs:

Mine didn't take nearly that wrong, but it does depend on filesystem and
disk performance. It's going to create 500k lock files in refs/foo. :)

You can cheat a bit like this:

  {
    # grab existing packed refs; don't worry about peel lines or the
    # header comment, we're producing a lowest-common denominator
    # version of the file
    grep '^[0-9a-f]' packed-refs

    # now make our new fake refs
    git rev-list HEAD |
    head -500000 |
    perl -lne 'print "$_ refs/foo/$."'
  } >packed-refs.tmp
  mv packed-refs.tmp packed-refs

  # and now ask Git to repack to get everything sorted, etc
  git pack-refs --all --prune

It sounds like you were able to come up with a smaller version to play
with anyway, but I enjoy coming up with such hacks. :)

-Peff
