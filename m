Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD972035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966259AbcJ1Szj (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:39 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35257 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbcJ1Szg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id s8so41507287pfj.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tSmWJamqq/20x0kGUYtDcWkTZ7kOfEkMuV1nRYyA+/s=;
        b=K76ce8AtJ2Mq15Ght73FxQ1WEzut8ZRJczT1EEDfAXbAv2bNBQOMJp/FTiRqQBSL9m
         MRLrOYew3O2X5hNQcDBcrC2bVB0pPfM4geZ88Pfi5rbp7KYxOI/rdyrUYAuWfo54hmdJ
         8WQE1eTNZE+u0V/niPVB2DwDA04MYjGVJm/QCD8r9DW1jRWcVovbVmdX7GL70Gy0dKQr
         VZ5K0Mz+CQ/WXq2wKA0iqqARDv/Bt9zU3OqC92dT6j0du0FWmn8Y3o77ooE2A0qL/Dbu
         qTqP7usEEoBoVReo5BtiU94OtYulImyfSDKF1oLtkc/elxZsNJvGH2kg7/Bz4GTlhtwH
         kh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSmWJamqq/20x0kGUYtDcWkTZ7kOfEkMuV1nRYyA+/s=;
        b=TRm4BNIcTK9nFqvPysjf9KLQkotO3IIi73TIPhH60rwsHBTGdEysPc0iPAHnFrqu2F
         1JQv1L7m36JRRShEMQJY0uEj4rhp+Hd3TsUGCk/AoJB/o5DDXdHn7gXzsRAQ+At2T427
         z7AvzoRP+nIkwkoJs1fkH2Q3PANcwVOxLvlfgL2JoS5ArbrGq66s4cj4CsdnjyPJESNB
         HZQ52t/iOASsqzkRAXcLZuXG6BGoTxRx8PDyyz81i0DeJSCL05r821pDcID0+3pnId3v
         nC0gU55/GCdY3br9Y2En8cuvU4pqfJCV/hHZLAOzG69aRyhe8Ahgaw0PaHT7dLoUPEhO
         uaWA==
X-Gm-Message-State: ABUngvcNxOAzL26Hpi7dFHypMwoHk5hoZ5B6reAEBm0WWTgiqYHiu7KzZEvV7Gmw8ET6lwsL
X-Received: by 10.98.149.149 with SMTP id c21mr27824948pfk.100.1477680935011;
        Fri, 28 Oct 2016 11:55:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id g27sm4768826pfj.46.2016.10.28.11.55.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 09/36] attr.c: plug small leak in parse_attr_line()
Date:   Fri, 28 Oct 2016 11:54:35 -0700
Message-Id: <20161028185502.8789-10-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If any error is noticed after the match_attr structure is allocated,
we shouldn't just return NULL from this function.

Add a fail_return label that frees the allocated structure and
returns NULL, and consistently jump there when we want to return
NULL after cleaning up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index f7cf7ae306..d180c7833e 100644
--- a/attr.c
+++ b/attr.c
@@ -223,7 +223,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		if (!macro_ok) {
 			fprintf(stderr, "%s not allowed: %s:%d\n",
 				name, src, lineno);
-			return NULL;
+			goto fail_return;
 		}
 		is_macro = 1;
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
@@ -233,7 +233,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 			fprintf(stderr,
 				"%.*s is not a valid attribute name: %s:%d\n",
 				namelen, name, src, lineno);
-			return NULL;
+			goto fail_return;
 		}
 	}
 	else
@@ -246,7 +246,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	for (cp = states, num_attr = 0; *cp; num_attr++) {
 		cp = parse_attr(src, lineno, cp, NULL);
 		if (!cp)
-			return NULL;
+			goto fail_return;
 	}
 
 	res = xcalloc(1,
@@ -267,7 +267,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
-			return NULL;
+			goto fail_return;
 		}
 	}
 	res->is_macro = is_macro;
@@ -283,6 +283,10 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	}
 
 	return res;
+
+fail_return:
+	free(res);
+	return NULL;
 }
 
 /*
-- 
2.10.1.714.ge3da0db

