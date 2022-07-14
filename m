Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DEFC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiGNVh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiGNVhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:37:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A885066BA4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:37:24 -0700 (PDT)
Received: (qmail 19477 invoked by uid 109); 14 Jul 2022 21:37:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jul 2022 21:37:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32335 invoked by uid 111); 14 Jul 2022 21:37:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jul 2022 17:37:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jul 2022 17:37:22 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Horn <git@knutwalker.engineer>
Cc:     git@vger.kernel.org
Subject: Re: Bugreport: pack-objects died of signal 11
Message-ID: <YtCMklbIoTAN/WRs@coredump.intra.peff.net>
References: <977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 10:51:29AM +0200, Paul Horn wrote:

> ultimately, `git repack` segfaults:
> 
>     $ git repack
>     error: pack-objects died of signal 11

Can you provide a backtrace that shows where we segfaulted?  If you can
build Git from source and have access to a debugger like gdb, that
should be enough.

One option is to make sure core dumps are enabled (probably "ulimit -c
unlimited"), then run the failing repack, then find the core file
(usually in the current directory, but I'm not sure offhand about
macOS), and then open the debugger on it ("gdb /path/to/your/git
/path/to/core").

But perhaps easier may be to directly run the buggy pack-objects
invocation. I pulled the options here from your trace file. Something
like:

  gdb -ex 'set args pack-objects \
      --delta-base-offset tmp-pack \
      --keep-true-parents --honor-pack-keep --non-empty \
      --all --reflog --indexed-objects --unpacked --incremental \
      </dev/null' \
    /path/to/your/git

Then "r" to run inside the debugger, which will stop if we segfault. And
then "bt" will show the backtrace.

Alternatively, is it possible to make the offending repository available
(even off-list)?

-Peff
