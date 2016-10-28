Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DA52035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030751AbcJ1S4B (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:01 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35937 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034191AbcJ1Sz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so41417760pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xdf0N5qnsr7Z4/3AE4EzK7oSsQNHPY0Gnhh4JJ2Wec0=;
        b=m8dztMsjIi9lHLfuO6lG/KzYEnwdc8KoujnljMJ6HjRSL01ZqsNB3HsNltWOm2zor4
         lsoDC8uKkDquUfYu3znNATr74d1/suwOJQ3HZd3MqNeL7nXseAYkNBDhjkHnx6C/SKJd
         mf0tNDxnV0seYScAub4ZMdjkdzIcvHtiK8COck4h/zK/Xh9spRg1JzjWy5ndePcp7JLB
         ok3GkYM3tk9hK0KzVefPYwACNZIMEnQFRcPkTZKeQSu3cRocQbihr8qbbarD4RJuJpL1
         vSjjCO7sAM0nDwnlY88ccqP+vqhrMMP1TaNe4QZntxwurGnNFso15lJ79NZ271jaa0ku
         CWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xdf0N5qnsr7Z4/3AE4EzK7oSsQNHPY0Gnhh4JJ2Wec0=;
        b=EwtMU7J/m6g4MwobGd828HeQLTXEpq3NWueAPwEh3gjpPXvfP403k55DaszfMkOE8i
         BwsFqkp99bR1nefMnLOjMyGeuLwPYTH7cp5zGCXQ0BOrFumMuxr+OIPrR+ee1LnK22Qj
         q1gX51GfUYULpLLf/gh1RYxGkWMrAVpXEVgGxCeUaSIIUJJD5irvn8bJ9c4dioJLWGsZ
         i9y62bpB2qtAKKoDL1BIpcKWJwz2WqLV/GlaSB8sgiSSazUWmwRE0m6R1abpcWSoGaCL
         xgFbbTTy+wGm1jPbS2WG+decj8RcItjGVyjP3EiGOv5D9moCiBmGIoAmWJIZyfNz3m/Y
         um2Q==
X-Gm-Message-State: ABUngvdTHMaq2fyGeDYgY7aeSyTooAV3hWW7ldtwJrNQdZ/rHltoJWcjNHgd/V1dfHFoq0vP
X-Received: by 10.98.19.87 with SMTP id b84mr6892297pfj.82.1477680955336;
        Fri, 28 Oct 2016 11:55:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id h5sm20529959pfg.86.2016.10.28.11.55.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 19/36] attr.c: add push_stack() helper
Date:   Fri, 28 Oct 2016 11:54:45 -0700
Message-Id: <20161028185502.8789-20-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
---
 attr.c | 71 +++++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index c8c4936f36..0a8ed5b582 100644
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
@@ -528,37 +540,23 @@ static void bootstrap_attr_stack(void)
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
 
@@ -569,15 +567,12 @@ static void bootstrap_attr_stack(void)
 
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
@@ -637,20 +632,21 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
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
 
@@ -660,8 +656,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-	info->prev = attr_stack;
-	attr_stack = info;
+	push_stack(&attr_stack, info, NULL, 0);
 }
 
 static int path_matches(const char *pathname, int pathlen,
-- 
2.10.1.714.ge3da0db

