Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B6D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755161AbdBVTQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 14:16:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:60117 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755154AbdBVTQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 14:16:45 -0500
Received: (qmail 17710 invoked by uid 109); 22 Feb 2017 19:16:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 19:16:44 +0000
Received: (qmail 26473 invoked by uid 111); 22 Feb 2017 19:16:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 14:16:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 14:16:42 -0500
Date:   Wed, 22 Feb 2017 14:16:42 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 03/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170222191641.o2rtt2ymtb4h2yqe@sigill.intra.peff.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
 <20170221234737.894681-4-sandals@crustytoothpaste.net>
 <xmqqy3wyawlu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3wyawlu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 10:50:21AM -0800, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > Convert most leaf functions to struct object_id.  Change several
> > hardcoded numbers to uses of parse_oid_hex.  In doing so, verify that we
> > when we want two trees, we have exactly two trees.
> >
> > Finally, in stdin_diff_commit, avoid accessing the byte after the NUL.
> > This will be a NUL as well, since the first NUL was a newline we
> > overwrote.  However, with parse_oid_hex, we no longer need to increment
> > the pointer directly, and can simply increment it as part of our check
> > for the space character.
> 
> After reading the pre- and post-image twice, I think I convinced
> myself that this is a faithful conersion and they do the same thing.

I think this is correct, too (but then, I think it largely comes from
the patch I wrote the other night. So I did look at it carefully, but
it's not exactly an independent review).

> What the function does appears somewhat iffy in the modern world.
> We are relying on the fact that while Git is operating in this mode
> of reading a tuple of commits per line and doing log-tree, that Git
> itself will not do the history traversal (instead, another instance
> of Git that feeds us via our standard input is walking the history)
> for this piece of code to work correctly.  
> 
> Of course, the "diff-tree --stdin" command was meant to sit on the
> downstream of "rev-list --parents", so the assumption the code makes
> (i.e. the parents field of the in-core commit objects do not have to
> be usable for history traversal) may be reasonable, but still...

I'm not sure it's that weird. "diff-tree" is about diffing, not
traversal. The only reason it touches commit->parents at all (and
doesn't just kick off a diff between the arguments it gets) is that it's
been stuck with pretty-printing the commits, which might ask to show the
parents.

-Peff
