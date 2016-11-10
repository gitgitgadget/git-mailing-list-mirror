Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A4120229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965530AbcKJUfK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:10 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35866 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965224AbcKJUfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:06 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so152172821pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wwo6bDIjSe5sMEBowsA+HcaNsH8HLVDDjmR4pVJVL/0=;
        b=jGckVTwaZhLpmhqtPHZOpr7SeBjnyPTe44tUZGz+KEJ8tAY7Jb1RNHgRBPkE/VisPw
         E7x3W69Ne1X0Bn16vfHqTiE/OXZOSrgver1gzFjjhBFitqhCrEYTTga2AJCQGo1SnHTp
         Zpub1eXLiEFbFF+CB7N1TlRhY4PsReMBwVlQJP89UKknuFjZZvq+/o50aCUvRG255YXf
         EKYHJWttvVJPyVhJLhR3pq7ZoogZ1Tj4a8SRoWxHu/brjjfRupw8ttOv0kQkXtBq+AAV
         5M6XCz2cCZywrD9b8L1vdtJ8HDworJWrIgcqwXaohaSlqnUTkWfRPwBkRO12EexsLYPx
         sFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wwo6bDIjSe5sMEBowsA+HcaNsH8HLVDDjmR4pVJVL/0=;
        b=nJ6oAmnwIUrHPSB+/4c7ztHWrrlP7N8KLUO2tf3cW/GgJK0kkHjbqMuYqK+fHzlz+S
         V8iFk43J+41gEF4w69utkR0TkeEsvwfxSQq8jbLrBnQSDunhYpCMkQ4T54ZZstyo/j4c
         zNmLXPgdSOQ3AjZ1s94/w6tTyrnjr9de4pb4a8PI5RjEhpNIbPZ82cKAhg7ifSvo1Juw
         7wrVWNi+dwic4vnExHmWhKXSGJ4+g/koh0indeaurW/VqdBIaR4u6ge6IExHjOZ6sB69
         WWcimjBN2YTegC4RmPnwNUED+puqO3rpkJqLrZB+9ArXxhSQKZaTX9r4eP3aQB2WY1bV
         P/Mw==
X-Gm-Message-State: ABUngvd+Anl1hJJGJlzHYlunkmofF/rlJswe7Ku7h1EHApZn5c2JsxlNmrbEeFTOIidgqQir
X-Received: by 10.98.34.68 with SMTP id i65mr13425395pfi.135.1478810105982;
        Thu, 10 Nov 2016 12:35:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id xt4sm7089023pac.25.2016.11.10.12.35.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 23/35] attr.c: always pass check[] to collect_some_attrs()
Date:   Thu, 10 Nov 2016 12:34:16 -0800
Message-Id: <20161110203428.30512-24-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/attr.c b/attr.c
index 5bb925d..246a5d0 100644
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
2.10.1.469.g00a8914

