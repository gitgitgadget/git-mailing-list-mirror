Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D63C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhLJJ0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:26:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:48554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236055AbhLJJ0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:26:18 -0500
Received: (qmail 18044 invoked by uid 109); 10 Dec 2021 09:22:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:22:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28404 invoked by uid 111); 10 Dec 2021 09:22:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:22:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:22:43 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 09/19] tests: use test_write_lines() to generate
 line-oriented output
Message-ID: <YbMcYwj/Mvf/PoFF@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-10-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-10-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:05AM -0500, Eric Sunshine wrote:

> Take advantage of test_write_lines() to generate line-oriented output
> rather than using for-loops or a series of `echo` commands. Not only is
> test_write_lines() a natural fit for such a task, but there is less
> opportunity for a broken &&-chain.

Makes sense. A few of these append like this:

> -	for w in Some extra lines here; do echo $w; done >>one &&
> +	test_write_lines Some extra lines here >>one &&

which made me wonder if the original really wanted to append, or if they
meant:

  for w in Some extra lines here; do echo $w >>one; done

in the first place. In which case you could write ">one". But in the
cases I peeked at, they really are appending to a file that already
existed. And at any rate, your conversions are all faithful to the
original, which is the right thing to do to avoid introducing bugs.

>  test_expect_success 'color new trailing blank lines' '
> -	{ echo a; echo b; echo; echo; } >x &&
> +	test_write_lines a b "" "" >x &&
>  	git add x &&
> -	{ echo a; echo; echo; echo; echo c; echo; echo; echo; echo; } >x &&
> +	test_write_lines a "" "" "" c "" "" "" "" >x &&

Some of these I think might be more readable as here-docs. But I think
keeping to the minimal change here makes sense (and I admit I do not
overly care much either way; it was just on my mind from the last
patch).

-Peff
