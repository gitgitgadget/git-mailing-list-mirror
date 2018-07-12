Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B9F1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 23:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbeGMADw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 20:03:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387708AbeGMADw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 20:03:52 -0400
Received: (qmail 19288 invoked by uid 109); 12 Jul 2018 23:51:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Jul 2018 23:51:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29481 invoked by uid 111); 12 Jul 2018 23:52:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 12 Jul 2018 19:52:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2018 19:51:56 -0400
Date:   Thu, 12 Jul 2018 19:51:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3404: fix use of "VAR=VAL cmd" with a shell function
Message-ID: <20180712235156.GA10590@sigill.intra.peff.net>
References: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com>
 <20180712201454.GA6281@sigill.intra.peff.net>
 <xmqq4lh4w6e8.fsf@gitster-ct.c.googlers.com>
 <xmqqzhywurey.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhywurey.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 01:31:49PM -0700, Junio C Hamano wrote:

> >> ...would you want to use test_when_finished here (both for robustness,
> >> but also to make it more clear to a reader what's going on)?
> >
> > Perhaps.
> 
> Yes, but this one ends up to be overly ugly.
> 
> The restoreing of the AUTHOR_NAME must be done not just before this
> test_expect_success finishes and control goes on to the next test,
> but also before "git rebase -i" in the middle of this test that is
> expected to fail with conflict, as we want it to see the original
> author name (not the modified AttributeMe name).

OK, that is ugly.

>  test_expect_success 'retain authorship w/ conflicts' '
> +	oGIT_AUTHOR_NAME=$GIT_AUTHOR_NAME &&
> +	test_when_finished "GIT_AUTHOR_NAME=\$oGIT_AUTHOR_NAME" &&
> +
>  	git reset --hard twerp &&
>  	test_commit a conflict a conflict-a &&
>  	git reset --hard twerp &&
> -	GIT_AUTHOR_NAME=AttributeMe \
> +
> +	GIT_AUTHOR_NAME=AttributeMe &&
> +	export GIT_AUTHOR_NAME &&
>  	test_commit b conflict b conflict-b &&
> +	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&
> +

I'd actually go so far as to say that it is less ugly without the helper
entirely, like:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..10d50650ae 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -267,8 +267,9 @@ test_expect_success 'retain authorship w/ conflicts' '
 	git reset --hard twerp &&
 	test_commit a conflict a conflict-a &&
 	git reset --hard twerp &&
-	GIT_AUTHOR_NAME=AttributeMe \
-	test_commit b conflict b conflict-b &&
+	echo b >conflict &&
+	git add conflict &&
+	git commit --author="AttributeMe <attr@example.com>" -m b &&
 	set_fake_editor &&
 	test_must_fail git rebase -i conflict-a &&
 	echo resolved >conflict &&

but it is probably not worth spending more brain cycles on this. Any of
the solutions is fine by me.

(I do agree that being able to automatically catch these with a linter
would be worth brain cycles, but I cannot immediately think a of a way
to do so).

-Peff
