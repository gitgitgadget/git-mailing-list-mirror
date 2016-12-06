Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C9F1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbcLFVxh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:37 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34034 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so153560925pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxW53DFO8HhBRi2SriKCaWl2xu6JkmikixoQCwPXGMY=;
        b=ZyRGPD6dQcw7psrLyGXR5WTeowGK92fcQl6UGOGirvAtCX76Z2dtJlJqEUisB1mlGz
         dYG9BYigmUBw5P0VM3jAgSZRU39wsJkr/6zr/BoImQeKKkxGrmttUttnEz9PCywpyKzr
         2VmqTr+1FOzCStgPSLtmh884Xld+FnKjX/MEwIF0k9iI4xDUyp/VqdBa2nwrN2bz+JUr
         Iu4H9eU4SYDyoqLH3ZwcHM8kFXiTIaOKbSPqSoGRJ3GoOXoHo7OTiGOr+7KsdLQehRmO
         GXx/wRlxrH4FYzcb6wbM4GuD20orFOvm/1rxeEtjNtehvm7rOymAAAC+q7PzHGvzM36w
         Stog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RxW53DFO8HhBRi2SriKCaWl2xu6JkmikixoQCwPXGMY=;
        b=ha433qbYWbSVa9JtH74JT8yy9HIwZrKrIxILQSQffDUMp4v80S8BSfk/bWWIZ6v8qE
         HXOw40NdXhSdwTofZG0Mao09BrJA4bECv4rCNhNsjYlyE75Vv4hyCvjKqVDFlkReVpWO
         uvkwEURJNpqYWzGNxijsZLxx7q2WJN86IS15MJMqTAdo/wK70Gc7STHQZZosRszxl2r0
         nao1IPVMk8AhmhKM/4hitKl/QvwGlDfjzHjRIKqtLMheLcYGLbVvN0Vsq3Xp7/y091pc
         vzFH4Lj7zGaDgVk8Bw14/6r5wkF5eU4pHZUVmrw9kdferiTOGicHhEOFFe0vUNTN8//0
         wAmw==
X-Gm-Message-State: AKaTC00uNHgpxGHySZNI/7r3B2LIFiXJ/cMxewzAWT2vtADYEfmjvy8ecpNZVgjYluY9Bkma
X-Received: by 10.99.49.213 with SMTP id x204mr114428749pgx.92.1481061155828;
        Tue, 06 Dec 2016 13:52:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/17] pathspec: create parse_element_magic helper
Date:   Tue,  6 Dec 2016 13:51:43 -0800
Message-Id: <1481061106-117775-15-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
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
 pathspec.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 1d28679..793caf1 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -244,6 +244,19 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
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
@@ -267,24 +280,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
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
-	if (!(flags & PATHSPEC_LITERAL_PATH))
+	if (!(flags & PATHSPEC_LITERAL_PATH)) {
+		copyfrom = parse_element_magic(&element_magic,
+					       &pathspec_prefix,
+					       elt);
+		magic |= element_magic;
 		magic |= get_global_magic(element_magic);
+	}
 
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
-- 
2.8.0.rc3.226.g39d4020

