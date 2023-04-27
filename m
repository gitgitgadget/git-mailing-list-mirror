Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E2C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 05:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjD0FAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0FAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 01:00:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131013AB6
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:00:48 -0700 (PDT)
Received: (qmail 19388 invoked by uid 109); 27 Apr 2023 05:00:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 05:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16127 invoked by uid 111); 27 Apr 2023 05:00:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 01:00:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 01:00:47 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 1/2] http: advertise capabilities when cloning empty repos
Message-ID: <20230427050047.GC982277@coredump.intra.peff.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-2-sandals@crustytoothpaste.net>
 <xmqqo7naqrb6.fsf@gitster.g>
 <ZEmXf4m8Hoz0KyOX@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEmXf4m8Hoz0KyOX@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 09:28:31PM +0000, brian m. carlson wrote:

> > > However, this does pose a problem when working with SHA-256
> > > repositories, since we use the capabilities to know the remote side's
> > > object format (hash algorithm).  It used to be possible to set the
> > > correct algorithm with `GIT_DEFAULT_HASH` (which is what the Git LFS
> > > testsuite did), but this no longer works as of 8b214c2e9d ("clone:
> > 
> > "this no longer works as of" -> "this was a mistake and was fixed by".
> 
> I tend to disagree.  While I agree that change is valuable because it
> fixes v2, which we want, it does cause a change in user-visible
> behaviour, which broke the Git LFS testsuite.  Whether we like things
> working that way or not, clearly there were people relying on it.
> 
> Fortunately, in that case, Git LFS can just enable protocol v2 and
> things work again, but I think "this no longer works" is accurate and
> more neutral, and addresses the issue.  We wouldn't have to deal with
> that issue if we could gracefully handle git clone --local with older
> versions of the protocol, but one of the tests fails when we do that.
> I'll take some more time to see if I can come up with a nice way to
> gracefully handle that, and if so, I'll send a v2.

Reiterating what I said upthread, I think it was always 50% broken.
Taking the local hash format over the remote one was always the wrong
thing to do, but it sometimes worked out (because we happened to match
the remote).

But the opposite case:

  git init --object-format=sha1 dst.git
  GIT_DEFAULT_HASH=sha256 git clone dst.git

would previously have done the wrong thing. We just flipped which half
was broken and which was not.

-Peff
