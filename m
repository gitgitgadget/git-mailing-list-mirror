Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E22520756
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966052AbdADSE5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:57 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34138 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761461AbdADSEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:33 -0500
Received: by mail-pf0-f176.google.com with SMTP id 127so3487121pfg.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ajV2ZIfW6M9k8iMUQ5pJHJSboV41qrlEATNUEaOMMSo=;
        b=DKBfnMYNzzMFR8yNMegCBjT1LpgXKGiXbx2BYMDzvszCPb0faxPxUauu2PHuDfF3fL
         7CDpKtbDLwDkb3InjXbSV0W0gtouZhGmH+Pny3ctN2ewaUWodEd7O+85iEEiz8UJy1ba
         N6px+9YVoTvH1oJrnPlnmkcgist23Bf2g66X/uA1pDe9r4+FVRj00rnYU2zGEVRMRNg9
         JR/1y5aBgKLBhYSj8tmmpmHJcspGsW7BxiFdsvmQ3zKb/zFe4Mthksv3iQUTU5d6dp88
         8eZUcnVdm0spNJrC8mAV0KHFt5UFXe5oF3DEewqDjFeplcRLzIVHogvmjJZgYcsAmGBI
         JNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajV2ZIfW6M9k8iMUQ5pJHJSboV41qrlEATNUEaOMMSo=;
        b=GMxuWnDDj1E71OOFLw+TwEhITNz+CwicxTaXRUZYhvO9qcvZT0HKSCFDnEpBGj2URL
         SrIzjUrg8EahhBpRkQRL1bNyvZ9zVneLAsutt7VM9Mii1zo30JQVNbbbf2lZZ443ZhfY
         qyhtuzdQxEdWZmee3QvqTSSwA1z8U7eu9NSEJM+SVImnq+SjMtkZ/VEHUloWoenbVTm+
         AKoLOUehfzQEmLy+q62UP5PqR5bQ6vKoeUcDt6k4V8PFBXCLEAmmxWdyM1WLOc/SAWm/
         6iFRJLgAhI9H+rBReJtQeLT+zvCUCVuzjpqCnmSO/Go7oe5NXHRFZrvRln1En4SxvZKY
         Zrmw==
X-Gm-Message-State: AIkVDXLgGs+v8N+bTxfu0ROKPd2/pTuavnL/J8bQq579sMnmrAmnIgh7UqYJlrO/lFcLR9yF
X-Received: by 10.99.189.26 with SMTP id a26mr125899145pgf.67.1483553072164;
        Wed, 04 Jan 2017 10:04:32 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:31 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 09/16] pathspec: simpler logic to prefix original pathspec elements
Date:   Wed,  4 Jan 2017 10:04:04 -0800
Message-Id: <20170104180411.150000-10-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
index 5df364bc6..af7f2d01d 100644
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
2.11.0.390.gc69c2f50cf-goog

