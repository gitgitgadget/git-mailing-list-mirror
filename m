Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A4220989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbcJKAV7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35511 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbcJKAV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id qn10so3907614pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwu6rEc8dY0TN9tKb2pZLCd9gb2YTKLJm/BeLdAcfYw=;
        b=XF0/Az+yWpvXyHtiTJqsJ77gaK3NrVXVrR6D6jM+5e4JhNfkt/fYOf1fkEOyy6tUsg
         eeXx5LOdzJ8rvh3BSKQ/C9x5nwlyFb0NvY4BWyX23pdCh9Y2W0koij7DejgfoIA+O68Y
         BXqtndAaTBd+Cz7GZSMI0IkKg0YY1EgmkQekyYG/9dhVolTB0/4x3wuMTGfE9eGdkvBT
         Kn1KO/HaugwJcdUNmgb5jlLG3LrMkp5Ynv3lethpQ5cmZSFCw/u7mcIqOmMEzpy2v/xq
         Zs44UBW5UHRi9LxnkFAVI9xr9Rxxb9PI7IQ0UnL8r5PudsKpVxKNBfp/N/z48mRhIGuk
         1bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lwu6rEc8dY0TN9tKb2pZLCd9gb2YTKLJm/BeLdAcfYw=;
        b=GikfYRzVMtb6yXBP6Imrgllz3aR/bpYcQksfq/qBPMUTtyzw/+1Xymk928vzF+WZds
         LLGiGwOUi/W4ZCDFq+B2lsipOfjsJVGZSNI1TMOMkw5Anl/hnxRKtXcSiVwhLOTAAo7g
         q+rEgZLGuSKCvKfp/Ek5w+N5AudILtNZwqAsrXjjId9gIKxgpiC3RLt876Dexo97ZKr5
         YOX1kiB4COeYgRUZk+MeW2dPCj631R1LMcQPN/RRl5nBPf9ioTbL+GlQIA7yhMakRzM7
         Zgdj90E/jPeq91Ky4FN5T3Sb4jrrfPEbUX1dcpHkQvRNH/RXKfIpBk6EvJVcKjbv1zKw
         v0ew==
X-Gm-Message-State: AA6/9RlM5+ZS4Yf/f7TvDascCm5X+tIG9IDyP6a7Vqyg46dvMsMfSpXHTDyDCGIyh52e5/v0
X-Received: by 10.67.21.169 with SMTP id hl9mr1615596pad.185.1476145316727;
        Mon, 10 Oct 2016 17:21:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id yi2sm525814pab.17.2016.10.10.17.21.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/28] attr.c: add push_stack() helper
Date:   Mon, 10 Oct 2016 17:21:06 -0700
Message-Id: <20161011002115.23312-20-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
index 6a14c9a..f9ebdd1 100644
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
2.10.1.382.ga23ca1b.dirty

