Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE34207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbcI2T0S (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:26:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50130 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752589AbcI2T0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:26:17 -0400
Received: (qmail 15113 invoked by uid 109); 29 Sep 2016 19:26:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 19:26:16 +0000
Received: (qmail 4246 invoked by uid 111); 29 Sep 2016 19:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 15:26:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 15:26:14 -0400
Date:   Thu, 29 Sep 2016 15:26:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
Message-ID: <20160929192613.o6q2fqp3mjntz2l6@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-3-gitster@pobox.com>
 <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
 <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
 <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
 <xmqq60pefrvc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60pefrvc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 12:06:15PM -0700, Junio C Hamano wrote:

> I think it deserves a separate patch and the result is more
> understandable.  I've queued this for now (on top of a revised 1/4
> that uses GIT_CONFIG_SYSTEM_PATH instead).

Thanks, makes sense (and I like the new variable name better, by the
way).

> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Thu, 29 Sep 2016 11:29:10 -0700
> Subject: [PATCH] t1300: check also system-wide configuration file in
>  --show-origin tests
> 
> Because we used to run our tests with GIT_CONFIG_NOSYSTEM, these did
> not test that the system-wide configuration file is also read and
> shown as one of the origins.  Create a custom/fake system-wide
> configuration file and make sure it appears in the output, using the
> newly introduced GIT_CONFIG_SYSTEM_PATH mechanism.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Good description.

Signed-off-by: Jeff King <peff@peff.net>

of course.

> @@ -1304,6 +1315,7 @@ test_expect_success '--show-origin with --get-regexp' '
>  		file:$HOME/.gitconfig	user.global true
>  		file:.git/config	user.local true
>  	EOF
> +	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
>  	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
>  	test_cmp expect output
>  '

This is one is trying to do a multi-file lookup, but we couldn't look in
the system config before. But to naturally extend it, it ought to look
like this on top:

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index d2476a8..4dd5ce3 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1310,11 +1310,12 @@ test_expect_success '--show-origin with single file' '
 
 test_expect_success '--show-origin with --get-regexp' '
 	cat >expect <<-EOF &&
+		file:$HOME/etc-gitconfig	user.system true
 		file:$HOME/.gitconfig	user.global true
 		file:.git/config	user.local true
 	EOF
 	GIT_ETC_GITCONFIG=$HOME/etc-gitconfig \
-	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
+	git config --show-origin --get-regexp "user\.[g|l|s].*" >output &&
 	test_cmp expect output
 '
 
> @@ -1312,6 +1324,7 @@ test_expect_success '--show-origin getting a single key' '
>  	cat >expect <<-\EOF &&
>  		file:.git/config	local
>  	EOF
> +	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
>  	git config --show-origin user.override >output &&
>  	test_cmp expect output
>  '

And I was tempted to say this one should not need to care, but I guess
it is testing that we correctly read the override from the local config
over the global one. So likewise, it is good to check that we also
override the system config (it does not effect the "expect" output, but
that does not mean it is not enhancing the test).

-Peff
