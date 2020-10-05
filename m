Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D09C4727D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B44C20870
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgJEIts (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:49:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:49424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgJEItr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:49:47 -0400
Received: (qmail 31329 invoked by uid 109); 5 Oct 2020 08:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17496 invoked by uid 111); 5 Oct 2020 08:49:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:49:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:49:46 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] t7415: rename to expand scope
Message-ID: <20201005084946.GE2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071954.GC2291074@coredump.intra.peff.net>
 <20201005075020.GF1166820@google.com>
 <20201005082448.GB2862927@coredump.intra.peff.net>
 <20201005083441.GL1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005083441.GL1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 01:34:41AM -0700, Jonathan Nieder wrote:

> > I couldn't think of a better name for "files that start with .git". I
> > almost called it "dot-git", but then I worried about confusion with the
> > actual ".git" directory.
> 
> t7450-dot-gitfoo-files.sh seems clear to me.

Heh, that was actually one of the ones I thought of, but I worried that
"foo" was too confusing (likewise, I almost called the test-tool
function check_dotgitfoo(const char *foo)). I guess dotgitx would follow
the same pattern here.

> > In practice, I doubt it matters that much. We don't tend to run the test
> > suite serially in order these days anyway, so the notion that finding a
> > bug in an early test might save you CPU time or time spent reading error
> > messages likely no longer applies.
> 
> I see --- the point here is that because it's using e.g. "git clone
> --recurse-submodules", we want it to be later than the other clone
> tests?
> 
> I think I'd like us to move away from having the numbers at all some
> day (since collisions are very common), but there's probably not much
> to discuss there until one of us comes up with a proposal that still
> makes it easy to do things like "skip all git-svn tests". :)

I'd be happy to get away from numbers, too. They're a frequent pain when
dealing with duplicates, or when we run out of space in a group (I have
another series to split t9001 into a few separate scripts, but I have to
move either it or the unrelated bits at t9002).

An obvious solution is providing some kind of name hierarchy. E.g.:

  t-svn-commit-diff.sh
  t-svn-dcommit-auto-props.sh
  t-svn-dcommit-clobber-series.sh
  t-svn-dcommit-concurrent.sh
  t-svn-dcommit-crlf.sh
  t-svn-dcommit-funky-renames.sh
  t-svn-dcommit-interactive.sh
  t-svn-dcommit-merge.sh
  t-svn-dcommit-new-file.sh
  t-svn-deep-rmdir.sh

Then you could skip t-svn-*, or just t-svn-dcommit-*, or even
t-svn-commit-diff.12.

The "t-" is ugly, but lets you distinguish test scripts from other shell
scripts in the directory.

We could also use actual directories for the hierarchy. svn/dcommit/*,
etc. The t/ directory is rather big. It does make it a little more work
to assemble the full set of tests (you have to use `find` rather than a
glob).

-Peff
