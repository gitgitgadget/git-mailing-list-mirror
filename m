Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28773C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJUFVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJUFVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:21:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EAB1A0F92
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:21:31 -0700 (PDT)
Received: (qmail 10466 invoked by uid 109); 21 Oct 2022 05:21:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:21:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1448 invoked by uid 111); 21 Oct 2022 05:21:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:21:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:21:30 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y1IsWt0ZrW+0hy1v@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
 <Y0TF0M6UzLS9r6iM@nand.local>
 <Y0TOpVF+Y70YJHzx@coredump.intra.peff.net>
 <Y1IGeuudJj18sDPz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1IGeuudJj18sDPz@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 10:39:54PM -0400, Taylor Blau wrote:

> --- 8< ---
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 0abe5354fc..566d581e1b 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -356,6 +356,19 @@ test_expect_success 'shortlog can match multiple groups' '
>  	test_cmp expect actual
>  '
> 
> +test_expect_success 'shortlog can match multiple format groups' '
> +	cat >expect <<-\EOF &&
> +	     2	User B <b@example.com>
> +	     1	A U Thor <author@example.com>
> +	     1	User A <a@example.com>
> +	EOF
> +	git shortlog -ns \
> +		--group="%(trailers:valueonly,separator=%0x00,key=some-trailer)" \
> +		--group="%(trailers:valueonly,separator=%0x00,key=another-trailer)" \
> +		-2 HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'set up option selection tests' '
>  	git commit --allow-empty -F - <<-\EOF
>  	subject
> --- >8 ---
> 
> The gross bit there really is the 'separator=%0x00' thing, since the
> "trailers" pretty format gives us a NL character already. I suppose that
> you could do something like this on top instead:

IMHO the new test should avoid using trailers entirely, to avoid the
notion that they are necessary to create the duplicate situation. In a
normal repository, the most obvious one is just asking about both
authors and committers:

  git shortlog --group=format:%cn --group=format:%an

Most commits will have the same value for both, but we want to credit
the commit to them only once.

Of course in our fake test-lib world, authors and committers are
different by default. :-/

But it's easy enough to make more normal-looking commits, perhaps like:

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 0abe5354fc..f0ff8a1714 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -356,6 +356,20 @@ test_expect_success 'shortlog can match multiple groups' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog can match multiple format groups' '
+	GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME \
+		git commit --allow-empty -m "identical names" &&
+	cat >expect <<-\EOF &&
+	     2	A U Thor
+	     1	C O Mitter
+	EOF
+	git shortlog -ns \
+		--group=%cn \
+		--group=%an \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up option selection tests' '
 	git commit --allow-empty -F - <<-\EOF
 	subject

You could also get fancier by dropping "-s" and making sure that the
commits were attributed as expected, but I think the count covers
things.

-Peff
