Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E4D208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 09:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbdHKJEq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 05:04:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751873AbdHKJEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 05:04:45 -0400
Received: (qmail 29899 invoked by uid 109); 11 Aug 2017 09:04:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 09:04:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14694 invoked by uid 111); 11 Aug 2017 09:05:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 05:05:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Aug 2017 05:04:42 -0400
Date:   Fri, 11 Aug 2017 05:04:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: remove prefix_length member from apply_state
Message-ID: <20170811090442.lyamw5euek4wwbfl@sigill.intra.peff.net>
References: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
 <20170810234157.fqsatxk4m3wncm3f@sigill.intra.peff.net>
 <746a8339-a490-0a10-a4af-ead78b7b7a6e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <746a8339-a490-0a10-a4af-ead78b7b7a6e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 10:52:48AM +0200, René Scharfe wrote:

> > I wondered at first whether it's actually necessary. Wouldn't
> > an empty prefix always match?
> > 
> > But I think we're looking for the pathname to be a proper superset of
> > the prefix (hence the "!*rest" check). So I guess an empty path would
> > not be a proper superset of an empty prefix, even though with the
> > current code it doesn't hit that block at all.
> > 
> > I'm still not sure it's possible to have an empty pathname, so that
> > corner case may be moot and we could simplify the condition a little.
> > But certainly as you've written it, it could not be a regression.
> 
> So you mean that removing the prefix length check would just cause
> empty paths to be rejected if we have an empty prefix, which shouldn't
> bother anyone because empty paths can't be used anyway, right?

Right.

> Actually I'm not even sure it's possible to have an empty, non-NULL
> prefix.

I'm not sure either. I had assumed this came from a --prefix argument to
git-apply, but it looks like it only ever comes from setup.c's prefix.
We seem to avoid empty prefixes there, but there are a lot of different
code paths and I didn't check them all.

> > The use of skip_prefix also took me a minute. I wonder if it's worth a
> > comment with the words "proper superset" or some other indicator (it
> > also surprised me that we're ok with matching "foobar" in the prefix
> > "foo", and not demanding "foo/bar". But I didn't look at the context to
> > know whether that's right or not. This may be a case where the prefix is
> > supposed to have "/" on it already).
> 
> As the literal translation it is intended to be it should have been a
> no-brainer. :)

Yeah. All of this is mostly me thinking out loud about whether we can
improve the existing code further. Don't feel like you need to spend
time on it.

> Applying a patch to foobar when we're in foo/ is not intended ("Paths
> outside are not touched").
> 
> I don't know if prefixes are guaranteed to end with a slash; the code
> in setup.c seems to ensure that, but has it been spelled out
> explicitly somewhere?  apply.c::use_patch() certainly relies on that.

I don't know that it's been spelled out. But if you do this:

diff --git a/setup.c b/setup.c
index 860507e1fd..48af25cac1 100644
--- a/setup.c
+++ b/setup.c
@@ -765,7 +765,6 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (offset != offset_1st_component(cwd->buf))
 		offset++;
 	/* Add a '/' at the end */
-	strbuf_addch(cwd, '/');
 	return cwd->buf + offset;
 }
 

lots of tests break horribly. So I'm content that we'd probably catch a
regression there, even if it's not spelled out explicitly.

-Peff
