Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E2C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 21:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKAVpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAVpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 17:45:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9222101E0
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 14:45:38 -0700 (PDT)
Received: (qmail 7581 invoked by uid 109); 1 Nov 2022 21:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 21:45:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29448 invoked by uid 111); 1 Nov 2022 21:45:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 17:45:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 17:45:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin von Zweigbergk <martinvonz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in `git branch --delete main` when on other orphan brancht
Message-ID: <Y2GTgB0oTW3rR1HZ@coredump.intra.peff.net>
References: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
 <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
 <Y2F9lkCWf/2rjT2E@nand.local>
 <Y2F+MA+cAsEB0Glb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2F+MA+cAsEB0Glb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:14:40PM -0400, Taylor Blau wrote:

> Actually, the test doesn't need "other" here, since we aren't actually
> going to delete the target branch (for the exact same reason that you
> pointed out to Martin earlier in the thread).
> 
> So it could actually be as small as something like this:
> 
> --- >8 ---
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 7f605f865b..464d3f610b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -279,6 +279,13 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
>  	test_cmp expect err
>  '
> 
> +test_expect_success 'git branch -d on detached HEAD' '
> +	test_when_finished git checkout main &&
> +	git checkout --orphan orphan &&
> +	test_must_fail git branch -d main 2>err &&
> +	grep "not fully merged" err
> +'

I think there's a more interesting case, which is when "main" has a
configured upstream to which it's fully merged. And then the deletion
actually succeeds (and the bug is not just giving us a crappy message,
but actually doing causing the wrong outcome).

And for that we'd probably not want to use "main", since a successful
test will actually delete it. ;)

I'll try later tonight to integrate that test into the patch you've
written.

-Peff
