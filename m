Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B021207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755464AbdEDN5V (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:57:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:63947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755377AbdEDN45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1drfov0LUa-00pu8T; Thu, 04
 May 2017 15:56:45 +0200
Date:   Thu, 4 May 2017 15:56:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 12/25] split_commit_in_progress(): simplify & fix memory
 leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <70ba46de5c9ca9987e6a5f1a16904b59a7c7cb45.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1qCKMUlHyOHOf9uB0KqrewSq6Vl+qkDY5ytfqfv+53G7irVeH0v
 KWLlIWbNV9u0G8G538p3pWG7tvr2LaZq9tc5yt8mIz4FAawUonW0RdUPrV/LiuZ4GEmkf9p
 SwgZSoxADOvfzWXhP45yxfWPvSWYxNrfg5Nc225TzcJfMookpx1zLPUEFzg69anqsTKpVo7
 8dqc1/DQHVry7+sp7QEBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/tqzqB65L+0=:wEBDVmcGQ1J6T1bhzUmTt7
 rageuoDfEVz4MrRo4zA1Y+VA/qW8nKd7h+kYD2/OZsWeCuEppQPLGHezTs/uMcmP7iV5kHrQm
 QSXlE4TPKy+0BR2a1n/jhRGMbXBLf2gxi5OVf2y0gJA77oRm1Y6WaBP6BPW6GmDjhYSmT4pmz
 EkJShaEBFXH2SP5xNIolx2QE2aBkHXUA3Qy4WDdd3GrEZUiKBbzh0Jg3fIrkQM/3o+U52+hK4
 u2JYTAZO1F61Z109Lh1QY7+MALpCCtrkkZb9kazhyXmjT3yH4Ges+xAW9KRE3FCOa/UqVWPRp
 wDS/oiaenMYT35mcL2VoQ9oVlr/TxoltKLwka+SOOLL+oY2EKhbzFzVUutVsxT5vx9tnarxi5
 12Bswxfm8zlMNnxnLn4eUOCMy5+JR7MGPDRTfJ0sBgCmNg+KuynK0yFOasYlshU7KcaVFR+iU
 Bv6nF3a4R7tEMiMglcm4nzu5Jl6BLJaRLmnJKxm/CrHTSmrG855chqUXABic7jLt58w6MObru
 JJCF+Qm0HvRulOtzrNFJb7Ykmo4NH8gG++yysqE+0iTwSaG48XbjvtRi+IvD2cczz0DgnI1ig
 A3eXy2HTBW9PpHlPTJH9BB4z22hfd2LXJFLiQf0w/DeRMezeRPRKwGcKt7qPOlU8PzeYcZrGl
 NARwisPMjiOu6S38HnxNjPsR+jREaDm9dBbmywaXxW6/Xcyn2JtERUZzklIr+Wp3XksS8E5W6
 HoXWF8O8aaKzq7PfUK9i0hdGo75nkWcmeTKQfut+QaVKLWAPKHH3H7Cynz4U3uj45qkF/4WO2
 opu6/TR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function did a whole lot of unnecessary work, such as reading in
four files just to figure out that, oh, hey, we do not need to look at
them after all because the HEAD is not detached.

Simplify the entire function to return early when possible, to read in
the files only when necessary, and to release the allocated memory
always (there was a leak, reported via Coverity, where we failed to
release the allocated strings if the HEAD is not detached).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0a6e16dbe0f..117ac8cfb01 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1082,29 +1082,29 @@ static char *read_line_from_git_path(const char *filename)
 static int split_commit_in_progress(struct wt_status *s)
 {
 	int split_in_progress = 0;
-	char *head = read_line_from_git_path("HEAD");
-	char *orig_head = read_line_from_git_path("ORIG_HEAD");
-	char *rebase_amend = read_line_from_git_path("rebase-merge/amend");
-	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
+	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
 
-	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
+	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
 	    !s->branch || strcmp(s->branch, "HEAD"))
-		return split_in_progress;
+		return 0;
 
-	if (!strcmp(rebase_amend, rebase_orig_head)) {
-		if (strcmp(head, rebase_amend))
-			split_in_progress = 1;
-	} else if (strcmp(orig_head, rebase_orig_head)) {
-		split_in_progress = 1;
-	}
+	head = read_line_from_git_path("HEAD");
+	orig_head = read_line_from_git_path("ORIG_HEAD");
+	rebase_amend = read_line_from_git_path("rebase-merge/amend");
+	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
 
-	if (!s->amend && !s->nowarn && !s->workdir_dirty)
-		split_in_progress = 0;
+	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
+		; /* fall through, no split in progress */
+	else if (!strcmp(rebase_amend, rebase_orig_head))
+		split_in_progress = !!strcmp(head, rebase_amend);
+	else if (strcmp(orig_head, rebase_orig_head))
+		split_in_progress = 1;
 
 	free(head);
 	free(orig_head);
 	free(rebase_amend);
 	free(rebase_orig_head);
+
 	return split_in_progress;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


