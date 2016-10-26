Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC25C2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934561AbcJZVVF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 17:21:05 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36113 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbcJZVVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 17:21:04 -0400
Received: by mail-pf0-f179.google.com with SMTP id e6so3238847pfk.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEvDxMHkpl2nYAG0tP4xy+jZxAokTVBM7QRAD297pQ0=;
        b=ZQKUQyvt9BWHTw3Ks9QzbYwf4mpH4VYRn8shP15sPhF63eUfIo0teRoT7rAs3iFu9p
         A25ffAjQr9dKbUdkKVMj+AMDpVUGEurB//VVdsUugxThBsTgnyTYHXgyTH8NkioRWY9u
         Z8bkP2EQHF7FHjpQbo2iXJ5AUuA23uLMzNVJjjW2F17Ov0jNpe5onXCRm1o2I6bLP3A4
         Taumlpe+PnQbs1BigX/I2Al02A7huDvSbrKE5mq76xpdlXhJmBzXTzi7ffwU/6nS2y40
         zLnOkncdJsUjotxoDn0cY/u3erfl6p+Hh2UCsfiaPivC8EBWdHgHE+IBvcLMxnZ/AcSv
         qUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEvDxMHkpl2nYAG0tP4xy+jZxAokTVBM7QRAD297pQ0=;
        b=L8g5CbMrWavTvjA/Uww02i/C5LeREh/+cKZo6Szizl1EYepJp+Drvq/6s0vS4eq8v6
         JKoJNTxyM7hjSaTfhWpQV88rGKU066pg2a5zgNJue6T+ib5kA9J6A1o350tYanFIcsoK
         eSYpLqgjKPU66RuSl9D/qpOnMdHiOTxIICzDHi/S38mmErQjqQNYFujceblLNraZAw4A
         tPLKS/u/ZJwl27knVhiGPiFkGGx9j9H9S8LchiI8NGD9HyrOBDChP9+LyCrJY5SDrqRN
         i+lVC1g0l35B1FuEmhyyj0dsi7ehH1VCjQ+nVMHTicfgTuhgCR9+Hmcpwx2i9KjAbmbb
         gSrA==
X-Gm-Message-State: ABUngvd5n+ifqG9HgEifDZXrDKR272dB9uss88zGjfXaGUuNFFW1w+53yRykJdmm84w+eZjH
X-Received: by 10.98.18.220 with SMTP id 89mr7884920pfs.71.1477516863083;
        Wed, 26 Oct 2016 14:21:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:14d0:6024:c11b:baba])
        by smtp.gmail.com with ESMTPSA id e7sm6245755pfa.65.2016.10.26.14.21.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Oct 2016 14:21:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     ramsay@ramsayjones.plus.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] attr: expose error reporting function for invalid attribute names
Date:   Wed, 26 Oct 2016 14:20:59 -0700
Message-Id: <20161026212059.11840-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <0425fea3-3419-c265-b964-f5a309b867fa@ramsayjones.plus.com>
References: <0425fea3-3419-c265-b964-f5a309b867fa@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Export invalid_attr_name_message() function that returns the
message to be given when a given <name, len> pair
is not a good name for an attribute.

We could later update the message to exactly spell out what the
rules for a good attribute name are, etc.

We do not need to export the validity check 'attr_name_valid()' itself
as we will learn about the validity indirectly in a later patch
via calling 'git_attr_counted()'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Ramsay,
 I intend to replace the previous
 
     [PATCH 17/36] attr: expose validity check for attribute names
     
 by this one in a reroll.
 
 Thanks,
 Stefan

 attr.c | 39 +++++++++++++++++++++++++--------------
 attr.h |  2 ++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 90dbacd..ec878c3 100644
--- a/attr.c
+++ b/attr.c
@@ -59,23 +59,38 @@ static unsigned hash_name(const char *name, int namelen)
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
index bcedf92..d39e327 100644
--- a/attr.h
+++ b/attr.h
@@ -13,6 +13,8 @@ extern struct git_attr *git_attr(const char *);
 /* The same, but with counted string */
 extern struct git_attr *git_attr_counted(const char *, size_t);
 
+extern void invalid_attr_name_message(struct strbuf *, const char *, int);
+
 /* Internal use */
 extern const char git_attr__true[];
 extern const char git_attr__false[];
-- 
2.10.1.508.g6572022

