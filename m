Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7C51F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdEBQC1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:62503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbdEBQCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:24 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSIf1-1dUdKy1XOV-00TXWY; Tue, 02
 May 2017 18:02:03 +0200
Date:   Tue, 2 May 2017 18:02:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 11/25] checkout: fix memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <7a78e949226251174c1b3a10b9a18addc2b52193.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T2lB+yf0huAUJZT0903DQTJm4uDWvUBR+zHNHfr0cuz51mFPp0p
 jc0PQSgVZOwEkxSc48xbYNcZts916VZp4pVn2U/opeDBg8MigQjEUb2ruOPB0J8uv7j6u7j
 uKtknHeo1HuGV2hwlVOU0VYO/c2tLiCc5TN66Qmjj5pXskOgEmj2HyjMpe8CB719plY3Hqz
 FK/J7FGOiwMh1CrbrMreg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QqMbrfD6N4s=:Kt48tz66iGVQ5T7TLI0nqp
 Cl4cL05nMWuRow0HFt6N2mS7RbI0bH5SgdN8j7n9EEYMhPPYQZHAhiR3dkrXyl4fUEldAG14m
 GkYJAAXKeRKsMqqVmez0+oa0iJ/BKkpxfAzJZkuxzvOk5l1RADicyKxRgwKd/YJ+25cXS68xk
 nS1ieRZ66FQMvTpwf141xMHMyxHIQZdhtCAmQpUdV83YYNKtw4BgjagMgISnuVM5+8sjXOYBz
 CO5aTaWKfd66rAjl7LhxVwSDHol5DmoKfFSrITAD/grjVUWBQWerTm2ciN856VONwY1mX+FAA
 JStjdk03r7zAD/2Yszv8VKgwpHiujwAd7mEe3yptOlOVEkI7NhserZwhUXBkatiff9TIQGnA0
 Ng/TDmfknt/P3mdCxIw4RLmTLVVr3Qm/dgqkg5SGWkZw/LC2FSOQlUrv9ZGLloDUSItz6Z+O4
 B7nv0XUIkaq88565sTvhcZ3jVzZUZMi22VLxyjvDt069KHQv40oJrVs8q7yWzW9AovczflgqK
 8hG4DQc2ehY/nUUcXijCcfaDagGIuqIgEuUKjXW9hm8nliEssKIxcZXhVm4hRFyFwV3joowyk
 JLXV2of1cfQW9jnw0365nYhVzc6luwp2nW0DQjUV6lpFf2AoKtJqpIXjFB6I9T5m2gJoLSZSW
 3Xpqy2hJr3WXzZIazoJkr9sbrCDnJzB6WkwSqqwX+7gGovEBomnNp3nMFU3+YZ4qbo7Y+30jj
 d2fyJiDo7pxs91Z2+8M83LW5kz+CUbs+yXEIs+wl7fcoksN3XIYmTgs9O2VPixjoI9PmgJnne
 pGABOB8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change addresses part of the NEEDSWORK comment above the code,
therefore the comment needs to be adjusted, too.

Discovered via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f335..5faea3a05fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -235,14 +235,14 @@ static int checkout_merged(int pos, const struct checkout *state)
 	/*
 	 * NEEDSWORK:
 	 * There is absolutely no reason to write this as a blob object
-	 * and create a phony cache entry just to leak.  This hack is
-	 * primarily to get to the write_entry() machinery that massages
-	 * the contents to work-tree format and writes out which only
-	 * allows it for a cache entry.  The code in write_entry() needs
-	 * to be refactored to allow us to feed a <buffer, size, mode>
-	 * instead of a cache entry.  Such a refactoring would help
-	 * merge_recursive as well (it also writes the merge result to the
-	 * object database even when it may contain conflicts).
+	 * and create a phony cache entry.  This hack is primarily to get
+	 * to the write_entry() machinery that massages the contents to
+	 * work-tree format and writes out which only allows it for a
+	 * cache entry.  The code in write_entry() needs to be refactored
+	 * to allow us to feed a <buffer, size, mode> instead of a cache
+	 * entry.  Such a refactoring would help merge_recursive as well
+	 * (it also writes the merge result to the object database even
+	 * when it may contain conflicts).
 	 */
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
 			    blob_type, oid.hash))
@@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
+	free(ce);
 	return status;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


