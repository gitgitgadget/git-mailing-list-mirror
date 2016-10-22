Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0CC020986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965064AbcJVXdW (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:22 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36037 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964952AbcJVXdL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:11 -0400
Received: by mail-it0-f45.google.com with SMTP id e187so74373574itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2nWMbb6BbLu1QwJJYuVgEDekWh4eu4Pz4pfoMz+ETo=;
        b=aeItGlu1amxW1rRNvt4L7xhNOeD8NJaw4lYk18Q6mi/+HFSA1xGAcrWMxmWlYufsrp
         IVXOKSic//6++ZLg59PIrDaY6uADPAY+2Kygsz95JMRn5U+CzVDFh/LIOVkKy0Vh5x/h
         90Cw4rVnW4Z50mXX0lQmGCWpWhLjdHxHf3o2bMz9+8Mv1s3oCZWq/pxcS66vQtN5TIP6
         F6LLW8YL2mEnfRpV6oCo7WAW8B+fjvzxN+mg9vR3ZmKxqvh0bfgxR8/v6WiVM9uhwDQu
         z7KX50++XO7Vws/ZLoZ5f7UTrPzvDmZt0czt/PN9yB1lJdgntF8Q6YzOdaYiI5x2gd/p
         kwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2nWMbb6BbLu1QwJJYuVgEDekWh4eu4Pz4pfoMz+ETo=;
        b=J9FZhwYJNgJvmCxtaJo7YM5ZmZiziLVnmxGf8EgU3zbU3FRaLYUDIFNY6XSA3C2HA7
         nedhqoJkISEwOYGkeGAkjmpmjWBE2W5krqQcuhSQkrghxfxazCs2+w72qLonp1AVj70l
         AzTg6tiQqEOnp/OGCP7rvASrCeWtqcf74UR7UkBl7FsszvdenH0o/TsGrz0nqiufpfX7
         Cabu9vx4wo1AIa8ywTTAivVDtc9Q5oUGDj5BemnSUH23syO+hoTe/r3DNoOvHdJqr72w
         Q3dB6Moh7lk4FlNwO08EM+NHTXhG5y2oOr8g+9VlmZrJYgz/PqDN2pXjJcCGVpnUTzZN
         n1OQ==
X-Gm-Message-State: ABUngvfIdxTcU8Xu4zaRUOT0tOuGCRiY5pzjm4de8Im17RZTuo9d4eDEHorinT+mwubkIau4
X-Received: by 10.36.10.196 with SMTP id 187mr7645699itw.93.1477179190411;
        Sat, 22 Oct 2016 16:33:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id m71sm1113608itg.1.2016.10.22.16.33.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 20/36] attr.c: pass struct git_attr_check down the callchain
Date:   Sat, 22 Oct 2016 16:32:09 -0700
Message-Id: <20161022233225.8883-21-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
index 34c297d..9ed4825 100644
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
2.10.1.508.g6572022

