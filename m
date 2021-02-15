Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919CBC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9864DE8
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBOXSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 18:18:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:33308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBOXSF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 18:18:05 -0500
Received: (qmail 9406 invoked by uid 109); 15 Feb 2021 23:17:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Feb 2021 23:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17281 invoked by uid 111); 15 Feb 2021 23:17:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Feb 2021 18:17:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Feb 2021 18:17:23 -0500
From:   Jeff King <peff@peff.net>
To:     Blake Burkhart <bburky@bburky.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Limited local file inclusion with .mailmap symlinks and
 git-archive
Message-ID: <YCsBA002yv8XpppM@coredump.intra.peff.net>
References: <CAP3OtXj15f9XV=Rzz2oBXQ1TQH3WWKJGBbeaWrmp6Ha4ZTn9nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP3OtXj15f9XV=Rzz2oBXQ1TQH3WWKJGBbeaWrmp6Ha4ZTn9nA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 13, 2021 at 11:49:32AM -0600, Blake Burkhart wrote:

> I reported this issue to the private security list first and discussed
> this issue with Peff. This is similar to existing concerns with
> .gitmodules, .gitattributes and .gitignore. Git already disallows
> checking out a .gitmodules file from a repository, and I understand
> there are in progress patches to add similar protection for
> .gitattributes and .gitignore. Please ensure the .mailmap file gets
> similar symlink protection.

Thanks again for bringing this up.

Here are some patches that I think will help. They're meant to be
applied on the stalled jk/symlinked-dotgitx-files topic, which Junio has
been carrying in "seen" for a few months now.

The sticking point there was that we were concerned that the fsck checks
for .gitattributes/.gitignore would catch historical commits in real
projects, making them annoying to work with. So the first patch here
loosens those checks to warnings. I think this is safe enough, as the
real protection is in preventing checkouts in the index code paths (the
fsck checks are really just about protecting other clients using older
versions, but the severity of these attacks is so low that the tradeoff
doesn't make as much sense).

Obviously this could be squashed into the earlier patches, but I think
documenting the change of direction with a separate commit makes sense.

And then the second patch adds similar .mailmap support (also as a
warning, since I think it is largely in the same boat, and it makes
sense to be consistent).

  [1/2]: fsck: make symlinked .gitignore and .gitattributes a warning
  [2/2]: disallow symlinked .mailmap files

 cache.h                      |  1 +
 fsck.c                       | 10 ++++++++--
 path.c                       |  5 +++++
 read-cache.c                 |  6 ++++--
 t/helper/test-path-utils.c   |  5 +++++
 t/t0060-path-utils.sh        | 10 ++++++++++
 t/t7450-bad-dotgitx-files.sh | 26 +++++++++++++++++++-------
 utf8.c                       |  5 +++++
 utf8.h                       |  1 +
 9 files changed, 58 insertions(+), 11 deletions(-)

-Peff
