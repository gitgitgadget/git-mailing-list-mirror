Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0FD1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdEBQDS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:03:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:60851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdEBQDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:03:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3ARX-1dyEWM2Vgl-00suzu; Tue, 02
 May 2017 18:03:05 +0200
Date:   Tue, 2 May 2017 18:03:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 24/25] show_worktree(): plug memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <ca9a9f22ffaebd6f59bdbe45fd6cc719d92b8d52.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OZ6SSqlqsJ6uJnGQzGDPCdmS6eStLfJ6MgY5BuwhLq1rL/Midq2
 Lu5AOOo7nFIRg5AWAsTkJogE8n8O+G0g6rC65wpTM8Ah2AwpTxPt1LZXCon8FhGrcoU/uo7
 JS+PxLeeEXJtoe6iJeWjAbShGWkbhZiiuwRLDt1DtvBTR02nEW9l7JVtAQyiCnsqo9ty/mu
 6ZlbQrTFc91PwiNcQhgSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XJg3sVFMteM=:OfpJvCOOzXF9HATn5qj1pN
 Bcyx+ijayKnihGNf9uXKhSAJXGnwUHVXP4tz1q/ssNgRDyWzlbvnKk3wD/4B9BcaFk4R+7vLL
 P79RZwJRXFBieiGxIRvZsK8crY5shUf1+pqEBQVq4HkFo5YJcimDfzdLMvJlKiVXyDy65E0UL
 bS6TJfNjpYAe6PTSOhuRAGrrczpiDcQadUe8dX009DiHyo3RBAcmlHPpByxipFPBBfO1YINc0
 1q/WtG2PIC4bHtZ8U8fQRG1/QwNLkrpziXoO9LuWylVZ/5aQEwcJYQn/Tdcn5B2o0q/I8/7aU
 zb4XSTfkaHKwG+8k6kt5qmb20ilOSfXyKRYzatGrwqoOso1uOKBMJdBpzxU76QomsFN/kmxE3
 HUyq2e0EQN+UuXfVWy4tqN5BczC6JcRhkESIQekNFj1aTKqJbEPZwdzmQX9PdZHYFkvYAJ+Tx
 Fa7P1WAz1RT2xQi52oeSVFB56y/82r1Jv/wNkYzf8gQs0o9IkhoUK9/4Y1939Kc5W0iWJZN+g
 KmZ1rK4iS+ou7mdp4jg4RNSY14Ktb8B1TJsoQPNaeAI7fzmXNBIRNQ08oHeDLNR9Bl0XbURGa
 Xcs0fEFSFBKCDHACWIBeWY0ZBAqt4Mv+A8J3hHvx/mr0efDjYKmCpVrhDSD+dfIhEPzDcFglE
 +T6DMU7Zk2+DGnPFV/zwHJ7CYhTIFlKCOWNh3DFLGmm7xqOdZMqyZeGCPvjxc0b+wDDp9S56q
 5LygJHZ5CrlY+ZlkGI6RyiHKJ40iPtx8ZTkRmNzRy8JfMg6mYxmrUp0GlsLDJ0YHUCSon7RZa
 z5yD7lX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer allocated by shorten_unambiguous_ref() needs to be released.

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/worktree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1722a9bdc2a..ff5dfd2b102 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -414,9 +414,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
-		else if (wt->head_ref)
-			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
-		else
+		else if (wt->head_ref) {
+			char *ref = shorten_unambiguous_ref(wt->head_ref, 0);
+			strbuf_addf(&sb, "[%s]", ref);
+			free(ref);
+		} else
 			strbuf_addstr(&sb, "(error)");
 	}
 	printf("%s\n", sb.buf);
-- 
2.12.2.windows.2.800.gede8f145e06


