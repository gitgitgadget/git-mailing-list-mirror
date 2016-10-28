Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22132035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034408AbcJ1S4y (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:54 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35973 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756398AbcJ1S4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:06 -0400
Received: by mail-pf0-f182.google.com with SMTP id e6so41419758pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ojvxcXpFIS8DiZHLR9CelqZe5r500sCs/0BIcVBppp8=;
        b=PGPE1dsycbF3IZtjtj5pm4oGwANjYYtsaMI3D842brMut3w5eBSW7J7bAGhBQAjBjD
         FjBOD5qoRtR29NyWrtuHxHVR2otvGe8usBHNSjIJ2CE2pDA8BPHioPYYvmDG5rHx13XS
         +j4CpneLOVWqFmImpqbmt+/tbVfVxP6v5Ogoyz8hiDCZPQwR85GYU1OJ+9udc3aW1IZ0
         AZxTlGOimKPyVGgg7wAXYdHQbixmBuu4j++2cQUM8P50QCfYmn/q0+qdaDQdeY8fQc80
         YWz4g6PIYatUgUkmFVOYJD/fxYP1lOBJBhrCUSdzvNgdGPaOgqqMQIYZ3hebWYkbKmXE
         kPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ojvxcXpFIS8DiZHLR9CelqZe5r500sCs/0BIcVBppp8=;
        b=jUlD9pbdIstw8VNcoqyowCMN3dbjbzRwYAJMUEgsO+f96Piw7vhVYKWQNUV3zM1FVK
         TShzZ7bvuDJDE7cDBexrLyDvrHiYq7kZDtg/4mdtev5lgXfrBo+Bmy8dnawlLUSsM4Cz
         P+TN8ZZP6ZEVvPO36oehaqPirrvokDxjAey4Qqdwb6cndRZGk9DDQNFI6gBbJ8sJ+vjX
         IHCCCP8sfngtmLqys+mbqbVF/EjToMtm19jjmWVfaqJLUeb5LwWfMzxjDHPYqdue0NWk
         xP2dJJqKgDZKXHhzjhiOJkWHUGRocHVJuOiT//KKLDLor20GhhhUwiVfV61tb/MupZ+B
         KijA==
X-Gm-Message-State: ABUngvdHR0VUYGU5cQph7LKjs8FrBw38q4OS3vyQfhJNM7kjTdFj7F4OoWokBVt4bDRE3Bqf
X-Received: by 10.99.116.15 with SMTP id p15mr22727193pgc.167.1477680965223;
        Fri, 28 Oct 2016 11:56:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id m129sm20599391pfm.13.2016.10.28.11.56.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 24/36] attr.c: always pass check[] to collect_some_attrs()
Date:   Fri, 28 Oct 2016 11:54:50 -0700
Message-Id: <20161028185502.8789-25-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
index 1098300e54..92b3130f1e 100644
--- a/attr.c
+++ b/attr.c
@@ -760,11 +760,12 @@ static void empty_attr_check_elems(struct git_attr_check *check)
 
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
@@ -785,10 +786,11 @@ static void collect_some_attrs(const char *path, int pathlen,
 	}
 
 	prepare_attr_stack(path, dirlen);
+
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
-	if (check && !cannot_trust_maybe_real) {
+	if (!collect_all && !cannot_trust_maybe_real) {
 		struct git_attr_check_elem *celem = check->check;
 
 		rem = 0;
@@ -807,6 +809,17 @@ static void collect_some_attrs(const char *path, int pathlen,
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
@@ -815,7 +828,7 @@ static int git_check_attrs(const char *path, int pathlen,
 	int i;
 	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, check);
+	collect_some_attrs(path, pathlen, check, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
 		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
@@ -829,19 +842,7 @@ static int git_check_attrs(const char *path, int pathlen,
 
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
2.10.1.714.ge3da0db

