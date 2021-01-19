Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E76BC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1604D23104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhASX3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:29:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:60520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730519AbhASX0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:26:51 -0500
Received: (qmail 15791 invoked by uid 109); 19 Jan 2021 23:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 23:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14142 invoked by uid 111); 19 Jan 2021 23:26:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 18:26:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 18:26:09 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAdqkYtxqeXVnzN3@coredump.intra.peff.net>
References: <20210119143348.27535-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119143348.27535-1-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 03:33:47PM +0100, Jacob Vosmaer wrote:

> What I learned is that by default, a fetch ends up using the
> '--include-tag' command line option of git-pack-objects. This causes
> git-pack-objects to iterate through all the tags of the repository to
> see if any should be included in the pack because they point to packed
> objects. The problem is that this "iterate through all the tags" uses
> for_each_ref which iterates through all references in the repository,
> and in doing so loads each associated object into memory to check if
> the ref is broken. But all we need for '--include-tag' is to iterate
> through refs/tags/.
> 
> On the repo we were testing this on, there are about
> 500,000 refs but only 2,000 tags. So we had to load a lot of objects
> just for the sake of '--include-tag'. It was common to see more than
> half the CPU time in git-pack-objects being spent in do_for_each_ref,
> and that in turn was dominated by ref_resolves_to_object.

Some of these details may be useful in the commit message, too. :)

Your "load a lot of objects" had me worried for a moment. We try hard
not to load objects during such an iteration, even when peeling them
(because the packed-refs format has a magic shortcut there). But I think
that is all working as intended. What you were seeing was just tons of
has_object_file() to make sure the ref was not corrupt (so finding the
entry in a packfile, but not actually inflating the object contents).

Arguably both upload-pack and pack-objects could use the INCLUDE_BROKEN
flag to avoid even checking this. We'd notice the problem when somebody
actually tried to fetch the object in question. That would speed things
up further on top of your patch, because we wouldn't need to check the
existence of even the tags. But it's definitely orthogonal, and should
be considered separately.

-Peff
