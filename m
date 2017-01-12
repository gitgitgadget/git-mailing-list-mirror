Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299641FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdAMAAl (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:00:41 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34423 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdAMAAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:00:39 -0500
Received: by mail-pf0-f180.google.com with SMTP id 127so20481959pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOmFCvcw9bBNVKs+0ahLmYlO1Sq6xTc1uNTz4D7ZTdE=;
        b=oN0ax1LVwehUglSAOPx/iMm5gkhlqsBHJRo9PUCZ44P79ZFoUriv+aISPNoRbK5Cmv
         2dKUkts/Rq+lFILpuHX1ZLKAUxcPO+3LVj7PgaQpJztofDgPAiPEdQY45BAVTqmJq5zO
         KW2w50j85M4ijQuu46Y2oHEV1ocfxrHMKk0wNNZH6zCn+hOrGnwII5UO/5hGdjtRoTqn
         D+t8lGzlEmgkG8GTK0LGjNpDd1j0SN/4LlcIuOTczsBRBXkmvJETYSK5vCIOHaQdabAM
         uTYaA5jIYP05JOypZvkFbRrlIwSp/JIXUaddvZ/xwvG3acP+EFYpxgYlLaVsQ7uDz0ul
         2scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOmFCvcw9bBNVKs+0ahLmYlO1Sq6xTc1uNTz4D7ZTdE=;
        b=uPTglUgJqsXuEUM41glWpuWiMob/LRL777LZxYi+FHO96h00IO1neYWfDQwSOKLbdy
         owyWhPIILW3aR01ZVOU1Od8yVWrOV8bI2UaMmoGwA8XsDdfwkePnDzX5Y8aXdi3S/Ja2
         sMwHAoN8Gl4wPkCbQ0EPLMFzGe5es5jN8qwq4pqy+2odkc/tcTHvCSKFGWX01nByh02R
         YOOyECywJfOItlm3uJ7L+3r9iw2aY92EIKi7Xggtjf77nkM1YyNu5QM15LcqN0ewESqc
         +WVAOe59OTJ0bKo8ayYUpYR7KNNirkTSr8lEvQUEOBIqa0bqbW73SbAgkZtZ7JS+WfCI
         Vm1A==
X-Gm-Message-State: AIkVDXLLk3uD3qpNRvdOnpkVb7X7twNnMyZBGqhTOfUROgY27fCkGCyiQQZbOGWFEG6TXfO7
X-Received: by 10.99.232.21 with SMTP id s21mr20779460pgh.19.1484265259451;
        Thu, 12 Jan 2017 15:54:19 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:18 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/27] attr.c: add push_stack() helper
Date:   Thu, 12 Jan 2017 15:53:38 -0800
Message-Id: <20170112235354.153403-12-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
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
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 71 +++++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index e1c630f79..8026d68bd 100644
--- a/attr.c
+++ b/attr.c
@@ -510,6 +510,18 @@ static int git_attr_system(void)
 
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
@@ -517,37 +529,23 @@ static void bootstrap_attr_stack(void)
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
 
@@ -558,15 +556,12 @@ static void bootstrap_attr_stack(void)
 
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
@@ -626,20 +621,21 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
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
 
@@ -649,8 +645,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-	info->prev = attr_stack;
-	attr_stack = info;
+	push_stack(&attr_stack, info, NULL, 0);
 }
 
 static int path_matches(const char *pathname, int pathlen,
-- 
2.11.0.390.gc69c2f50cf-goog

