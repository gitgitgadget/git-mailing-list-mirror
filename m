Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D541FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbdALXz2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:28 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33172 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f181.google.com with SMTP id y143so20697214pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3KPulpR8K6cfckjYFdFC1IMtSCgxS+MSRHoifIYnqeE=;
        b=ZBK1vVWV2vV63qFRedtZaJUvmTWIwFrnidYF3q5Lh/torM/rt/Y/u/dG5l0WTEn/K/
         Mxr47nIfqgoW0NF3+sIHliKOSNYJs9Qo4otV5myLdlYErC4tOAJ646q15hKleP1FlXeU
         qEdDNaDL4kPFN+tz/LFmcfQdQH/FTyDCr5JZVy+/c8F3qX3mX4CiU1c3EDOHfNmoIHDy
         9f8BTW7QgR6tsiRZZ1sy/yVO7sIk9UiZq4Azms7bBEqlDZ2p0+w70Nlv0lryDEINO5HB
         OMf93oclxxy/gVp9ONDJC7U2j0QuA+1L3REutCWUpMKLfUtscDqZuoOSRgs74PIIj7K3
         f5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3KPulpR8K6cfckjYFdFC1IMtSCgxS+MSRHoifIYnqeE=;
        b=PDB18ohBGH1crFy58sGA8jgsXPCGTn4ksOWXx0eQQ/qoS6UvB8Lb0Q+Y9HuPrN1RZ0
         r3EqTmw0GBD7C0fpi2eIizSmX7qfQ75tC6IJj6GstHrnr61dpKt8xMg3JH0MRU0v/FYz
         NKOXbbR2ZAjhUiWOydv4WI18FwOuWPFFUMOU+nNCHC+5zfO/3QjlmlG6O7irOD/nCZL4
         23zo7gVGyBPFEoRkkEqGK36VX1f20fcDu3LjThDyhy9diaK/8uKwMUQe58TjRSj+UsDL
         qi5n8MQarmHvAWL+31b2ax39XeMAd8+E9aDq951xjIiBxtGCkKHQNA7zklVs1Sfhb8K7
         /hUA==
X-Gm-Message-State: AIkVDXICnohP6AwWPaBIMCWdGwxnbSVjILpuAYWKX70CbH6Jyb4ZTyoqFhfo8tfW7b/ILJ0S
X-Received: by 10.84.248.70 with SMTP id e6mr25481139pln.179.1484265273539;
        Thu, 12 Jan 2017 15:54:33 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 20/27] attr: change validity check for attribute names to use positive logic
Date:   Thu, 12 Jan 2017 15:53:47 -0800
Message-Id: <20170112235354.153403-21-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
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
index e58fa340c..5399e1cb3 100644
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
2.11.0.390.gc69c2f50cf-goog

