Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C66202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbdJSRo4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:57774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752485AbdJSRoz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:44:55 -0400
Received: (qmail 28881 invoked by uid 109); 19 Oct 2017 17:44:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:44:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9997 invoked by uid 111); 19 Oct 2017 17:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 13:44:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 13:44:53 -0400
Date:   Thu, 19 Oct 2017 13:44:53 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH v2] commit: check result of resolve_ref_unsafe
Message-ID: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
 <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
 <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 12:36:50PM +0300, Andrey Okoshkin wrote:

> Add check of the resolved HEAD reference while printing of a commit summary.
> resolve_ref_unsafe() may return NULL pointer if underlying calls of lstat()
> or
> open() fail in files_read_raw_ref().
> Such situation can be caused by race: file becomes inaccessible to this
> moment.
> 
> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> ---
> Thank you for your review.
> 
> Changes since the previous patch:
> * BUG is replaced with die, message;
> * Message is changed.

Thanks, this looks good to me. One other possible minor improvement:

>  	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
> +	if (!head)
> +		die(_("unable to resolve HEAD after creating commit"));

Should we use die_errno() here to report the value of errno? I think
resolve_ref_unsafe() should set it consistently (even an internal
problem, like an illegally-formatted refname, yields EINVAL).

I grepped the code base looking for other instances of the same problem,
and found four of them. Patches to follow.

Unlike this one, I ended up quietly returning an error in most cases.
The individual commit messages discuss the reasoning for each case, but
I do wonder if we ought to simply die() in each case out of an abundance
of caution (either the repo has a broken symref, or some weird
filesystem error occurred, but either way it may be best not to
continue). I dunno.

These are all independent, so can be applied in any order or combination
with respect to each other and to your patch.

  [1/4]: test-ref-store: avoid passing NULL to printf
  [2/4]: remote: handle broken symrefs
  [3/4]: log: handle broken HEAD in decoration check
  [4/4]: worktree: handle broken symrefs in find_shared_symref()

 builtin/remote.c          | 2 +-
 log-tree.c                | 2 +-
 t/helper/test-ref-store.c | 2 +-
 worktree.c                | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

-Peff
