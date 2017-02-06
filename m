Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2981FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbdBFSuP (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:50:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:49948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbdBFSty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:49:54 -0500
Received: (qmail 22943 invoked by uid 109); 6 Feb 2017 18:49:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 18:49:53 +0000
Received: (qmail 16060 invoked by uid 111); 6 Feb 2017 18:49:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 13:49:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 19:49:51 +0100
Date:   Mon, 6 Feb 2017 19:49:51 +0100
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git/git-scm.com GH Issue Tracker
Message-ID: <20170206184951.vwq6ib2qzxc542i4@sigill.intra.peff.net>
References: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
 <CACsJy8BCTY=T9f2ac7HUuHA-_RzjaxPHZNPQs9ecBhmsnDuRVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BCTY=T9f2ac7HUuHA-_RzjaxPHZNPQs9ecBhmsnDuRVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 05:18:03PM +0700, Duy Nguyen wrote:

> On Mon, Feb 6, 2017 at 1:15 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> > # Irrelevant but someone should take a look
> >
> > 693
> 
> To save people some time (and since i looked at it anyway), this is
> about whether "warning in tree xxx: contains zero-padded file modes:
> from fsck should be a warning or error. It is a warning now even
> though "git -c transfer.fsckobjects=true clone" treats it as an error.
> There are some discussions in the past [1] [2] about this.

The bug that caused the trees is long-fixed. There's a question of
how severity levels should be handled in transfer.fsckObjects. By
default it treats everything as a reason to reject the object. Dscho
added configurable levels a few versions ago. It may be a good idea to
tweak the defaults to something more permissive[1].

> There's also a question "And I failed to find in the documentation if
> transfer.fsckobjects could be disabled per repository, can you confirm
> it's not possible for now ?"

I don't know why it wouldn't be, though note that it won't override
the operation-specific {receive,fetch}.fsckObjects.

-Peff

[1] If we had a more permissive set of defaults, it would probably make
    sense to turn on fsckObjects by default. Some of the checks are
    security-relevant, like disallowing trees with ".GIT",
    "../../etc/passwd", etc. Those _should_ be handled sanely by the
    rest of Git, but it serves as a belt-and-suspenders check, and also
    protects anybody with a buggy Git downstream from you.

    GitHub has had the feature turned on for ages, with a few caveats:

      - we loosened the zero-padded mode warning, because it was causing
	too many false positives

      - we loosened the timezone checks for the same reason; we've seen
	time zones that aren't exactly 4 characters before

      - we occasionally get complaints from people trying to push old
	histories with bogus committer idents. Usually a missing name or
	similar.

     So those are the ones we'd probably need to loosen off the bat, and
     they're all pretty harmless. But it would be a potential irritating
     regression for somebody if they have a history with other minor
     flaws, and Git suddenly starts refusing to clone it.
