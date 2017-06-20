Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708F31FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdFTCsc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35305 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdFTCs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:29 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so2560047pfk.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQXD0PsQLzTBjynnu++rY7gVjWLIcykHREKg/rM8mM0=;
        b=N3MYF8GPxNXoMTdr7S9C6nT32N2+YOiCspCWjbkSVL+vqUISQRGlXcVOtGPD6lk1iD
         qPyUJq1QwbSU5pbLMuHTiGZu8LXs4A3u7ni/H7Ch6U+t8bKCxrFW7Pa0s8nNYHsZzELS
         1YpC63jAvJ6t4i+e2ED+imLaS8FFxpgFH6pSairtyOUIs0lJCqbIRgDfTv4BUQ008U4Q
         kzc47j8X64xvJGuy3OAU+kjjm5bHuR0XRb+XNsAT1jXgfiLyAE405tHMIVliz7AQ4o7o
         bYZZYMhuvCt+8qHyVL4uhyjEuoD7R/F1cwTzodN3DVbVazx2lV+oDbTzKao3/8Izxa1P
         5FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQXD0PsQLzTBjynnu++rY7gVjWLIcykHREKg/rM8mM0=;
        b=O1emoIRnZ580ZGu0wkpdIMmaegl0rjWqnGl7W8cKJ5ZHjb410giBtx82hdm+CvuZ9r
         qELE8LZ8WWClrqy8IjbPNmbdYx3sKUc2UEKugorHmdxGxrEuUDdUqsdiVUDbRkTpvORc
         4QLPzHsBPeRoSjqwjTw72dR1RrxMzx3oKbaFFSvhmrviGGS9MydWvAP0EsZU/BFsKw8a
         8wiD8cYTvjaSVhDJxr9IjbpYk0wA1EOGZOLFXFO0hELZoF9NODAohS72DfbU1IA7HVwi
         k5HpZK56pIhZqrJHIKuStJFbCrqfoBBbIu/7bV7hZJEn7pGpijHuAfNNkLOOjPeFqmzj
         wL5w==
X-Gm-Message-State: AKS2vOw35BTfPrmpoyaDJeO1rbBkbk24eMHCb5/PYxtT+3vpXP96meUP
        PKlhcy6QPc9cuS8A1yQwmA==
X-Received: by 10.84.228.194 with SMTP id y2mr7076182pli.102.1497926908925;
        Mon, 19 Jun 2017 19:48:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id r5sm23195592pfe.94.2017.06.19.19.48.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 03/26] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Mon, 19 Jun 2017 19:47:53 -0700
Message-Id: <20170620024816.20021-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to do more things before and after all filepairs
are flushed. So factor flushing out all file pairs into its own function
that the new code can be plugged in easily.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index c2ed605cd0..2f9722b382 100644
--- a/diff.c
+++ b/diff.c
@@ -4737,6 +4737,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(_(rename_limit_advice), varname, needed);
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
@@ -4831,11 +4842,7 @@ void diff_flush(struct diff_options *options)
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
2.12.2.575.gb14f27f917

