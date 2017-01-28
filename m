Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF6E1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 14:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdA1O2X (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 09:28:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:46328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbdA1O2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 09:28:16 -0500
Received: (qmail 31951 invoked by uid 109); 28 Jan 2017 14:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Jan 2017 14:28:10 +0000
Received: (qmail 16058 invoked by uid 111); 28 Jan 2017 14:28:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Jan 2017 09:28:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jan 2017 09:28:08 -0500
Date:   Sat, 28 Jan 2017 09:28:08 -0500
From:   Jeff King <peff@peff.net>
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
Cc:     Michael Spiegel <michael.m.spiegel@gmail.com>, git@vger.kernel.org
Subject: Re: show all merge conflicts
Message-ID: <20170128142808.hefnv7r3h6zidobw@sigill.intra.peff.net>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
 <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
 <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 09:42:41PM -0800, G. Sylvie Davies wrote:

> Aside from the usual "git log -cc", I think this should work (replace
> HEAD with whichever commit you are analyzing):
> 
> git diff --name-only HEAD^2...HEAD^1 > m1
> git diff --name-only HEAD^1...HEAD^2 > b1
> git diff --name-only HEAD^1..HEAD    > m2
> git diff --name-only HEAD^2..HEAD    > b2
> 
> If files listed between m1 and b2 differ, then the merge is dirty.
> Similarly for m2 and b1.
> 
> More information here:
> 
> http://stackoverflow.com/questions/27683077/how-do-you-detect-an-evil-merge-in-git/41356308#41356308

I don't think that can reliably find evil merges, since it looks at the
file level. If you had one hunk resolved for "theirs" and one hunk for
"ours" in a given file, then the file will be listed in each diff,
whether it has evil hunks or not.

I don't think this is just about evil merges, though. For instance,
try:

  seq 1 10 >file
  git add file
  git commit -m base

  sed s/4/master/ <file >tmp && mv tmp file
  git commit -am master

  git checkout -b other HEAD^
  sed s/4/other/ <file >tmp && mv tmp file
  git commit -am other

  git merge master
  git checkout --ours file
  git commit -am merged

  merge=$(git rev-parse HEAD)

The question is: were there conflicts in $merge, and how were they
resolved?

That isn't an evil merge, but there's still something interesting to
show that "git log --cc" won't display.

Replaying the merge like:

  git checkout $merge^1
  git merge $merge^2
  git diff -R $merge

shows you the patch to go from the conflict state to the final one.

-Peff
