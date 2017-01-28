Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA081F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdA1CDg (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:36 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34088 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdA1CDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:10 -0500
Received: by mail-pf0-f171.google.com with SMTP id e4so76791650pfg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FdPzMfaPB+QU15kQYDNltIm4t2xawpIgWq91q1OvOqE=;
        b=mkWEfot8AxAnXp/gkXG9MxDnenFj8siSky9waU8QeQ94pDn+5t8jr485q+blapw0y2
         YrHEsuTNfS3DZfZ5IEGZT4wL+QaRlFSqsc3m+KfM+dA4Kqur5A0CKW405y84oYImlt2i
         08p9SHzAKtJSk7RfqcW6ifRFzB3K7YGPQGf4suK5tqPAYDyNaOp78uJISakFFw2ZyQU2
         AlG5qtJmr4HOcK/ual92wq3r5RmonurjUpHY0NT/QV8yErnR2NYLanJId8ISGJUpMiHJ
         P+m+W+JWenPAUghynnsVuAKrP4Z2srO8TjsfGwkRYtWmOcBHQdKDNDWrHKXlJcnXP/ro
         PvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FdPzMfaPB+QU15kQYDNltIm4t2xawpIgWq91q1OvOqE=;
        b=lbNODzkfZjagSdOg3T6HFEJbQSITsurl7jMb3LKQZOZTXySIdSEyF4lnp0v3DmkII0
         T8vU6EO3LE5K4wVkvhD4jnLdUcL0DC6wZV5iJo/I39aQt9Qq1fJha4kWICviFS830g/c
         lOxQJIoLLqLtdTCdr/7ikU17lY7jGC4SxrhiVs0zhK1f6qi+txDI8xVojDBFHeH5K7o4
         IBqqdajgygRUHRtCf33wWCXL9kutfmiEQou/e5WiWQl+/6zqGB8nJZQu38HM36MENL+W
         dSkDRfPyTJNyWToFzuI1K8No3Q02JTpZkypQ7KEIs87Em7noNeIYBKrDxyzi54E/2wXp
         x6uQ==
X-Gm-Message-State: AIkVDXLlIYrPdz7avlF/y0hmsdpXGmJBZ2vIXx4/5XJQ3tmRahVeoJbdC9jyz70Ebncpv+z/
X-Received: by 10.98.51.70 with SMTP id z67mr12174330pfz.68.1485568978975;
        Fri, 27 Jan 2017 18:02:58 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:58 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 20/27] attr: change validity check for attribute names to use positive logic
Date:   Fri, 27 Jan 2017 18:02:00 -0800
Message-Id: <20170128020207.179015-21-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Convert 'invalid_attr_name()' to 'attr_name_valid()' and use positive
logic for the return value.  In addition create a helper function that
prints out an error message when an invalid attribute name is used.

We could later update the message to exactly spell out what the
rules for a good attribute name are, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 81a3c74d8..9fe848f59 100644
--- a/attr.c
+++ b/attr.c
@@ -74,23 +74,33 @@ static unsigned hash_name(const char *name, int namelen)
 	return val;
 }
 
-static int invalid_attr_name(const char *name, int namelen)
+static int attr_name_valid(const char *name, size_t namelen)
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
+static void report_invalid_attr(const char *name, size_t len,
+				const char *src, int lineno)
+{
+	struct strbuf err = STRBUF_INIT;
+	strbuf_addf(&err, _("%.*s is not a valid attribute name"),
+		    (int) len, name);
+	fprintf(stderr, "%s: %s:%d\n", err.buf, src, lineno);
+	strbuf_release(&err);
 }
 
 static struct git_attr *git_attr_internal(const char *name, int len)
@@ -105,7 +115,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 			return a;
 	}
 
-	if (invalid_attr_name(name, len))
+	if (!attr_name_valid(name, len))
 		return NULL;
 
 	FLEX_ALLOC_MEM(a, name, name, len);
@@ -196,17 +206,15 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
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
@@ -258,10 +266,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
-- 
2.11.0.483.g087da7b7c-goog

