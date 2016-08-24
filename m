Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EC91F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755570AbcHXRub (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:50:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:60586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755466AbcHXRuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:50:01 -0400
Received: (qmail 13742 invoked by uid 109); 24 Aug 2016 17:49:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:49:59 +0000
Received: (qmail 4928 invoked by uid 111); 24 Aug 2016 17:50:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 13:50:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 13:49:56 -0400
Date:   Wed, 24 Aug 2016 13:49:56 -0400
From:   Jeff King <peff@peff.net>
To:     Richard <richard.maw@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: Adding more namespace support to git
Message-ID: <20160824174956.ln4fpxorszuzpw7k@sigill.intra.peff.net>
References: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2016 at 08:07:00PM +0100, Richard wrote:

> Because git is not namespace aware for anything but git-upload-pack
> and git-receive-pack, I've had to implement namespace parsing in cgit
> for listing branches, showing logs, displaying notes and commit
> decorations.  It might be more useful if this support was added to git
> itself, so other git servers could make use of it so there's less
> duplicated code.
> 
> I think the way to do this would be to make the low-level ref reading
> functions, read_raw_ref, for_each_reflog_ent*, reflog_exists etc.,
> interpret the ref they are passed as being relative to the current git
> namespace.

At GitHub, we store many forks for a single repository, and we
considered using namespaces for our storage strategy. But like you, we
ran into the problem that you they only work for certain operations. :)

Our solution is to use separate repositories, each with their own ref
storage, but pointing to a shared object store. It works, but there are
a lot of gotchas and performance issues with migrating objects around,
running repacks.

Michael Haggerty (cc'd) has picked up the pluggable ref-backend work
started by others, and I know has some ideas on doing namespaces at that
level. Basically, the concept of "namespaces" should be able to plug in
between the actual storage backend and the rest of the git code. Git
code wouldn't have to care whether the namespace plugin was in use, and
the namespace plugin wouldn't have to care which storage backend was in
use (it would just silently translate "refs/heads/foo" into
"refs/namespaces/123/heads/foo", and vice versa).

That's a very "complete" solution in the sense that the git code does
not know about the namespaces, and cannot even access refs outside of
it. But I think in general it would do what you want. Most operations
would run in a certain namespace (i.e., pretend nothing outside of that
namespace exists, for fetches, diffs, etc), and others would want to
look at the whole namespace (e.g., repacking, pruning). I don't know of
any operations that want to see both views in the same process.

-Peff
