Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A80C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQTtf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:49:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:49980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729855AbeGQTtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:49:35 -0400
Received: (qmail 14047 invoked by uid 109); 17 Jul 2018 19:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 19:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24714 invoked by uid 111); 17 Jul 2018 19:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 15:15:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 15:15:31 -0400
Date:   Tue, 17 Jul 2018 15:15:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] repack -ad: fix after `fetch --prune` in a
 shallow repository
Message-ID: <20180717191531.GA30594@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <pull.9.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.9.v2.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 06:51:39AM -0700, Johannes Schindelin via GitGitGadget wrote:

> Under certain circumstances, commits that were reachable can be made
> unreachable, e.g. via `git fetch --prune`. These commits might have
> been packed already, in which case `git repack -adlf` will just drop
> them without giving them the usual grace period before an eventual
> `git prune` (via `git gc`) prunes them.
> 
> This is a problem when the `shallow` file still lists them, which is
> the reason why `git prune` edits that file. And with the proposed
> changes, `git repack -ad` will now do the same.
> 
> Reported by Alejandro Pauly.
> 
> Changes since v1:
> 
> - Also trigger `prune_shallow()` when `--unpack-unreachable=<approxidate>` was passed to `git repack`.
> - No need to trigger `prune_shallow()` when `git repack` was called with `-k`.

I think you might have missed the bigger problem I pointed at, as it was
buried deep within my later reply. Try applying this patch on top, which
tests the opposite case (reachable shallow commits are retained):

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index d32ba20f9d..911e457ae1 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,17 +186,20 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success '.git/shallow is edited by repack' '
+test_expect_success 'set up shallow server' '
 	git init shallow-server &&
 	test_commit -C shallow-server A &&
 	test_commit -C shallow-server B &&
 	git -C shallow-server checkout -b branch &&
 	test_commit -C shallow-server C &&
 	test_commit -C shallow-server E &&
 	test_commit -C shallow-server D &&
 	d="$(git -C shallow-server rev-parse --verify D)" &&
-	git -C shallow-server checkout master &&
+	git -C shallow-server checkout master
+'
 
+test_expect_success 'repack drops unreachable objects from .git/shallow' '
+	test_when_finished "rm -rf shallow-client" &&
 	git clone --depth=1 --no-tags --no-single-branch \
 		"file://$PWD/shallow-server" shallow-client &&
 
@@ -213,4 +216,13 @@ test_expect_success '.git/shallow is edited by repack' '
 		origin "+refs/heads/*:refs/remotes/origin/*"
 '
 
+test_expect_success 'repack keeps reachable objects in .git/shallow' '
+	test_when_finished "rm -rf shallow-client" &&
+	git clone --depth=1 --no-tags --no-single-branch \
+		"file://$PWD/shallow-server" shallow-client &&
+
+	git -C shallow-client repack -adfl &&
+	grep $d shallow-client/.git/shallow
+'
+
 test_done
