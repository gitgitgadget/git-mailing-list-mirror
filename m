Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1AA202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 00:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbdCJANg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 19:13:36 -0500
Received: from mout.web.de ([212.227.17.12]:63342 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752459AbdCJANf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 19:13:35 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWo4-1c4zML0QpY-010t8x; Fri, 10
 Mar 2017 01:13:13 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] blame: move blame_entry duplication to add_blame_entry()
Message-ID: <11b8ad3a-cd3d-2fd6-4b06-b442099c2709@web.de>
Date:   Fri, 10 Mar 2017 01:12:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iwV3veki3D18EYoiRQT3yd+a5OKDOwFhA+Qx1cglI6pwTqzI0CS
 DNaiwUqwD0OKQKAtN/I25uHDGE4yY8ZduJ1JlLMIUw8uwY9mdtd6xSxEJ3aoFFMAi6ActMa
 6g5H7myzhVvMA1UA2t9UEDA7e4O4LSxgz+mrlsSABmJjBinY6SJH75rShklHZamVbY/xS8E
 +9DewaAK8GmWSZnAooznA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RGAJ+gACSGQ=:BBf0008q0/bBBpk83GnHVS
 wkaCbaNVT50sgqwJZ5IGgWDSkxUgciLLLUh7XImxx0m1ihJkQTB6Xp9aWXQkfKcLZEKazycik
 /G4d84E4pJEv1QMpuHeToYXGeKD3BzHYdpUZbWG++Ng3JJw2auNPUzjerV+4Fna6K1V5i+EC5
 NwcBqh1iPj2SqtFJTlh3Wz/kbtKjklyT7g/lyp6N5/6/kk64ZW8y6AgAmT+LLQ77OMPz4xb6a
 cwT6N3kSlM11LmmLHgOTrq01GHtb8jzwDCMMKVIvtC0CPjrTI/rmFZtS0YC+dLSswKLAYlX2l
 PJudNrmr2TX1WJbYQqSm1rb274LOKOn3/8aik2aeGvLWD9Ksbw3dSGh4BRR5Fr+HHAsmEEZiR
 xYZHxv4mWkCq5G7fmRGZRcJeBjGM8dJ+3I0bSvA8lNg6VeOf5tHNedECftqDQmP7TDd51A6fh
 fVnTAWbcF1eXV/7BJCs3K1mHh1odDbAL1ojFrJYQ4mUomygD+32u3nGqhLEJfX4VcqZyyO1b3
 U/2rviXlsEH4iZ/C3LCgEOFkapgUjLPq655ZhbypaKnAifzegIAWomssz4Rd4deulRTnozSGa
 lX9x/nIg2SlGMWdhFt2VuYZUALtYSau+/TSZ143Lrxy8GEPrMxpb5A/h1MFlkyzQjAg7lxEYn
 YeQ2qshWtjxnAxIscjkPzjl4RXbyuanYwvEw5+He+/Xj0gJQmkw8gRZ56R/wijP7tqMCYFCjY
 bUzDGjXlEXKMSzBG3Pai66dasza1f4AiT4OQp3P4AxrqefC/vDYZwHu/vvkB8U8hiytEmK/un
 aNyho8D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers of add_blame_entry() allocate and copy the second argument.
Let the function do it for them, reducing code duplication.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/blame.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cffc626540..f7aa95f4ba 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -658,8 +658,11 @@ static struct origin *find_rename(struct scoreboard *sb,
 /*
  * Append a new blame entry to a given output queue.
  */
-static void add_blame_entry(struct blame_entry ***queue, struct blame_entry *e)
+static void add_blame_entry(struct blame_entry ***queue,
+			    const struct blame_entry *src)
 {
+	struct blame_entry *e = xmalloc(sizeof(*e));
+	memcpy(e, src, sizeof(*e));
 	origin_incref(e->suspect);
 
 	e->next = **queue;
@@ -760,21 +763,15 @@ static void split_blame(struct blame_entry ***blamed,
 			struct blame_entry *split,
 			struct blame_entry *e)
 {
-	struct blame_entry *new_entry;
-
 	if (split[0].suspect && split[2].suspect) {
 		/* The first part (reuse storage for the existing entry e) */
 		dup_entry(unblamed, e, &split[0]);
 
 		/* The last part -- me */
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(unblamed, new_entry);
+		add_blame_entry(unblamed, &split[2]);
 
 		/* ... and the middle part -- parent */
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(blamed, new_entry);
+		add_blame_entry(blamed, &split[1]);
 	}
 	else if (!split[0].suspect && !split[2].suspect)
 		/*
@@ -785,18 +782,12 @@ static void split_blame(struct blame_entry ***blamed,
 	else if (split[0].suspect) {
 		/* me and then parent */
 		dup_entry(unblamed, e, &split[0]);
-
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
-		add_blame_entry(blamed, new_entry);
+		add_blame_entry(blamed, &split[1]);
 	}
 	else {
 		/* parent and then me */
 		dup_entry(blamed, e, &split[1]);
-
-		new_entry = xmalloc(sizeof(*new_entry));
-		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
-		add_blame_entry(unblamed, new_entry);
+		add_blame_entry(unblamed, &split[2]);
 	}
 }
 
-- 
2.12.0

