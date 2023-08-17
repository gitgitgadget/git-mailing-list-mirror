Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3660C27C7A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 05:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbjHQF2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 01:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347999AbjHQF1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 01:27:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB272D53
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 22:27:43 -0700 (PDT)
Received: (qmail 18747 invoked by uid 109); 17 Aug 2023 05:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 05:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25945 invoked by uid 111); 17 Aug 2023 05:27:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 01:27:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 01:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] upload-pack: fix exit code when denying fetch of
 unreachable object ID
Message-ID: <20230817052742.GB3006160@coredump.intra.peff.net>
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
 <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
 <xmqqjztvezen.fsf@gitster.g>
 <xmqq8rabey3v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rabey3v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 09:44:04AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The change to the code sounds sensible in that it is a move to
> > restore the status quo, and we know that the original never intended
> > to "fix" the exit status from 128 to 1.  The test change etches the
> > status quo in stone, which is a bit more than that and might be
> > debatable, but when we someday formally declare that users should
> > not be relying on the exit status that are not documented, we would
> > hunt for the uses of test_expect_code in the tests and turn this one
> > back, and probably do the same to others that are too strict on the
> > exact exit status, so I think that half of the change is OK, at
> > least for now.
> >
> > Comments?
> 
> An alternative to make this "fix" without setting any policy is to
> do this.  That is, to remove the change to the test part and then to
> rephrase the tail end of the proposed commit log message.
> 
> I can go either way.  I personally prefer our tests not to be overly
> strict about behaviors they test, especially the ones we do not
> document.

FWIW, my gut feeling agrees with you. I do not mind restoring the
previous "128" exit code for consistency and continuity, and there is no
reason to prefer "1" here instead. But I don't know that it's something
we should be promising or keeping track of with a test.

In fact, I would say that most of these die() calls in upload-pack are
pointless. The stderr of the server-side process is frequently not even
visible to the user (because it is on the other side of an http, etc,
connection). So in practice the message is going to /dev/null or perhaps
polluting some daemon log.

From the perspective of a server operator, I would even go so far as to
suggest that upload-pack should return "0" here. The client broke
protocol, but we told them over the correct channel and then exited
cleanly. There is no error on the server side. One could argue that a
large-scale server operator may want to keep track of protocol breaks
like this, because they could be a sign of a bug. But they'd probably be
better off with instrumenting upload-pack (or any proxy that sits in
front of it) to count messages coming over the ERR channel.

I've never really made patches in that direction because for the most
part the existing die() calls aren't hurting anything, and nobody cares
much about the exit code either way. But adding a more specific test
feels like going in the wrong direction (yes, I know t5516 is already
checking for a failed code, but modulo the race problems we have with
reading ERR packets, we really would be better off checking what the
client sees, or talking directly to upload-pack itself, the way t5530
does).

-Peff
