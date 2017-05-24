Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0BE20281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969192AbdEXFR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34504 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969151AbdEXFQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id w10so31062690oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aTqXy0J4JHTcWRgKbI4kA9QiQAexjTemxcffYfb7Ju0=;
        b=PFKPRc/FGqEsA+maePK9Oa0AV/w7x+k+J5c51hnjGvirCTwVJjL8xFgME1ojdIRPHT
         8OgfPrW23RyyiGA4KbRsL9ow9bBkrWagVeYSkkc3PDzNoGPJ/DDZQBb1Xj4JJ3C3LntV
         fFVa7dmViswON2XfY5ibwPkGb5c51fUvHS9HXYUwSU19xT4ca3LgKtPR2bymglyaBkwm
         AaJP4CuO6gdEjJp2judgnpHZ7Xs1pPXat4d2ezPnsCQ6kCWPM1XSQMRjgPB1rvgMN1hq
         XWHG16vrt2bND91zM+RyDcyOGRsjTTVnWC0mKPEQXz0oUNza95/C2WmuM+Yp6XckPcLB
         bBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aTqXy0J4JHTcWRgKbI4kA9QiQAexjTemxcffYfb7Ju0=;
        b=KTZoJCmD1TdmXiikxl7yhViiJKvibWE1wslNddQNS9E/+0P1jLKYs4uhrh3sRD8SFn
         vfTmcC7U8Cm7tHH7KfDtxeOprq4JbK8jif/xj0hsByGvlzMp1EHEZl5dFZLJNtR0zGPv
         gXUjeBSzJntzn9bWvxZVDjFsbjfSS0ZTLeIFzTCtUN0d8KsQs/ixDt14ET90NFq7dV/K
         sP5VmnpAcFqM0bV2f9YoqviiU5mUmokuKZLRap5iD2Zi0gMcC9gcfsoUFdy9P7S4n7IR
         zE2RLG2XcZ3/5fsOoVAI1EC5dhvGXDVFEZpyAHWP26mLPO7TjHPgDhXs3vkJl4CmAIau
         DsTw==
X-Gm-Message-State: AODbwcASdCLkaFOAT7jBtyTkfJZzpbSnAz/6YWsbRIoywAlkAJNmxxf1
        ETmQZRxaTlE/vg==
X-Received: by 10.157.38.200 with SMTP id i8mr4319274otd.25.1495603001151;
        Tue, 23 May 2017 22:16:41 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:40 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 17/29] blame: make sanity_check use a callback in scoreboard
Date:   Wed, 24 May 2017 00:15:25 -0500
Message-Id: <20170524051537.29978-18-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow the interface user to decide how to handle a failed sanity check,
whether that be to output with the current state or to do nothing.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 90c643c..1b53325 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -387,6 +387,10 @@ struct blame_scoreboard {
 	int show_root;
 	int xdl_opts;
 	int no_whole_file_rename;
+	int debug;
+
+	/* callbacks */
+	void(*on_sanity_fail)(struct blame_scoreboard *, int);
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -412,7 +416,7 @@ static void blame_coalesce(struct blame_scoreboard *sb)
 		}
 	}
 
-	if (DEBUG) /* sanity */
+	if (sb->debug) /* sanity */
 		sanity_check_refcnt(sb);
 }
 
@@ -1809,7 +1813,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		}
 		blame_origin_decref(suspect);
 
-		if (DEBUG) /* sanity */
+		if (sb->debug) /* sanity */
 			sanity_check_refcnt(sb);
 	}
 
@@ -2148,12 +2152,16 @@ static void sanity_check_refcnt(struct blame_scoreboard *sb)
 			baa = 1;
 		}
 	}
-	if (baa) {
-		int opt = 0160;
-		find_alignment(sb, &opt);
-		output(sb, opt);
-		die("Baa %d!", baa);
-	}
+	if (baa)
+		sb->on_sanity_fail(sb, baa);
+}
+
+static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)
+{
+	int opt = OUTPUT_SHOW_SCORE | OUTPUT_SHOW_NUMBER | OUTPUT_SHOW_NAME;
+	find_alignment(sb, &opt);
+	output(sb, opt);
+	die("Baa %d!", baa);
 }
 
 static unsigned parse_score(const char *arg)
@@ -2888,6 +2896,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (blame_copy_score)
 		sb.copy_score = blame_copy_score;
 
+	sb.debug = DEBUG;
+	sb.on_sanity_fail = &sanity_check_on_fail;
+
 	sb.show_root = show_root;
 	sb.xdl_opts = xdl_opts;
 	sb.no_whole_file_rename = no_whole_file_rename;
-- 
2.9.3

