Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8D31F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDFTss (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:48:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:56324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751968AbeDFTsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:48:47 -0400
Received: (qmail 25353 invoked by uid 109); 6 Apr 2018 19:48:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 19:48:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29043 invoked by uid 111); 6 Apr 2018 19:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 15:49:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 15:48:45 -0400
Date:   Fri, 6 Apr 2018 15:48:45 -0400
From:   Jeff King <peff@peff.net>
To:     Satya Prakash GS <g.satyaprakash@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: reg. fatal: The remote end hung up unexpectedly on NFS
Message-ID: <20180406194845.GB11450@sigill.intra.peff.net>
References: <CAJZK4X4-AZ6uEoVbAtQ9ErdJ2guKj9puXcpdX_3igBNPdQNp5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZK4X4-AZ6uEoVbAtQ9ErdJ2guKj9puXcpdX_3igBNPdQNp5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 11:55:51PM +0530, Satya Prakash GS wrote:

> We have a distributed filesystem with NFS access. On the NFS mount, I
> was doing a git-clone and if NFS server crashed and came back up while
> the clone is going on, clone fails with the below message:
> 
> git clone https://satgs@github.com/fs/private-qa.git
> 
> remote: Counting objects: 139419, done.
> remote: Compressing objects: 100% (504/504), done.
> Receiving objects:   7% (9760/139419), 5.32 MiB | 5.27 MiB/s
> error: RPC failed; result=18, HTTP code = 200 MiB | 96.00 KiB/s
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed

Curl's result=18 is CURLE_PARTIAL_FILE. Usually that means the other
side hung up partway through. But given the NFS symptoms you describe, I
wonder if fwrite() to the file simply returned an error, and curl gave
up.

> On NFS server crash, it usually takes a minute or two for our
> filesystem to failover to new NFS server. Initially I suspected it had
> something to do with the filesystem, like attributes of the file
> written by git weren't matching what it was expecting but the same
> test fails on open source NFS server. While clone is going on, if I
> stopped the open source NFS server for 2 minutes and restarted it, git
> clone fails.
> 
> Another interesting thing is, if the restart happens within a few
> seconds, git clone succeeds.
> 
> Sideband_demux fails while trying to read from the pipe. Read size
> doesn't match what is expected. If there are 2 parts to git clone
> which is fetching data and writing to local filesystem, is this error
> happening while trying to fetch ? Since it succeeds if the restart is
> done immediately, has this got something to do with the protocol
> timeouts.
> 
> Please advise on how to debug this further.

If you're on Linux, strace could show you the write error. Unfortunately
it's a little tricky because the http bits happen in a sub-process. But
try:

  cat >/in/your/$PATH/git-remote-strace <<\EOF
  #!/bin/sh
  protocol=$(echo "$2" | cut -d: -f1)
  exec strace -f -o /tmp/foo.out git-remote-$protocol "$@"
  EOF
  chmod +x /in/your/$PATH/git-remote-strace

  git clone strace::https://github.com/whatever

My guess is you may find a failed `write()` in there.

-Peff
