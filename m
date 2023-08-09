Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA20C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjHIRRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjHIRRd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:17:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53751FEF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:17:32 -0700 (PDT)
Received: (qmail 25325 invoked by uid 109); 9 Aug 2023 17:17:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Aug 2023 17:17:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31923 invoked by uid 111); 9 Aug 2023 17:17:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 13:17:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 13:17:31 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/4] diff --no-index: support reading from named pipes
Message-ID: <20230809171731.GA3663609@coredump.intra.peff.net>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
 <cover.1688586536.git.phillip.wood@dunelm.org.uk>
 <4e05a0be54f66f2b394642762832e426a545426c.1688586536.git.phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e05a0be54f66f2b394642762832e426a545426c.1688586536.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2023 at 08:49:30PM +0100, Phillip Wood wrote:

> +test_expect_success PIPE 'diff --no-index refuses to diff a named pipe and a directory' '
> +	test_when_finished "rm -f pipe" &&
> +	mkfifo pipe &&
> +	{
> +		(>pipe) &
> +	} &&
> +	test_when_finished "kill $!" &&
> +	test_must_fail git diff --no-index -- pipe a 2>err &&
> +	grep "fatal: cannot compare a named pipe to a directory" err
> +'
> +
> +test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
> +	test_when_finished "rm -f old new new-link" &&
> +	mkfifo old &&
> +	mkfifo new &&
> +	ln -s new new-link &&
> +	{
> +		(test_write_lines a b c >old) &
> +	} &&
> +	test_when_finished "! kill $!" &&
> +	{
> +		(test_write_lines a x c >new) &
> +	} &&
> +	test_when_finished "! kill $!" &&
> +
> +	cat >expect <<-EOF &&
> +	diff --git a/old b/new-link
> +	--- a/old
> +	+++ b/new-link
> +	@@ -1,3 +1,3 @@
> +	 a
> +	-b
> +	+x
> +	 c
> +	EOF
> +
> +	test_expect_code 1 git diff --no-index old new-link >actual &&
> +	test_cmp expect actual
> +'

I've had t4053 hang for me once or twice in the last few days. I haven't
managed to pinpoint the problem, but I did notice that running it with
--stress seems to occasionally fail in thie "reads from pipes" test.

The problem is that the "kill" is racy. Even after we've read all of the
input from those sub-processes, they might still be hanging around
waiting to exit when our test_when_finished runs. And then kill will
return "0". So I think we need to either:

  1. Soften the when_finished to "kill $! || true" so that we are OK if
     they are still there.

  2. If the diff command completed as expected, it should be safe to
     "wait" for each of them to confirm that they successfully wrote
     everything. I'm not sure it buys us much over testing the output
     from "diff", though.

I still don't see where the hang comes from, though. It might be
unrelated. I'll try to examine more next time I catch it in the act.

-Peff
