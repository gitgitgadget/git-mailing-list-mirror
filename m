Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E20208B4
	for <e@80x24.org>; Wed,  2 Aug 2017 08:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbdHBIcG (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 04:32:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752232AbdHBIcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 04:32:03 -0400
Received: (qmail 579 invoked by uid 109); 2 Aug 2017 08:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 08:32:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7332 invoked by uid 111); 2 Aug 2017 08:32:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 04:32:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 04:32:01 -0400
Date:   Wed, 2 Aug 2017 04:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Richard Jones <richardj@backbase.com>
Cc:     git@vger.kernel.org
Subject: Re: Git log --tags isn't working as expected
Message-ID: <20170802083200.3rmnz6mx2wfoarng@sigill.intra.peff.net>
References: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 08:41:41AM +0100, Richard Jones wrote:

> I’m trying to locate a commit which takes place after another one,
> matches a certain tag, and is by a specific user. I have the following
> command:
> 
> git log <COMMIT_ID>..HEAD --decorate --author=“<AUTHOR>" --tags=“project-name”
> 
> The tag follows the format: project-name-version

I think you want --tags="project-name-*", as the pattern is a glob. If
you omit any wildcards, it does a prefix match, but only at "/"
boundaries. That's the implied "/*" from the docs:

  --tags[=<pattern>]
    Pretend as if all the refs in refs/tags are listed on the command
    line as <commit>. If <pattern> is given, limit tags to ones matching
    given shell glob. If pattern lacks ?, *, or [, /* at the end is implied.

> How ever this doesn’t seem to work, as it returns all the commits by
> that user since the commit ID supplied.

Your ref selector "--tags" didn't match anything. So we just showed
<COMMIT_ID>..HEAD.

However, I suspect "--tags" still doesn't quite do what you want. It
behaves as if each tag was given as a starting point for a traversal. So
we'd generally show <COMMIT_ID>..HEAD in _addition_ to any tags we found
(and any commits reachable from those tags, down to <COMMIT_ID>). But it
sounds like you want to just see tags. For that, I'd do one of:

  1. Ask git-tag to show the interesting bits of your tags, like:

       git tag --format='%(refname:short) %(*authorname) / %(*subject)'

     The "*" there is dereferencing the tag to show the underlying
     commit. See the FIELD NAMES section of git-for-each-ref for more
     details. You can further limit that to tags that contain a
     particular commit with "--contains <COMMIT_ID>".

  2. Feed git-log some ref tips but ask it not to walk:

       git log --no-walk --tags='project-name-*'

     This is similar to (1), but uses the revision machinery, which can
     show more about each commit (e.g., the diff). But I don't think
     there's a good way to ask only for the tips that contain your
     particular commit (a negative endpoint like "<COMMIT_ID>.." doesn't
     play well with --no-walk, I think).

  3. Use --simplify-by-decoration to show a particular range of commits,
     but limit to ones that actually have a ref pointing at them. Like:

       git log <COMMIT_ID>..HEAD --simplify-by-decoration

I think (3) matches what you're trying to do the best. You can't say
"just tags" for the decoration, though, so you'll see branch tips as
well. There's been some discussion about allowing specific decorations,
but nothing merged yet.

-Peff
