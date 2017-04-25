Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED85207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952014AbdDYV1G (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:27:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:40110 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1951934AbdDYV1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:27:04 -0400
Received: (qmail 16592 invoked by uid 109); 25 Apr 2017 21:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 21:27:02 +0000
Received: (qmail 29043 invoked by uid 111); 25 Apr 2017 21:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 17:27:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 17:27:00 -0400
Date:   Tue, 25 Apr 2017 17:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: BUG: diff-{index,files,tree} (and git-gui) do not respect the
 diff.indentHeuristic config setting
Message-ID: <20170425212659.ds4vbj5fjcbyycpc@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 01:21:09PM -0400, Marc Branchaud wrote:

> So I have
> 
> 	diff.indentHeuristic = true
> 
> and I noticed that git-gui was not using the heuristic.  This is because
> git-gui uses diff-index, and that does not respect the config setting, even
> though it supports the --indent-heuristic option.
> 
> And it looks like diff-files and diff-tree also have the same problem.
> 
> I tried a couple of quick-n-dirty things to fix it in diff-index, without
> success, and I've run out of git-hacking tame, so all I can do for now is
> throw out a bug report.

Right, this is intentional. Those commands are scriptable plumbing, and
we try to avoid surprising their callers with behavior-changing config.

I could see an argument that the behavior change for this particular
option is subtle enough that it any script caller would not need to
care. The resulting diff is syntactically identical, and it's not like
Git makes promises about the exact diff algorithm it uses. We generally
tend to err on the side of caution with plumbing, though (for instance,
if you piped the result through patch-id, you'd probably get different
results with and without the config option set).

> diff-index.c explicitly says "no 'diff' UI options" since 83ad63cfeb ("diff:
> do not use configuration magic at the core-level", 2006-07-08), so maybe
> this needs to be fixed in git-gui (and maybe elsewhere), but to me it feels
> like the diff-foo commands should respect the setting.

Yes, if git-gui wants to respect the option, it needs to read the config
and turn on the command-line option. That's what add--interactive does,
for example.

It's possible we could make this simpler with a catch-all "allow diff
ui config" command-line option. The effect is the same, but it makes
things simpler for the caller.

-Peff
