Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960E820188
	for <e@80x24.org>; Sun, 14 May 2017 03:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758788AbdENDQ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36712 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758734AbdENDQX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id w138so14313677oiw.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxrh3z+3gW57mfBimK/JaPCOwUWpEpoNs41H/LsWvEg=;
        b=OwtbXlaTOf5HXd0g+6FwtyJdcqvmooJkyBymsfL+Th6yTkX7Rj1hEfJCv0jaUdxUpl
         2e+zqnrpQocCkPXDgNKY5ue1GpmbdhX2TsL/53ZjGsWSYY1vem+YIBjT5KsN7fmlWhOK
         bc5YwGmgTAk9vEQjscybdTWoDbYBiwiYvHBuH8HAyOnREZTN3j3XlpNrZvTxFMRPy0nb
         5Hg3oTId2X+5ULSmQASgf+Vi6SSfiT+YGIcwjf+M7keXYSdQ/6+kAGVjaj2QbOQXgATr
         yZpBqUEJJwtMo80Egaf+GhQ+SV60vwOVzUIyG3LQx09fQmpOjAqRt/YfAZlD4hXSRsVy
         dolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gxrh3z+3gW57mfBimK/JaPCOwUWpEpoNs41H/LsWvEg=;
        b=BrrXbAt+JyTSB3EduS+QOJ6WEy7GtQPrPMwc90WklhchNM+c8nyHGgxwVCmboS1xg3
         DEAxCptwjfTqA5a7vFq2eykqb0aE7zLbNpkXLzTqg0w9vylZm1WvSINx50/SyLN8R+s4
         MWXnGxwFbQjhb9CTc9mfiLTVVCLs5wq80nqSm9mSmQ7cIwyIfQj7wNWvkYAwtenSAdQ3
         fuTxUtGxB47+xfyO4RhwbrJmb4DrrV1MUqMUc8WH+nMeWbttGpEQv0bU48GaqBJ3bVWJ
         Zmt+Yp8YTRYr+KzDi0iQtfHJ+syGEhZA3cb0vDiIR02L1vAB2zV1lnivdARzJg4Fq2pJ
         k9zA==
X-Gm-Message-State: AODbwcA6tBHNSohgH0HH41saRvqcDPfQhs2rayrvnO0DWPk7tqgZ/vL2
        5lbeX7mxqpRfSQ==
X-Received: by 10.202.230.10 with SMTP id d10mr4617558oih.99.1494731782498;
        Sat, 13 May 2017 20:16:22 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:21 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 13/22] blame: make sanity_check use a callback in scoreboard
Date:   Sat, 13 May 2017 22:15:04 -0500
Message-Id: <20170514031513.9042-14-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow the interface user to decide how to handle a failed sanity check,
whether that be to output with the current state or to do nothing.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         |  4 ++++
 builtin/blame.c | 23 +++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/blame.h b/blame.h
index c140f41..e85db06 100644
--- a/blame.h
+++ b/blame.h
@@ -134,6 +134,10 @@ struct blame_scoreboard {
 	int show_root;
 	int xdl_opts;
 	int no_whole_file_rename;
+	int debug;
+
+	/* callbacks */
+	void(*on_sanity_fail)(struct blame_scoreboard *, int);
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index bd295eb..d7b3b5a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -285,7 +285,7 @@ static void coalesce(struct blame_scoreboard *sb)
 		}
 	}
 
-	if (DEBUG) /* sanity */
+	if (sb->debug) /* sanity */
 		sanity_check_refcnt(sb);
 }
 
@@ -1682,7 +1682,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 		}
 		origin_decref(suspect);
 
-		if (DEBUG) /* sanity */
+		if (sb->debug) /* sanity */
 			sanity_check_refcnt(sb);
 	}
 
@@ -2021,12 +2021,16 @@ static void sanity_check_refcnt(struct blame_scoreboard *sb)
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
@@ -2761,6 +2765,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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

