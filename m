Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295541F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393285AbfFMRJp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:09:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:54066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2393574AbfFMRJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:09:44 -0400
Received: (qmail 3265 invoked by uid 109); 13 Jun 2019 17:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 17:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20125 invoked by uid 111); 13 Jun 2019 17:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 13:10:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 13:09:41 -0400
Date:   Thu, 13 Jun 2019 13:09:41 -0400
From:   Jeff King <peff@peff.net>
To:     Farhan Khan <farhan@farhan.codes>
Cc:     git@vger.kernel.org
Subject: Re: Understanding last ~28 bytes of index file
Message-ID: <20190613170941.GA13670@sigill.intra.peff.net>
References: <c7c9012143e0818d332d0a9967c1a3e6@farhan.codes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7c9012143e0818d332d0a9967c1a3e6@farhan.codes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 06:32:03AM +0000, Farhan Khan wrote:

> I am trying to understand how the index (.git/index) file works. When
> looking through extensions, it loops until it reaches the last 28
> bytes (SHA size + 8). This is referenced here.
> https://github.com/git/git/blob/master/read-cache.c#L1933
> What do the last 28 bytes consist of? Where in the source are bytes written?

It is not that the last 28 bytes are magical. It is that you must have
at least 28 bytes remaining in the file for there to be any extension.
20 of those are the trailing sha1 hash (which are written as part of the
hashfile code in csum-file.c).

And then for there to be an extension, it must have 8 bytes of name and
length, which will then be followed by however many bytes the length
indicated. After parsing that, we check to see if there are enough bytes
for another extension, and so on.

To find where the index extension blocks themselves are written, perhaps
grep for write_index_ext_header(), which should be called before writing
out the data for each.

-Peff
