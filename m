Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C000F20188
	for <e@80x24.org>; Sun, 14 May 2017 04:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdENEBg (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:36 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34959 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdENEBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:32 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so42314772pfb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Plouo8Q3oPX7G1El4q1o7lBFr61uOEAMzuWEgJNfMpk=;
        b=r3vPaemr2gLAFeeoF7/mnCq8n5yGwxqY/5H2knVLvnJxD284h5C+/jiCacOvPDwLc2
         2NhsicjHu8wJSUN5sDZdhXIZ2yHYnu8eMsizJwutsxS2b+AUR+gwasIb6INH4G0l3ler
         AXdrHZfutWsSsgL6gxDt2hlpFcIc669PGwd+N0/fqR1tL1DoBnB7TVJ+SJvj02syftm4
         txXFXjESjHhU7RAvVtZgDfc+W4t4TlK+nn3Z3JK5BqSL1Kn3qhSBhoxV4Mta3e+M5LJG
         Z3xK8yY6qL9z3924zWP6hvp0n+A68aYCECsyIPZZ8KDkuXzEOEoDBYBwc40zPE+v9P82
         vDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Plouo8Q3oPX7G1El4q1o7lBFr61uOEAMzuWEgJNfMpk=;
        b=kM4EklsXoSkTsCnpGEaObwGuVckB+dJpWODI/mPgaQImXuYjP/6swXwb+uWSVS957R
         SK7U7orbBZPwXqSfVt8x4MnXXsYeupnJNFbHkS2R+XwtqrmeTWDdMhF9sFdfpcZC3X2K
         y7Q7jH17GHvgQ1amYbXCDGZQj5iAAeD/pbs5OZbvIbLm5aZZ4AP4vQCjNkEYqDUef+Zn
         wcORYfvDPsQXyES5lGv86jV4dm475P7pRTkTiSMZJ127lLK93k0TpHEyRaMfGf3JbFY+
         GktcE1fnyM7oIfMCJEitttbBLw2aiNnfTr3sSEhUjEc956mO+ITY6/lIFh3E2GiW7O1F
         LM1g==
X-Gm-Message-State: AODbwcBg2lbf9nW0JAlT+6ICK7BKQxYD9gC7fIPJDP8eef4MW9llNbP3
        3s1sclIq+T/JoLSp
X-Received: by 10.99.173.12 with SMTP id g12mr11605757pgf.225.1494734491307;
        Sat, 13 May 2017 21:01:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id p10sm12571093pgf.63.2017.05.13.21.01.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/19] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Sat, 13 May 2017 21:01:02 -0700
Message-Id: <20170514040117.25865-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
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
index 4269b8dccf..381b572d76 100644
--- a/diff.c
+++ b/diff.c
@@ -4728,6 +4728,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
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
@@ -4825,11 +4836,7 @@ void diff_flush(struct diff_options *options)
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
2.13.0.18.g183880de0a

