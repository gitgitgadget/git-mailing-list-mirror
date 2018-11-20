Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A6A1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeKTTjP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 14:39:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:45416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725851AbeKTTjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 14:39:15 -0500
Received: (qmail 19545 invoked by uid 109); 20 Nov 2018 09:11:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 09:11:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26160 invoked by uid 111); 20 Nov 2018 09:10:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 04:10:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 04:11:08 -0500
Date:   Tue, 20 Nov 2018 04:11:08 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181120091107.GA30542@sigill.intra.peff.net>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 11:36:08AM -0800, Carlo Arenas wrote:

> tests 3-8 seem to fail because perl is hardcoded to /urs/bin/perl in
> t5562/invoke-with-content-length.pl, while I seem to be getting some
> sporadic errors in 9 with the following output :
> 
> ++ env CONTENT_TYPE=application/x-git-receive-pack-request
> QUERY_STRING=/repo.git/git-receive-pack
> 'PATH_TRANSLATED=/home/carenas/src/git/t/trash
> directory.t5562-http-backend-content-length/.git/git-receive-pack'
> GIT_HTTP_EXPORT_ALL=TRUE REQUEST_METHOD=POST
> /home/carenas/src/git/t/t5562/invoke-with-content-length.pl push_body
> git http-backend
> ++ verify_http_result '200 OK'
> ++ grep fatal: act.err
> Binary file act.err matches
> ++ return 1
> error: last command exited with $?=1
> not ok 9 - push plain
> 
> and the following output in act.err (with a 200 in act)
> 
> fatal: the remote end hung up unexpectedly

This bit me today, too, and I can reproduce it by running under my
stress-testing script.

Curiously, the act.err file also has 54 NUL bytes before the "fatal:"
message. I tried adding an "strace" to see who was producing that
output, but I can't seem to get it to fail when running under strace
(presumably because the timing is quite different, and this likely some
kind of pipe race).

-Peff
