Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE911F454
	for <e@80x24.org>; Wed, 26 Sep 2018 04:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeIZKXT (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 06:23:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:59790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726062AbeIZKXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 06:23:18 -0400
Received: (qmail 17187 invoked by uid 109); 26 Sep 2018 04:12:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 04:12:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15181 invoked by uid 111); 26 Sep 2018 04:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 00:12:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 00:12:22 -0400
Date:   Wed, 26 Sep 2018 00:12:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 9/9] Documentation/config: add
 odb.<name>.promisorRemote
Message-ID: <20180926041222.GA743@sigill.intra.peff.net>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
 <20180802061505.2983-10-chriscool@tuxfamily.org>
 <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
 <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
 <xmqqd0t1nr93.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0t1nr93.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 03:31:36PM -0700, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > The main issue that this patch series tries to solve is that
> > extensions.partialclone config option limits the partial clone and
> > promisor features to only one remote. One related issue is that it
> > also prevents to have other kind of promisor/partial clone/odb
> > remotes. By other kind I mean remotes that would not necessarily be
> > git repos, but that could store objects (that's where ODB, for Object
> > DataBase, comes from) and could provide those objects to Git through a
> > helper (or driver) script or program.
> 
> I do not think "sources that are not git repositories" is all that
> interesting, unless they can also serve as the source for ext::
> remote helper.  And if they can serve "git fetch ext::...", I think
> they can be treated just like a normal Git repository by the
> backfill code that needs to lazily populate the partial clone.

I don't know about that. Imagine I had a regular Git repo with a bunch
of large blobs, and then I also stored those large blobs in something
like S3 that provides caching, geographic locality, and resumable
transfers.

It would be nice to be able to say:

  1. Clone from the real repo, but do not transfer any blobs larger than
     10MB.

  2. When you need a blob, check the external odb that points to S3. Git
     cannot know about this automatically, but presumably you would set
     a few config variables to point to an external-odb helper script.

  3. If for some reason S3 doesn't work, you can always request it from
     the original repo. That part _doesn't_ need extra config, since we
     can assume that the source of the promisor pack can feed us the
     extra objects[1].

But you don't need to ever be able to "git fetch" from the S3 repo.

Now if you are arguing that the interface to the external-odb helper
script should be that it _looks_ like upload-pack, but simply advertises
no refs and will let you fetch any object, that makes more sense to me.
It's not something you could "git clone", but you can "git fetch" from
it.

However, that may be an overly constricting interface for the helper.
E.g., we might want to be able to issue several requests and have them
transfer in parallel. But I suppose we could teach that trick to
upload-pack in the long run, as it may be applicable even to fetching
from "real" git repos.

Hmm. Actually, I kind of like that direction the more I think about it.

-Peff
