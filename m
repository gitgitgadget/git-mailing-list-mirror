Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEABC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjBCQza (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjBCQz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 11:55:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1446D4A
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 08:55:28 -0800 (PST)
Received: (qmail 26330 invoked by uid 109); 3 Feb 2023 16:55:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 16:55:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10114 invoked by uid 111); 3 Feb 2023 16:55:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 11:55:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 11:55:27 -0500
From:   Jeff King <peff@peff.net>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Message-ID: <Y908f2qaxKeljtj+@coredump.intra.peff.net>
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
 <CALnO6CA3LL2TbMyvVsgeNgGHr9tGq4-FYR0-RMyJJiMvV3P91w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CA3LL2TbMyvVsgeNgGHr9tGq4-FYR0-RMyJJiMvV3P91w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 03:47:28PM -0500, D. Ben Knoble wrote:

> Further, the following C program compiles without warnings (except for
> the unused main parameters):
> ```
> #include <regex.h>
> #include <assert.h>
> #include <stddef.h>
> #include <stdio.h>
> 
> int main(int argc, char **argv) {
>     regex_t re;
>     int ret = regcomp(&re, "[\xc0-\xff][\x80-\xbf]+", REG_EXTENDED |
> REG_NEWLINE);
>     /* assert(ret != 0); */
>     size_t errbuf_size = regerror(ret, &re, NULL, 0);
>     char errbuf[errbuf_size];
>     regerror(ret, &re, errbuf, errbuf_size);
>     printf("%s\n", errbuf);
> }
> ```

Just a guess, but does calling:

  setlocale(LC_CTYPE, "");

at the start of the program change things (you'll probably need to also
include locale.h)? I don't have a macos system to test on.

-Peff
