Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B30202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdJTVnP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:43:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:59376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752418AbdJTVnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:43:14 -0400
Received: (qmail 24489 invoked by uid 109); 20 Oct 2017 21:43:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 21:43:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19866 invoked by uid 111); 20 Oct 2017 21:43:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 17:43:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 17:43:12 -0400
Date:   Fri, 20 Oct 2017 17:43:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     David Lang <david@lang.hm>, Git mailing list <git@vger.kernel.org>
Subject: Re: hot to get file sizes in git log output
Message-ID: <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
 <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 01:44:36PM -0700, Jacob Keller wrote:

> On Fri, Oct 20, 2017 at 11:12 AM, David Lang <david@lang.hm> wrote:
> > I'm needing to scan through git history looking for the file sizes (looking
> > for when a particular file shrunk drastically)
> >
> > I'm not seeing an option in git log or git whatchanged that gives me the
> > file size, am I overlooking something?
> >
> > David Lang
> 
> I'm not exactly sure what you mean by size, but if you want to show
> how many lines were added and removed by a given commit for each file,
> you can use the "--stat" option to produce a diffstat. The "size" of
> the files in each commit isn't very meaningful to the commit itself,
> but a stat of how much was removed might be more accurate to what
> you're looking for.

That's a good suggestion, and hopefully could help David answer his
original question.

I took the request to mean "walk through history, and for each file that
a commit touches, show its size". Which is a bit harder to do, and I
think you need to script a little:

  git rev-list HEAD |
  git diff-tree --stdin -r |
  perl -lne '
    # raw diff line, capture filename and post-image sha1
    if (/^:\S+ \S+ \S+ (\S+) \S+\t(.*)/) {
      print "$1 $commit:$2"
    }
    # otherwise it is a commit sha1
    else {
      $commit = $_;
    }
  ' |
  git cat-file --batch-check='%(objectsize) %(rest)'

That should show the size of each file along with the "commit:path" in
which it was introduced.

-Peff
