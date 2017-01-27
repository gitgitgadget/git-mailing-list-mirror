Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 982391F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934106AbdA0RwU (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:52:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:45954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934090AbdA0Rvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:51:53 -0500
Received: (qmail 13977 invoked by uid 109); 27 Jan 2017 17:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:51:53 +0000
Received: (qmail 6221 invoked by uid 111); 27 Jan 2017 17:51:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 12:51:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 12:51:51 -0500
Date:   Fri, 27 Jan 2017 12:51:51 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Spiegel <michael.m.spiegel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: show all merge conflicts
Message-ID: <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 11:56:08AM -0500, Michael Spiegel wrote:

> I'm trying to determine whether a merge required a conflict to resolve
> after the merge has occurred. The git book has some advice
> (https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging) to use
> `git show` on the merge commit or use `git log --cc -p -1`. These
> strategies work when the merge conflict was resolved with a change
> that is different from either parent. When the conflict is resolved
> with a change that is the same as one of the parents, then these
> commands are indistinguishable from a merge that did not conflict. Is
> it possible to distinguish between a conflict-free merge and a merge
> conflict that is resolved by with the changes from one the parents?

No. You'd have to replay the merge to know if it would have had
conflicts.

There was a patch series a few years ago that added a new diff-mode to
do exactly that, and show the diff against what was resolved. It had a
few issues (I don't remember exactly what) and never got merged.

Certainly one complication is that you don't know exactly _how_ the
merge was done in the first place (e.g., which merge strategy, which
custom merge drivers were in effect, etc). But in general, replaying
with a standard merge-recursive would get you most of what you want to
know.

I've done this manually sometimes when digging into erroneous merges
(e.g., somebody accidentally runs "git reset -- <paths>" in the middle
of a merge and throws away some changes.

You should be able to do:

  git checkout $merge^1
  git merge $merge^2
  git diff -R $merge

to see what the original resolution did.

-Peff
