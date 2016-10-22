Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B41F20987
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbcJVXdJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:09 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35577 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964952AbcJVXdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:05 -0400
Received: by mail-it0-f52.google.com with SMTP id 198so53157156itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4konakGkd9Mo5DDMUGdnCMlVQ5V9nImAMVwIlHzbtE=;
        b=ZAlEB2Is5D4vWwBSQsQA8Oi8f9qw2qzw58PtXWErD8qg+2MGIIeBOS3kY1SjF53rp5
         bDivESZTkU+i4CHa+NbAMKLZalfMse9zem4+QFM7wLKEl+hStxuqYYAoLexo1OahXpMo
         GKLT6yTDu01Xr2/LKlMvkF/rys1FF/ZldsF4WbuW9xRxQvmD4r/zwKDWwTnNIVJinm5p
         wXGLsff/d6wEVs4dyqtsX0dL/gkJ6aWc7BQE2PdBGKMWO26oHRkVhQxsGqit6HZrrbi0
         JUl2QaaggDmsBqnm7NAQojEGxAooAs2/KBN5zT8uQz6d1AkWCkmCMabBCxf9MsluyKNQ
         4jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4konakGkd9Mo5DDMUGdnCMlVQ5V9nImAMVwIlHzbtE=;
        b=P/jWMH3ARCMSKm0U6y2AyI/cyKP8B76AwAZkvTWDZ+4gA6xdC2lnfYC6smcAr8l1VW
         2n/w56qpSO+UoadEjlxx/yF4AjkAV1F2cwhecj5n8I+zUkYEJVkv85Pr2sKrEzrjS//x
         qHvD1Lht+S/G0AU6gmno6Az5h6AuvRCHPqy3r24Csj4ZaeXg7KC6pdtT2YhbrTygOI8n
         6IH4KYLDXfP+LF6qVJqzrsvRMwVhPGxBvF73aSDh0T+aXVqaNUtSlQ+PDLvwaE4r4uk3
         QHz3+Zmv/D5TVfUJfnDfYUqKIeDHiJ9KK5WU4ae9eio+kuOzSOEev8dLTw5OYPbhY+tV
         IoNw==
X-Gm-Message-State: ABUngvfysKWR2hpNGkheRFBFS6jCmy8uDt/wC/oA3tkbTTe/VadBtpL7czplEIyRP4IfPxvi
X-Received: by 10.36.46.4 with SMTP id i4mr4775449ita.27.1477179184776;
        Sat, 22 Oct 2016 16:33:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id k140sm4554446iok.33.2016.10.22.16.33.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/36] attr: expose validity check for attribute names
Date:   Sat, 22 Oct 2016 16:32:06 -0700
Message-Id: <20161022233225.8883-18-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Export attr_name_valid() function, and a helper function that
returns the message to be given when a given <name, len> pair
is not a good name for an attribute.

We could later update the message to exactly spell out what the
rules for a good attribute name are, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 39 +++++++++++++++++++++++++--------------
 attr.h |  3 +++
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 90dbacd..659dc41 100644
--- a/attr.c
+++ b/attr.c
@@ -59,23 +59,38 @@ static unsigned hash_name(const char *name, int namelen)
 	return val;
 }
 
-static int invalid_attr_name(const char *name, int namelen)
+int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
 	 * Attribute name cannot begin with '-' and must consist of
 	 * characters from [-A-Za-z0-9_.].
 	 */
 	if (namelen <= 0 || *name == '-')
-		return -1;
+		return 0;
 	while (namelen--) {
 		char ch = *name++;
 		if (! (ch == '-' || ch == '.' || ch == '_' ||
 		       ('0' <= ch && ch <= '9') ||
 		       ('a' <= ch && ch <= 'z') ||
 		       ('A' <= ch && ch <= 'Z')) )
-			return -1;
+			return 0;
 	}
-	return 0;
+	return 1;
+}
+
+void invalid_attr_name_message(struct strbuf *err, const char *name, int len)
+{
+	strbuf_addf(err, _("%.*s is not a valid attribute name"),
+		    len, name);
+}
+
+static void report_invalid_attr(const char *name, size_t len,
+				const char *src, int lineno)
+{
+	struct strbuf err = STRBUF_INIT;
+	invalid_attr_name_message(&err, name, len);
+	fprintf(stderr, "%s: %s:%d\n", err.buf, src, lineno);
+	strbuf_release(&err);
 }
 
 struct git_attr *git_attr_counted(const char *name, size_t len)
@@ -90,7 +105,7 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
 			return a;
 	}
 
-	if (invalid_attr_name(name, len))
+	if (!attr_name_valid(name, len))
 		return NULL;
 
 	FLEX_ALLOC_MEM(a, name, name, len);
@@ -176,17 +191,15 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			cp++;
 			len--;
 		}
-		if (invalid_attr_name(cp, len)) {
-			fprintf(stderr,
-				"%.*s is not a valid attribute name: %s:%d\n",
-				len, cp, src, lineno);
+		if (!attr_name_valid(cp, len)) {
+			report_invalid_attr(cp, len, src, lineno);
 			return NULL;
 		}
 	} else {
 		/*
 		 * As this function is always called twice, once with
 		 * e == NULL in the first pass and then e != NULL in
-		 * the second pass, no need for invalid_attr_name()
+		 * the second pass, no need for attr_name_valid()
 		 * check here.
 		 */
 		if (*cp == '-' || *cp == '!') {
@@ -229,10 +242,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
 		name += strspn(name, blank);
 		namelen = strcspn(name, blank);
-		if (invalid_attr_name(name, namelen)) {
-			fprintf(stderr,
-				"%.*s is not a valid attribute name: %s:%d\n",
-				namelen, name, src, lineno);
+		if (!attr_name_valid(name, namelen)) {
+			report_invalid_attr(name, namelen, src, lineno);
 			goto fail_return;
 		}
 	}
diff --git a/attr.h b/attr.h
index bcedf92..40abc16 100644
--- a/attr.h
+++ b/attr.h
@@ -13,6 +13,9 @@ extern struct git_attr *git_attr(const char *);
 /* The same, but with counted string */
 extern struct git_attr *git_attr_counted(const char *, size_t);
 
+extern int attr_name_valid(const char *name, size_t namelen);
+extern void invalid_attr_name_message(struct strbuf *, const char *, int);
+
 /* Internal use */
 extern const char git_attr__true[];
 extern const char git_attr__false[];
-- 
2.10.1.508.g6572022

