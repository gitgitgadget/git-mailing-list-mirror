Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC04020446
	for <e@80x24.org>; Wed, 18 Oct 2017 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdJRSfI (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 14:35:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:56954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751637AbdJRSez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 14:34:55 -0400
Received: (qmail 4612 invoked by uid 109); 18 Oct 2017 18:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 18:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3092 invoked by uid 111); 18 Oct 2017 18:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 14:34:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 14:34:53 -0400
Date:   Wed, 18 Oct 2017 14:34:53 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH] commit: check result of resolve_ref_unsafe
Message-ID: <20171018183453.lr67zw455bkdmrlz@sigill.intra.peff.net>
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
 <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 08:00:43PM +0300, Andrey Okoshkin wrote:

> Add check of the resolved HEAD reference while printing of a commit summary.
> resolve_ref_unsafe() may return NULL pointer if underlying calls of lstat() or
> open() fail in files_read_raw_ref().
> Such situation can be caused by race: file becomes inaccessible to this moment.

Yeah, I think we've had several bugs over the years with not checking
the result of resolve_ref_unsafe(). Simply because it's so rare for it
to fail without the READING flag, especially on HEAD, these bugs tend to
linger.

But I agree we should be handling this case, and that it could trigger
in real life because of a race or other weird intermittent failure.

I was able to trigger it by doing this in one terminal:

  while true; do
    git commit --allow-empty -m foo

    # we may see any of:
    #  - success
    #  - not a git repo (because HEAD is broken when we do setup)
    #  - can't lock HEAD (because it's broken when we take the lock)
    #  - a segfault (HEAD is broken when we try to print the summary)
    # but we only care about the last one
    ret=$?
    test $ret = 0 || test $ret = 128 || break
  done

and this in another:

  # pick some valid sha1
  sha1=$(git rev-parse HEAD)

  # flip back and forth between broken and valid states
  while true; do
    echo trash >.git/HEAD
    echo $sha >.git/HEAD
  done

Obviously this is silly, but it does eventually trigger the segfault.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1a0da71a4..71a58dea3 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1483,6 +1483,8 @@ static void print_summary(const char *prefix, const struct object_id *oid,
>  	diff_setup_done(&rev.diffopt);
>  
>  	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
> +	if (!head)
> +		BUG("unable to resolve HEAD reference");

Checking !head here is the right thing to do, but I don't think this is
a BUG(). It's not a logic error in the program, but rather an unexpected
result. So probably:

  die("unable to resolve HEAD reference");

would be more appropriate. It's also possible that we could simply
continue. We _did_ make the commit, but we're just failing at the
informational bits. This should be sufficiently uncommon that I think
dying is probably fine. We maybe could say:

  die("unable to resolve HEAD after creating commit")

or something so that the user has some clue that the commit did in fact
happen (depending on the error, further commands may or may not see the
updated value of HEAD).

Tangential to your patch, I also wondered why we did not pass
RESOLVE_REF_READING to resolve_ref_unsafe(). I think the answer is that
for symref lookups, we normally don't pass it so that we can handle
dangling symrefs. Of course we _just_ wrote HEAD ourselves, so we'd
expect it to exist, so it shouldn't really matter either way.

-Peff
