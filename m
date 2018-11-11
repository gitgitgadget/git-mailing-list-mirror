Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C1E1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeKKQc0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:32:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:47604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbeKKQc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:32:26 -0500
Received: (qmail 32394 invoked by uid 109); 11 Nov 2018 06:44:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 06:44:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31811 invoked by uid 111); 11 Nov 2018 06:44:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 01:44:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 01:44:43 -0500
Date:   Sun, 11 Nov 2018 01:44:43 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 04/10] fast-export: avoid dying when filtering by paths
 and old tags exist
Message-ID: <20181111064442.GD30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-5-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:06PM -0800, Elijah Newren wrote:

> If --tag-of-filtered-object=rewrite is specified along with a set of
> paths to limit what is exported, then any tags pointing to old commits
> that do not contain any of those specified paths cause problems.  Since
> the old tagged commit is not exported, fast-export attempts to rewrite
> such tags to an ancestor commit which was exported.  If no such commit
> exists, then fast-export currently die()s.  Five years after the tag
> rewriting logic was added to fast-export (see commit 2d8ad4691921,
> "fast-export: Add a --tag-of-filtered-object  option for newly dangling
> tags", 2009-06-25), fast-import gained the ability to delete refs (see
> commit 4ee1b225b99f, "fast-import: add support to delete refs",
> 2014-04-20), so now we do have a valid option to rewrite the tag to.
> Delete these tags instead of dying.

Hmm. That's the right thing to do if we're considering the export to be
an independent unit. But what if I'm just rewriting a portion of history
like:

  git fast-export HEAD~5..HEAD | some_filter | git fast-import

? If I have a tag pointing to HEAD~10, will this delete that? Ideally I
think it would be left alone.

> +test_expect_success 'rewrite tag predating pathspecs to nothing' '
> +	test_create_repo rewrite_tag_predating_pathspecs &&
> +	(
> +		cd rewrite_tag_predating_pathspecs &&
> +
> +		touch ignored &&

We usually prefer ">ignored" to create an empty file rather than
"touch".

> +		git add ignored &&
> +		test_commit initial &&

What do we need this "ignored" for? test_commit should create a file
"initial.t".

> +		echo foo >bar &&
> +		git add bar &&
> +		test_commit add-bar &&

Likewise, "test_commit bar" should work by itself (though note the
filename is "bar.t" in your fast-export command).

> +		git fast-export --tag-of-filtered-object=rewrite --all -- bar >output &&
> +		grep -A 1 refs/tags/v0.0.0.0.0.0.1 output | grep -E ^from.0{40}

I don't think "grep -A" is portable (and we don't seem to otherwise use
it). You can probably do something similar with sed.

Use $ZERO_OID instead of hard-coding 40, which future-proofs for the
hash transition (though I suppose the hash is not likely to get
_shorter_ ;) ).

-Peff
