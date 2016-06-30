Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7362720FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 06:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbcF3GXw (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 02:23:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:38156 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751203AbcF3GXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 02:23:51 -0400
Received: (qmail 22994 invoked by uid 102); 30 Jun 2016 06:22:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:22:43 -0400
Received: (qmail 5787 invoked by uid 107); 30 Jun 2016 06:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:22:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 02:22:37 -0400
Date:	Thu, 30 Jun 2016 02:22:36 -0400
From:	Jeff King <peff@peff.net>
To:	Laszlo Papp <lpapp@kde.org>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: git tag --contains for cherry-picks
Message-ID: <20160630062236.GA15380@sigill.intra.peff.net>
References: <CAOMwXhNp9SwA_oQ8bE6-m72C+po+28maGtsP8wRFRfBLjSb5NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMwXhNp9SwA_oQ8bE6-m72C+po+28maGtsP8wRFRfBLjSb5NA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 12:48:33PM +0100, Laszlo Papp wrote:

> Old releases are maintained with important bug fixes or even new features
> in our case. It sometimes means that we need to cherry-pick commits across
> branches, like from master to a specific release branch.
> 
> Cherry-picking changes the hash of the commit, therefore, this may no
> longer work for cherry-picks:
> 
> git tag --contains
> 
> I am thinking of having something like:
> 
> git tag --contains-follow
> 
> which would follow cherry-picks. I am not sure how easily and/or
> efficiently this can be implemented, but my gut feeling is that in the vast
> majority of the cases, the content check would bail out already at the
> "subject line".

Git generally considers commits "equivalent" based on the patch-id, whic
his a sha1 of the diff (modulo some canonicalization).

So you could ask right now for the patch-id of a particular commit:

  git show $commit | git patch-id >needle

and then the patch-id of all tagged commits:

  git log -p --tags | git patch-id | sort >haystack

Each line will have the patch-id followed by the commit id. You can then
correlate them (join is part of GNU coreutils):

  join needle haystack | cut -d' ' -f2- >synonyms

That gives you a list of synonym commits, which you can use to ask git
which tags contain any of them:

  git tag $(for i in $(cat synonyms); do echo "--contains $i"; done)

The big downside is that generating the haystack is expensive (it has to
do a diff on every commit). But if this is something you do a lot, you
can save the haystack and incrementally update it with new commits.


Of course there are other ways of determining commit equivalence. You
could find ones with duplicate commit messages, or duplicate subjects,
or whatever. But if you have a cherry-picking workflow, I suspect the
easiest thing may be to simply use "git cherry-pick -x", which will
write the sha1 of the original commit into the cherry-picked commit
message. You can then use that to correlate directly.

So there's no specific "--contains-follow" as you want, but the tools
are there to do it (and more flexibly and efficiently, depending on your
needs). That doesn't necessarily mean it's not a good idea to make the
simple case easier, though.

-Peff
