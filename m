Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB9E20209
	for <e@80x24.org>; Wed, 24 May 2017 21:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164145AbdEXVkx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:40:53 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33533 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163618AbdEXVku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:50 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so147530166pfh.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJKm/fDoS+jgFlyL1vnQJeRSTycCjClwRg8tMdoDcy8=;
        b=qSliJH+1DTXBGxaePqmVVOaautT95/BxNqxtOh0tKjSF9OGeOC85aE9vhzGwAJV59h
         wQknOIEpAJ1vpS6GuRLpfnFWiCYDkrLE7ZPSaxEV4jzcPUpEcz1w8xfE2vVzY3XasLJB
         q1LOm08WriW6iXepUbnJ8fYGo4Yo5jmUhozXdnh3ALc2GTEDfbjOVN6FvNh+cJQ8nckW
         Sff01U2FczErPM0zzJJk3io8AVsZI7HBtQZ+i1cRJ+yh5vCF80jWvZ35D1dFVujoFqB8
         548+mhdDhSBGnPTHXdvFwQ+czxDMk52Cc4AtLSzbHdkRPPpi6MDA52UzXCCQ8HATAjQ0
         0CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJKm/fDoS+jgFlyL1vnQJeRSTycCjClwRg8tMdoDcy8=;
        b=JWSNFiOTCP9GXky57sNssAP8ezPur6LkHjrSvuF4SAnAxop0+pbSURJL6MJfUK88qd
         Km6sm7CWWWWVtVLkt4Yjec1qSYo+9fufTxIGXcGS4XHDFGz9noK43eAj19Ma+OMxPAkl
         7LZ0HP4i6R7p07WTk2F7mUkYRAxU0js459Onbqi4shoX4mt5l6jm3ma5efkcWzMJ1yBz
         ST7c3hThFaWYIMqMZiSwZUPRe4WJlj8ki3uPd6sdAL3Q5laU2ypYPK5AluG2CJsASejP
         +3FbY3wyywJt/C/DZ/K/dZSskUDBVpVt2BMV9LfpAnoJSb8lIo657mONHhBLM/Bqcdyi
         y4nQ==
X-Gm-Message-State: AODbwcC83nEpxQEdBoV8bY4whYSSHvGblkdMvQxFVJfDYWxYXOgshemJ
        2wW8Way3jPWStYSe
X-Received: by 10.84.233.200 with SMTP id m8mr45217049pln.118.1495662045168;
        Wed, 24 May 2017 14:40:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id e76sm8448064pfh.121.2017.05.24.14.40.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 03/17] diff.c: factor out diff_flush_patch_all_file_pairs
Date:   Wed, 24 May 2017 14:40:22 -0700
Message-Id: <20170524214036.29623-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
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

