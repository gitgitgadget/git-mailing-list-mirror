Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3002035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034287AbcJ1S4L (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:11 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34417 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034208AbcJ1Sz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:59 -0400
Received: by mail-pf0-f181.google.com with SMTP id n85so41592572pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cYa2Vn8STPTvJjULHUAh2rH8rmMsgCY6oPrF2iP69aQ=;
        b=bGsOb5Tzayj5lgfqqXIK6o1+DpL3wFh248vpm7SUnQTqhEo4mOXwrVDMe+KCUUQnD5
         bJKZKLl+/mKRm2Gri92r5G6NPFWUsV40ksenPdTKZDaZwHF60lZDhB7HNRXml75VfQQj
         xJ/+wBVVYd0dGrr+6b0lo90h1zkzzaB3w1n2OILknBQoJZESU+XB1r2QQf3aTKNbntII
         jd/1iLF8e7WT5xKedNS5HUYcoB8ASKh3bAK1MpY+CqMJuOcCpWM+co0sKRFeDRYrz67T
         Es/rcjoAnfWPfoKB986JhqpPe43uLTm98GQl/e3R/qW1meNNU9Lzhjiq8VF5xN9QrxJp
         KkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cYa2Vn8STPTvJjULHUAh2rH8rmMsgCY6oPrF2iP69aQ=;
        b=DVvjftEmzcfs3sx5zs1ZKyqPFsYm7/SNdcOpihCBTYOsO7CfP+maI9HkXHPJ5Gefy4
         i2PkB/+Sqb2Fj++w5s7ERYl8x5v9LW7dqE6G6HYmXjrodmdvHDGUzCq+IRRiJwPfT6QY
         Sk9xLEna6oIro3aTAFyMtQ2pq+Hr80yeZuliRyiRNImVmaeaS8edHjO0afxJAXWSqJw+
         u1UB7Aqd5L3et6JXGCLRa5ypDSpTV5GYzOesJJoC65VKAuekPlRFzX037RP3rfIBJh4x
         QryWc2aVnRjQABJxSGuUQoc1urc+iuhHrqsHL3uvL6zU/3F6NQj89bQBPBgPnGCq5K9N
         OmUg==
X-Gm-Message-State: ABUngvfJFBeowlZbdHjHLxoAcbTosM4XQu0r5A7F8X/yIqDt3goU1mcaCBcvJutHU95r+J2i
X-Received: by 10.98.98.68 with SMTP id w65mr27321923pfb.121.1477680958079;
        Fri, 28 Oct 2016 11:55:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id h9sm6030856paw.18.2016.10.28.11.55.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 20/36] attr.c: pass struct git_attr_check down the callchain
Date:   Fri, 28 Oct 2016 11:54:46 -0700
Message-Id: <20161028185502.8789-21-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The callchain that starts from git_check_attrs() down to
collect_some_attrs() used to take an array of git_attr_check_elem
as their parameters.  Pass the enclosing git_attr_check instance
instead, so that they will have access to new fields we will add to
the data structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/attr.c b/attr.c
index 0a8ed5b582..47ab59c157 100644
--- a/attr.c
+++ b/attr.c
@@ -755,14 +755,25 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int pathlen, int num,
-			       struct git_attr_check_elem *check)
+static void collect_some_attrs(const char *path, int pathlen,
+			       struct git_attr_check *check)
 
 {
 	struct attr_stack *stk;
 	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
+	int num;
+	struct git_attr_check_elem *celem;
+
+	if (!check) {
+		/* Yuck - ugly git_all_attrs() hack! */
+		celem = NULL;
+		num = 0;
+	} else {
+		celem = check->check;
+		num = check->check_nr;
+	}
 
 	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
@@ -782,9 +793,9 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
 	if (num && !cannot_trust_maybe_real) {
 		rem = 0;
 		for (i = 0; i < num; i++) {
-			if (!check[i].attr->maybe_real) {
+			if (!celem[i].attr->maybe_real) {
 				struct git_attr_check_elem *c;
-				c = check_all_attr + check[i].attr->attr_nr;
+				c = check_all_attr + celem[i].attr->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
@@ -798,18 +809,19 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int pathlen, int num,
-			   struct git_attr_check_elem *check)
+static int git_check_attrs(const char *path, int pathlen,
+			   struct git_attr_check *check)
 {
 	int i;
+	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, num, check);
+	collect_some_attrs(path, pathlen, check);
 
-	for (i = 0; i < num; i++) {
-		const char *value = check_all_attr[check[i].attr->attr_nr].value;
+	for (i = 0; i < check->check_nr; i++) {
+		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		check[i].value = value;
+		celem[i].value = value;
 	}
 
 	return 0;
@@ -820,7 +832,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), 0, NULL);
+	collect_some_attrs(path, strlen(path), NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -849,7 +861,7 @@ int git_check_attr_counted(const char *path, int pathlen,
 			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check);
 }
 
 int git_check_attr(const char *path, struct git_attr_check *check)
-- 
2.10.1.714.ge3da0db

