Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A975A1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760674AbdACSxH (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:53:07 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34240 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbdACSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:53:06 -0500
Received: by mail-pg0-f44.google.com with SMTP id y62so165503887pgy.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fCMVqDu1N982RtNaIA8uEvl/y5dgUVKZf+wNHLvuETw=;
        b=QN09x4k2MhsCt/XXRewdH9jxpxX4pFMsp1wHUNkH6Ez3aDMtv+7WnMo2W+NWQ7gjp1
         1DQ12P+A6p6SLAVdwnC/iKzCpiG+qQ13fccR7b50QvAhnXh2DMQYm71+29gZndi2cpx/
         U8VQlVyFRY60ZyMOBv5anA9My8nf/9Va2WIfFeAr37QXqqglSTDFIJnajq/p1Mc+sX/c
         YONBI2seZ4WnpSqdUbKZAozYtpxi0C81i2H/zBAJpmxaBrajJJisEXy6se/7XhbvqToE
         dHV5O/BamwcHS7dG5mfSJ5GMgsRbjyXrmeAlszzVAxCrA4AJfGErPNzbuzgyqZ0eGShU
         SDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fCMVqDu1N982RtNaIA8uEvl/y5dgUVKZf+wNHLvuETw=;
        b=p4VgfAb0U6r5fis478yAPNviUzInVvW3A9NuaVJJWaoLs/15QztuJpXRxwDuagM7g4
         rksYLW/Ybzop7pHgBIxIGMsMpS7yZGSrAk1uAWC8VqlruuYaB12Bcz5ybS1XU81QFgmR
         vxqRt5WDOSig8XPr0LzhIqy370s9FMUoET6iuZvAxj6hRYGoH8dXV3dNZqXcdzMsbsch
         SaRm+opL2faFPdLbwEU+vY0AwwWmm4kaw2zt6BIG8VZQ1tcxhfUb68tpk63jW1aefSpa
         xUT1vhxfHO2JwGqBudrEfBa+RxFkG1nXG1hzibHyJBSm2M7emvuWBcIhuE9pAQpF1h0/
         eb4Q==
X-Gm-Message-State: AIkVDXIutifopPc72Re7qdyiNMY8k25jl4RiBQHNetbjo6igc5ODTT4xxBEkVeGhnnTqwT9v
X-Received: by 10.84.129.111 with SMTP id 102mr140183753plb.103.1483468998804;
        Tue, 03 Jan 2017 10:43:18 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 13/16] pathspec: create parse_element_magic helper
Date:   Tue,  3 Jan 2017 10:42:38 -0800
Message-Id: <20170103184241.128409-14-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for the magic in a pathspec element
into its own function.

Also avoid calling into the parsing functions when
`PATHSPEC_LITERAL_PATH` is specified since it causes magic to be
ignored and all paths to be treated as literals.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index f1439f6f9..fe811a0a4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -245,6 +245,19 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 	return pos;
 }
 
+static const char *parse_element_magic(unsigned *magic, int *prefix_len,
+				       const char *elem)
+{
+	if (elem[0] != ':' || get_literal_global())
+		return elem; /* nothing to do */
+	else if (elem[1] == '(')
+		/* longhand */
+		return parse_long_magic(magic, prefix_len, elem);
+	else
+		/* shorthand */
+		return parse_short_magic(magic, elem);
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -267,26 +280,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	char *match;
 	int i, pathspec_prefix = -1;
 
-	if (elt[0] != ':' || get_literal_global() ||
-	    (flags & PATHSPEC_LITERAL_PATH)) {
-		; /* nothing to do */
-	} else if (elt[1] == '(') {
-		/* longhand */
-		copyfrom = parse_long_magic(&element_magic,
-					    &pathspec_prefix,
-					    elt);
-	} else {
-		/* shorthand */
-		copyfrom = parse_short_magic(&element_magic, elt);
-	}
-
-	magic |= element_magic;
-
 	/* PATHSPEC_LITERAL_PATH ignores magic */
-	if (flags & PATHSPEC_LITERAL_PATH)
+	if (flags & PATHSPEC_LITERAL_PATH) {
 		magic = PATHSPEC_LITERAL;
-	else
+	} else {
+		copyfrom = parse_element_magic(&element_magic,
+					       &pathspec_prefix,
+					       elt);
+		magic |= element_magic;
 		magic |= get_global_magic(element_magic);
+	}
 
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
-- 
2.11.0.390.gc69c2f50cf-goog

