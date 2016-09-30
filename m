Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FC4207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbcI3Tfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:35:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:50590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbcI3Tfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:35:36 -0400
Received: (qmail 31147 invoked by uid 109); 30 Sep 2016 19:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:35:36 +0000
Received: (qmail 13410 invoked by uid 111); 30 Sep 2016 19:35:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:35:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:35:34 -0400
Date:   Fri, 30 Sep 2016 15:35:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 0/6] receive-pack: quarantine pushed objects
Message-ID: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've mentioned before on the list that GitHub "quarantines" objects
while the pre-receive hook runs. Here are the patches to implement
that.

The basic problem is that as-is, index-pack admits pushed objects into
the main object database immediately, before the pre-receive hook runs.
It _has_ to, since the hook needs to be able to actually look at the
objects. However, this means that if the pre-receive hook rejects the
push, we still end up with the objects in the repository. We can't just
delete them as temporary files, because we don't know what other
processes might have started referencing them.

The solution here is to push into a "quarantine" directory that is
accessible only to pre-receive, check_connected(), etc, and only
move the objects into the main object database after we've finished
those basic checks.

One of the things we use it for at GitHub is object-size policy, which
we implement via a pre-receive hook (sort of; see below). This scheme
has been in use for about 2 years, though I did do a fair bit of
tweaking to make it ready for upstream (squashing bugfixes and merges
from upstream that came later, along with polishing a few rough edges I
saw while doing so). So I may have introduced new bugs. :)

The patches are:

  [1/6]: check_connected: accept an env argument
  [2/6]: sha1_file: always allow relative paths to alternates

    These two are preparatory.

  [3/6]: tmp-objdir: introduce API for temporary object directories
  [4/6]: receive-pack: quarantine objects until pre-receive accepts

    This is the interesting part.

  [5/6]: tmp-objdir: put quarantine information in the environment
  [6/6]: tmp-objdir: do not migrate files starting with '.'

    These are two changes that I ended up doing later to support another
    series. They're not strictly necessary here, but I think they're
    worth including now, as they change the visible behavior in minor
    ways. It seems like a good idea to start with what I think should be
    the final behavior.

    The other series is basically an optimization for the object-size
    policy. Without it, you are stuck walking the graph again in the
    pre-receive hook to find the new objects and check their sizes.

    But index-pack can do that for you very cheaply; it has the size of
    each object already. But it _doesn't_ produce nice error messages;
    it has no idea at what path the objects are found, and it doesn't
    know what kind of advice it should give the user.

    So what we can do is ask index-pack to make a note of any objects
    larger than N bytes, and write their sha1 and size into a file in
    the quarantine path. Then the pre-receive hook can look in that log
    and generate any nice message it wants. In the common case, the log
    is empty, and it does not have to do any work at all.

    These two patches set that up by letting index-pack and pre-receive
    know that quarantine path and use it to store arbitrary files that
    _don't_ get migrated to the main object database (i.e., the log file
    mentioned above).

-Peff
