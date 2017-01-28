Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC8F1FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdA1CC6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:58 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35206 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdA1CCq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:46 -0500
Received: by mail-pf0-f175.google.com with SMTP id f144so77054836pfa.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=St4+jeUjANHaSlpEqkHv8n3g43hFf8dXY5VGaiFxkkM=;
        b=SymccxXPrhjSvgPuizZ0zw0RkIOx6vnT9LXWVSB9Zf9QRGVpb/8HAEJTrYQEkbyshO
         cXbtN3QjqqowlWzB+pMw6ZVBcgRpwCweiCapHDXzI6/F36BxaeF9iMd7Prq8qr7EYMch
         xP4D8GUaKNUxByPsVofmx5xNFPHXVKq+Cnhk97a/GFx6VWbKrdznItRCETJZ4iW/x2kg
         mXxg+FQzm5HraduOLWviwP6XYkrXGmH0Z+VkIH7xvYixoRdiEWBkC/NnwdKqmFzw+o+3
         MA1cLn7Cm9033IvN7nM5EF+wgDBuH9QTcOdtjfRYiXpVsMLOcMpR9tBC6tZPEnAZ8RZ8
         orcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=St4+jeUjANHaSlpEqkHv8n3g43hFf8dXY5VGaiFxkkM=;
        b=pQYeNgZxhaMbf0xo3pDYTGWv+1NQ93u2Gwrbqix9u77udNyKiykzJUS6BkNPl2xa5p
         AUIrRzyVQp/72V/6i/P1JACJ8unt2sTPwRuAdITdyguruJOV1UQPYfCouF+VPhaK5CdU
         7QezCMzkoTUwBW3gwpP05fLzWE1Am/0TeobSpNRml32XoF3r3jfS3uElJbUsH6UV79H9
         jp9+GloZdt56byM8/Fdh1MfkYneg5eLffhdMgtmpXtEMVj0HQ3ipQlZUQJcwua6lzH+v
         wgzc4iBOT8fNnLRFUscuGFfLRNvNeMozndGMsPjQyyTf+G9PFaY1k8GBh0ZGgiDRFxGK
         iFTg==
X-Gm-Message-State: AIkVDXJV/6jVNoCfCiD0tz3id+sL2JzJ5Cx+GNuLlJKhMtbA/Dbe4TOtKy8+VikT5Ew+Ne3Q
X-Received: by 10.98.69.139 with SMTP id n11mr12150141pfi.65.1485568965335;
        Fri, 27 Jan 2017 18:02:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 11/27] attr.c: add push_stack() helper
Date:   Fri, 27 Jan 2017 18:01:51 -0800
Message-Id: <20170128020207.179015-12-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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
2.11.0.483.g087da7b7c-goog

