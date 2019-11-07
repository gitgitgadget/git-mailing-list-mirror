Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC161F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfKGGEM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:04:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:41672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725763AbfKGGEM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:04:12 -0500
Received: (qmail 28924 invoked by uid 109); 7 Nov 2019 06:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32167 invoked by uid 111); 7 Nov 2019 06:07:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:07:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:04:10 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 4/8] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191107060410.GC6431@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <15c33fc245401791fd2530d9d4dbde8e0e451939.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15c33fc245401791fd2530d9d4dbde8e0e451939.1573094789.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:15AM +0700, Doan Tran Cong Danh wrote:

> On musl libc, ISO-2022-JP encoder is too eager to switch back to
> 1 byte encoding, musl's iconv always switch back after every combining
> character. Comparing glibc and musl's output for this command
> $ sed q t/t3900/ISO-2022-JP.txt| iconv -f ISO-2022-JP -t utf-8 |
> 	iconv -f utf-8 -t ISO-2022-JP | xxd
> 
> glibc:
> 00000000: 1b24 4224 4f24 6c24 5224 5b24 551b 2842  .$B$O$l$R$[$U.(B
> 00000010: 0a                                       .
> 
> musl:
> 00000000: 1b24 4224 4f1b 2842 1b24 4224 6c1b 2842  .$B$O.(B.$B$l.(B
> 00000010: 1b24 4224 521b 2842 1b24 4224 5b1b 2842  .$B$R.(B.$B$[.(B
> 00000020: 1b24 4224 551b 2842 0a                   .$B$U.(B.
> 
> Although musl iconv's output isn't optimal, it's still correct.
> 
> From commit 7d509878b8, ("pretty.c: format string with truncate respects
> logOutputEncoding", 2014-05-21), we're encoding the message to utf-8
> first, then format it and convert the message to the actual output
> encoding on git commit --squash.
> 
> Thus, t3900::test_commit_autosquash_flags is failing on musl libc.
> 
> Reencode to utf-8 before arranging rebase's todo list.

OK, that makes sense.

> By doing this, we also remove a breakage introduced in the previous
> commit.

We'd usually say that a commit "introduced a breakage" if it was the
source of the bug. Perhaps:

  ...we also remove a breakage noticed by a test added in the previous
  commit.

-Peff
