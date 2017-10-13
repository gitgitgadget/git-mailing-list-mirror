Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E741F20437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbdJMR5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:57:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:52426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752895AbdJMR46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:56:58 -0400
Received: (qmail 395 invoked by uid 109); 13 Oct 2017 17:56:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:56:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27463 invoked by uid 111); 13 Oct 2017 17:57:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:57:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:56:56 -0400
Date:   Fri, 13 Oct 2017 13:56:56 -0400
From:   Jeff King <peff@peff.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: alias -q to --quiet
Message-ID: <20171013175656.qitarz6lvrppyb5f@sigill.intra.peff.net>
References: <20171013164415.6632-1-asottile@umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013164415.6632-1-asottile@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 09:44:15AM -0700, Anthony Sottile wrote:

> Previously, `-q` was silently ignored:

I'm not sure if is totally ignored. Normally if we have an unknown
options we'd complain:

  $ git diff -x
  error: invalid option: -x

but we don't with "-q". Why?

In builtin/diff.c:471, we can see:

  else if (!strcmp(argv[1], "-q"))
          options |= DIFF_SILENT_ON_REMOVED;

So it _does_ do something, just not what you expected.

But wait, that's not the whole story. We convert "-q" into
SILENT_ON_REMOVED in git-diff-files and in git-diff (when we're acting
like diff-files). But nobody ever seems to check it!

Running "git log -p -SSILENT_ON_REMOVED" turns up two interesting
commits:

  - 95a7c546b0 (diff: deprecate -q option to diff-files, 2013-07-17)

  - c48f6816f0 (diff: remove "diff-files -q" in a version of Git in a
    distant future, 2013-07-18).

So we dropped "-q" a few years ago and added a deprecation notice. "git
tag --contains 95a7c546b0" tells us that happened in v1.8.5, which
shipped in Nov 2013.

And then in v2.0.0 (May 2014) we tried to drop "-q" completely. Looking
over c48f6816f0, I _think_ it's a mistake that "-q" became a silent noop
there. That commit should have ripped out the remaining bits that set
the SILENT_ON_REMOVED flag, and "-q" would have become an error.

So there are two separate questions/tasks:

  1. Should we remove the special handling of "-q" leftover from this
     deprecation? I think the answer is yes.

  2. Should we teach the diff machinery as a whole to treat "-q" as a
     synonym for "--quiet".

     Probably yes, but it's less clear to me that this won't have funny
     interactions. Are there other commands which use the diff-options
     parser via setup_revisions(), but expect "-q" to be left in the
     output so that they can handle it themselves?

     It looks like git-log does so, but it pulls the "-q" out before
     handing the remainder to setup_revisions(). And anyway, it just
     converts the option into a quiet diff (though it does in a way
     that's different than the rest of the diff code -- that might bear
     investigating on its own).

     Grepping for 'q' and OPT__QUIET, I don't see any others, but I
     didn't spend very much time digging.

-Peff
