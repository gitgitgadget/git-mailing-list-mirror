Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E276A201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757672AbdERTiD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:03 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33325 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757500AbdERTh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:37:59 -0400
Received: by mail-pf0-f169.google.com with SMTP id e193so28546134pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cco31UO08DxSisfosGQrINbL67LOtImGVN2PZykgVZ0=;
        b=wNHhbfjrpH3j7z+OO0AzpZSyhcJvOCUWezWwlaU/sFZiN6OH2wBi4I/FH/wjIiSkuI
         ZVgxD9j+793lHA2b1hNl2IWn9/81dGAcykD0MuS4dkHTtp6faIWeCexWnEeU0WQ2mo5i
         h0gutVdEocmUpTOwEnyiYdXRCTIwc7PQKs1nq4GHPcbX/l7WIkOfbjYJ9QWEdewKwL/G
         ugCWzGEkIonoTrUhorllUFENy87zgvHlbp6XOmhpZBjTJDYPXWOpdUJGMZiOzcupzvnC
         wIOwASf+mcHd/IreDyllSNUonqEA4LQ22ZlXC3HuGipyWEUlWZtML3+0RZ++U+pLG8je
         Yn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cco31UO08DxSisfosGQrINbL67LOtImGVN2PZykgVZ0=;
        b=r9JAeyOeAkaWGPWNcX1MyR3Q1vy7x33NUxuR31ozlQ9+gRny2kTRwPs5CM7kj3Bd2F
         Z179/AZVtIBUfbF7g5uYvcHme4VpbbmXF9icblqv+nC7tuRAgfQKDSzm99/scOLVgNu4
         itTZngyBt24t0+7Egbo6ZOAPfGG5KrEZTZ/VVyMQRz1+iyVyktIx+0QwN6siSPJUvLQn
         116+VwAeZ7ptfBaXrUm3CIfGpq1iJRf2rZj3m377LNj2XNs/Mp8nIJnOVePzc590zXym
         m/03xTJRxF9DSR696YhNFy3KniIn7U4TMTTTrjuTls8TDVfMbvuQtBQ1VYZkCf1B7GY5
         YlOA==
X-Gm-Message-State: AODbwcDXtSgrjiwtijQ1EoP+WvpNjoLDlgPgxB+35mXBQks3+qIZguUa
        AYjcZxM1LT+YRbcn
X-Received: by 10.99.115.73 with SMTP id d9mr886002pgn.5.1495136278680;
        Thu, 18 May 2017 12:37:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id d1sm9842230pfa.56.2017.05.18.12.37.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:37:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 03/20] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Thu, 18 May 2017 12:37:29 -0700
Message-Id: <20170518193746.486-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
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
2.13.0.18.g7d86cc8ba0

