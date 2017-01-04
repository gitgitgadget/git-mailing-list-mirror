Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BBE120754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965656AbdADSEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:49 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35233 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761465AbdADSEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:40 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so83049366pfk.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZxHZ4kz/NNOVHLczrxmMfrgHD+M6wRN+UL/wI61Bew=;
        b=tu6oD/WfvUwQi2X6xDrUL8/om8zOHNT4oL3j3kGPjfBZG7WSqW45XfXfEeVSxDRYId
         gGqFo/Qh+j4iA0dENUCnTEQ0Dim02msKXv/SaDh4ncii3Xzg/oqOGX25ob9HV405cDdM
         PwPSxJj7XKSxCqVCNMUy/PBOJWOtikmlGbvD1uw4VrwY+hzofEzYoyCpBQwq6OF0hG75
         iYEETAAhmpkGtNopEIlrK48CKa38oS1sD0HWwNrsB+I32QD/RQUdoXazY6HDESfgwLUo
         iskpVVHlMRSlpK7Qg/sU2KiB4ur4AXKqFXd9PnmXUL6rBXaaP4GoPIxREbZyQcCXhe0M
         EK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XZxHZ4kz/NNOVHLczrxmMfrgHD+M6wRN+UL/wI61Bew=;
        b=F2V/8gf1pUIH3aTVk8kS+ghenyr2YN7O2NNmtDhQk1SSIWGjwjtZ2U8dEJ61SZ81gP
         3vZbfZ9D4x8VD4Siy20+WMG/dPp2zRNlsuNw33Ln+ylO6LuLw6RG1347WooRQTXo5R9D
         8bjgtoR6GZEQCQtWps167nCpzZ+XQk+4wQi62Cj+RCFbEwQ1n0gVwEbq+ypBGuz6Y7EC
         sJKxSjz96bbsXi5qPGIL25VlaUsuLKJZW6ScXjTlQRuYndwSs7yU+X6xvxB/mXjH6jV2
         NDn34qFRHrlw3jt1FPdmQzHOeSy0qwmA5Rx9L1DQNyuvmiwCtQv5usgZnp+RJoIRhpNT
         EeXw==
X-Gm-Message-State: AIkVDXLhYM2dQZ7vjrTOqtRbIOPsuIDrfK9kJkNTEDLTemUBy0nyr4RHNlA9kAB3m32daKh8
X-Received: by 10.84.217.70 with SMTP id e6mr147841272plj.161.1483553079504;
        Wed, 04 Jan 2017 10:04:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 13/16] pathspec: create parse_element_magic helper
Date:   Wed,  4 Jan 2017 10:04:08 -0800
Message-Id: <20170104180411.150000-14-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
index f6356bde1..00fcae4e1 100644
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

