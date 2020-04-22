Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F8C2BA19
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8C220735
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDVBga (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:36:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:35382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726024AbgDVBga (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 21:36:30 -0400
Received: (qmail 313 invoked by uid 109); 22 Apr 2020 01:36:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 01:36:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25512 invoked by uid 111); 22 Apr 2020 01:47:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Apr 2020 21:47:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Apr 2020 21:36:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
Message-ID: <20200422013629.GA3559880@coredump.intra.peff.net>
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
 <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422010943.GD6465@camp.crustytoothpaste.net>
 <20200422012817.GD103469@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422012817.GD103469@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 06:28:17PM -0700, Jonathan Nieder wrote:

> Thanks.  Here's another (though I haven't tried bisecting yet):
> 
> 	echo url='https://github.com/git/git' |
> 	GIT_TERMINAL_PROMPT=0 \
> 	git -c credential.helper= \
> 		-c credential.github.com.helper='!echo username=foo; echo password=bar;:' \
> 		credential fill
> 
> produces
> 
> 	fatal: could not read Username for 'https://github.com': terminal prompts disabled

It's almost certainly the same commit. The credential_match() function
would have said "aha, there is no protocol in the pattern, so match any
protocol". But now we are trying to match full URLs.

TBH, I'm not sure if the original was actually sane (especially in light
of all of the recent confusion around missing protocols).

-Peff
