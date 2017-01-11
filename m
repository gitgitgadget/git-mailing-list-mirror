Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE45205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 12:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966285AbdAKMxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 07:53:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:37952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966244AbdAKMxf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 07:53:35 -0500
Received: (qmail 29634 invoked by uid 109); 11 Jan 2017 12:53:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 12:53:34 +0000
Received: (qmail 21634 invoked by uid 111); 11 Jan 2017 12:54:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 07:54:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 07:53:30 -0500
Date:   Wed, 11 Jan 2017 07:53:30 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org
Subject: Re: git cat-file on a submodule
Message-ID: <20170111125330.3skwxdleoooacts6@sigill.intra.peff.net>
References: <1484093500.17967.6.camel@frank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1484093500.17967.6.camel@frank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 07:11:40PM -0500, David Turner wrote:

> Why does git cat-file -t $sha:foo, where foo is a submodule, not work?

Because "cat-file" is about inspecting items in the object database, and
typically the submodule commit is not present in the superproject's
database. So we cannot know its type. You can infer what it _should_ be
from the surrounding tree, but you cannot actually do the object lookup.

Likewise, "git cat-file -t $sha1:Makefile" is not just telling you that
we found a 100644 entry in the tree, so we expect a blob. It's resolving
to a sha1, and then checking the type of that sha1 in the database. It
_should_ be a blob, but if it isn't, then cat-file is the tool that
should tell you that it is not.

> git rev-parse $sha:foo works.

Right. Because that command is about resolving a name to a sha1, which
we can do even without the object.

> By "why", I mean "would anyone complain if I fixed it?"  FWIW, I think
> -p should just return the submodule's sha.

I'm not sure if I'm complaining or not. I can't immediately think of
something that would be horribly broken. But it really feels like you
are using the wrong tool, and patching the tool to handle this case will
probably lead to weird cognitive dissonance down the road.

Maybe it would help to describe your use case more fully. If what you
care about is the presumed type based on the surrounding tree, then
maybe:

  git --literal-pathspecs ls-tree $sha -- foo

would be a better match.

-Peff
