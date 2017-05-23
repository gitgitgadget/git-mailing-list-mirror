Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66EE12023D
	for <e@80x24.org>; Tue, 23 May 2017 02:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965598AbdEWCl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36106 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbdEWClG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so99600168pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJKm/fDoS+jgFlyL1vnQJeRSTycCjClwRg8tMdoDcy8=;
        b=I0wQZqRp5n9/ApD73GYSeH4bWKkioKTMKMSz36emmXMtQ981rSRVowHz4ihKffFGii
         N1U8JluV5OkDxEs56BQvT8oCzANDqFPzWHrBtoI8fceiO9Q4IwAoqebPHuCdr96+vdIp
         lsjKflFAvcaMs5WV//xDmdKo5pBRC6C4lUYNLFblUX8JkrIOakJTOjWShc9h3Qlr/POB
         jtoFt4Dqr/3HOjvYmW8e6eNOpIQ1f1ljZ9bHnGFRxfWeGqFjbnr+Vu4ny15Atp/qXjtz
         Mq9m5qTPUgM0fddIh543LHIptxRLuKPAR5+tYx/JbTPeQSU+BjrvRp+9LFaQSbndxreW
         L8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJKm/fDoS+jgFlyL1vnQJeRSTycCjClwRg8tMdoDcy8=;
        b=UdBo1dh3hNZT1kLIwVB6Dt8Uf2a9Z/1yOf6Jwv3i4IaQzq20aG/pt6a5U3UFvCw+s/
         hiCprIcBDjvRbBkh85x4oIn28WECjBGQr5HeCKc9ekLn4DzBRwpJuWhWQmy4OrDyj3sK
         z75aTZ8Xda9WTl5CfZG8UoXi5EnR0GwTXimlFhOFJg+9gXUkV+IY6LI1x91xR1d9poU4
         tViRcYnZ/AFou1MHnIxkNtazLMO1A9iPr8YRpbArk3LGRB9kdYSfxHeJsjwltlOrc61J
         /Ccawymwx4Q7GFwW+paxpLrD5YLlK559njYDQqmzKzse940vg6NKasQsyulYKAvbpwP1
         EhJg==
X-Gm-Message-State: AODbwcBlaMZeiCk4OUaObXdsqg+5rl5GBqyXg9CDvfDcQc7kaPrcph5d
        SMz21FdL+sn7Vv9L
X-Received: by 10.99.55.22 with SMTP id e22mr30080721pga.221.1495507265993;
        Mon, 22 May 2017 19:41:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id i63sm33018937pgc.26.2017.05.22.19.41.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 03/17] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Mon, 22 May 2017 19:40:34 -0700
Message-Id: <20170523024048.16879-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
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
2.13.0.18.g7d86cc8ba0

