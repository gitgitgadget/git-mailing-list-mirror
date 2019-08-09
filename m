Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C5A1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406175AbfHILgP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:36:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:38818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbfHILgP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 07:36:15 -0400
Received: (qmail 10846 invoked by uid 109); 9 Aug 2019 11:36:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Aug 2019 11:36:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29538 invoked by uid 111); 9 Aug 2019 11:38:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Aug 2019 07:38:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Aug 2019 07:36:14 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809113613.GA3957@sigill.intra.peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190809111452.GA93559@syl.local>
 <20190809112552.GM118825@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809112552.GM118825@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 11:25:52AM +0000, brian m. carlson wrote:

> > > +			if (!flush_attributes && patch->new_name) {
> > > +				char *dummy = strip_path_suffix(patch->new_name, GITATTRIBUTES_FILE);
> > 
> > It's a shame that 'strip_path_suffix' doesn't take a 'char *out', and
> > accept NULL for that (which would save us the assignment and subsequent
> > 'free'). In either case, this is certainly the appropriate function.
> 
> Yeah, I felt the same way. We could refactor this out into two separate
> functions, one which returns an ssize_t and one which actually
> allocates, but I'm not sure it makes a huge amount of sense with just
> one caller. The allocation is relatively small, and I've tried to make
> sure it's called exactly once per patch so as not to be wasteful and
> inefficient.

I think you could do this with:

  size_t len;
  if (strip_suffix(patch->new_name, GITATTRIBUTES_FILE, &len) &&
      len > 0 && is_dir_sep(patch->new_name[len-1]))
          flush_attributes = 1;

Not sure if that is better or worse. It avoids the extra memory
boilerplate, but the logic is a slightly more subtle.

-Peff
