Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A12C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2EF610A6
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhJYTVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:21:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234629AbhJYTUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 15:20:34 -0400
Received: (qmail 6588 invoked by uid 109); 25 Oct 2021 19:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Oct 2021 19:18:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22835 invoked by uid 111); 25 Oct 2021 19:18:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Oct 2021 15:18:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Oct 2021 15:18:10 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Unexpected cat-file --batch-check output
Message-ID: <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
References: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 12:02:38PM -0700, Bryan Turner wrote:

> I'm working with some users trying to reconcile an odd mismatch
> observed in some Git output.
> 
> Running an ls-tree for a branch and path, limited to a single pattern
> within, shows this:
> /usr/bin/git ls-tree -z refs/heads/develop:path/to/parent – file
> 100644 blob 4c8d566ed80a1554a059b97f7cd533a55bbd2ea8    file
> 
> If we then run cat-file --batch-check, though, we see this:
> echo 'refs/heads/develop
> refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch-check
> 28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
> cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330

That's definitely odd. Some things I'd try:

  - do other versions of cat-file behave differently (i.e., is it a
    regression)?

  - what does "git rev-parse refs/heads/develop:path/to/parent/file"
    say? If it comes up with 4c8d566ed80, then the problem is cat-file
    specific. If not, then it's a problem in the name resolution
    routines.

  - likewise, what does "git cat-file -t cc10f4b27808" say? I'd expect
    it to really be a commit (a bug in batch-check's formatting routines
    could show the wrong object, but I'd expect the oid to at least
    match what ls-tree showed).

  - Is there anything odd about the tree? E.g., duplicate entries, out
    of order entries, etc? Examining "ls-tree" output might help, but
    "git fsck" should also note any irregularities.

After that, I'd probably start running "cat-file --batch-check" through
a debugger. I know you said you don't have access to the repository, but
perhaps whoever does might be willing to run it through "fast-export
--anonymize" and see if the bug persists?

-Peff
