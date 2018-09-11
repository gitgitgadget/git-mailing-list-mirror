Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CE41F404
	for <e@80x24.org>; Tue, 11 Sep 2018 01:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeIKGwq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 02:52:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:45550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726194AbeIKGwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 02:52:46 -0400
Received: (qmail 3455 invoked by uid 109); 11 Sep 2018 01:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Sep 2018 01:55:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14062 invoked by uid 111); 11 Sep 2018 01:56:08 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 21:56:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 21:55:53 -0400
Date:   Mon, 10 Sep 2018 21:55:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
Message-ID: <20180911015553.GA5838@sigill.intra.peff.net>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180910212221.GG26356@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180910212221.GG26356@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 02:22:21PM -0700, Jonathan Nieder wrote:

> Thanks.  I am wondering if we should go all the way and do
> 
> 	ssize_t val;
> 	const char *str = getenv("CONTENT_LENGTH");
> 
> 	if (!str || !*str)
> 		return 0;
> 	if (!git_parse_ssize_t(str, &val))
> 		die(...);
> 	return val;
> 
> That would match the RFC, but it seems to make t5510-fetch.sh hang,
> right after
> 
>   ok 165 - --negotiation-tip understands abbreviated SHA-1
> 
> When I run with -v -i -x, it stalls at
> 
>   ++ git -C '/usr/local/google/home/jrn/src/git/t/trash directory.t5510-fetch/httpd/www/server' tag -d alpha_1 alpha_2 beta_1 beta_2
>   Deleted tag 'alpha_1' (was a84e4a9)
>   Deleted tag 'alpha_2' (was 7dd5cf4)
>   Deleted tag 'beta_1' (was bcb5c65)
>   Deleted tag 'beta_2' (was d3b6dcd)
>   +++ pwd
>   ++ GIT_TRACE_PACKET='/usr/local/google/home/jrn/src/git/t/trash directory.t5510-fetch/trace'
>   ++ git -C client fetch --negotiation-tip=alpha_1 --negotiation-tip=beta_1 origin alpha_s beta_s
> 
> Do you know why?

Yes. :)

It's due to this comment in the patch you are replying to:

+       if (!str) {
+               /*
+                * RFC3875 says this must mean "no body", but in practice we
+                * receive chunked encodings with no CONTENT_LENGTH. Tell the
+                * caller to read until EOF.
+                */
+               val = -1;

-Peff
