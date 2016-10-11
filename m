Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3901D2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752818AbcJKAV4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:56 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34557 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbcJKAVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id rz1so3953310pab.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dD0zTFaFb98SZpIDaNd635oI14v+C24NSqt/Cyp7lwU=;
        b=bbNc0wH4Frn29wjbmM6vfS5lJVCnbEpGISKqs2thjldibpPwC6SdSTWqHwCapycZLj
         wSaasXPOARmrBB5MtkIVGvgzk1f68hX5m4RNCU9L6K4DsKmvvf+m62Cfm3EyJhEUuG/2
         KZkZcteEahpJDFd52kxfK0nuy+PF0TIn8iA1XZqmj7E0TLqUBF0w1RtJUOHdFJ4q1CAf
         pN/6MXRaBoeH4UJSYW3MumcuN7l7EQbxrKw26ELEKb4NHMVKArVhSg5Gr3YUNggND4AK
         iPieaqdbTlF8R5k0y0hfXH8pGi+hWyM2fRsrThb4cfZu8jAvfFhfUU0ZGow9oJ79vEF1
         lI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dD0zTFaFb98SZpIDaNd635oI14v+C24NSqt/Cyp7lwU=;
        b=DnAcrIIovlLtZl2RrdqaGIKCE5ldr3asMm+9RVZtIT5oaUBbnrmZLl+ZLN2acJRRpg
         c3641dgmozAUWt/N2SalaDE9GWghmCVzFMHgxCp92LQTU58/WbsaWbMOLRs5lbvyVSSy
         ijGL7XpiLEP18z4esOGSrUQgKLOstsIkwQvGVqgq3dnbkZKP6bljyr/XXm4n62lrTUHM
         bF4ki2slEWv2/bLj+eWjvmcpYuVyACOa9eFqqW7mIMK7BgsCLwOT6GV0mqZPhZlw64RJ
         dftDLDEhVOX5VsONELivK9/vJmWBT3y6fDy9IbI+PdfOV7BYicirghO9FLuZqKexE8+Y
         ClWA==
X-Gm-Message-State: AA6/9RmbGPABhhba5hmXfJEonvj+2wnFja0jRMORrwuwc4tRe86dAFuOGiqxDJYnf3/6oUXu
X-Received: by 10.66.160.72 with SMTP id xi8mr1724579pab.78.1476145313112;
        Mon, 10 Oct 2016 17:21:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id bx5sm538934pad.6.2016.10.10.17.21.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/28] attr: expose validity check for attribute names
Date:   Mon, 10 Oct 2016 17:21:04 -0700
Message-Id: <20161011002115.23312-18-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
index 90dbacd..6e3bd25 100644
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
+	return -1;
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
2.10.1.382.ga23ca1b.dirty

