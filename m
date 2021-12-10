Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2022C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhLJJMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:12:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:48538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhLJJMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:12:40 -0500
Received: (qmail 17989 invoked by uid 109); 10 Dec 2021 09:09:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:09:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28287 invoked by uid 111); 10 Dec 2021 09:09:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:09:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:09:04 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 04/19] t4202: clarify intent by creating expected content
 less cleverly
Message-ID: <YbMZMITRqyHmNC7Z@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-5-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-5-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:00AM -0500, Eric Sunshine wrote:

> Several tests assign the output of `$(...)` command substitution to an
> "expect" variable, taking advantage of the fact that `$(...)` folds out
> the final line terminator while leaving internal line terminators
> intact. They do this because the "actual" string with which "expect"
> will be compared is shaped the same way. However, this intent (having
> internal line terminators, but no final line terminator) is not
> necessarily obvious at first glance and may confuse casual readers. The
> intent can be made more obvious by using `printf` instead, with which
> line termination is stated clearly:
> 
>     printf "sixth\nthird"
> 
> In fact, many other tests in this script already use `printf` for
> precisely this purpose, thus it is an established pattern. Therefore,
> convert these tests to employ `printf`, as well.

Seems reasonable. I don't think these tests actually care about the lack
of trailing newline, so another option is to use tformat. Or its shorter
cousin, --format. E.g.:

> -	actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
> -	expect=$(echo second) &&
> -	verbose test "$actual" = "$expect"
> +	git log --pretty="format:%s" --diff-filter=M HEAD >actual &&
> +	printf "second" >expect &&
> +	test_cmp expect actual

becomes:

  git log --format=%s --diff-filter=M HEAD >actual &&
  echo second >expect &&
  test_cmp expect actual

which is even less magical. But if the existing pattern is there in
nearby tests, I don't have any problem with following it.

> While at it, modernize the tests to use test_cmp() to compare the
> expected and actual output rather than using the semi-deprecated
> `verbose test "$x" = "$y"`.

Yay. Happy to see more "verbose" calls cleaned up.

-Peff
