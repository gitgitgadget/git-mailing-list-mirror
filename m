Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA0120248
	for <e@80x24.org>; Fri,  1 Mar 2019 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCATjQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 14:39:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:34884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727545AbfCATjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:14 -0500
Received: (qmail 22355 invoked by uid 109); 1 Mar 2019 19:39:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 19:39:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 860 invoked by uid 111); 1 Mar 2019 19:39:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 14:39:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 14:39:12 -0500
Date:   Fri, 1 Mar 2019 14:39:12 -0500
From:   Jeff King <peff@peff.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] name-rev: improve memory usage
Message-ID: <20190301193912.GA28195@sigill.intra.peff.net>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
 <20190301184208.GD30847@sigill.intra.peff.net>
 <c496ca1a-d493-64cf-9e9d-d1aa189bd33d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c496ca1a-d493-64cf-9e9d-d1aa189bd33d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 08:14:26PM +0100, Alban Gruin wrote:

> > diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> > index f1cb45c227..7aaa86f1c0 100644
> > --- a/builtin/name-rev.c
> > +++ b/builtin/name-rev.c
> > @@ -431,6 +431,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
> >  		OPT_END(),
> >  	};
> >  
> > +	save_commit_buffer = 0;
> > +
> [...]
> 
> Unfortunately this does not work in all cases, apparently.  On my git
> copy, I have 3 origins.  If I run this:
> 
> 	git log --graph --oneline --abbrev=-1 -5 | git name-rev --stdin
> 
> With or without your change, it uses 3GB of RAM.  With this series, it
> uses 25MB of RAM.

Sorry if I was unclear. I meant to try that _in addition_ to your
changes. It helps by avoiding keeping the useless commit-object buffers
in RAM as we traverse. But the most it can save is the total
uncompressed bytes of all commit objects. I.e., in git.git:

  $ git cat-file --batch-check='%(objectsize) %(objecttype)' --batch-all-objects |
    grep commit |
    perl -alne '$total += $F[0]; END { print $total }'
  74678114

or around 70MB. In linux.git, it's more like 700MB.

But in your examples, the problem is the inefficiencies in name-rev's
algorithm, and you're not actually traversing that many commits. So I
think you'd want to turn off save_commit_buffer as an extra patch in
your series. It may or not be a big win for any given case, but it's
quite easy to do.

-Peff
