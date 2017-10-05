Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415622036D
	for <e@80x24.org>; Thu,  5 Oct 2017 03:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdJEDqf (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 23:46:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:32954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751223AbdJEDqe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 23:46:34 -0400
Received: (qmail 2819 invoked by uid 109); 5 Oct 2017 03:46:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 03:46:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23677 invoked by uid 111); 5 Oct 2017 03:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 23:46:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 23:46:32 -0400
Date:   Wed, 4 Oct 2017 23:46:32 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: lstat-ing delayed-filter output, was Re: playing with MSan
Message-ID: <20171005034632.kzsspk7wsuk23kf2@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
 <20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net>
 <20171004193005.GD30301@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004193005.GD30301@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 08:30:05PM +0100, Thomas Gummerer wrote:

> > So I dunno. This approach is a _lot_ more convenient than trying to
> > rebuild all the dependencies from scratch, and it runs way faster than
> > valgrind.  It did find the cases that led to the patches in this
> > series, and at least one more: if the lstat() at the end of
> > entry.c:write_entry() fails, we write nonsense into the cache_entry.
> 
> Yeah valgrind found that one too, as I tried (and apparently failed :))
> to explain in the cover letter.  I just haven't found the time yet to
> actually try and go fix that one.

No, I just have poor memory. :)

The obvious fix is that we should check the return value of `lstat`, but
the bigger question is why and when that would fail.

The case triggered by t0021 is using the new "delayed" filter mechanism.
So at the time that write_entry() finishes, we don't actually have the
file in the filesystem. I think we need to recognize that we got delayed
and didn't actually check anything out, and skip that whole "if
(state->refresh_cache)" block. It's not clear to me, though, how we tell
the difference between the delayed and normal cases in that function.

But I think this lstat could also fail if we are checking out and
somebody else racily deletes our file. This is presumably sufficiently
rare that I actually wonder if we should just bail with an error, so
that the user knows something funny is going on.

+cc Lars for thoughts no the delayed-filter case.

-Peff
