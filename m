Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F3A2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbdFWB3f (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:35 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34011 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWB3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:33 -0400
Received: by mail-pg0-f42.google.com with SMTP id e187so15005144pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQXD0PsQLzTBjynnu++rY7gVjWLIcykHREKg/rM8mM0=;
        b=TFklPAhGq5mLamJCZUogVaNQctz57JF+W3uE7iskSlNLkbGJckFbWwEo7/VszEn1ev
         1ZJrX/4RzKmB4ir1n48A6TGUy/glLAUUQR3XKjzbh7JutMpft/zfkeCPE1DcIOP3R4jC
         pOu8ugPKvyMEw8PDxAyESfiLC/drGJBZ0kdI4zgjbzh2fAoDBF6uc1Vomaesdo0YFvDJ
         EKDaGTXPudTXGiXj52RLfAeB2F0XSKcYoSRD5hn/n8KXqslMH06d0cYr3IzLv3v1S0pJ
         UDXdKRZ37jzUMXFtZhmlGtVO/zsUsakVbTn0dXj+tdC6jEOvvgHoYMfiy/whQyKqaSw5
         1GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQXD0PsQLzTBjynnu++rY7gVjWLIcykHREKg/rM8mM0=;
        b=iqPFbQzvaFZdcAVMZKzJhtZ2Hz74OjIaP1hwXCFdCPpzXg5Wvj1TXt6CannJPqiiai
         FHoweQAV+qdtS75f9MLwQBNJFVaUrptFLOxQZTZXyIGTKs3nVJcnb5+NEGUsstzjVrKs
         x03JYSvW0mSeP8MttEcNXfo2KXqAV6a69ruLZ5BfaQjPgBZFAFcKTf+DZBfy/aTM4fQF
         fHBDcwHWrow5aOTwrKYcJI0FlcO7kDeq18LkpBLRYE1EUmlFoVOGI6cHRW3JzUM2Vxa9
         CTI78JVPTMCnDd808lrwKrjOvKpemvQelDsfY8EvISL9wpcC75pFfoCh9eX5f0ZLG8mW
         QEuQ==
X-Gm-Message-State: AKS2vOxvAwyvHCdPfRNT/J7J4Uy1N4ElyD+jI7GmYdu9mOU6iHf0qBBf
        Y/mrMSfX+P08U73j
X-Received: by 10.99.150.2 with SMTP id c2mr5454729pge.27.1498181372497;
        Thu, 22 Jun 2017 18:29:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id n74sm1140265pfh.118.2017.06.22.18.29.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 03/25] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Thu, 22 Jun 2017 18:28:57 -0700
Message-Id: <20170623012919.28693-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
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

