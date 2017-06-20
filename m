Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C0320D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 14:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdFTOvD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 10:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750993AbdFTOvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 10:51:03 -0400
Received: (qmail 25379 invoked by uid 109); 20 Jun 2017 14:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Jun 2017 14:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13512 invoked by uid 111); 20 Jun 2017 14:51:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jun 2017 10:51:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jun 2017 10:51:01 -0400
Date:   Tue, 20 Jun 2017 10:51:01 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     paul.mattke@s4m.com, git@vger.kernel.org
Subject: Re: Transform log message during migration svn -> git (using git-svn)
Message-ID: <20170620145101.6mjikvmxegw5pbwj@sigill.intra.peff.net>
References: <8ce2bf074fcf4d6181a29eb3e7fff132@GTLBML3EX0005.bagmail.net>
 <EAA4B747-FA00-4A3B-88CD-AF8EBE1F8586@gmail.com>
 <90ee80a910884e1e98fa8a5001ae850c@GTLBML3EX0005.bagmail.net>
 <BDA6D349-0DF9-49F3-B2B6-0B1AE3BBD052@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BDA6D349-0DF9-49F3-B2B6-0B1AE3BBD052@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 02:46:22PM +0200, Lars Schneider wrote:

> 
> > On 20 Jun 2017, at 14:32, <paul.mattke@s4m.com> <paul.mattke@s4m.com> wrote:
> > 
> > Well this is a possibility, of course. Our problem is that our SVN
> > repository contains about 220.000 revisions currently. As a colleague of
> > mine said that the command you suggest might take about 4 seconds per
> > revision, it would take about 10 days to do this for our whole repository.
> > So of course it could save a lot of time generally if such operation could
> > be done immediately during git-svn.
> 
> You colleague is most likely correct. I suggested it as this is a one time
> operation and therefore still somewhat practical from my point of view.

I didn't follow this whole thread, but I happened to see this bit. I
think the command in question is:

  git filter-branch -f --msg-filter 'perl -lape "s/^T(\d+)/#\$1/"'

I know filter-branch is slow, but a msg-filter should be relatively
fast.  I'd be surprised at 4 seconds per revision (the main cost is
kicking off a new perl process per revision). It's more like 120/sec on
my machine.

However, I think the fastest way would be to do it with fast-export,
where you can just tweak the stream as it flows through:

  # set up a new repo to hold the results; we won't bother
  # copying the blobs, so just point at the current repo as an
  # alternate.
  git init fixed-repo
  echo "../../../.git/objects" >fixed-repo/.git/objects/info/alternates

  git fast-export --no-data --all |
  perl -ne '
	# look for "data" chunks which contain the commit message
	if (/^data (\d+)/) {
		read STDIN, my $buf, $1;
		$buf =~ s/^T(\d+)/#$1/;
		print "data ", length($buf), "\n";
		print $buf;
	} else {
		print;
	}
  ' |
  git -C fixed-repo fast-import

That runs at about 3600 commits/sec on my machine.

Most of that time goes to doing a tree diff on each commit. Technically
that is not required for your use case, but I don't think there's a way
to get fast-export to skip that (and it's an inherent part of the
fast-import stream). It's probably fast enough, but it's possible that
a specialized tool like BFG repo cleaner[1] could do better (I don't
know offhand if it handles commit message rewrites or not).

-Peff

[1] https://rtyley.github.io/bfg-repo-cleaner/
