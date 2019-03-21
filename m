Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D6D20248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCUTjO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:39:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726787AbfCUTjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:39:14 -0400
Received: (qmail 25386 invoked by uid 109); 21 Mar 2019 19:39:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Mar 2019 19:39:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12518 invoked by uid 111); 21 Mar 2019 19:39:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 15:39:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 15:39:12 -0400
Date:   Thu, 21 Mar 2019 15:39:12 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Strange annotated tag issue
Message-ID: <20190321193912.GB19427@sigill.intra.peff.net>
References: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
 <CAGyf7-F4vvzwVsdgtiog+xvwgHgYkNMKQ59bCxrZYtdn+eGAPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-F4vvzwVsdgtiog+xvwgHgYkNMKQ59bCxrZYtdn+eGAPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 12:04:22PM -0700, Bryan Turner wrote:

> > Why does it show two entries? In my `packed-refs` file, it also shows
> > a strange revision for the tag (I expect to see just 1 SHA1). Not sure
> > if it is related:
> >
> > ```
> > 66c41d67da887025c4e22e9891f5cd261f82eb31 refs/tags/4.2.0.1900
> > ^2fcfd00ef84572fb88852be55315914f37e91e11
> > ```
> 
> This part, though, is normal for "packed-refs". The first line shows
> the annotated tag object's hash ("66c41d67da8") and the tagged
> object's hash ("2fcfd00ef8"). You can see that "2fcfd00ef8" matches
> the tagged commit output by "git show". The leading "^" on the second
> line is how Git knows the line identifies a peeled tag's target rather
> than the start of a new ref. If your "packed-refs" starts with
> "peeled" (and maybe "fully-peeled") then every annotated (or signed)
> tag in the file should have a second line prefixed by "^".

Nicely explained.

I think there's one other interesting bit of trivia, since we seem to be
dealing with a tag-of-a-tag here. We store only a single peeled value
for each ref, whatever is at the bottom (which is always a non-tag). So
in this case of a tag that points to a tag that points to a commit, the
peeled value is the commit, and the tag in the middle isn't mentioned.

Likewise for upload-pack output, which mentions the peeled objects (so
that clients can auto-fetch tags). It only gives the full peeling.

In theory we could store and advertise the intermediate objects, but I
don't think anybody has ever cared enough about this case to explore
that (and this is mostly an optimization; it should all work correctly,
and I recall fixing some bugs over the years).

-Peff
