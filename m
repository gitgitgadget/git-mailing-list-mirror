Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A581C2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbcGOKZM (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:25:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:45290 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932082AbcGOKZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:25:10 -0400
Received: (qmail 17718 invoked by uid 102); 15 Jul 2016 10:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:25:11 -0400
Received: (qmail 14093 invoked by uid 107); 15 Jul 2016 10:25:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:25:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:25:06 -0400
Date:	Fri, 15 Jul 2016 06:25:06 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 0/12] push progress reporting and keepalives
Message-ID: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If you push a large number of objects, the server side may have to chew
CPU for a long time processing the input (delta resolution, connectivity
check, and whatever any hooks choose to do). During this time, you get
no feedback that anything is happening, unless the hooks feel like
writing something to stderr.  For a repository the size of linux.git, a
full push from scratch can take several minutes.

This is annoying and confusing to the user, who wonders if the
connection has hung. But it can also cause problems on systems that have
other timeouts (e.g., firewalls dropping TCP sessions, or web proxies
dropping requests that produce no response within a certain time).

This patch series adds two new features:

 1. Progress reporting for the CPU-intensive parts of receive-pack.

 2. A keepalive mechanism similar to what we use in upload-pack
    (basically sending zero-length packets on sideband 1 while the client
    is waiting for us to speak).

Both are enabled for any client which speaks the sideband protocol.
Existing versions of git handle the new behavior just fine (the progress
reporting is easy, because they were expecting stderr messages anyway;
the keepalive works because the demuxer just relays zero bytes back to
send-pack).

I also tested with both JGit and libgit2 clients, and both seem to
handle the zero-length packets just fine.

There are unfortunately no automated tests, as it's hard to simulate the
effect. My manual testing involved inserting "sleep" statements into
index-pack (and hooks with manual sleeps), and then using "strace" to
confirm that the keepalives were sent.

  [01/12]: check_everything_connected: always pass --quiet to rev-list
  [02/12]: rev-list: add optional progress reporting
  [03/12]: check_everything_connected: convert to argv_array
  [04/12]: check_everything_connected: use a struct with named options
  [05/12]: check_connected: relay errors to alternate descriptor
  [06/12]: check_connected: add progress flag
  [07/12]: clone: use a real progress meter for connectivity check
  [08/12]: index-pack: add flag for showing delta-resolution progress
  [09/12]: receive-pack: turn on index-pack resolving progress
  [10/12]: receive-pack: relay connectivity errors to sideband
  [11/12]: receive-pack: turn on connectivity progress
  [12/12]: receive-pack: send keepalives during quiet periods

-Peff
