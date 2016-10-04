Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1924B20986
	for <e@80x24.org>; Tue,  4 Oct 2016 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbcJDP11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 11:27:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:52055 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbcJDP10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 11:27:26 -0400
Received: (qmail 28976 invoked by uid 109); 4 Oct 2016 15:27:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 15:27:25 +0000
Received: (qmail 5998 invoked by uid 111); 4 Oct 2016 15:27:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 11:27:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 11:27:22 -0400
Date:   Tue, 4 Oct 2016 11:27:22 -0400
From:   Jeff King <peff@peff.net>
To:     Rich Felker <dalias@libc.org>
Cc:     git@vger.kernel.org, musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
Message-ID: <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004150848.GA7949@brightrain.aerifal.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:

> This commit broke support for using git with musl libc:
> 
> https://github.com/git/git/commit/2f8952250a84313b74f96abb7b035874854cf202

Yep. The idea is that you would compile git with NO_REGEX=1, and it
would use the included compat routines.

Is there something in particular you want to get out of using musl's
regex that is not supported in the compat library?

> Rather than depending on non-portable GNU regex extensions, there is a
> simple portable fix for the issue this code was added to work around:
> When a text file is being mmapped for use with string functions which
> depend on null termination, if the file size:
> 
> 1. is nonzero mod page size, it just works; the remainder of the last
>    page reads as zero bytes when mmapped.

Is that a portable assumption?

> 2. if an exact multiple of the page size, then instead of directly
>    mmapping the file, first mmap a mapping 1 byte (thus 1 page) larger
>    with MAP_ANON, then use MAP_FIXED to map the file over top of all
>    but the last page. Now the mmapped buffer can safely be used as a C
>    string.

I'm not sure whether all of our compat layers for mmap would be happy
with that (e.g., see compat/win32mmap.c).

So it seems like any mmap-related solutions would have to be
conditional, too. And then regexec_buf() would have to become something
like:

  int regexec_buf(...)
  {
  #if defined(REG_STARTEND)
	... set up match ...
	return regexec(..., REG_STARTEND);
  #elif defined(MMAP_ALWAYS_HAS_NUL)
	/*
	 * We assume that every buffer we see is always NUL-terminated
	 * eventually, either because it comes from xmallocz() or our
	 * mmap layer always ensures an extra NUL.
	 */
	 return regexec(...);
  #else
  #error "Nope, you need either NO_REGEX or USE_MMAP_NUL"
  #endif
  }

The assumption in the middle case feels pretty hacky, though. It fails
if we get a buffer from somewhere besides those two sources. It fails if
somebody calls regexec_buf() on a subset of a string.

It also doesn't handle matching past embedded NULs in the string. That's
not something we're relying on yet, but it would be nice to support
consistently in the long run.

If there's a compelling reason, it might be worth making that tradeoff.
But I am not sure what the compelling reason is to use musl's regex
(aside from the obvious of "less code in the resulting executable").

-Peff
