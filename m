Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6BC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8FA613E4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCT3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:29:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:45326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCT3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:29:25 -0400
Received: (qmail 6327 invoked by uid 109); 3 Jun 2021 19:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 19:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28450 invoked by uid 111); 3 Jun 2021 19:27:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 15:27:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 15:27:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: use user-specific utf-8 locale for testing
Message-ID: <YLktKeMXoZ/6wHqT@coredump.intra.peff.net>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114646.17463-1-congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 06:46:46PM +0700, Đoàn Trần Công Danh wrote:

> In some test-cases, utf-8 locale is required. To find such locale,
> we're using the first available UTF-8 locale that returned by
> "locale -a".
> 
> Despite being required by POSIX, locale(1) is unavailable in some
> systems, e.g. Linux with musl libc.  Some of those systems support
> utf-8 locale out of the box.
> 
> However, without "locale -a", we can't guess provided UTF-8 locale.
> 
> Let's give users of those systems an option to have better test
> coverage.

That makes sense. At first I thought this was fixing a test breakage,
and wondered if we should simply be skipping the tests. But after
reading more carefully, we already are doing that, and this is just
allowing those tests to run in more places (you even said so in the last
sentence above, but I missed it, so I am calling it out).

I kind of wonder if trying "C.UTF-8" would be a reasonable fallback so
that people don't even have to set this extra Makefile knob. But I'm not
sure if we have a good way of testing if that locale works (if we can't
find the "locale" binary). So this is probably a reasonable medium
ground.

> ---
>  Makefile                                 |  6 ++++++
>  t/lib-git-svn.sh                         | 15 +++++++++------
>  t/t9100-git-svn-basic.sh                 | 14 +++-----------
>  t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
>  t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
>  5 files changed, 23 insertions(+), 22 deletions(-)

I think we test musl in our ci builds; should we do something like:

diff --git a/ci/lib.sh b/ci/lib.sh
index d848c036c5..ec67398c18 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -229,6 +229,7 @@ linux-musl)
 	CC=gcc
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
+	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=something.UTF-8?"
 	;;
 esac
 

here, too (I don't know what the correct "something" is here; maybe
"C")?

-Peff
