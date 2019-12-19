Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B12C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F23822314
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLSCpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:45:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58980 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLSCpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 21:45:19 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D2CEE1F463;
        Thu, 19 Dec 2019 02:45:18 +0000 (UTC)
Date:   Thu, 19 Dec 2019 02:45:18 +0000
From:   Eric Wong <e@80x24.org>
To:     Ed Maste <emaste@FreeBSD.org>
Cc:     git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
Message-ID: <20191219024518.GA3411@dcvr>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219015833.49314-1-emaste@FreeBSD.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@FreeBSD.org> wrote:
> There are several different ways this could be solved; this approach
> felt cleanest to me, but there are at least two other reasonable
> alternatives:
> 
>   * Add -a to the invocations and .git to the expected output
> 
>   * Add LSFLAGS and set it to -I on BSDs, to turn off the special dot
>     behaviour
> 
> I'll submit a new patch if a different approach is preferred.

Relying on "ls" itself seems a bit fragile.
My first choice is to write more tests in Perl5 :)

But using a shell for loop seems doable, here, since there
doesn't seem to be wonky characters.  I've done this in the past
when I had to fix a system without "ls".

This goes on top of your patch:

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3a3eafa653..a431d05643 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -6,7 +6,7 @@ test_description='sparse checkout builtin tests'
 
 ls_no_git()
 {
-	ls -1 "$1" | grep -v .git
+	( cd "$1" && for i in *; do echo "$i"; done )
 }
 
 test_expect_success 'setup' '

