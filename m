Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB6BC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbjD0Ikk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbjD0Ikj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:40:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE2B4EDF
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:40:35 -0700 (PDT)
Received: (qmail 20804 invoked by uid 109); 27 Apr 2023 08:40:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:40:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17569 invoked by uid 111); 27 Apr 2023 08:40:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:40:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:40:34 -0400
From:   Jeff King <peff@peff.net>
To:     Michael =?utf-8?B?Vm/FmcOtxaFlayAtIMSMVlVU?= FJFI 
        <vorismi3@fjfi.cvut.cz>
Cc:     git@vger.kernel.org
Subject: Re: Non-zero exit code of custom filter process is not handled
Message-ID: <20230427084034.GA1479657@coredump.intra.peff.net>
References: <a7cf2f3bbc6dcd8758e188f79d31e6e0bff44ea3e768fce482309ba532205f6b@mahalux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7cf2f3bbc6dcd8758e188f79d31e6e0bff44ea3e768fce482309ba532205f6b@mahalux.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 04:21:31PM +0200, Michael Voříšek - ČVUT FJFI wrote:

> When a custom filter process exits with a non-zero code, the git currently
> tries to decode the response, even if it should fail and let the user know
> the problem is not the payload, but instead of the filter process.

Isn't there an ordering problem here? We will not see the exit code
until we wait() for the process. And we will not wait for it to finish
until we get EOF on the pipe we are reading from. So we will read what
it says (if anything) before checking the exit code.

What would normally happen is something like:

  1. The process encounters an error. It prints a message to stderr
     (which is usually pointing at the terminal or a log), says nothing
     else to stdout, and then exits with a failing code.

  2. Git sees EOF on the pipe, which has been closed.

  3. Git calls wait() and sees the failing exit code.

> You can reproduce this with setting a git filter to "php non-existent.php",
> in this case the filter (php binary) will exit with non-zero code. Currently
> "fatal: protocol error: bad line length character: Coul" is printed which is
> very hard to understand as even not the whole error string is shown.

The problem here is that php prints "Could not open input file:
non-existent.php" to stdout, not stderr. So it really is sending garbage
over the pipe from which Git expects it to be speaking a particular
protocol. Whether it exits with a non-zero code or not, it has broken
the protocol and Git is correct to complain.

It might be helpful in such a case if the pkt-line reader showed the
whole string it received, rather than just the first four bytes which it
is trying to parse (though I suspect in some cases it may require extra
read() calls, as the data may still be in the pipe buffer).

-Peff
