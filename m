Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CDC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDE823370
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAMNqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:46:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:54720 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbhAMNqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:46:44 -0500
Received: (qmail 22497 invoked by uid 109); 13 Jan 2021 13:46:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:46:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29998 invoked by uid 111); 13 Jan 2021 13:46:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:46:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:46:02 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
Message-ID: <X/75mip8tYO/mmSW@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <xmqq5z4153gq.fsf@gitster.c.googlers.com>
 <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 06:25:20PM -0500, Jeff Hostetler wrote:

> On the Unix side, the socket is created inside the .git directory
> by the daemon.  Potential clients would have to have access to the
> working directory and the .git directory to connect to the socket,
> so in normal circumstances they would be able to read everything in
> the WD anyway.  So again, I don't think it is a problem.

Just thinking out loud, here are two potential issues with putting it in
.git that we may have to deal with later:

  - fsmonitor is conceptually a read-only thing (i.e., it would speed up
    "git status", etc). And not knowing much about how it will work, I'd
    guess that is carried through (i.e., even though you may open the
    socket R/W so that you can write requests and read them back, there
    is no operation you can request that will overwrite data). But the
    running user may not have write access to .git.

    As long as we cleanly bail to the non-fsmonitor code paths, I don't
    think it's the end of the world. Those read-only users just won't
    get to use the speedup (and it may even be desirable). They may
    complain, but it is open source so the onus is on them to improve
    it. You will not have made anything worse. :)

  - repositories may be on network filesystems that do not support unix
    sockets.

So it would be nice if there was some way to specify an alternate path
to be used for the socket. Possibly one or both of:

  - a config option to give a root path for sockets, where Git would
    then canonicalize the $GIT_DIR name and use $root/$GIT_DIR for the
    socket. That solves the problem for a given user once for all repos.

  - a config option to say "use this path for the socket". This would be
    per-repo, but is more flexible and possibly less confusing.

One final note: on some systems[1] the permissions on the socket file
itself are ignored. The safe way to protect it is to make sure the
permissions on the surrounding directory are what you want. See
credential-cache's init_socket_directory() for an example.

-Peff

[1] Sorry, I don't remember which systems. This is one of those random
    bits of Unix lore I've carried around for 20 years, and it's
    entirely possible it is simply obsolete at this point.
