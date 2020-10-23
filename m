Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9ABC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD96121D43
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 01:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374245AbgJWBDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 21:03:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:40010 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374229AbgJWBDR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 21:03:17 -0400
Received: (qmail 23266 invoked by uid 109); 23 Oct 2020 01:03:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 01:03:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32054 invoked by uid 111); 23 Oct 2020 01:03:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Oct 2020 21:03:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Oct 2020 21:03:15 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <20201023010315.GA1542721@coredump.intra.peff.net>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 08:56:14AM +0200, Patrick Steinhardt wrote:

> The above scenario is the motivation for the new "reference-transaction"
> hook that reaches directly into Git's reference transaction mechanism.
> The hook receives as parameter the current state the transaction was
> moved to ("prepared", "committed" or "aborted") and gets via its
> standard input all queued reference updates. While the exit code gets
> ignored in the "committed" and "aborted" states, a non-zero exit code in
> the "prepared" state will cause the transaction to be aborted
> prematurely.

I know this has been merged for a while, but Taylor and I were looking
at it today and came across a question. The docs say:

> +For each reference update that was added to the transaction, the hook
> +receives on standard input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> LF

but that doesn't define <old-value>. I take it to mean the current value
of the ref before the proposed update. But in the tests:

> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> new file mode 100755
> index 0000000000..da58d867a5
> --- /dev/null
> +++ b/t/t1416-ref-transaction-hooks.sh
> [...]
> +test_expect_success 'hook gets all queued updates in prepared state' '
> +	test_when_finished "rm .git/hooks/reference-transaction actual" &&
> +	git reset --hard PRE &&
> +	write_script .git/hooks/reference-transaction <<-\EOF &&
> +		if test "$1" = prepared
> +		then
> +			while read -r line
> +			do
> +				printf "%s\n" "$line"
> +			done >actual
> +		fi
> +	EOF
> +	cat >expect <<-EOF &&
> +		$ZERO_OID $POST_OID HEAD
> +		$ZERO_OID $POST_OID refs/heads/master
> +	EOF

We are expecting to see $ZERO_OID in that slot, even though the current
value of the ref is "PRE" due to our reset above.

Should this be $PRE_OID (we don't have that variable, but it would be
the result of "git rev-parse PRE")?

I could alternatively see an argument that <old-value> is the old-value
that the caller asked for. So seeing $ZERO_OID is saying that the caller
wants to move from _anything_ to $POST_OID, and we're not willing to
tell the hook what the current value actually is.

We could actually fill in the current value for zero cost. The reason we
found this is that we have a custom patch at GitHub that fills in these
values when we open the ref after locking.

In real usage, I'm not sure how much the distinction would matter,
because any careful caller would provide a non-zero "old" value. And if
that doesn't match the current value, we'd reject the transaction before
we even hit the hook, I think. It's only the fact that the update-ref
calls are sloppy and do not provide an expected old value that it even
matters.

So I wonder if:

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index f6e741c6c0..8155522a1a 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -9,6 +9,7 @@ test_expect_success setup '
 	test_commit PRE &&
 	PRE_OID=$(git rev-parse PRE) &&
 	test_commit POST &&
+	PRE_OID=$(git rev-parse PRE) &&
 	POST_OID=$(git rev-parse POST)
 '
 
@@ -52,10 +53,10 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
-	git update-ref HEAD POST <<-EOF &&
+	git update-ref HEAD POST POST <<-EOF &&
 		update HEAD $ZERO_OID $POST_OID
 		update refs/heads/master $ZERO_OID $POST_OID
 	EOF
@@ -75,10 +76,10 @@ test_expect_success 'hook gets all queued updates in committed state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
-	git update-ref HEAD POST &&
+	git update-ref HEAD POST PRE &&
 	test_cmp expect actual
 '
 

would be a step forward. This isn't changing the actual behavior,
obviously. It's just tweaking the test so that it tests the more likely
real-world case.  But we'd possibly want to actually change the behavior
to always send the actual ref value to the hook.

-Peff
