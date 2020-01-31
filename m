Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CFC33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3591620CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgAaKaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:30:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:49420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728291AbgAaKaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 05:30:10 -0500
Received: (qmail 13536 invoked by uid 109); 31 Jan 2020 10:30:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 10:30:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30741 invoked by uid 111); 31 Jan 2020 10:37:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 05:37:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 05:30:08 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 0/6] commit-graph: use 'struct object_directory *'
 everywhere
Message-ID: <20200131103008.GD2916051@coredump.intra.peff.net>
References: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580424766.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 03:00:40PM -0800, Taylor Blau wrote:

> This series became a little bit longer than I was expecting it to be, so
> here is the high-level structure:
> 
>   - 1/6 fixes a bug in a test that would cause a subsequent failure if
>     unaddressed.
> 
>   - 2/6 does the first half of the removal by using 'struct
>     object_directory *'s within the 'commit_graph' structure.
> 
>   - 4/6 does the second half by removing 'char *object_dir' usage in the
>     'write_commit_graph_context' structure.
> 
>   - 5/6 ties 2/6 and 4/6 together by removing all path normalization
>     completely, fixing the uninitialized read bug.
> 
>   - And 6/6 cleans up.

With the exception of the patch-ordering discussion in the sub-thread
with Martin, this looks good to me.

Patch 3 is a change in user-visible behavior, as it restricts how
--object-dir can be used (it must be the main object-dir or an alternate
within the repository). I don't _think_ anybody would care, as the
semantics of those options seemed kind of ill-defined to me in the first
place. But it's worth calling out as a potential risk. I suppose the
alternative is to make a one-off fake "struct object_directory" within
the process that isn't connected to the repository. But if nobody cares,
I'd just as soon avoid that.

One other funny thing with this series: the Date headers of your patches
seem out of order. They ordering in your cover letter here is fine and
presumably reflects the commit topology:

> Taylor Blau (6):
>   t5318: don't pass non-object directory to '--object-dir'
>   commit-graph.h: store object directory in 'struct commit_graph'
>   builtin/commit-graph.c: die() with unknown '--object-dir'
>   commit-graph.h: store an odb in 'struct write_commit_graph_context'
>   commit-graph.c: remove path normalization, comparison
>   commit-graph.h: use odb in 'load_commit_graph_one_fd_st'

but the Date headers in order of 1-6 are:

  Date:   Thu, 30 Jan 2020 15:00:43 -0800
  Date:   Thu, 30 Jan 2020 15:00:50 -0800
  Date:   Thu, 30 Jan 2020 15:00:54 -0800
  Date:   Thu, 30 Jan 2020 15:00:52 -0800
  Date:   Thu, 30 Jan 2020 15:00:45 -0800
  Date:   Thu, 30 Jan 2020 15:00:47 -0800

It's like your sending script rewrites the Date header and puts a
2-second bump between each one (which is good, and what git-send-email
does), but got fed the patches in the wrong order (perhaps their
_original_ date order, if there was clean-up rebasing).

-Peff
