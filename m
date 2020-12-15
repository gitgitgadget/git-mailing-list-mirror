Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CDC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 01:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A0221D42
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 01:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgLOB20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 20:28:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:60654 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgLOB20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 20:28:26 -0500
Received: (qmail 9980 invoked by uid 109); 15 Dec 2020 01:27:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 01:27:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6241 invoked by uid 111); 15 Dec 2020 01:27:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 20:27:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 20:27:45 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Message-ID: <X9gREadU/cxBYREY@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201211210508.2337494-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 01:05:08PM -0800, Jonathan Tan wrote:

> Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
> 
> When cloning an empty repository, a default branch is created. However,
> it is named after the locally configured init.defaultBranch, not the
> default branch of the remote repository.

Your subject line puzzled me at first, because I thought we already did
that. And indeed we do, but this is about adding the unborn case. I
think this contributed to Ævar's confusion.

Maybe:

  Subject: clone: respect unborn remote HEAD

  When cloning, we choose the default branch based on the remote HEAD.
  But if there is no remote HEAD, we'll fall back to using our local
  init.defaultBranch. Traditionally this hasn't been a big deal, because
  everybody used "master" as the default. But these days it is likely to
  cause confusion if the server and client implementations choose
  different values (e.g., if the remote started with "main", we may
  choose "master" locally, create commits there, and then the user is
  surprised when they push to "master" and not "main").

  To solve this...

makes the current state more clear, as well as motivating why we care.

It might also be worth breaking the patch up a bit. E.g., implement the
capability in upload-pack, then infrastructure for the client to use the
capability and surface the info to transport callers, and then finally
surface it to in the program logic of ls-refs, then clone, etc.

Not strictly necessary, but it make it easier to see what is being
changed at each step.

> Currently, symrefs that have unborn targets (such as in this case) are
> not communicated by the protocol. Teach Git to advertise and support the
> "unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
> This feature indicates that "ls-refs" supports the "unborn" argument;
> when it is specified, "ls-refs" will send the HEAD symref with the name
> of its unborn target.

It's probably also worth mentioning that v0 won't get any support here,
and why.

-Peff
