Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD8A201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 05:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbdBQFR6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 00:17:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:56848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdBQFR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 00:17:57 -0500
Received: (qmail 25469 invoked by uid 109); 17 Feb 2017 05:17:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 05:17:57 +0000
Received: (qmail 30139 invoked by uid 111); 17 Feb 2017 05:17:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 00:17:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 00:17:55 -0500
Date:   Fri, 17 Feb 2017 00:17:55 -0500
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: difflame improvements
Message-ID: <20170217051755.fx2ueizsprw2vida@sigill.intra.peff.net>
References: <CAOc6etYz6+FzDRbkLS2SB9=F9DP18=6uLKdfCN3D3yd2Gug-tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOc6etYz6+FzDRbkLS2SB9=F9DP18=6uLKdfCN3D3yd2Gug-tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 11:19:05PM -0600, Edmundo Carmona Antoranz wrote:

> I've been working on detecting revisions where a "real" deletion was
> made and I think I advanced a lot in that front. I still have to work
> on many scenarios (renamed files, for example... also performance) but
> at least I'm using a few runs against git-scm history and the results
> are "promising":

I played with this a bit more, and it did turn up the correct results
for some deletions in my experiments.

One thing I noticed is that it also turned up nonsense for lines that
blame in weird ways. For instance, I have a diff like this (these are
real examples, but don't pay attention to the sha1s; it's in a fork of
git, not upstream):

  $ git diff v2.6.5 builtin/prune-packed.c
  diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
  index 7cf900ea07..5e3727e841 100644
  --- a/builtin/prune-packed.c
  +++ b/builtin/prune-packed.c
  @@ -2,6 +2,7 @@
   #include "cache.h"
   #include "progress.h"
   #include "parse-options.h"
  +#include "gh-log.h"
   
   static const char * const prune_packed_usage[] = {
   	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
  @@ -29,8 +30,11 @@ static int prune_object(const unsigned char *sha1, const char *path,
   
   	if (*opts & PRUNE_PACKED_DRY_RUN)
   		printf("rm -f %s\n", path);
  -	else
  +	else {
  +		gh_logf("prune", "%s Duplicate loose object pruned\n",
  +			sha1_to_hex(sha1));
   		unlink_or_warn(path);
  +	}
   	return 0;
   }
   

Running difflame on it says this:

  $ python /path/to/difflame.py v2.6.5..HEAD -- builtin/prune-packed.c
  [...]
  -2c0b29e662 (Jeff King 2016-01-26 15:27:55 -0500 32) 	else
  +d60032f8640 builtin/prune-packed.c (Jeff King        2015-02-02 23:15:33 -0500 33) 	else {
  +d60032f8640 builtin/prune-packed.c (Jeff King        2015-02-02 23:15:33 -0500 34) 		gh_logf("prune", "%s Duplicate loose object pruned\n",
  +d60032f8640 builtin/prune-packed.c (Jeff King        2015-02-02 23:15:33 -0500 35) 			sha1_to_hex(sha1));
   0d3b729680e builtin/prune-packed.c (Jeff King        2014-10-15 18:40:53 -0400 36) 		unlink_or_warn(path);
  +2396ec85bd1 prune-packed.c         (Linus Torvalds   2005-07-03 14:27:34 -0700 37) 	}

There are two weird things. One is that the old "else" is attributed to
my 2c0b29e662. That's quite weird, because that is a merge commit which
did not touch the file at all. I haven't tracked it down, but presumably
that is weirdness with the --reverse blame.

But there's another one, that I think is easy to fix. The closing brace
is attributed to some ancient commit from Linus. Which yes, I'm sure had
a closing brace, but not _my_ closing brace that was added by
d60032f8640, that the rest of the lines got attributed to.

This isn't difflame's fault; that's what "git blame" tells you about
that line. But since I already told difflame "v2.6.5..HEAD", it would
probably make sense to similarly limit the blame to that range. That
turns up a boundary commit for the line. Which is _also_ not helpful,
but at least the tool is telling me that the line came from before
v2.6.5, and I don't really need to care much about it.

Part of this is that my use case may be a bit different than yours. I
don't actually want to look at the blame results directly. I just want
to see the set of commits that I'd need to look at and possibly
cherry-pick in order to re-create the diff.

-Peff
