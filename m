Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD5720450
	for <e@80x24.org>; Fri,  3 Nov 2017 12:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbdKCM62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 08:58:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:56751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbdKCM61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 08:58:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McEI3-1dsecv0UBb-00JehH; Fri, 03
 Nov 2017 13:58:18 +0100
Date:   Fri, 3 Nov 2017 13:58:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrew Baumann <Andrew.Baumann@microsoft.com>
Subject: [PATCH] setup: avoid double slashes when looking for HEAD
Message-ID: <9322728aaa3010c0b71574eb5876548487d66885.1509713589.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yktnci8RKbQ7eq2iiXmkqBlBo7rTXn0nVNU4ovohTg9DmFj1WY1
 JETIhGJzhZ9nFq6OzqJI4b/t4z2/sx4S1DNe6YdWbD/H0OEeI/3ENnbpeDZzjeePpdc8Tnk
 GzT++B/pmF2JgPZ634aqdqbqs5KXJwCxZWLuh1NDwxojq/EI157euAHHNWCb0KcWsew5wuw
 99bnvrINsOMoQNNdTTAdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l+MAswD15AY=:1SsppucMTIJpfoV6/bKnwB
 FJP7rUrAMKgM3xVjpZC+orqv7e+MehmWIn1QhZcs3WAQwH72IueES5WC5tiJ111DlaZLB8xKG
 QqRof2T+gsuH9XiFLnrr0QBf1gFq5id6NyOMOU1T74E7b8wzGZVnm9+oOQpgRBfsQ4ShCWh/D
 8TTjtUplnWttfsxSF1BklPvX2UfIJJKkaRtLd9t6q0Iw83apXpsQiSDqo7ArpnJVEiIa3sotK
 Y5u+Ftndotp9Ou6O5vPHAAIL6jXzZ8Z0nBzqnww8C39tbr6gk8wYqgzeavyv5yi1QKZMTSpgn
 1YVmkr1mbSADcCV1B/WRSYbMRx7jivHxSdHFsBre/Aw65HkI63WoA58DX+rYc9Ltiiezezl3H
 SvoPW3an3mjp1S6cjiE0Uk/5nKKx+Yfj8ahUV81oFfiN3izQnaAUk0mWVjxG5ADDl2QOkruCZ
 13uMISsl7G9QPE0SjRmpuCFGUXBg9sfE6ccNbo+7/yWh2k4MHAd+lzmL2GksGtK45Un8F+G/I
 pXnSj+cHZ8ofWlYyzJpfq24dE7DaeWPyFYTTAM5PtfkLzq+gJLTTFHqtHvsfpQuEdwq2LHT4I
 GMXcXznV5keEDjXKjtfRYsxbTKUu+BPl4EdWkHfPTpdJiub6Zqtf+Wt2B9NMa5xY/zye+QvOl
 KWENPLvj693qrCmJll97FUeBUnuObeCgzTXfEz5v8GmSh3nU/w3dvkbhpgw/l4/tLMJVOCCGp
 YX/7LwK4VVfxYoW6zFdbVsy6yR37aOVv/acGXhhlL/aMT9cU27o8+CbsJJNt0/WpFp5SrNz63
 tpM0Hn836Q9NThL6f6ioxV0s7gvbhTqln3o3vfYiK0GX/CB5vE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Andrew Baumann reported that when called outside of any Git worktree,
`git rev-parse --is-inside-work-tree` eventually tries to access
`//HEAD`, i.e.  any `HEAD` file in the root directory, but with a double
slash.

This double slash is not only unintentional, but is allowed by the POSIX
standard to have a special meaning. And most notably on Windows, it
does, where it refers to a UNC path of the form `//server/share/`.

As a consequence, afore-mentioned `rev-parse` call not only looks for
the wrong thing, but it also causes serious delays, as Windows will try
to access a server called `HEAD`.  Let's simply avoid the unintended
double slash.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/double-slash-HEAD-v1
Fetch-It-Via: git fetch https://github.com/dscho/git double-slash-HEAD-v1

	And here it is, as a proper, easy-to-pull branch, and also in the
	form Junio prefers.

 setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 03f51e056cd..94768512b79 100644
--- a/setup.c
+++ b/setup.c
@@ -312,7 +312,9 @@ int is_git_directory(const char *suspect)
 	size_t len;
 
 	/* Check worktree-related signatures */
-	strbuf_addf(&path, "%s/HEAD", suspect);
+	strbuf_addstr(&path, suspect);
+	strbuf_complete(&path, '/');
+	strbuf_addstr(&path, "HEAD");
 	if (validate_headref(path.buf))
 		goto done;
 

base-commit: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
-- 
2.15.0.windows.1
