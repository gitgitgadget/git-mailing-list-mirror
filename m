Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDC5C5519F
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8967B23A65
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgKUAke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:40:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:37292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgKUAke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 19:40:34 -0500
Received: (qmail 7597 invoked by uid 109); 21 Nov 2020 00:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Nov 2020 00:40:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12848 invoked by uid 111); 21 Nov 2020 00:40:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Nov 2020 19:40:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Nov 2020 19:40:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
Message-ID: <20201121004033.GD353076@coredump.intra.peff.net>
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
 <20201120235203.GA353076@coredump.intra.peff.net>
 <xmqq3613tuwy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3613tuwy.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 04:28:45PM -0800, Junio C Hamano wrote:

> > This won't resolve a symref pointing to an unborn branch, so it would
> > count as "missing". I.e.:
> >
> >   git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/nope
> >   git -c fetch.updatehead=missing fetch
> >
> > will update it based on the remote HEAD.  I guess I could see some
> > argument for defining "missing" in that way, but I suspect it is not
> > what somebody in this situation would expect.
> 
> What do we do in "git clone" of an empty repository with the current
> branch not yet to be born?  Modern Git tells where the HEAD points at
> even for unborn branch, so using that would be a natural thing to do.

We don't seem to do anything:

  $ git init
  $ git clone . dst
  Cloning into 'dst'...
  warning: You appear to have cloned an empty repository.
  done.
  $ find dst/.git/refs
  dst/.git/refs
  dst/.git/refs/tags
  dst/.git/refs/heads

Likewise with --no-local.

I don't think we do advertise the symref in such a case. In v2, the
symref information is attached to individual lines in the ref
advertisement. And we don't advertise the unborn line (we could, but I
think we might need a special syntax for the oid field).

In v0, it comes in the capability section attached to the first line of
the advertisement, but it doesn't have to be about that particular line.
If there are no refs to advertise, we don't seem to send anything (I
_thought_ we sent a capabilities^{} line, but I think that is only
receive-pack; if we have no refs to fetch, then capabilities are not
interesting on the upload-pack side anyway).

But even if we do have a ref in v0, it looks like we don't advertise the
symref:

  $ git init
  $ git commit --allow-empty -m foo
  $ git checkout --orphan another-branch
  $ git-upload-pack .
  0104d4cebe701d3d7b36e6c383193e92ef4bd49ab2b0 refs/heads/mastermulti_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed object-format=sha1 agent=git/2.29.2.730.g3e418f96ba

We could likewise support it there, but I don't think modifying the v0
protocol at this point is that interesting.

-Peff
