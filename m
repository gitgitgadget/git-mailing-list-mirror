Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B171F731
	for <e@80x24.org>; Fri,  9 Aug 2019 13:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406503AbfHINvu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 09:51:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:38936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbfHINvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 09:51:50 -0400
Received: (qmail 11518 invoked by uid 109); 9 Aug 2019 13:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Aug 2019 13:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30521 invoked by uid 111); 9 Aug 2019 13:54:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Aug 2019 09:54:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Aug 2019 09:51:49 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809135148.GA7495@sigill.intra.peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190809111452.GA93559@syl.local>
 <20190809112552.GM118825@genre.crustytoothpaste.net>
 <20190809113613.GA3957@sigill.intra.peff.net>
 <20190809124318.GJ20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809124318.GJ20404@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 02:43:18PM +0200, SZEDER Gábor wrote:

> > I think you could do this with:
> > 
> >   size_t len;
> >   if (strip_suffix(patch->new_name, GITATTRIBUTES_FILE, &len) &&
> >       len > 0 && is_dir_sep(patch->new_name[len-1]))
> >           flush_attributes = 1;
> > 
> > Not sure if that is better or worse. It avoids the extra memory
> > boilerplate, but the logic is a slightly more subtle.
> 
> Subtle indeed :) because you have to allow len == 0 to catch the
> toplevel .gitattributes file.

I'll pretend I was leaving that as a puzzle for the readers. :)

> But there is an other subtlety here: when I read the commit message
> saying "patch that touches a path ending in ".gitattributes"." and saw
> the new call to strip_path_suffix(), I immediately thought what would
> happen with a file called 'foo.gitattributes'.  Only when I looked
> into strip_path_suffix() became it clear that it only removes full
> path components, so such a filename won't cause any trouble (though
> perhaps the worst thing that could happen is that we unnecessarily
> flush the attributes cache).

Right. I think the term we want here is really "basename". So in fact:

  if (!strcmp(basename(patch->new_name), GITATTRIBUTES_FILE))

would do what we want, except for the annoying caveat that basename() is
allowed to modify its parameter (to remove trailing directory
separators, but we know we wouldn't have them here).

-Peff
