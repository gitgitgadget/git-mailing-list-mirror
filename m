Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D31D1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 20:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDFUEq (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:04:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:56358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751276AbeDFUEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 16:04:45 -0400
Received: (qmail 25943 invoked by uid 109); 6 Apr 2018 20:04:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 20:04:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29103 invoked by uid 111); 6 Apr 2018 20:05:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 16:05:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 16:04:43 -0400
Date:   Fri, 6 Apr 2018 16:04:43 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org, git@vger.kernel.org
Subject: Re: [PATCH 3/7] diff.c: do not pass diff options as keydata to
 hashmap
Message-ID: <20180406200443.GE11450@sigill.intra.peff.net>
References: <20180402224854.86922-1-sbeller@google.com>
 <20180402224854.86922-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180402224854.86922-4-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 02, 2018 at 03:48:50PM -0700, Stefan Beller wrote:

> The diff options are passed to the compare function as
> 'hashmap_cmp_fn_data', which are given when the hashmaps
> are initialized.
> 
> A later patch will make use of the keydata to signal
> different settings for comparision.

I had to scratch my head here for a moment. Don't we use those options
as part of the comparison?

I took the "which" to mean "the compare function", but I think you mean
"we pass these diff options already when the hashmap is initialized".

Maybe something like this would be more clear:

  When we initialize the hashmap, we give it a pointer to the
  diff_options, which it then passes along to each call of the
  hashmap_cmp_fn function. There's no need to pass it a second time as
  the "keydata" parameter, and our comparison functions never look at
  keydata.

  This was a mistake left over from an earlier round of 2e2d5ac184
  (diff.c: color moved lines differently, 2017-06-30), before hashmap
  learned to pass the data pointer for us.

(I'm just guessing on the second paragraph based on a quick look at
git-blame and my recollection from the time).

-Peff
