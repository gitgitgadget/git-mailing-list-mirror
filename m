Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109F01F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeHOAiy (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:38:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728080AbeHOAix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:38:53 -0400
Received: (qmail 7273 invoked by uid 109); 14 Aug 2018 21:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 21:49:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26491 invoked by uid 111); 14 Aug 2018 21:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 17:49:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 17:49:42 -0400
Date:   Tue, 14 Aug 2018 17:49:42 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
Message-ID: <20180814214942.GB667@sigill.intra.peff.net>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814114721.25577-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 01:47:21PM +0200, SZEDER Gábor wrote:

> The test 'pack-objects to file can use bitmap' added in 645c432d61
> (pack-objects: use reachability bitmap index when generating
> non-stdout pack, 2016-09-10) is silently buggy and doesn't check what
> it's supposed to.
> 
> In 't5310-pack-bitmaps.sh', the 'list_packed_objects' helper function
> does what its name implies by running:
> 
>   git show-index <"$1" | cut -d' ' -f2
> 
> The test in question invokes this function like this:
> 
>   list_packed_objects <packa-$packasha1.idx >packa.objects &&
>   list_packed_objects <packb-$packbsha1.idx >packb.objects &&
>   test_cmp packa.objects packb.objects
> 
> Note how these two callsites don't specify the name of the pack index
> file as the function's parameter, but redirect the function's standard
> input from it.  This triggers an error message from the shell, as it
> has no filename to redirect from in the function, but this error is
> ignored, because it happens upstream of a pipe.  Consequently, both
> invocations produce empty 'pack{a,b}.objects' files, and the
> subsequent 'test_cmp' happily finds those two empty files identical.
> 
> Fix these two 'list_packed_objects' invocations by specifying the pack
> index files as parameters.  Furthermore, eliminate the pipe in that
> function by replacing it with an &&-chained pair of commands using an
> intermediate file, so a failure of 'git show-index' or the shell
> redirection will fail the test.

Good catch, and nicely explained. The patch itself looks obviously
correct.

-Peff
