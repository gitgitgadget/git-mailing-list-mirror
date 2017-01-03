Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027841FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757876AbdACTN0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:13:26 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34448 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757967AbdACTNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:13:25 -0500
Received: by mail-pg0-f48.google.com with SMTP id y62so165679551pgy.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hV2g0UTb7nf+Xa2y5BPQZPDeSGE8h07gg7c+2s7puoc=;
        b=gAXq1+Z5/0Zdh/zG3po5qgCHfckgCkNvd9oA+0xXX7Yv7JvUlgqjh73otaQ3Gx07hM
         CrlTsSm0Z9RKG51Q7nbYYwKrE2o/V2v7qQRI2WP4cYpFmqwU0rOvIS5LiZOUQkIvXz1U
         abamZxkG90hs8PP9NHQqjGPETMnATcxTmUbUeDPqgNUAMXhvW3fUS1rA067QoH2l6hnI
         wLoF4y8lwE4ZgW4CVeTknfUzFSws7himJHqWRrvYIUx70042xMUOKX3kM2/uQvm4aWXr
         btszCZbW8uIYLULmTrzZpNShhj2MgVi4cT6kLWAqYO4eOKBB51VCA4V1JxAuVTGfib3d
         k9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hV2g0UTb7nf+Xa2y5BPQZPDeSGE8h07gg7c+2s7puoc=;
        b=lxorPsJ0E+9OMB2HVaHgpyYLbFVuThd6N1C2XMJnbqX8oRvjxC9RrCWGSPo81iYhOr
         9y6EoLTGb5czCQfs6DB+nYNRfalpn+oCPk+Ozl3Trz3Pd4RjhtUtrSQFBShniNourBq7
         7bhcfbV1RX1CCZOfgbPZAe/IZxnyFcXeDn40q9GAvTM1hQp88dgRW7zisQ5GrrEbnbcz
         JIAt2fAEp09MEnfNu/LmUmbMrkdFr78qHO19CA8QC6un5iVVHKHmz06Xt0FLVSXgiujl
         pPeXG3Fja+Kj7YUNfRhMfePgc+MQpq2r3/jfAwTyPo72FOz8+xaGWK5oE+4ZtaocBZah
         alHA==
X-Gm-Message-State: AIkVDXLyG6rvisA9mDYctDzSJFvVYjIvAGnpubpNGD8Cys5yd7ZE5msbn5pZHw2OQCHFqfUr
X-Received: by 10.99.164.9 with SMTP id c9mr118786003pgf.141.1483468997329;
        Tue, 03 Jan 2017 10:43:17 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:16 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 12/16] pathspec: create parse_long_magic function
Date:   Tue,  3 Jan 2017 10:42:37 -0800
Message-Id: <20170103184241.128409-13-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for parsing long magic into its own
function.  As well as hoist the prefix check logic outside of the inner
loop as there isn't anything that needs to be done after matching
"prefix:".

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 92 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 8574010d5..f1439f6f9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -157,6 +157,60 @@ static int get_global_magic(int element_magic)
 }
 
 /*
+ * Parse the pathspec element looking for long magic
+ *
+ * saves all magic in 'magic'
+ * if prefix magic is used, save the prefix length in 'prefix_len'
+ * returns the position in 'elem' after all magic has been parsed
+ */
+static const char *parse_long_magic(unsigned *magic, int *prefix_len,
+				    const char *elem)
+{
+	const char *pos;
+	const char *nextat;
+
+	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
+		size_t len = strcspn(pos, ",)");
+		int i;
+
+		if (pos[len] == ',')
+			nextat = pos + len + 1; /* handle ',' */
+		else
+			nextat = pos + len; /* handle ')' and '\0' */
+
+		if (!len)
+			continue;
+
+		if (starts_with(pos, "prefix:")) {
+			char *endptr;
+			*prefix_len = strtol(pos + 7, &endptr, 10);
+			if (endptr - pos != len)
+				die(_("invalid parameter for pathspec magic 'prefix'"));
+			continue;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if (strlen(pathspec_magic[i].name) == len &&
+			    !strncmp(pathspec_magic[i].name, pos, len)) {
+				*magic |= pathspec_magic[i].bit;
+				break;
+			}
+		}
+
+		if (ARRAY_SIZE(pathspec_magic) <= i)
+			die(_("Invalid pathspec magic '%.*s' in '%s'"),
+			    (int) len, pos, elem);
+	}
+
+	if (*pos != ')')
+		die(_("Missing ')' at the end of pathspec magic in '%s'"),
+		    elem);
+	pos++;
+
+	return pos;
+}
+
+/*
  * Parse the pathspec element looking for short magic
  *
  * saves all magic in 'magic'
@@ -218,41 +272,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		; /* nothing to do */
 	} else if (elt[1] == '(') {
 		/* longhand */
-		const char *nextat;
-		for (copyfrom = elt + 2;
-		     *copyfrom && *copyfrom != ')';
-		     copyfrom = nextat) {
-			size_t len = strcspn(copyfrom, ",)");
-			if (copyfrom[len] == ',')
-				nextat = copyfrom + len + 1;
-			else
-				/* handle ')' and '\0' */
-				nextat = copyfrom + len;
-			if (!len)
-				continue;
-			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
-				if (strlen(pathspec_magic[i].name) == len &&
-				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
-					element_magic |= pathspec_magic[i].bit;
-					break;
-				}
-				if (starts_with(copyfrom, "prefix:")) {
-					char *endptr;
-					pathspec_prefix = strtol(copyfrom + 7,
-								 &endptr, 10);
-					if (endptr - copyfrom != len)
-						die(_("invalid parameter for pathspec magic 'prefix'"));
-					/* "i" would be wrong, but it does not matter */
-					break;
-				}
-			}
-			if (ARRAY_SIZE(pathspec_magic) <= i)
-				die(_("Invalid pathspec magic '%.*s' in '%s'"),
-				    (int) len, copyfrom, elt);
-		}
-		if (*copyfrom != ')')
-			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
-		copyfrom++;
+		copyfrom = parse_long_magic(&element_magic,
+					    &pathspec_prefix,
+					    elt);
 	} else {
 		/* shorthand */
 		copyfrom = parse_short_magic(&element_magic, elt);
-- 
2.11.0.390.gc69c2f50cf-goog

