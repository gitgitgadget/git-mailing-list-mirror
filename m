Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B78C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F0F610A8
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhFBUCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:02:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:44394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhFBUCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:02:44 -0400
Received: (qmail 2325 invoked by uid 109); 2 Jun 2021 20:01:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Jun 2021 20:01:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20579 invoked by uid 111); 2 Jun 2021 20:01:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Jun 2021 16:01:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Jun 2021 16:00:59 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLfjexczp1/HILWj@coredump.intra.peff.net>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
 <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net>
 <CAOLTT8SCeKy74cVO3K5zJ5n=0s=o9zk2ipV5wM6CHQPzRoMi5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8SCeKy74cVO3K5zJ5n=0s=o9zk2ipV5wM6CHQPzRoMi5Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 09:15:45PM +0800, ZheNing Hu wrote:

> > The commit message hints at the root of the problem, but doesn't say it
> > explicitly. Which is: because setting skip_object_info depends on seeing
> > that the object_info is empty, we can't add items to it after setting
> > that flag. And the code path for --batch does that, hence re-ordering
> > them is the solution.
> 
> Um, let's rewrite the commit message, I don't know if this is accurate:
> 
> [GSOC] cat-file: fix --batch report changed-type bug
> 
> When `--batch` used with `--batch-all-objects`,
> with some format atoms like %(objectname), %(rest)
> or even no atoms may cause Git exit and report
> "object xxx changed type!?".
> 
> E.g. `git cat-file --batch="batman" --batch-all-objects`
> 
> The bug was present from when the skip_object_info code
> was initially added in 845de33a5b (cat-file: avoid
> noop calls to sha1_object_info_extended, 2016-05-18).
> 
> This is because we did not get the object type through
> oid_object_info_extended(), it's composed of two
> situations:
> 
> 1. all_objects will be set to true when we use
> `--batch-all-objects`, seeing that object_info
> is empty, skip_object_info will be to true,
> `oid_object_info_extended()` will not get the
> type of the object.
> 
> 2. The formatting atom like %(objectname) does
> not require oid_object_info_extended() to collect
> object types.
> 
> print_contents will be set to true when we use
> `--batch`, which can make object_info non-empty,
> so the solution is to swap the code order of it
> and checking if object_info is empty, which will
> ensure that we must get the type of the object
> when using --batch.

I don't see any inaccuracies there. I do think we could explain it a bit
more succinctly. I'll give my attempt, and then you can pick and choose
which parts to include between ours. :)

  Subject: cat-file: handle trivial --batch format with --batch-all-objects

  The --batch code to print an object assumes we found out the type of
  the object from calling oid_object_info_extended(). This is true for
  the default format, but even in a custom format, we manually modify
  the object_info struct to ask for the type.

  This assumption was broken by 845de33a5b (cat-file: avoid noop calls
  to sha1_object_info_extended, 2016-05-18). That commit skips the call
  to oid_object_info_extended() entirely when --batch-all-objects is in
  use, and the custom format does not include any placeholders that
  require calling it.

  This results in an error when we try to confirm that the type didn't
  change:

    $ git cat-file --batch=batman --batch-all-objects
    batman
    fatal: object 000023961a0c02d6e21dc51ea3484ff71abf1c74 changed type!?

  and also has other subtle effects (e.g., we'd fail to stream a blob,
  since we don't realize it's a blog in the first place).

  We can fix this by flipping the order of the setup. The check for "do
  we need to get the object info" must come _after_ we've decided
  whether we need to look up the type.

-Peff
