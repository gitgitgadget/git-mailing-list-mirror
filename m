Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FE42035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755586AbcJ1S4H (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:07 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34430 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935899AbcJ1S4C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id n85so41593190pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39AmjKbazB7wnd+/H0uNpBimmoGHh/FlpfAVwZSTM7c=;
        b=UYyhCyKN7IrKFa0Y0Crtk6fH9M2V4DTlcMUHY+blH+g6s9iC49FbTpTNRSFwrBJydw
         9wEwpyY5JziPpOl4kejf6gQbPNqLHh1dCRK2iBYF8d/g8sLAGistRLQaQKnIbPyS58RV
         QQ3esgt2yJreWA2iv2l5sKVDyQAcjLVgSLzjMn08+lD9sS4odshD5M9+2b8Nwm9WzCGc
         aTtyVVLNw77Yq1BSFGnY6PMoDbvzhNe6sYS7Y7o7Q73YlJwZaQ7ObGNouKhzgpOxoviU
         6nEGEn2w3xS4pcmRCfXxRHg/UgwlGGuLvs2Lls1kJ4XY1CIfj3qJq57DcYlGiiXUBY7/
         9PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39AmjKbazB7wnd+/H0uNpBimmoGHh/FlpfAVwZSTM7c=;
        b=Boa8blv6c3vC0P3doMbBY3Yat52A9cA6d1DVuNDVUguhXs6b3wipy2ntDVgZMEyxoR
         iob+spM7JTqlYN38II9SMV1k37v11MtZwN/psIILq1jmve7USpojwVOl2Kkvmx9Pxo7c
         xzSwI3bp97GaZoAtk9Mj+wwTesvT/c5FBaSIvarx3kGgAVN6uqIsGEp+UvY1bI53IraO
         Gpzm0aq7oJ+KDJt9GdLHAcAkHT+3X8W1XmexaEoJQYDRUsBrTVISe3Zu5VDlGsnrpxp6
         7lR6ID2P7b7WRv6RCQKNDC82M7ickUKr5jZyQZzcjoNy4skh2fD+j2Q31TZrjhj67P+p
         J2FA==
X-Gm-Message-State: ABUngvfhICedUhnGKKQ15VrvoGZ9ztABYwEBchWE4znaQG5EBP/Sx+YuX9ZUts6uDm/Ue2lw
X-Received: by 10.98.135.13 with SMTP id i13mr500601pfe.138.1477680961650;
        Fri, 28 Oct 2016 11:56:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id 128sm20602527pfy.4.2016.10.28.11.56.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 22/36] attr.c: correct ugly hack for git_all_attrs()
Date:   Fri, 28 Oct 2016 11:54:48 -0700
Message-Id: <20161028185502.8789-23-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
---
 attr.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index c85685da29..94476de3d2 100644
--- a/attr.c
+++ b/attr.c
@@ -752,8 +752,8 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr. If num is non-zero, only attributes in check[] are
- * collected. Otherwise all attributes are collected.
+ * check_all_attr.  If check is not NULL, only attributes in
+ * check[] are collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int pathlen,
 			       struct git_attr_check *check)
@@ -763,17 +763,6 @@ static void collect_some_attrs(const char *path, int pathlen,
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
@@ -790,9 +779,12 @@ static void collect_some_attrs(const char *path, int pathlen,
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
@@ -800,7 +792,7 @@ static void collect_some_attrs(const char *path, int pathlen,
 				rem++;
 			}
 		}
-		if (rem == num)
+		if (rem == check->check_nr)
 			return;
 	}
 
-- 
2.10.1.714.ge3da0db

