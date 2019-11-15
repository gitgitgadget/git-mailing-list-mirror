Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248471F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 03:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKOD5N (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 22:57:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:48014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726674AbfKOD5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 22:57:12 -0500
Received: (qmail 25385 invoked by uid 109); 15 Nov 2019 03:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 03:57:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10025 invoked by uid 111); 15 Nov 2019 04:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 23:00:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 22:57:11 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
Message-ID: <20191115035711.GC20863@sigill.intra.peff.net>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
 <CAGyf7-GTWsQEYH9mkM8TkY1PusMimtYcSaKhHubN_KsOtMRiBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-GTWsQEYH9mkM8TkY1PusMimtYcSaKhHubN_KsOtMRiBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 05:19:39PM -0800, Bryan Turner wrote:

> Just to provide a little context, this isn't coming up as something I
> myself hit. Rather, it's a fairly common issue reported by Bitbucket
> Server end users, and I would assume it happens with other hosting
> providers as well: A user URL-hacks an ambiguous (or "ambiguous", in
> cases like this) short hash and is disappointed when the system
> doesn't manage to find the commit they were looking for. I'm just
> investigating possible avenues for improving how Bitbucket Server
> handles these cases. One option is to (essentially) parse the "hint",
> if it's present, to get the candidates, and include them on the error
> message we display. But in cases like the above it gets weird because
> there's only one _commit_ candidate, and having our error message
> include trees and blobs seems likely to be confusing/unexpected. I
> suspect most Bitbucket Server users would say "The answer's obvious!
> Why didn't you just use the commit?!", and I can sort of get behind
> that view. The combination of using the disambiguation mechanism, so
> single-commit ambiguities are resolved automatically, and parsing the
> hint seems like it would produce the most logical behavior.

It depends on your URL scheme obviously, but on GitHub for example, it
would make sense for https://github.com/user/repo/commit/1234abcd to use
the "^{commit}" trick. I don't think it currently does, though.

> Where users get the short hashes they try is an interesting question.
> As you say, Git wouldn't display a 5 character short hash, at least by
> default, and Bitbucket Server doesn't either; it shows a flat 11
> characters. I'm not sure, on that point.

GitHub often produces 7-char short hashes, because it's abbreviating
them in presentation code that doesn't want to spend the round trip to
talk to the repo (to find out if it's unique, or how many objects are in
the repo). It _usually_ shouldn't matter much, because we try to produce
abbreviated hashes where users might read them, and long hashes when we
generate URLs. But of course people sometimes generate URLs themselves
from who knows where. :) I've been lightly lobbying to bump our default
to something higher, like 12.

-Peff
