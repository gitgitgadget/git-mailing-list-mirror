Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1718C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 12:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiKDMva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKDMv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 08:51:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B610052
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 05:51:26 -0700 (PDT)
Received: (qmail 18681 invoked by uid 109); 4 Nov 2022 12:51:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 12:51:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29560 invoked by uid 111); 4 Nov 2022 12:51:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 08:51:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 08:51:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Message-ID: <Y2UKzV7ptjMdHcfh@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
 <Y2Ty6KZT8iACqHf+@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2Ty6KZT8iACqHf+@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 06:10:02PM +0700, Đoàn Trần Công Danh wrote:

> I think we should use OPT_SUBCOMMAND to parse bisect--helper
> subcommand instead, which would pave ways for easier converting to
> built-int git-bisect. This huge patch, which could be splited into
> 2 patches can fix the problem:

Yeah, I haven't really dug into the subcommand stuff before, but I
noticed while poking at the low-level callback code that it may stop the
parsing.

If so, then yes, I think that fixes the problem. But does it break other
modes, that want to be parsing "--log"? It sounds from other responses
in the thread that no, nobody actually cares about the "--log" flag (and
that matches my reading of the code; nobody looks at the nolog variable
we set).

The other obvious problem with switching to subcommands is that it
changes the caller-visible name (to drop the "--"). But that should be
OK here, as we make no promises about what's in helper command like
bisect--helper.

So yeah, that does seem like a better path forward.

-Peff
