Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF4E20437
	for <e@80x24.org>; Fri, 13 Oct 2017 13:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758186AbdJMNPF (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 09:15:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753380AbdJMNPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 09:15:03 -0400
Received: (qmail 20242 invoked by uid 109); 13 Oct 2017 13:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25159 invoked by uid 111); 13 Oct 2017 13:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 09:15:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 09:15:01 -0400
Date:   Fri, 13 Oct 2017 09:15:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] branch: forbid refs/heads/HEAD
Message-ID: <20171013131501.3qarwhanktfvgjqd@sigill.intra.peff.net>
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171013051132.3973-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013051132.3973-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 02:11:32PM +0900, Junio C Hamano wrote:

> strbuf_check_branch_ref() is the central place where many codepaths
> see if a proposed name is suitable for the name of a branch.  It was
> designed to allow us to get stricter than the check_refname_format()
> check used for refnames in general, and we already use it to reject
> a branch whose name begins with a '-'.
> 
> Use it to also reject "HEAD" as a branch name.

Heh, I just pointed somebody to this a day or two ago as #leftoverbit. I
guess it's taken now. :)

Related to this: should we do a better job of confirming that the
refname is available for use?

If you do:

  git branch foo
  git checkout -b foo/bar

then "foo/bar" is not available. And for "checkout -b", we'd notice when
we tried to create the ref. But for:

  git checkout --orphan foo/bar

we'd update HEAD with a non-viable name, and only find out later during
"git commit". That's not the end of the world, but it might be nice to
complain when writing the symlink.

Largely orthogonal to the problem you're solving here, but I suspect it
may touch the same code, so it might be worth thinking about while we're
here.

> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index e88349c8a0..3ecb2eab0c 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -331,4 +331,12 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
>  	grep "fatal: invalid ref format: ~a" err
>  '
>  
> +test_expect_success 'branch rejects HEAD as a branch name' '
> +	test_must_fail git branch HEAD HEAD^
> +'
> +
> +test_expect_success 'checkout -b rejects HEAD as a branch name' '
> +	test_must_fail git checkout -B HEAD HEAD^
> +'

Should we test that:

  git update-ref refs/heads/HEAD HEAD^

continues to work?

-Peff
