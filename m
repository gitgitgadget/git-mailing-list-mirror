Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6DB20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbdAWUf4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:56 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34119 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdAWUfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:51 -0500
Received: by mail-pg0-f45.google.com with SMTP id 14so47683141pgg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+45k8H2jJuWldxUOQadee5jc/jqPN+P6kbHVofHOEY=;
        b=CdfMGH6wlmTJmUAn+WRNo8RfEb6VNX9JWaFRV95lfuXNzpYjNwR7zbUCx4QEWOKGBA
         Z9RU3L/v5OT6X1OEYd5DrkvLSDyfCMVZXJdCBfqdwVfhKio0Q14AmI9vQa6t+D6Eve9z
         sk4JfcxMxIg7yIU2DqRZ4h7aJx5SFM48r1JgJ58h810thBXv4PJap7LrW7y9KIRHFGuU
         +FT0vlyZDSwDtLD6g9aaJWfeYj+ubLonYcN55k+qpSpWkYbDWmvnB7sKgxK9TTnr/Cbw
         /AbtuPtXn3ov0rLOa7D/15pjZ+xDjtNSahj7ctGBMGri1PmZso1Q1e1JFPXQoH6pxAck
         Xw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+45k8H2jJuWldxUOQadee5jc/jqPN+P6kbHVofHOEY=;
        b=W078VGngzVV0jh5yJzIQR6U59OcjMvEamxIm1Z+xvv5MzEZewINQAQkB8msPxE3JMI
         pT/S03kMuNti+DF3askpvDaHmXaniUnlIITYZcHiOTI+45TngMEqdrEces0uNnawK+9f
         rGGZoBq0mehNCvW4rXYMaN+0bsgG7vXfoxIfMnwDvZCBwNf80ZeMzasGf2YhQfC8s3h0
         +5WF4HBpzg4PFBEbg42XTPjw1IhKdQ4LXI989xrHwmhNGmQFMCk7fZI491L8fwFjQR/5
         HJDM5WPIj0P/Cu0OPST7kXKB+O0rWWrdoDKNP8wN/0TkhtAZ49c+8EguXzOa5CnbZTxz
         MzBQ==
X-Gm-Message-State: AIkVDXK5iZujYzUtvudKJ9X+8SZTqGOoEaC1FSf8JCwzuS33mn2t5++1vA+c+Be3Cb7eVAZm
X-Received: by 10.98.131.136 with SMTP id h130mr34663226pfe.4.1485203750562;
        Mon, 23 Jan 2017 12:35:50 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:49 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 09/27] attr.c: plug small leak in parse_attr_line()
Date:   Mon, 23 Jan 2017 12:35:07 -0800
Message-Id: <20170123203525.185058-10-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index f7cf7ae30..d180c7833 100644
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
2.11.0.483.g087da7b7c-goog

