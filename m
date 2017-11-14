Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EAE8202A0
	for <e@80x24.org>; Tue, 14 Nov 2017 05:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbdKNFxL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:53:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:57182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753177AbdKNFxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:53:10 -0500
Received: (qmail 24150 invoked by uid 109); 14 Nov 2017 05:53:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Nov 2017 05:53:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28481 invoked by uid 111); 14 Nov 2017 05:53:22 -0000
Received: from host81-135-178-254.in-addr.btopenworld.com (HELO sigill.intra.peff.net) (81.135.178.254)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 14 Nov 2017 00:53:22 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Nov 2017 05:53:06 +0000
Date:   Tue, 14 Nov 2017 05:53:06 +0000
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Recovering from gc errors
Message-ID: <20171114055306.3tfi726wzmkcfluk@sigill.intra.peff.net>
References: <4f548c23-7bb5-a672-21bb-6c1dd6de6139@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f548c23-7bb5-a672-21bb-6c1dd6de6139@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 04:13:19PM -0500, Marc Branchaud wrote:

> Various incantations of "git show ... 9c355a7726e31" only fail with the same
> error, so I can't determine much about the problematic commit. Luckily I'm
> not particularly concerned with losing objects, as I push any important
> progress to named refs in backup repos.

Doing "git show" will require looking at the parent commit to produce
the diff. Probably "git show -s" would work. But in general for poking
at corruption, something bare-bones like "git cat-file commit 9c355a77"
is going to be your best bet.

> But I would like to clean this up in my local repo so that gc stops failing.
> I tried simply removing this and other loose commits that trip up gc (i.e.
> the objects/9c/355a7726e31b3033b8e714cf7edb4f0a41d8d4 file -- there are 49
> such files, all of which are several months old), but now gc complains of a
> bad tree object:

You can't generally fix corruption issues by deleting objects[1]. The
"source" that makes Git want to have these objects is the refs and
reflogs. So your best bet is to find which of those point to the
problematic objects and delete them.

I'd start by seeing if the breakage is reachable from any refs:

  git rev-list --objects --all >/dev/null

If that command succeeds, then all your refs are intact and the problem
is in the reflogs. You can try to figure out which, but I'd probably
just blow them all away:

  rm -rf .git/logs

If the rev-list fails, then one or more branch is corrupted.
Unfortunately the usual efficient tools for asking "which branch
contains this object" are likely to be broken by the corruption. But you
can brute-force it, like:

  git for-each-ref --format='%(refname)' |
  while read ref; do
    git rev-list --objects "$ref" >/dev/null 2>&1 ||
    echo "$ref is broken"
  done

Hopefully that turns up only branches with little value, and you can
delete them:

  git update-ref -d $broken_ref

-Peff

[1] A note on my "you can't fix corruption by deleting objects".

    Since abcb86553d (pack-objects: match prune logic for discarding
    objects, 2014-10-15) , git-gc also traverses the history graph of
    unreachable but "recent" objects. This is to keep whole chunks of
    the history graph intact during the gc grace period (which is 2
    weeks by default). So object themselves _can_ be a source of
    traversal for git-gc.

    We do that traversal with the ignore_missing_links flag, so
    breakages in the unreachable objects _shouldn't_ cause what you're
    seeing. IIRC we did turn up a bug or two with ignore_missing_links.
    The only one I could find was a3ba6bf10a (revision.c: ignore broken
    tags with ignore_missing_links, 2017-05-20), which I think wouldn't
    generate the output you're seeing.
