Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E848DC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 18:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiIHSUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiIHSUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 14:20:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46EC2F91
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 11:20:39 -0700 (PDT)
Received: (qmail 28287 invoked by uid 109); 8 Sep 2022 18:20:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 18:20:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23350 invoked by uid 111); 8 Sep 2022 18:20:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 14:20:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 14:20:38 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lana Deere <lana.deere@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <Yxoydthiq0Hzzx4G@coredump.intra.peff.net>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxJkn7K3zRm1u3Vn@tapette.crustytoothpaste.net>
 <CA+4x=b_KP4rMH-EDmVCD_4LHPiLx32J2OJC6Mm5xpQ-QUcSKuA@mail.gmail.com>
 <s46p34qn-rq84-20q6-nr36-594sos6q5qq9@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s46p34qn-rq84-20q6-nr36-594sos6q5qq9@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 02:59:08PM +0200, Johannes Schindelin wrote:

> At first I thought that this would be the root cause:
> `feature/switch-to-qt5` is not included in the refs to fetch.
> 
> But then I added a test case for that specific scenario:
> 
> -- snip --
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 081808009b2..6e6ddeb7e63 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -218,6 +218,17 @@ test_expect_success 'fail if upstream branch does not exist' '
>  	test_cmp expect file
>  '
> 
> +test_expect_success 'fetch upstream branch even if refspec excludes it' '
> +	git branch tirili &&
> +	git branch tirili2 &&
> +	git init -b tirili downstream &&
> +	git -C downstream remote add -t tirili origin "file://$(pwd)/.git" &&
> +	git -C downstream config branch.tirili.remote origin &&
> +	git -C downstream config branch.tirili.merge refs/heads/tirili2 &&
> +	git -C downstream pull 2>err &&
> +	! grep "configuration specifies to merge" err
> +'
> +
>  test_expect_success 'fail if the index has unresolved entries' '
>  	git checkout -b third second^ &&
>  	test_when_finished "git checkout -f copy && git branch -D third" &&
> 
> -- snap --
> 
> And that test case passes!
> 
> The reason is that we specifically add the ref that needs to be merged to
> the list of refs to be fetched:
> https://github.com/git/git/blob/v2.37.2/builtin/fetch.c#L605-L614

I just sent another message with more details. But the reason this test
passes is that "tirili" is a prefix of "tirili2". The v2 feature to
limit advertisements works on string prefixes, so asking for "tirili"
will let the server advertise both branches. Switching the first branch
name like so:

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6e6ddeb7e6..7e9ed436d3 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -219,12 +219,12 @@ test_expect_success 'fail if upstream branch does not exist' '
 '
 
 test_expect_success 'fetch upstream branch even if refspec excludes it' '
-	git branch tirili &&
+	git branch tirili1 &&
 	git branch tirili2 &&
-	git init -b tirili downstream &&
-	git -C downstream remote add -t tirili origin "file://$(pwd)/.git" &&
-	git -C downstream config branch.tirili.remote origin &&
-	git -C downstream config branch.tirili.merge refs/heads/tirili2 &&
+	git init -b tirili1 downstream &&
+	git -C downstream remote add -t tirili1 origin "file://$(pwd)/.git" &&
+	git -C downstream config branch.tirili1.remote origin &&
+	git -C downstream config branch.tirili1.merge refs/heads/tirili2 &&
 	git -C downstream pull 2>err &&
 	! grep "configuration specifies to merge" err
 '

causes it to fail just like Lana's case.

-Peff
