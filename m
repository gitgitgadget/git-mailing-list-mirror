Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C4C48BDF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E14613AD
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhFVToO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:44:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhFVToM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 15:44:12 -0400
Received: (qmail 6821 invoked by uid 109); 22 Jun 2021 19:39:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 19:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29794 invoked by uid 111); 22 Jun 2021 19:39:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 15:39:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 15:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YNI8iyzObjxH0/ED@coredump.intra.peff.net>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
 <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
 <YMnvCI/jksyn2flD@tanuki>
 <YMyYz6Tavj5l6S8n@coredump.intra.peff.net>
 <YMyhCTaHmm6oNFpB@xps>
 <YNG/05+fmA0YPKj7@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNG/05+fmA0YPKj7@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 12:47:57PM +0200, Patrick Steinhardt wrote:

> Today I've been experimenting with the connectivity check of
> git-receive-pack(1) once again to see whether I'm able to get a
> performance improvement if the git-rev-list(1) command spawned as part
> of the connectivity check uses `--use-bitmap-index`.
> 
> Turns out the answer is "no": it has exactly the same performance
> characteristics when pushing into a bitmapped repository (linux.git)
> compared to the version not using a bitmap index, except for once case
> where it performs 70x worse: force-pushing "master~10:master" into a
> bitmapped repo takes 11s instead of 0.15s with bitmaps enabled.
> 
> Just leaving this here as a note for anybody (or myself) to pick up at a
> later point.

Thanks. I'd wager that's probably the "we find the exact bitmap for the
'haves'" problem. There are probably a lot of old refs with so-so bitmap
coverage, and we traverse all of them down to the nearest bitmap. If we
filled in the bitmap by traversing commits in timestamp or generation
order and ending at the merge-base, we could probably avoid looking at
them at all.

-Peff
