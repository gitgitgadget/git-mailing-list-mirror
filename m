Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5862F1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeKKRHz (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:07:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:47698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727334AbeKKRHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:07:55 -0500
Received: (qmail 1594 invoked by uid 109); 11 Nov 2018 07:20:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 07:20:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32000 invoked by uid 111); 11 Nov 2018 07:19:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 02:19:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 02:20:07 -0500
Date:   Sun, 11 Nov 2018 02:20:07 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 09/10] fast-export: add a --show-original-ids option to
 show original names
Message-ID: <20181111072007.GI30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-10-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-10-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:11PM -0800, Elijah Newren wrote:

> Knowing the original names (hashes) of commits, blobs, and tags can
> sometimes enable post-filtering that would otherwise be difficult or
> impossible.  In particular, the desire to rewrite commit messages which
> refer to other prior commits (on top of whatever other filtering is
> being done) is very difficult without knowing the original names of each
> commit.
> 
> This commit teaches a new --show-original-ids option to fast-export
> which will make it add a 'originally <hash>' line to blob, commits, and
> tags.  It also teaches fast-import to parse (and ignore) such lines.

Makes sense as a feature; I think filter-branch can make its mappings
available, too.

Do we need to worry about compatibility with other fast-import programs?
I think no, because this is not enabled by default (so if sending the
extra lines to another importer hurts, the answer is "don't do that").

I have a vague feeling that there might be some way to combine this with
--export-marks or --no-data, but I can't really think of a way. They
seem related, but not quite.

> ---
>  Documentation/git-fast-export.txt |  7 +++++++
>  builtin/fast-export.c             | 20 +++++++++++++++-----
>  fast-import.c                     | 17 +++++++++++++++++
>  t/t9350-fast-export.sh            | 17 +++++++++++++++++
>  4 files changed, 56 insertions(+), 5 deletions(-)

The fast-import format is documented in Documentation/git-fast-import.txt.
It might need an update to cover the new format.

> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -121,6 +121,13 @@ marks the same across runs.
>  	used by a repository which already contains the necessary
>  	parent commits.
>  
> +--show-original-ids::
> +	Add an extra directive to the output for commits and blobs,
> +	`originally <SHA1SUM>`.  While such directives will likely be
> +	ignored by importers such as git-fast-import, it may be useful
> +	for intermediary filters (e.g. for rewriting commit messages
> +	which refer to older commits, or for stripping blobs by id).

I'm not quite sure how a blob ends up being rewritten by fast-export (I
get that commits may change due to dropping parents).

The name "originally" doesn't seem great to me. Probably because I would
continually wonder if it has one "l" or two. ;) Perhaps something like
"original-oid" might be better. That's well into bikeshed territory,
though.

-Peff
