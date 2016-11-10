Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24EA20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965381AbcKJUfD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:03 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34009 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965224AbcKJUfA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:00 -0500
Received: by mail-pf0-f179.google.com with SMTP id n85so151865813pfi.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jhc2L7MgcVhqwJNr11T8ABwJvyWs/X6eD32QMRec3qU=;
        b=hD7QM9amppcJ8u//NwslH/wN+WFZauiOHXbQX5dhPmSnHj9VxVCZvbCQkEFqNCotzL
         ykdrQJdTRE2DuyphSKbg5NHB6I84tVc/0wirV5Ktnxq88vF9iwTh3UkNyXC+qd+MTB9W
         y+4EiNeb7fy32fP9p2dODdGSLbiMoXNoEXeoqhXOBgb94UQqrSp3YUjarXCkx4NfgRU1
         pGhzRvadgN5WYDkLJuH5fnc3qOIHsxd1rQ3ZLqXi0USJXsW1TDMeP4rOQObMG91PUR+7
         idIoPFrnNwNm8Uho9Qa9Ei606fRfCZ0xe045f8qc4uuZkUBWMgRUCaGh3Qzf1L7mSPH5
         RZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jhc2L7MgcVhqwJNr11T8ABwJvyWs/X6eD32QMRec3qU=;
        b=KZQhRP+OGgNoiZXcAXmyhqOMAbiroQgUGbBT8cvAzGGk6O7vCB4eEeYRe1Sqig2xVr
         FCDtWuoDODymtONJXzTsj1MLMxXNHkVJan79sXoiOZh9dxOoYPUA4/+Q4ShxeH7Bo7IR
         Y7gAHRX3Hwx3cPbpi5RURBmbgxWEI2MevcPda1znGedjeQ7UyWuZV9OlF3IlMrPbVtHL
         8FuZU2VFH3XTtUST55n7BOvW1afs4vwEXFtL0evuoUiRrNL5QBLveiTRjSvcA7jZLLB/
         qtHu56/GisqmS11g2BGx5ePlhhy2J7AdYvsQaHqOiFCI+zVHAtTjZl91Qef8zdKzaGmq
         G2NA==
X-Gm-Message-State: ABUngvcxLThNKViFUNAP5FUDePpJfpmRDPrBBr5fqWfz0cHLCMY7RK0s4lLoX0Gfly3LWcv5
X-Received: by 10.99.143.2 with SMTP id n2mr26473531pgd.70.1478810099906;
        Thu, 10 Nov 2016 12:34:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id r74sm9260449pfl.79.2016.11.10.12.34.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/35] attr.c: add push_stack() helper
Date:   Thu, 10 Nov 2016 12:34:11 -0800
Message-Id: <20161110203428.30512-19-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

There are too many repetitious "I have this new attr_stack element;
push it at the top of the stack" sequence.  The new helper function
push_stack() gives us a way to express what is going on at these
places, and as a side effect, halves the number of times we mention
the attr_stack global variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 71 +++++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 88fcb7c..a504cb3 100644
--- a/attr.c
+++ b/attr.c
@@ -521,6 +521,18 @@ static int git_attr_system(void)
 
 static GIT_PATH_FUNC(git_path_info_attributes, INFOATTRIBUTES_FILE)
 
+static void push_stack(struct attr_stack **attr_stack_p,
+		       struct attr_stack *elem, char *origin, size_t originlen)
+{
+	if (elem) {
+		elem->origin = origin;
+		if (origin)
+			elem->originlen = originlen;
+		elem->prev = *attr_stack_p;
+		*attr_stack_p = elem;
+	}
+}
+
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
@@ -528,52 +540,35 @@ static void bootstrap_attr_stack(void)
 	if (attr_stack)
 		return;
 
-	elem = read_attr_from_array(builtin_attr);
-	elem->origin = NULL;
-	elem->prev = attr_stack;
-	attr_stack = elem;
-
-	if (git_attr_system()) {
-		elem = read_attr_from_file(git_etc_gitattributes(), 1);
-		if (elem) {
-			elem->origin = NULL;
-			elem->prev = attr_stack;
-			attr_stack = elem;
-		}
-	}
+	push_stack(&attr_stack, read_attr_from_array(builtin_attr), NULL, 0);
+
+	if (git_attr_system())
+		push_stack(&attr_stack,
+			   read_attr_from_file(git_etc_gitattributes(), 1),
+			   NULL, 0);
 
 	if (!git_attributes_file)
 		git_attributes_file = xdg_config_home("attributes");
-	if (git_attributes_file) {
-		elem = read_attr_from_file(git_attributes_file, 1);
-		if (elem) {
-			elem->origin = NULL;
-			elem->prev = attr_stack;
-			attr_stack = elem;
-		}
-	}
+	if (git_attributes_file)
+		push_stack(&attr_stack,
+			   read_attr_from_file(git_attributes_file, 1),
+			   NULL, 0);
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
 		elem = read_attr(GITATTRIBUTES_FILE, 1);
-		elem->origin = xstrdup("");
-		elem->originlen = 0;
-		elem->prev = attr_stack;
-		attr_stack = elem;
+		push_stack(&attr_stack, elem, xstrdup(""), 0);
 		debug_push(elem);
 	}
 
 	elem = read_attr_from_file(git_path_info_attributes(), 1);
 	if (!elem)
 		elem = xcalloc(1, sizeof(*elem));
-	elem->origin = NULL;
-	elem->prev = attr_stack;
-	attr_stack = elem;
+	push_stack(&attr_stack, elem, NULL, 0);
 }
 
 static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
-	int len;
 	const char *cp;
 
 	/*
@@ -633,20 +628,21 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
 		assert(attr_stack->origin);
 		while (1) {
-			len = strlen(attr_stack->origin);
+			size_t len = strlen(attr_stack->origin);
+			char *origin;
+
 			if (dirlen <= len)
 				break;
 			cp = memchr(path + len + 1, '/', dirlen - len - 1);
 			if (!cp)
 				cp = path + dirlen;
-			strbuf_add(&pathbuf, path, cp - path);
-			strbuf_addch(&pathbuf, '/');
-			strbuf_addstr(&pathbuf, GITATTRIBUTES_FILE);
+			strbuf_addf(&pathbuf,
+				    "%.*s/%s", (int)(cp - path), path,
+				    GITATTRIBUTES_FILE);
 			elem = read_attr(pathbuf.buf, 0);
 			strbuf_setlen(&pathbuf, cp - path);
-			elem->origin = strbuf_detach(&pathbuf, &elem->originlen);
-			elem->prev = attr_stack;
-			attr_stack = elem;
+			origin = strbuf_detach(&pathbuf, &len);
+			push_stack(&attr_stack, elem, origin, len);
 			debug_push(elem);
 		}
 
@@ -656,8 +652,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-	info->prev = attr_stack;
-	attr_stack = info;
+	push_stack(&attr_stack, info, NULL, 0);
 }
 
 static int path_matches(const char *pathname, int pathlen,
-- 
2.10.1.469.g00a8914

