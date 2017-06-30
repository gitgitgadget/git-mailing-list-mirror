Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBA6201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbdF3Ux0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:26 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36478 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdF3UxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:24 -0400
Received: by mail-pf0-f176.google.com with SMTP id q86so72397891pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGcmNupeDJrKVnj7/r52Ck2IFtSOzfgdpBoKqmiwkyQ=;
        b=KGQMxp4gKa/lImfBo8fx0zwiu6NF/rpEIIHBFSM8uemQmgDlF7oEP/YQiIqwnjNHsw
         k3HUYE20C24kgJTtdLzWuolwHXyJr9AN0wjLy4Jt5UwYx2HirPnyo7G5X3Fw3f+Y2cBZ
         MnN56y6ZsU6Z2CUcPgqWIxaI7n/t6tTbjjKwZh2YdHc5A3CdjxXtngFYdIN0X2zIiVHe
         QiPeQ7T4riGm1nmtSyTaaU9QY5DkrKDI0thZVpxH7Ujl5x4BA9yGhLu2mSpOw+ATfl2k
         LZU+BaA22/3QGVdiwL5qooCr2Sshc/f0WYk2c8FFBI94mre9ZfCuIUqna2qaUSIJk5WV
         d07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGcmNupeDJrKVnj7/r52Ck2IFtSOzfgdpBoKqmiwkyQ=;
        b=Pc7JCMcpaz1/p5Prq0pg7SmpfXnb92JdSwCnKFN+15caIKVIPb1Ndq2JzRDGficSZi
         uzx15hWzYAa93lvXmbs93kxdIQLa/kre261eOBdBz6TbKU5+z3cL1Wg1EVod33ezhfCS
         BaKEbMvttj9eGCsAroj4fOolf/dhBBLinoVKxMfOKhu5ny+CvYHsjEhZQTiiNfbOGhG9
         6FyRIQimD+oc9X4ADG/rpYI6SSpGlfweJ5219AINSweNmqo9IrDS51XMdvVVrk7wujZr
         PiKsgpYhzspTYgx4zm09eFk5rRqjZ1Yx/mypBScAqCpUO4G+RT5c2WuJmyktVXnw7llf
         TU2g==
X-Gm-Message-State: AKS2vOzXcAv5nR6+UCEG+8i4jLjw+rtsjxCTvNKENIdvoMjoHMZlr1zZ
        ISI6kI4GEqQRWA8E
X-Received: by 10.98.209.22 with SMTP id z22mr18474324pfg.141.1498855998578;
        Fri, 30 Jun 2017 13:53:18 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id q14sm14231440pfj.26.2017.06.30.13.53.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 03/25] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Fri, 30 Jun 2017 13:52:48 -0700
Message-Id: <20170630205310.7380-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
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
index 94fdb57927..77ef56a6e4 100644
--- a/diff.c
+++ b/diff.c
@@ -4734,6 +4734,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
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
@@ -4826,11 +4837,7 @@ void diff_flush(struct diff_options *options)
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
2.13.0.31.g9b732c453e

