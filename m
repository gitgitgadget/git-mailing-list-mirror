Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391191F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbcGTNOh (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:14:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:47432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754048AbcGTNOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:14:33 -0400
Received: (qmail 7976 invoked by uid 102); 20 Jul 2016 13:14:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:14:32 -0400
Received: (qmail 20314 invoked by uid 107); 20 Jul 2016 13:14:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:14:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:14:24 -0600
Date:	Wed, 20 Jul 2016 07:14:24 -0600
From:	Jeff King <peff@peff.net>
To:	Ernesto Maserati <ernesto.2.maserati@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: How to generate feature branch statistics?
Message-ID: <20160720131424.GC17469@sigill.intra.peff.net>
References: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:05:09AM +0200, Ernesto Maserati wrote:

> I assume that feature branches are not frequently enough merged into
> master. Because of that we discover bugs later than we could with a more
> continuous code integration. I don't want to discuss here whether feature
> branches are good or bad.
> 
> I want just to ask is there a way how to generate a statistic for the
> average duration of feature branches until they are merged to the master? I
> would like to know if it is 1 day, 2 days or lets say 8 or 17 days. Also it
> would be interesting to see the statistical outliers.

In a workflow that merges feature branches to master, you can generally
recognize them by looking for merges along the first-parent chain of
commits:

  git log --first-parent --merges master

(Depending on your workflow, some feature branches may be fast-forwards
with no merge commit, so this is just a sampling. Some workflows use
"git merge --no-ff" to merge in feature branches, so this would see all
of them).

And then for each merge, you can get the set of commits that were merged
in (it is the commits in the second parent that are not in the first).
The bottom-most one is the "start" of the branch (or close to it; of
course the author started writing code before they made a commit), and
the "end" is the merge itself.

So something like:

  git rev-list --first-parent --merges master |
  while read merge; do
	start=$(git log --format=%at $merge^1..$merge^2 | tail -1)
	end=$(git log -1 --format=%at $merge)
	subject=$(git log -1 --format=%s $merge)
	echo "$((end - start)) $subject"
  done

That should output a sequence of topic branch merges prefixed by the
number of seconds they were active. Two exercises for the reader:

  1. Converting seconds into some more useful time scale. :)

  2. This can probably be done with fewer invocations of git,
     which would be more efficient.

-Peff
