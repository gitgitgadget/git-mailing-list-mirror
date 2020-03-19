Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F1EC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B652072C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCSQdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:33:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:44034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727222AbgCSQdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:33:35 -0400
Received: (qmail 26027 invoked by uid 109); 19 Mar 2020 16:33:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:33:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28649 invoked by uid 111); 19 Mar 2020 16:43:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:43:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:33:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] t4124: fix test for non-compliance diff
Message-ID: <20200319163334.GG3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:07PM +0700, Đoàn Trần Công Danh wrote:

> POSIX's diff(1) requires output in normal diff format.
> However, busybox's diff's output is written in unified format.

That's a pretty big difference. I'm surprised this only produces one
problem in the test scripts. ;)

> POSIX requires no option for normal-diff format.
> 
> A hint in test-lib-functions::test_cmp said `diff -u` isn't available
> everywhere.
> 
> Workaround this problem by assuming `diff(1)` output is unified
> if we couldn't make anything from normal-diff format.

I wonder if we could use "git diff" here. We have to be careful about
circular reasoning in our tests (i.e., making sure we're not verifying
output with the same code that we're testing), but I think here we're
checking how "apply --whitespace=fix" works.

But if this is the only spot, then adjusting to handle unified or normal
diff isn't too bad.

> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 971a5a7512..2a54ce96b5 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -52,6 +52,12 @@ test_fix () {
>  
>  	# find touched lines
>  	$DIFF file target | sed -n -e "s/^> //p" >fixed
> +	if ! test -s fixed; then
> +		$DIFF file target |
> +		grep '^+' |
> +		grep -v '^+++' |
> +		sed -e "s/+//" >fixed
> +	fi

I think those greps could be lumped into sed like:

  sed -ne "s/^+[^+]//p"

(at the cost of missing blank lines, but I think that's OK for our
purposes here; it could be fixed with an ERE).

Could we then make a single invocation that covers both diff formats? We
can further observe that the only thing we do with the "fixed" file is
count the lines, so we can leave the markers. Which means we could ditch
sed entirely and use grep. Something like:

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 971a5a7512..15cb0c81b7 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -50,8 +50,9 @@ test_fix () {
 	# fix should not barf
 	apply_patch --whitespace=fix || return 1
 
-	# find touched lines
-	$DIFF file target | sed -n -e "s/^> //p" >fixed
+	# find touched lines; handle either normal or unified
+	# diff, as system diff may generate either
+	$DIFF file target | grep '^[>+][^+]' >fixed
 
 	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)

seems to work for with both busybox diff and GNU diff.

-Peff
