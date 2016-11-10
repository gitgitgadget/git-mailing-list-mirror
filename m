Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32DB20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966143AbcKJUfy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:54 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35857 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965497AbcKJUfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:09 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so152172400pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K9Bx30jkCDJZ8kx3CG7Jyyoy9gNogXIMhqgP0ysWTXU=;
        b=AxvSnjWkWiXGkOa+rQB3mY5l9YLWnb9bnSTEsoRWBAyfsAbCYfUHxhVP6qc6PjYWoE
         Ykk6KoD9Db2V9eyK0uT+AKyXSdsaOirL/vWtUfcZk9xHhZdCbTwgXukYCqp31FW/M6Na
         WPEKlPdGlveOyHuIVfQvv7BaEd+OBxWZ+BaZeZqvp3rf0IYM+5PIKq6rSTH8UpRBHUki
         wvvdMqHxzjVJIw4m4AzabkN23YnmM0TkoA4OzW46VZ8Q85fZQY5CP/zFDOI71kmaV9L/
         xnZoDQM7Z0Krbpw6zzR9KWfaxEe3Cf1LciyyJgnZIPfx2Iiy+7BwRhhOE348X110H2Uf
         xHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K9Bx30jkCDJZ8kx3CG7Jyyoy9gNogXIMhqgP0ysWTXU=;
        b=Y64KEaUiwAVLZbZajRz9NmbVeqvQwSSLG7eIxpQ8NbTTVqM1uqhfJmXWar3pfItcVx
         Myl9Y9Z+wG00IGjrpU9t8xD4vkYdpTa3v78gMRxvjl18L+skBWKsIHP28g4jZgSHNprd
         UpEpz4sr/EpCgn0/JOk1Ro6B1bF6Yg6mGRTcHfoW7StO84zJ0IygSXCsg0ua5KBR7ViF
         Jva87/0dD7fvIfM+WZ4wRIb6j3vUCmTTM7s/EC1mmqDKfh8njymu8wx+awhvI6P9mBIF
         Ip7moD/rhS0DDUP7BKTUSYPTjPzt/frLF94cPn2GjSoLza0BE3UzAZSujBk6aZM+Attu
         vifA==
X-Gm-Message-State: ABUngvdiegFvjTJYN+ujul925M0xAevJ4DqsJGkPxh0BSLHjjC/NN1tL2/kNxwe1ieJb0xD6
X-Received: by 10.98.141.74 with SMTP id z71mr13332186pfd.53.1478810103321;
        Thu, 10 Nov 2016 12:35:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id c8sm9345960pfe.15.2016.11.10.12.35.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 21/35] attr.c: correct ugly hack for git_all_attrs()
Date:   Thu, 10 Nov 2016 12:34:14 -0800
Message-Id: <20161110203428.30512-22-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The collect_some_attrs() function has an ugly hack since

06a604e6 (attr: avoid heavy work when we know the specified attr is
not defined, 2014-12-28) added an optimization that relies on the
fact that the caller knows what attributes it is interested in, so
that we can leave once we know the final answer for all the
attributes the caller asked.

git_all_attrs() that asks "what attributes are on this path?"
however does not know what attributes it is interested in, other
than the vague "we are interested in all of them", which is not a
very useful thing to say.  As a way to disable this optimization
for this caller, the said commit added a code to skip it when
the caller passes a NULL for the check structure.

However, it skipped the optimization not when check is NULL, but
when the number of attributes being checked is 0, which is
unnecessarily pessimistic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index e18098c..48460d2 100644
--- a/attr.c
+++ b/attr.c
@@ -748,8 +748,8 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr. If num is non-zero, only attributes in check[] are
- * collected. Otherwise all attributes are collected.
+ * check_all_attr.  If check is not NULL, only attributes in
+ * check[] are collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int pathlen,
 			       struct git_attr_check *check)
@@ -759,17 +759,6 @@ static void collect_some_attrs(const char *path, int pathlen,
 	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
-	int num;
-	struct git_attr_check_elem *celem;
-
-	if (!check) {
-		/* Yuck - ugly git_all_attrs() hack! */
-		celem = NULL;
-		num = 0;
-	} else {
-		celem = check->check;
-		num = check->check_nr;
-	}
 
 	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
@@ -786,9 +775,12 @@ static void collect_some_attrs(const char *path, int pathlen,
 	prepare_attr_stack(path, dirlen);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
-	if (num && !cannot_trust_maybe_real) {
+
+	if (check && !cannot_trust_maybe_real) {
+		struct git_attr_check_elem *celem = check->check;
+
 		rem = 0;
-		for (i = 0; i < num; i++) {
+		for (i = 0; i < check->check_nr; i++) {
 			if (!celem[i].attr->maybe_real) {
 				struct git_attr_check_elem *c;
 				c = check_all_attr + celem[i].attr->attr_nr;
@@ -796,7 +788,7 @@ static void collect_some_attrs(const char *path, int pathlen,
 				rem++;
 			}
 		}
-		if (rem == num)
+		if (rem == check->check_nr)
 			return;
 	}
 
-- 
2.10.1.469.g00a8914

