Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9380A20986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965122AbcJVXdq (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:46 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38153 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbcJVXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:19 -0400
Received: by mail-it0-f41.google.com with SMTP id 66so74096273itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GORJYD8ovWkA5zeFwhMFdAh8F2q1dIu51n9XYngYu4I=;
        b=pAhPouQUspemB3KSINdQWrRqnTyS825bvzO5FYjqn81ROs/joZ5N4+gTve1fbuCSIo
         vX1JsYJ2ZkE5r45Z0zq33U7EJ587lcRhuYF/4+Ea5mu0f3jcBo5OD9q+5LB4tDb/4nvV
         yw9lSuyff+SKAECQyBBk2SDI7I0RRPJwQCVLucZVko9UkntK7D2EXi63+PwvlmD9gLKo
         YVAy40DCgj69dbHOly9v7exZ3sy3X3dRVtz6V2OIExj8tdeToN53LXyZmB8rZfogqc88
         Ju7P6wOWRvBnpE3uioP7Gd0+w++LJBiK0dcTOR0ju9UF5a6yg8G+XRTiX4MCYDKhtoef
         axYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GORJYD8ovWkA5zeFwhMFdAh8F2q1dIu51n9XYngYu4I=;
        b=j8o5Ttjxmpuuv3aXUHuKS+ydR8WRM9FS/ndskmCdMMDtQPsyYfrOQ1+5zbjMgNpJ9q
         33mD+FCo2V6wZfSqHWa393fUBNcy1FFxujBCw/2H2GayWdlY/7alCVgPrOO8Wp20ZnLt
         Ch7VS/Ee7FNUmf+x2jPxbwYcKmPBYfIutLU2eJFZAdCmQDw5V1H0eD3YLgF4YmAnydSX
         sBhdy/fPSAp1ARonspV4mAwiGnIVt1bVzGHA1i8GikA/M3d84ylDALunztZxxaFEIDao
         hT/9Xy02H3BGz9fdLrJnS5zozXMkJ4/am6a8FqLkUZI8YI4p20UZ8qisgRK1+vYDN/Mw
         y89g==
X-Gm-Message-State: ABUngvfvTcWlmBen/6K2MJKE41d4C2y/0Qi7JdDmpRRXCzl35DXWGaJ9cBB3wf8eDF6bnzlE
X-Received: by 10.107.166.16 with SMTP id p16mr7380981ioe.228.1477179198038;
        Sat, 22 Oct 2016 16:33:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id e12sm4565294ioe.14.2016.10.22.16.33.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 24/36] attr.c: always pass check[] to collect_some_attrs()
Date:   Sat, 22 Oct 2016 16:32:13 -0700
Message-Id: <20161022233225.8883-25-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

This function used to be called with check=NULL to signal it to
collect all attributes in the global check_all_attr[] array.

Because the longer term plan is to allocate check_all_attr[] and
attr_stack data structures per git_attr_check instance (i.e. "check"
here) to make the attr subsystem thread-safe, it is unacceptable.

Pass "Are we grabbing all attributes defined in the system?" bit as
a separate argument and pass it from the callers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/attr.c b/attr.c
index 9f58cc0..673dc7a 100644
--- a/attr.c
+++ b/attr.c
@@ -756,11 +756,12 @@ static void empty_attr_check_elems(struct git_attr_check *check)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr.  If check is not NULL, only attributes in
- * check[] are collected. Otherwise all attributes are collected.
+ * check_all_attr.  If collect_all is zero, only attributes in
+ * check[] are collected.  Otherwise, check[] is cleared and
+ * any and all attributes that are visible are collected in it.
  */
 static void collect_some_attrs(const char *path, int pathlen,
-			       struct git_attr_check *check)
+			       struct git_attr_check *check, int collect_all)
 
 {
 	struct attr_stack *stk;
@@ -781,10 +782,11 @@ static void collect_some_attrs(const char *path, int pathlen,
 	}
 
 	prepare_attr_stack(path, dirlen);
+
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
-	if (check && !cannot_trust_maybe_real) {
+	if (!collect_all && !cannot_trust_maybe_real) {
 		struct git_attr_check_elem *celem = check->check;
 
 		rem = 0;
@@ -803,6 +805,17 @@ static void collect_some_attrs(const char *path, int pathlen,
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
 		rem = fill(path, pathlen, basename_offset, stk, rem);
+
+	if (collect_all) {
+		empty_attr_check_elems(check);
+		for (i = 0; i < attr_nr; i++) {
+			const struct git_attr *attr = check_all_attr[i].attr;
+			const char *value = check_all_attr[i].value;
+			if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
+				continue;
+			git_attr_check_append(check, attr)->value = value;
+		}
+	}
 }
 
 static int git_check_attrs(const char *path, int pathlen,
@@ -811,7 +824,7 @@ static int git_check_attrs(const char *path, int pathlen,
 	int i;
 	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, check);
+	collect_some_attrs(path, pathlen, check, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
 		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
@@ -825,19 +838,7 @@ static int git_check_attrs(const char *path, int pathlen,
 
 void git_all_attrs(const char *path, struct git_attr_check *check)
 {
-	int i;
-
-	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), NULL);
-
-	for (i = 0; i < attr_nr; i++) {
-		const char *name = check_all_attr[i].attr->name;
-		const char *value = check_all_attr[i].value;
-		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
-			continue;
-		git_attr_check_append(check, git_attr(name));
-		check->check[check->check_nr - 1].value = value;
-	}
+	collect_some_attrs(path, strlen(path), check, 1);
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
-- 
2.10.1.508.g6572022

