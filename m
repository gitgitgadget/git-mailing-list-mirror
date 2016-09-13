Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864E9207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbcIMEq3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:29 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33180 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbcIMEqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:24 -0400
Received: by mail-pa0-f41.google.com with SMTP id cm16so57856964pac.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5aNDe4cGOConukocfcLE0TT3ZEkb6Q2c/YgfEPpo1M=;
        b=FyuBZjbYp4q73xoFv+j31qhtAiduVS/gicoYmlkYVlLEK0oTKZQAIyGBrTgCEsAElu
         npVNikXxwP8hZz50O/lSkoNpIu0ZOlPvsBlFweeLyDWqU7I41Yx3I12f0Yn1mXWSfVjO
         xjObWH2jtlI93bqGG9ejyhBXAlvJ8ZZHt0CfeH8K2IVmRjJlebd48IxTERCCnmkg52tf
         bYEfTTXvSZgIe8ru48X1ww6e2ysX+UlOTGeHqN9d6XaT8ONxNhYXDcu2pyiBvtWNomgu
         wYlqKdoO4KgksCmJLnJwXXfUs8ZXPUj24XzY8+wn9KxozG3UymURD+OB95nAZodTLlgI
         86/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5aNDe4cGOConukocfcLE0TT3ZEkb6Q2c/YgfEPpo1M=;
        b=NWGvwX0CCTlggckEo6D74L4lAIhPzs1UE3HM2vIx3uGTpqt/dQnaDZTED6esiG9XEm
         fWu6023BRkYD9l5tW4aXJ0mt7qsy4mwSoB5MvFHX1qH9IUmspk91M4M8ieFRo5/MQpzF
         gL3mvsv/NPgl66Kh64XCBTSrxnwzgKj33i9IQrI+mWXR+IjSkzApE+XrfOllA5i575va
         kHb/smMQG+IAY9+W9hqRD/5pjus789tTL5pMTpqOK3X4OVZhfcSqx4kfOra62Ed2tyqI
         3+wYN0avnTwYFfmjVOLwph4YAryIbCRJgTvovLuvCkS9GErllIyY/DQcOQj/40FoIpf5
         TVoA==
X-Gm-Message-State: AE9vXwPWSeAYsLAw9ovNqbfT+uF+qt0zKw9FGx1lMJFwXwAvgcVSc21vZzz/N6hiIYyik13z
X-Received: by 10.66.11.167 with SMTP id r7mr36166068pab.136.1473741983888;
        Mon, 12 Sep 2016 21:46:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id p187sm27822021pfb.5.2016.09.12.21.46.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 04/17] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Mon, 12 Sep 2016 21:46:00 -0700
Message-Id: <20160913044613.1037-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to do more things before and after all filepairs
are flushed. So factor flushing out all file pairs into its own function
that the new code can be plugged in easily.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 9d2e704..b6a40ae 100644
--- a/diff.c
+++ b/diff.c
@@ -4608,6 +4608,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(rename_limit_advice, varname, needed);
 }
 
+static void diff_flush_patch_all_file_pairs(struct diff_options *o)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_patch(p, o);
+	}
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -4702,11 +4713,7 @@ void diff_flush(struct diff_options *options)
 			}
 		}
 
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_patch(p, options);
-		}
+		diff_flush_patch_all_file_pairs(options);
 	}
 
 	if (output_format & DIFF_FORMAT_CALLBACK)
-- 
2.10.0.21.g1da280f.dirty

