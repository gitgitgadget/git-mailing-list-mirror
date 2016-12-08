Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11D21FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbcLHS7r (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:47 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32963 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbcLHS7n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:43 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so176787956pgd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRUp/tDa0jR+bk6RlUlEKYdMfk0sZ+D0t1h8Jsh+wNA=;
        b=OdI13zTskEMez5vDB5BHUkpxhubDV4Qh1zbJDZ2jFr02vjuhOtzGt82tv7L+4RzH18
         OnSUCTnAi6EUI3Mtg6J4PJAoGG4yjECP+ftbCMCazalITtFgwIyWHM+WvwRtIT6cweS7
         ca/uf+XGjxz8z8u2d9RkHnyw83cSH86CGM6MS/kKs0ObSW0zz18jRntjovWJLxabV7h5
         ZWMh6TpI00pTYhim4U0Dpvg4+hfmzKRdSIPYV7Zkg4aIYbTurnhia+gl0uyP+9xSU2YB
         I3M6bicDUe8Bw5h90Bvy/PVHmToy4jCHgjYZpEj1f2jHk78Ge4Zym3SO4d59AvkXleUQ
         7a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRUp/tDa0jR+bk6RlUlEKYdMfk0sZ+D0t1h8Jsh+wNA=;
        b=IWykw9+GoiDrHT49l3ixga5rDpd0Or0YeTfuVRLxWu2QDQfLNrmDy2j5j0otf2jIbi
         GZ6wFS8G8XRVjU9HczFaqkIrg+FSgy252C3gjHQbSnelFqilwIfkR1AlziXYf9n1OUzv
         KdVeUG0LPBOUMAOQ29FEMlWs+7WnOvauFQzI2hFa2Xofcj4rzM1kA0ruHQjxXL3fqXdT
         38HqASk2jPteTyMaddJ7RPlfzVaRt3wgicoXIhNeVmiT5TX7Ihp5XQNc3Y9GWG1H+7Nh
         nuxg2e4Bbc5Qx16xzvPD72u6tK11Zeh6Yix4hF66VbYHvkMJF7FDv1QORit9lIBQVf6N
         TeAw==
X-Gm-Message-State: AKaTC02YBGzsSYcWbt14tOz3dCoEJFxIdI9DcPFMgKy8tIJ5RQixFs6SHJfPCKILkiDSC2i8
X-Received: by 10.99.228.5 with SMTP id a5mr135689434pgi.1.1481223582369;
        Thu, 08 Dec 2016 10:59:42 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:41 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 13/16] pathspec: create parse_element_magic helper
Date:   Thu,  8 Dec 2016 10:59:07 -0800
Message-Id: <1481223550-65277-14-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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
index 6e9555e..f37f887 100644
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
2.8.0.rc3.226.g39d4020

