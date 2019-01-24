Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08A51F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfAXTSi (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:18:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:47774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727558AbfAXTSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:18:38 -0500
Received: (qmail 10229 invoked by uid 109); 24 Jan 2019 19:18:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 19:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31429 invoked by uid 111); 24 Jan 2019 19:18:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 14:18:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 14:18:36 -0500
Date:   Thu, 24 Jan 2019 14:18:36 -0500
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124191836.GA31073@sigill.intra.peff.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124121037.GA4949@sigill.intra.peff.net>
 <20190124183810.GC29200@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124183810.GC29200@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 02:38:10PM -0400, Joey Hess wrote:

> > Just off the top of my head, something like:
> > 
> >   /* guess that the filtered output will be the same size as the original */
> >   hint = len;
> > 
> >   /* allocate 10% extra in case the clean size is slightly larger */
> >   hint *= 1.1;
> > 
> >   /*
> >    * in any case, never go higher than half of core.bigfileThreshold.
> >    * We'd like to avoid allocating more bytes than that, and that still
> >    * gives us room for our strbuf to preemptively double if our guess is
> >    * just a little on the low side.
> >    */
> >   if (hint > big_file_threshold / 2)
> > 	hint = big_file_threshold / 2;
> > 
> > But to be honest, I have no idea if that would even produce measurable
> > benefits over simply growing the strbuf from scratch (i.e., hint==0).
> 
> Half of 512 MB is still quite a lot of memory to default to using in
> this situation. Eg smaller VPS's still often only have a GB or two of ram.

I think you'd want to drop core.bigFileThreshold on such a server, just
because Git will happily keep 2*(bigFileThreshold-1) in memory to do a
diff. But that nit aside...

> I did some benchmarking, using cat as the clean filter:
> [...]
> From this, it looks like the file has to be quite large before the
> preallocation makes a sizable improvement to runtime, and the
> smudge/clean filters have to be used for actual content filtering
> (not for hash generation purposes as git-annex and git-lfs use it).
> An unusual edge case I think. So hint == 0 seems fine.

Thanks for these timings! I agree that "hint == 0" is probably
reasonable, then.

I suppose there's no reason not to proceed with a patch around this.
For most cases it's really only half the solution (since smudging is
going to run into the same problem). But fixing that is quite a bit more
involved, and the change itself will be largely orthogonal.

-Peff
