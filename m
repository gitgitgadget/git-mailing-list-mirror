Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C4C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5558920872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgJGVGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:06:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:53004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgJGVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:06:10 -0400
Received: (qmail 22324 invoked by uid 109); 7 Oct 2020 21:06:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 21:06:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17175 invoked by uid 111); 7 Oct 2020 21:06:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 17:06:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 17:06:09 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
Message-ID: <20201007210609.GA1984296@coredump.intra.peff.net>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 10:28:36PM +0200, Thomas Braun wrote:

> $ git --version
> git version 2.29.0.rc0.windows.1
> 
> Since I upgraded to that version (thanks to dscho for providing these so
> early) I'm seeing occasionally
> 
> $ git fetch origin +refs/head/abcd:refs/remotes/origin/abcd
> fatal: unexpected duplicate commit id
> 31a13139875bc5f49ddcbd42b4b4d3dc18c16576

That message comes from the commit-graph code:

  $ git grep unexpected.duplicate.commit.id '*.c'
  commit-graph.c:                 die(_("unexpected duplicate commit id %s"),

So presumably it's related to the fetch.writeCommitGraph feature, though
I thought it was not on by default (for a while it was tied to
feature.experimental, but I think even that is not true in 2.29). Do you
have that option set?

The message is in sort_and_scan_merged_commits(), which is trying to
join multiple incremental commit-graph files together. Presumably you
have two such files with the same commit appearing in both. I think we
try to avoid that (by omitting commits from new incrementals that
already appear in another one), but I wonder if there is a race or other
condition that can cause it. In which case this code ought to be more
lenient, and just quietly ignore the duplicate.

Is it possible to share the contents of your .git directory? If not, can
you look in .git/objects/info/ and see if there are multiple
commit-graph files (and if so, possibly share those; they don't contain
any identifying info).

-Peff
