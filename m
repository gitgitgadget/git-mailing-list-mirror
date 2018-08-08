Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F393F1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeHIAxY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:53:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:47594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727706AbeHIAxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:53:24 -0400
Received: (qmail 16834 invoked by uid 109); 8 Aug 2018 22:31:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 22:31:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3722 invoked by uid 111); 8 Aug 2018 22:31:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 18:31:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 18:31:39 -0400
Date:   Wed, 8 Aug 2018 18:31:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180808223139.GA3902@sigill.intra.peff.net>
References: <20180730152756.15012-1-pclouds@gmail.com>
 <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 08, 2018 at 03:48:04PM -0400, Jeff Hostetler wrote:

> > ce_match_stat() may not be a very good measure to see if two paths
> > refer to the same file, though.  After a fresh checkout, I would not
> > be surprised if two completely unrelated paths have the same size
> > and have same mtime/ctime.  In its original use case, i.e. "I have
> > one specific path in mind and took a snapshot of its metadata
> > earlier.  Is it still the same, or has it been touched?", that may
> > be sufficient to detect that the path has been _modified_, but
> > without reliable inum, it may be a poor measure to say two paths
> > refer to the same.
> 
> I agree with Junio on this one.  The mtime values are sloppy at best.
> On FAT file systems, they have 2 second resolution.  Even NTFS IIRC
> has only 100ns resolution, so we might get a lot of false matches
> using this technique, right?

Yeah, I think anything less than inode (or some system equivalent) is
going to be too flaky.

> It might be better to build an equivalence-class hash-map for the
> colliding entries.  Compute a "normalized" version of the pathname
> (such as convert to lowercase, strip final-dots/spaces, strip the
> digits following tilda of a shortname, and etc for the MAC's UTF-isms).
> Then when you rescan the index entries to find the matches, apply the
> equivalence operator on the pathname and do the hashmap lookup.
> When you find a match, you have a "potential" collider pair (I say
> potential only because of the ambiguity of shortnames).  Then we
> can use inum/file-index/whatever to see if they actually collide.

I think we really want to avoid doing that normalization ourselves if we
can. There are just too many filesystem-specific rules.

If we have an equivalence-class hashmap and feed it inodes (or again,
some system equivalent) as the keys, we should get buckets of
collisions. I started to write a "something like this..." earlier, but
got bogged down in boilerplate around the C hashmap.

But here it is in perl. ;)

-- >8 --
# pretend we have these paths in our index
paths='foo FOO and some other paths'

# create them; this will make a single path on a case-insensitive system
for i in $paths; do
  echo $i >$i
done

# now find the duplicates
perl -le '
  for my $path (@ARGV) {
    # this would be an ntfs unique-id on Windows
    my $inode = (lstat($path))[1];
    push @{$h{$inode}}, $path;
  }

  for my $group (grep { @$_ > 1 } values(%h)) {
    print "group:";
    print "  ", $_ for (@$group);
  }
' $paths
-- >8 --

which should show the obvious pair (it does for me on vfat-on-linux,
though where it gets those inodes from, I have no idea ;) ).

-Peff
