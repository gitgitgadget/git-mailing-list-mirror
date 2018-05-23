Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637CF1F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbeEWWJS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:09:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933791AbeEWWJR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:09:17 -0400
Received: (qmail 26409 invoked by uid 109); 23 May 2018 22:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 May 2018 22:09:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19543 invoked by uid 111); 23 May 2018 22:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 May 2018 18:09:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 May 2018 18:09:15 -0400
Date:   Wed, 23 May 2018 18:09:15 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
Subject: Re: [PATCH 2/2] rev-parse: verify that commit looked up is not NULL
Message-ID: <20180523220915.GB32171@sigill.intra.peff.net>
References: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
 <20180523204613.11333-1-newren@gmail.com>
 <20180523204613.11333-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523204613.11333-2-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 01:46:13PM -0700, Elijah Newren wrote:

> In commit 2122f8b963d4 ("rev-parse: Add support for the ^! and ^@ syntax",
> 2008-07-26), try_parent_shorthands() was introduced to parse the special
> ^! and ^@ syntax.  However, it did not check the commit returned from
> lookup_commit_reference() before proceeding to use it.  If it is NULL,
> bail early and notify the caller that this cannot be a valid revision
> range.

Yep, this is definitely the right track. But...

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 55c0b90441..4e9ba9641a 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -334,6 +334,8 @@ static int try_parent_shorthands(const char *arg)
>  	}
>  
>  	commit = lookup_commit_reference(&oid);
> +	if (!commit)
> +		return 1;
>  	if (exclude_parent &&
>  	    exclude_parent > commit_list_count(commit->parents)) {
>  		*dotdot = '^';

...I don't think this is quite right. I see two issues:

  1. We need to restore "*dotdot" like the other exit code-paths do.

  2. I think a return of 1 means "yes, I handled this". We want to
     return 0 so that the bogus name eventually triggers an error.

I also wondered if we need to print an error message, but since we are
using the non-gentle form of lookup_commit_reference(), it will complain
for us (and then the caller will issue some errors as well).

It might make sense to just lump this into the get_oid check above.
E.g., something like:

  if (get_oid_committish(arg, &oid) ||
      !(commit = lookup_commit_reference(&oid))) {
          *dotdot = '^';
	  return 0;
  }

though I am fine with it either way.

> diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
> index 7b1b2dbdf2..f91cc417bd 100755
> --- a/t/t6101-rev-parse-parents.sh
> +++ b/t/t6101-rev-parse-parents.sh
> @@ -214,7 +214,7 @@ test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
>  	test_must_fail git rev-list merge^-1x
>  '
>  
> -test_expect_failure 'rev-parse $garbage^@ should not segfault' '
> +test_expect_success 'rev-parse $garbage^@ should not segfault' '
>  	git rev-parse ffffffffffffffffffffffffffffffffffffffff^@
>  '

Once we flip the return value as above, I think this needs to be
test_must_fail, which matches how I'd expect it to behave.

This code (sadly) duplicates the functionality in revision.c. I checked
there to see if it has the same problem, but it's fine.

Unfortunately I think rev-parse has one other instance, though:

  bogus=ffffffffffffffffffffffffffffffffffffffff

  # this is ok; we just normalize to "$bogus ^$bogus" without looking at
  # the object, which is OK
  git rev-parse $bogus..$bogus

  # this segfaults, because we try to feed NULL to get_merge_bases()
  git rev-parse $bogus...$bogus

We should probably fix that at the same time.

-Peff
