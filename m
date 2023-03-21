Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB1C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCURW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCURW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:22:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5735EF6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:22:25 -0700 (PDT)
Received: (qmail 27420 invoked by uid 109); 21 Mar 2023 17:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 17:22:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2237 invoked by uid 111); 21 Mar 2023 17:22:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 13:22:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 13:22:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stanislav Malishevskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
Message-ID: <20230321172223.GA3119834@coredump.intra.peff.net>
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <xmqqlejrmj4y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlejrmj4y.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 10:23:41AM -0700, Junio C Hamano wrote:

> Is this something that can be protected from future breakage with a
> few new tests somewhere in t/t5559 (which may also involve touching
> t/lib-httpd.sh as well)?

I don't think we'd want to put it there. While it is the only test that
requires SSL currently, it's also specific to HTTP/2, so it may not get
run everywhere.

The original design of the SSL support in the test suite was that you'd
do a run of the whole suite with LIB_HTTPD_SSL set, and then it would
run all of the usual tests with ssl. But experience has shown that
nobody does that. So I think there are two paths forward here:

  1. Add a mode to CI that runs with LIB_HTTPD_SSL set. We'd need to fix
     the bit-rotted tests that fail (usually due to things like
     expecting "http" in the output instead of "https", etc). I linked
     to earlier discussion there elsewhere in the thread.

  2. Add a specific "test with https" script that covers some basic
     tests (possibly even just including t5551, in the same way t5559
     does). If the platform apache doesn't support ssl, then it should
     fail gracefully. And then we could add more SSL specific tests
     to that script.

-Peff
