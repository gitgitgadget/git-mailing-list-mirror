Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF0320188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758750AbdENDQX (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36695 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758302AbdENDQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id w138so14313514oiw.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GclSAiWuZ6CAAKBEtM4zDXcNJF6kRc5+rK0PB4SwHUw=;
        b=qjSlBwv/CWKhelHYJ6my/Ctegkes6AUOvd7NNRrN9haxosKFjNS5WQLQKygAlqJ3lt
         4hmDjD15U98PyxZh+3V66s92rPHcp5zznXL5cm0kPbPeOgAccJ6vYDB5hinmkQbv3m+m
         LWoogkGFWS8wTH+V7sQjMOwO9iBQarH6lngnMJBVWp9dFIh7slqROyZKvP3zr2CQpjTB
         kdP/llnKIn3tA04p84uJE0SfSdVO2skkjRER8+EdDMg0SGQUECYiuFvlSCj7+leF36jn
         BvO63YBa2sfM3SCMf9obrFlc5LAfQtbXhcNJ3awXKFAOwRd1CBpp/TIUQdYIRdI89pF+
         UPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GclSAiWuZ6CAAKBEtM4zDXcNJF6kRc5+rK0PB4SwHUw=;
        b=MTvQ/5ndVngYdqmeGJXWbbk6Zrv6DLaCzbLZ+sxdTQ4k6KmFhPeRhQCHBgKfg59qe7
         KF4tO/raI6b60jlfQrcaZUaObosV/L0GPNDCGgysCkuR1Y6q+8o2Ymq212XxU/0J+tjW
         ccOFBeWNhD4XuKucAgbnN+LyD/cWtSpdGdJg5/W4ogJCV7x+7dBCiQ4J4xcsQNzwIXsu
         526/R2dqNDePzWOi6ODqcW7XhrhZyuqpo1JlfNNGVWEdChVygA0nNmcSKAvy+8qQoJZx
         BTsUPX/boQ7rhp2PXEJ4fj1SG9Sxn4gTGegvWJKwzwyuq1jXw+79TOiy+RbXF0okRd4y
         PWew==
X-Gm-Message-State: AODbwcCTl/fx4FujQQUfLH2V+rBCY3p289rp9ZOKPLycxdoRuwxNrpRf
        qIqt9mtKttqclQ==
X-Received: by 10.202.73.23 with SMTP id w23mr4970214oia.103.1494731776531;
        Sat, 13 May 2017 20:16:16 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:15 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 08/22] blame: move contents_from to scoreboard
Date:   Sat, 13 May 2017 22:14:59 -0500
Message-Id: <20170514031513.9042-9-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argument from --contents is used in parts of blame that are being
moved to libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 3 +++
 builtin/blame.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/blame.h b/blame.h
index fde7d1d..388309d 100644
--- a/blame.h
+++ b/blame.h
@@ -125,6 +125,9 @@ struct blame_scoreboard {
 	 */
 	unsigned move_score;
 	unsigned copy_score;
+
+	/* use this file's contents as the final image */
+	const char *contents_from;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 949e179..032fd15 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2617,6 +2617,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.copy_score = BLAME_DEFAULT_COPY_SCORE;
 
 	sb.revs = &revs;
+	sb.contents_from = contents_from;
 	if (!reverse) {
 		final_commit_name = prepare_final(&sb);
 		sb.commits.compare = compare_commits_by_commit_date;
-- 
2.9.3

