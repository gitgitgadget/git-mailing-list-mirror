Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D94D2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbdEQC7O (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:14 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33345 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdEQC7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:08 -0400
Received: by mail-pg0-f53.google.com with SMTP id u187so85356066pgb.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cco31UO08DxSisfosGQrINbL67LOtImGVN2PZykgVZ0=;
        b=RXA9jj9PsDB49n3+cCJXco7ZYWIBDny5U5egA5Caiy1eK0q9MXxuLVVZorB4GDQ89G
         BlY7dpsrIn6oSuxhyYFdfTqbuajAaTNnmqnHHhO923E5DtrDar3PI44LyDf84Ga99Qw8
         NhM38Bak5w62DjWjHvjwIZ11ayswKKzaQm68gE9Wk+x72rPab6SbVkO9gbBUW5GpNeJE
         CrkOeSenbsfpUbEp1gp3nU+G5rqDpK+Ct8mNBlURdPVZyvby5Wik9SnWgliFSavr9q+u
         xcutzuAxrSI0Pq6Kls2g8RRN4eiVkbJpNBAJ0ZIqFlcO7muHn69djRPKHr19tdeqWAtP
         7F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cco31UO08DxSisfosGQrINbL67LOtImGVN2PZykgVZ0=;
        b=HVes+tUlGJbi+lNT/Vy/H5HLJrwb1oJZOjOXpkI/J1CEjhFFzIi8eqbcCC6zO1kt65
         GozRKDpe2T2YvGB7vLU5Z99uqxXxvO+wYB0uZAA8LerIoD9itNaGWzsmTNDQ+0thtN9u
         2ip1V64VFvgxWJeQRyhb6hkpX5XYJVleYr5xujRQg3RTkc5yUS0pXicPNwogIFk73PmY
         6GMQHa6rAaRDZlsf71qo41ZD0wrYqySUL0POS/nbwyKlMeY8ioemGYNNyawKuW7xXdEH
         t7LVUSxaJ3aBxBFAUq8U+6FHJCbF/NB2/V+B0KyC9Hpu/ECAgJO0zeE0pUJyq5q+nfjZ
         zG0w==
X-Gm-Message-State: AODbwcCOIEl5SDMq6KzKjO/N8NGwLJZ1ycahMYz9dH03fqum9gnlssOM
        cQss/QMEHmjwxtSL
X-Received: by 10.98.212.66 with SMTP id u2mr1298147pfl.73.1494989947538;
        Tue, 16 May 2017 19:59:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id t5sm640530pgo.48.2017.05.16.19.59.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 03/20] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Tue, 16 May 2017 19:58:40 -0700
Message-Id: <20170517025857.32320-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
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

