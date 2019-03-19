Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF44220248
	for <e@80x24.org>; Tue, 19 Mar 2019 06:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCSGjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 02:39:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:56080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726020AbfCSGjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 02:39:06 -0400
Received: (qmail 7943 invoked by uid 109); 19 Mar 2019 06:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 06:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27166 invoked by uid 111); 19 Mar 2019 06:39:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Mar 2019 02:39:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2019 02:39:05 -0400
Date:   Tue, 19 Mar 2019 02:39:05 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how can i "gc" or "prune" objects related to a deleted remote?
Message-ID: <20190319063904.GC31801@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1903081029510.25426@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1903081029510.25426@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 10:36:44AM -0500, Robert P. J. Day wrote:

>   as an example, i cloned the linux kernel source tree, then added
> the linux-next repo as a remote -- the end result was two pack files
> (the smaller one i'm assuming being for linux-next):
> 
> $ ls -l .git/objects/pack
> total 2723632
> -r--r--r--. 1 rpjday rpjday    1215376 Mar  8 09:44 pack-08cc266c0914e924961a1c8412fdf8746d327d7e.idx
> -r--r--r--. 1 rpjday rpjday   38402840 Mar  8 09:44 pack-08cc266c0914e924961a1c8412fdf8746d327d7e.pack
> -r--r--r--. 1 rpjday rpjday  204032716 Mar  8 09:42 pack-1036510bb74967c91093fc0cd8982683a66dbf5f.idx
> -r--r--r--. 1 rpjday rpjday 2545333327 Mar  8 09:42 pack-1036510bb74967c91093fc0cd8982683a66dbf5f.pac
> $
> 
>   after playing with a couple branches from the new remote, i deleted
> the remote, then also did things like clear the reflog, delete any
> local tracking branches related to the deleted remote, and so on, but
> i can't seem to prune the objects that should no longer be reachable
> now that i deleted that remote.

After arriving at a similar state, I did:

  git remote rm linux-next
  git tag -d next-20190319
  git gc --prune=now

My guess is you forgot the tag? There's not a general solution there,
because the tags all get intermingled. Git has no idea which ones came
from which remote. However, if you have the commit id of an object you
expect to be going away, you can use:

  git for-each-ref --contains=$that_commit

to see what's still pointing to it (even indirectly).

Expiring the HEAD reflog is another frequently-forgotten thing, but in
my case I had never actually checked out any branches. You should be
able to do "git reflog expire --expire-unreachable=now --all" for that.

>   what am i overlooking? is it because those objects are in a separate
> pack file? do i need to repack first? what is hanging onto those
> objects in that second pack file such that they can't be garbage
> collected?

The two packs shouldn't matter. The gc process works by repacking what's
reachable, not including what's not, and then deleting the old packs.

-Peff
