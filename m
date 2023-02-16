Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FCC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBPVF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 16:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjBPVFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 16:05:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E862B632
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 13:05:24 -0800 (PST)
Received: (qmail 31853 invoked by uid 109); 16 Feb 2023 21:05:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 21:05:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10154 invoked by uid 111); 16 Feb 2023 21:05:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 16:05:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 16:05:22 -0500
From:   Jeff King <peff@peff.net>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: Add --mtime option to git archive
Message-ID: <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
References: <Y+6G9n6cWRT9EKyl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+6G9n6cWRT9EKyl@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 12:41:42PM -0700, Raul E Rangel wrote:

> When generating a tarball with `git archive <tree>`, `git archive` will
> use the current time as the mtime. This results in a non-hermetic
> tarball. Could we should add a --mtime option that allows passing in
> the time? 

That seems like a very reasonable feature to have. Just to sketch out
the implementation, in case anybody wants to work on it:

  - options are read first in cmd_archive(), but it passes unknown ones
    on to write_archive(), which is where we parse the interesting ones.

  - that relies on parse_archive_args() in archive.c. So we'd want a new
    option in opts[] there, and to write the value into a new field in
    the archiver_args struct.

  - the time is filled in via parse_treeish_arg(), where we use
    time(NULL) if there's no commit. And there we'd just use the value
    from archiver_args.

    If there is a commit and they've specified --mtime, what should
    happen? Quietly ignore it? Override the commit's timestamp? Complain
    and bail?

  - I didn't look at how this might interact with "git archive
    --remote". I think it might just all work, as we just ship the
    options to the other side, which parses them itself using the same
    code.

-Peff
