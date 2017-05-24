Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9055D1FF30
	for <e@80x24.org>; Wed, 24 May 2017 14:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964846AbdEXOTw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 10:19:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57438 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdEXOTv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 10:19:51 -0400
Received: (qmail 4649 invoked by uid 109); 24 May 2017 14:19:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 14:19:49 +0000
Received: (qmail 11275 invoked by uid 111); 24 May 2017 14:20:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 10:20:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2017 10:19:48 -0400
Date:   Wed, 24 May 2017 10:19:48 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?RsOpbGl4?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch
 tries to check out the master branch
Message-ID: <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
 <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
 <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 12:24:52AM +0100, Philip Oakley wrote:

> > > $ git clone git@github.com:passcod/UPPERCASE-NPM.git
> > > Cloning into 'UPPERCASE-NPM'...
> > > remote: Counting objects: 14, done.
> > > remote: Compressing objects: 100% (11/11), done.
> > > remote: Total 14 (delta 3), reused 14 (delta 3), pack-reused 0
> > > Receiving objects: 100% (14/14), done.
> > > Resolving deltas: 100% (3/3), done.
> > > warning: remote HEAD refers to nonexistent ref, unable to checkout.
> 
> Perhaps here the warning message could include the value of the ref provided
> by the remote's HEAD which would then more clearly indicate to the user what
> was expected.
> 
> I haven't had chance to look at how easy that maybe in the code - perhaps a
> bit of low hanging fruit for someone?

Unfortunately, it can't, because the ref doesn't exist:

  $ git ls-remote git://github.com/passcod/UPPERCASE-NPM.git
  efc7dbfd6ca155d5d19ce67eb98603896062f35a	refs/heads/MASTER
  e60ea8e6ec45ec45ff44ac8939cb4105b16477da	refs/pull/1/head
  f35a73dcb151d336dc3d30c9a2c7423ecdb7bd1c	refs/pull/2/head
  0d9b3a1268ff39350e04a7183af0add912b686e6	refs/tags/V1.0.0
  efc7dbfd6ca155d5d19ce67eb98603896062f35a	refs/tags/V1.0.1

There is no HEAD line at all, so we have no information about it on the
client side.  Likewise, if you run with GIT_TRACE_PACKET=1, you'll see
that the capabilities line does not include a symref marker either.

So if we wanted to improve this, I think the first step would be for the
server to start sending symref lines for HEAD, even when it does not
resolve to anything.

That would also make a case like this:

  git -C dst.git symbolic-ref refs/heads/does-not-exist
  git clone dst.git local

use "does-not-exist" as the default branch name in our local clone
(rather than just falling back to "master", which presumably the other
side never plans to use).

-Peff
