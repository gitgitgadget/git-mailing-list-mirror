Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4E520985
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbcIKFml (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34456 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbcIKFmi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id g202so6283121pfb.1
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPbq/3iDxqR+jW8q5n1r5IKebmgRCKDcinM1LX8ROsU=;
        b=ZHc8d8CvJDMtfQ7/PxGVWWYusk1Q54QCvi6Ym9hdiW9Q/PVbtOgM3UHBehDlC4dQVa
         2qZHVmObJtR5l+eI6fd5drbhm3gcezwSXLqNRCjWAWR6Kx5bJ7Y/slEdxzeAs8zvU9I5
         KbRimjwqkwhV8k/Cp/xdGiWK9LGqXD0JG2FcTVLQGH1UPCzrkwnJ93U95J2lOOZlZVWc
         52HS5havFVGjBa1XqB6A33A4EM3gJDr97B+BTLhcw2nGkKRZU2kjFPB7hVSrZZwcduAg
         L931jKS09iUhBl9cBITl7i4/oVcVb/hZYEOuJUF5kMMcgWnJ8opDb/rMeQKAGClstq0F
         PA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPbq/3iDxqR+jW8q5n1r5IKebmgRCKDcinM1LX8ROsU=;
        b=gdsAzROeCopaDRVSP0QiKNT0DPkH2xYvPKiFru9KTkudkBiSunShuG4RL6EOPCfnIm
         Q6UCiYdepFnILqhaAV1xdGFimHAveNG5NOcKDNtmbQBJHlZgiWzKanw9Q/cYE1D7Kz9d
         d3jSUJ9eK8H6XLw4iur073zaUiBD1GKOMVNvjKup9sadtOzkl3G3yg+sLfTWQmsZujng
         0pSSQFr7N5Spyr93YC+ZnTQ7j8SgNwiBlACV7PukN0MCCn8PhYCkwn48n0rR9doFOvPP
         sL8Oz/E7AOoSm3Myh0oQmiIczgWxAKihlTTtFV2+i4OHvzajKDaCLYMnXZ0v2NRxNVBw
         qpew==
X-Gm-Message-State: AE9vXwO+g9xl3Fm4KgLOwrGudJRinlyBTW5TiVZ0HT3ehUJeS4D7soXjvIIDP8l6EkeC/g==
X-Received: by 10.98.99.67 with SMTP id x64mr21798481pfb.26.1473572557594;
        Sat, 10 Sep 2016 22:42:37 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id v29sm15451876pfd.65.2016.09.10.22.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:37 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/10] diff.c: reintroduce diff_flush_patch for all files
Date:   Sat, 10 Sep 2016 22:42:05 -0700
Message-Id: <1473572530-25764-6-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

---
 diff.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 85fb887..87b1bb2 100644
--- a/diff.c
+++ b/diff.c
@@ -4608,6 +4608,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(rename_limit_advice, varname, needed);
 }
 
+static void diff_flush_patch(struct diff_options *o)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_patch_filepair(p, o);
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
-				diff_flush_patch_filepair(p, options);
-		}
+		diff_flush_patch(options);
 	}
 
 	if (output_format & DIFF_FORMAT_CALLBACK)
-- 
2.7.4

