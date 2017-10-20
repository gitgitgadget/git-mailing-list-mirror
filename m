Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65FB202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 05:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdJTFvB (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 01:51:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750905AbdJTFvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 01:51:00 -0400
Received: (qmail 23144 invoked by uid 109); 20 Oct 2017 05:51:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 05:51:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15043 invoked by uid 111); 20 Oct 2017 05:51:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 01:51:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 01:50:58 -0400
Date:   Fri, 20 Oct 2017 01:50:58 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
Message-ID: <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
 <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
 <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 07:23:37PM -0400, Jeff King wrote:

> So one trick is that we can't just set it to a higher number. We have to
> also open and manage that descriptor. It might be enough to do:
> 
>   if test -n "$BASH_VERSION"
>   then
> 	exec 999>&4
> 	BASH_XTRACEFD=999
>   fi
> [...]
> I think it might be workable, but I'm worried we're opening a can of
> worms. Or continuing to dig into the can of worms from the original
> BASH_XTRACEFD, if you prefer. :)

So this is the best I came up with (on top of my other patches for
ease of reading, though I'd re-work them if this is the route we're
going to go):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 14fac6d6f2..833ceaefd2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -377,7 +377,12 @@ fi
 #
 # Note also that we don't need or want to export it. The tracing is local to
 # this shell, and we would not want to influence any shells we exec.
-BASH_XTRACEFD=4
+if test -n "$BASH_VERSION"
+then
+	exec 999>&4
+	BASH_XTRACEFD=999
+	silence_trace="999>/dev/null"
+fi
 
 test_failure=0
 test_count=0
@@ -627,14 +632,16 @@ test_eval_ () {
 	#     be _inside_ the block to avoid polluting the "set -x" output
 	#
 
-	test_eval_inner_ "$@" </dev/null >&3 2>&4
-	{
-		test_eval_ret_=$?
-		if want_trace
-		then
-			set +x
-		fi
-	} 2>/dev/null 4>&2
+	eval '
+		test_eval_inner_ "$@" </dev/null >&3 2>&4
+		{
+			test_eval_ret_=$?
+			if want_trace
+			then
+				set +x
+			fi
+		} 2>/dev/null '"$silence_trace"'
+	'
 
 	if test "$test_eval_ret_" != 0 && want_trace
 	then

I really hate that extra eval, since it adds an extra layer of "+" to
the tracing output in bash.

But I can't find a way to make it work without it. The "999>/dev/null"
is syntactically bogus in non-bash shells, so it _must_ appear as part
of an eval.  We can't conditionally stick it at the end of the eval run
by test_eval_inner_, because that one is running the actual test code
(so it may bail early with "return", for example).

TBH, I'm not 100% sure that the initial "exec 999>&4" won't cause
complaints in some shells. Dash seems to handle it, but others might
not. That can be worked around with another eval, though.

So I dunno. It does solve the problem in a way that the individual test
scripts wouldn't have to care about. But it's a lot of eval trickery.

-Peff
