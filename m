Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC8C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A422320772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZItF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:49:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726318AbgCZItE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:49:04 -0400
Received: (qmail 1667 invoked by uid 109); 26 Mar 2020 08:49:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:49:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12464 invoked by uid 111); 26 Mar 2020 08:58:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:58:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:49:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] tests: do not let lazy prereqs inside
 `test_expect_*` turn off tracing
Message-ID: <20200326084903.GE2200716@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 05:41:20AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The `test_expect_*` functions use `test_eval_` and so does
> `test_run_lazy_prereq_`. If tracing is enabled via the `-x` option,
> `test_eval_` turns on tracing while evaluating the code block, and turns
> it off directly after it.
> 
> This is unwanted for nested invocations.
> 
> One somewhat surprising example of this is when running a test that
> calls `test_i18ngrep`: that function requires the `C_LOCALE_OUTPUT`
> prereq, and that prereq is a lazy one, so it is evaluated via
> `test_eval_`, the command tracing is turned off, and the test case
> continues to run _without tracing the commands_.

Good catch. I didn't see this when looking at the GPG stuff earlier
because I didn't nest the lazy prereqs. But it is worth fixing
regardless, because as you note it comes up in other places.

> @@ -926,7 +927,8 @@ test_eval_ () {
>  		test_eval_ret_=$?
>  		if want_trace
>  		then
> -			set +x
> +			test 1 = $_trace_level && set +x
> +			_trace_level=$(($_trace_level-1))
>  		fi
>  	} 2>/dev/null 4>&2

I briefly wondered if adding more logic here might upset our delicate
balance of avoiding writing cruft to the "-x" output. But the answer is
"no", due to the descriptor hackery at the end of that {} block.

Of course, any test evaluating a lazy prereq already gets tons of cruft
anyway, because the outer level of tracing sees all of our internal
function calls checking the prereq and setting up the inner level of
tracing. But there's not much we can do about that.

-Peff
