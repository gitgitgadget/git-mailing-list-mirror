Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C685E1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbcLHS7j (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:39 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32951 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbcLHS7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:38 -0500
Received: by mail-pg0-f51.google.com with SMTP id 3so176787271pgd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VVE4aG3NleYs5frTk2wOQ2KmuOCYp+OTo4NFLalXx24=;
        b=h6pFazL66gIhWFHtmYStwMJsBzx2zt5K9RNIWhUtvC73xZfQiXnNIXv2ImJpIuPHTH
         Pib5JrJH70Aqo26vPtgzzJlvsv5zTJFiAnhy+SlCQsqpYX4R20bVPIuq7yQGbO+H8UUZ
         dvEM4zPMaePqb+K5gwuYPzVXrC1nvGTP3et7Dpj4QLW88IFFZj/2RU87pUKrebo3c73u
         sqWIwAjEGP+vFGlp6IsKh3R/idCvQlWyHcskJWyBNk87iECmiNBzNEXEKrMqKBVb28ka
         c9oRt1yBP+op9g/4iiS1IWlFxlitIcJuq8g0085gPsK0CRsmbqU/Gr0z9o4npXmdpw96
         U2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VVE4aG3NleYs5frTk2wOQ2KmuOCYp+OTo4NFLalXx24=;
        b=WfclMY8+5z+/vV8Gb6sbcqS5QifDmwrXcqq5SE0FNsHTgP4r5lYO3C+hhkpJ+rzPG8
         S4kK/M5hs/oh76KnJRD9LFcN8MdlQ2ivbaj4CJBryUFkK5f/HqjSCLWRQxpGAIAL0pjW
         qfLCPOm839VhXYBARGKjso7aSN8N2EfqzWrehs3ONYVQR12c6WvKU0FUVlR3Yb/QAP6k
         tK9FioKMXRO1lwwHzKbxDVC2KkFKXld/9r4pW/yXpJD4HX02K4ack1TvAwwqz1e9459D
         mcsYv0Nxq2wxMt+1y7BlqRDaNKybHhCIj8jlS0/sxZYuM6I/6FqZ4U/dcewA5/7kiVeE
         XUXQ==
X-Gm-Message-State: AKaTC01QZ6PMlNk4Nej75ICSEcisqZACtjvcCGNF5S6ebqhK4ec91qkvdkgdE5TlV7SvUZp6
X-Received: by 10.98.157.148 with SMTP id a20mr76926091pfk.1.1481223577157;
        Thu, 08 Dec 2016 10:59:37 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 09/16] pathspec: simpler logic to prefix original pathspec elements
Date:   Thu,  8 Dec 2016 10:59:03 -0800
Message-Id: <1481223550-65277-10-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The logic used to prefix an original pathspec element with 'prefix'
magic is more general purpose and can be used for more than just short
magic.  Remove the extra code paths and rename 'prefix_short_magic' to
'prefix_magic' to better indicate that it can be used in more general
situations.

Also, slightly change the logic which decides when to prefix the
original element in order to prevent a pathspec of "." from getting
converted to "" (empty string).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index a360193..49adea4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -74,13 +74,12 @@ static struct pathspec_magic {
 	{ PATHSPEC_EXCLUDE, '!', "exclude" },
 };
 
-static void prefix_short_magic(struct strbuf *sb, int prefixlen,
-			       unsigned short_magic)
+static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
 {
 	int i;
 	strbuf_addstr(sb, ":(");
 	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
-		if (short_magic & pathspec_magic[i].bit) {
+		if (magic & pathspec_magic[i].bit) {
 			if (sb->buf[sb->len - 1] != '(')
 				strbuf_addch(sb, ',');
 			strbuf_addstr(sb, pathspec_magic[i].name);
@@ -109,8 +108,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	static int glob_global = -1;
 	static int noglob_global = -1;
 	static int icase_global = -1;
-	unsigned magic = 0, short_magic = 0, global_magic = 0;
-	const char *copyfrom = elt, *long_magic_end = NULL;
+	unsigned magic = 0, element_magic = 0, global_magic = 0;
+	const char *copyfrom = elt;
 	char *match;
 	int i, pathspec_prefix = -1;
 
@@ -164,7 +163,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 				if (strlen(pathspec_magic[i].name) == len &&
 				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
-					magic |= pathspec_magic[i].bit;
+					element_magic |= pathspec_magic[i].bit;
 					break;
 				}
 				if (starts_with(copyfrom, "prefix:")) {
@@ -183,7 +182,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		}
 		if (*copyfrom != ')')
 			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
-		long_magic_end = copyfrom;
 		copyfrom++;
 	} else {
 		/* shorthand */
@@ -196,7 +194,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 				break;
 			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
 				if (pathspec_magic[i].mnemonic == ch) {
-					short_magic |= pathspec_magic[i].bit;
+					element_magic |= pathspec_magic[i].bit;
 					break;
 				}
 			if (ARRAY_SIZE(pathspec_magic) <= i)
@@ -207,7 +205,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 			copyfrom++;
 	}
 
-	magic |= short_magic;
+	magic |= element_magic;
 
 	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
@@ -242,18 +240,13 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	 * Prefix the pathspec (keep all magic) and assign to
 	 * original. Useful for passing to another command.
 	 */
-	if (flags & PATHSPEC_PREFIX_ORIGIN) {
+	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
+	    prefixlen && !literal_global) {
 		struct strbuf sb = STRBUF_INIT;
-		if (prefixlen && !literal_global) {
-			/* Preserve the actual prefix length of each pattern */
-			if (short_magic)
-				prefix_short_magic(&sb, prefixlen, short_magic);
-			else if (long_magic_end) {
-				strbuf_add(&sb, elt, long_magic_end - elt);
-				strbuf_addf(&sb, ",prefix:%d)", prefixlen);
-			} else
-				strbuf_addf(&sb, ":(prefix:%d)", prefixlen);
-		}
+
+		/* Preserve the actual prefix length of each pattern */
+		prefix_magic(&sb, prefixlen, element_magic);
+
 		strbuf_addstr(&sb, match);
 		item->original = strbuf_detach(&sb, NULL);
 	} else {
-- 
2.8.0.rc3.226.g39d4020

