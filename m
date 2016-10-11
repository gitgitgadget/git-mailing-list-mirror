Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B8220989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbcJKAWI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:08 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36500 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbcJKAV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:59 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so1650709pfk.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ns/gU03T5OqNRebmBT6MFFhMHa+qkDIbof4nE1z8K5g=;
        b=ZtriOfy6SEYcm84OrP8CHvcFtdUX5sBD1K9F9FFCF7Fgl4fxZCILovmIGKHm2Wcn8y
         x0IQY4VKePO4yYvXpMjFNExRGNP7V022JKdTlXAlRTpR5wQ7KEDv7rvtUmd3V6/mFWob
         NRT/1aN66bfyzP51C4g99kERU4BXruZyMz1Rz+5X8fm+Fz0vKimJ8Be51EarPmTIeYW9
         UoC8pmzaW2XF8ac2mFx1Z6J+tdl21IsjHI2gEyW53I4v41FembIW1oLacOj9eSnFfCJ7
         CiCA1BELoWyRzuyyqx9GTKPJJgd+TIrDxX007EHfMGcDEQD/J5ZEL8/SrwS2WfmxQ7MM
         U9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ns/gU03T5OqNRebmBT6MFFhMHa+qkDIbof4nE1z8K5g=;
        b=hAZoz66ZCiBNtg7IOQLMtNj8S9349yBVG55CfUlzxXtlIFV3KrPdassnIxlUPyHqpu
         73f+bkwmXXYtf+iFi9hW9hOkijRo8vE9I/gSFtYCZ56R4FS6nOMEkG//WFXGxiQToqLU
         OowGuhod5uNf5TACsc1p6c8uw6K0sb7x4q87w3/XzlWpB4FgvboklLOa/MZwHuz19UJW
         HwT87m1X84qkzocbcYMiMqtHriLeP0DTWHft7KUnWiuWEFOKsAopF2Mxm14qvvCBT+nd
         Pi3k0/tpzsRmp76O6ZOKTr5GZQwfEs5a2fFvozL1DqHHq4qiBMSt4V2h9qvbirph3UCF
         T+8A==
X-Gm-Message-State: AA6/9Rm3Bn/LQKvvnq+5gJjGJHmKtTnLjdhC9uPF6pnWkMuCxwYGhYteYHqAmnVKfj2BAlYm
X-Received: by 10.99.67.7 with SMTP id q7mr170827pga.74.1476145318492;
        Mon, 10 Oct 2016 17:21:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id y2sm515477pfk.54.2016.10.10.17.21.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 20/28] attr.c: pass struct git_attr_check down the callchain
Date:   Mon, 10 Oct 2016 17:21:07 -0700
Message-Id: <20161011002115.23312-21-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
index f9ebdd1..c1d5222 100644
--- a/attr.c
+++ b/attr.c
@@ -751,14 +751,25 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
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
@@ -778,9 +789,9 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
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
@@ -794,18 +805,19 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
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
@@ -816,7 +828,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), 0, NULL);
+	collect_some_attrs(path, strlen(path), NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -845,7 +857,7 @@ int git_check_attr_counted(const char *path, int pathlen,
 			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check);
 }
 
 int git_check_attr(const char *path, struct git_attr_check *check)
-- 
2.10.1.382.ga23ca1b.dirty

