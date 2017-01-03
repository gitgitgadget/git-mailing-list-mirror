Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADAE41FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760660AbdACSuL (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:50:11 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35222 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbdACSuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:50:10 -0500
Received: by mail-pg0-f42.google.com with SMTP id i5so152708590pgh.2
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k3wMbOGyAHLf0gt/3aGBwnpvJ7q5wq5fJuuWI44FJQY=;
        b=u/b2Kn3r5Jh8hBdXGC9PI5rBLyo9ej4xwZBbKeDYZx3uxTck9YKn9H16gBlIuxjlrU
         5bXUe6G7VtM+0ykfDZ+LHUrJ5t8wrGKSJcCn18yR/8JeJajNmGsFv+E7CvjEJvNVZ8R4
         fv2EHHLh7cw5EX3YeW4zGOPpGYfQoRG9xe4dUeK6gJNwX0/XZmZF6Qp3AIr/tJRnr1S2
         PdWwLHQZ/Twksc05G0kYT6B7M/0Ng4S+THuVM6xQFlfWjMA07884AFmqYbJHwR1mLQQe
         rhSRbFRvpPaaVCvxRA67A9BEPcY31PWp7HLd3YPHes2S6/T66U+glN/JgbyVRs2cluCg
         igWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k3wMbOGyAHLf0gt/3aGBwnpvJ7q5wq5fJuuWI44FJQY=;
        b=rAg2Ysw59Zjxm50hn4OwIrzob7knt7FEuggCLkv2te1LQyIRrPWUbaGux4MbohCHUY
         NHLO/B4sTMlKdMeSh5BRQWaAIftDnlWbIkNlRCDnYbMdCbheDkU/ha0XxVWEhAdzTNL+
         LkKYe/Pln3fmWMLXm/W9CFBn3iGxlr/yMjn/solV2TNMkcVgvHc1TThGEVAdd7Wo4QGW
         lzQcFuYFEp8S0+pJ8XL0Oiit1jLKFLOAWXjMQhMb/mRgo6MnYy4w/jrYk4pMTCA39lPW
         XxNT7LxYesF/v+wkP6TwYlsXRLGqeWlhe8rufsGb8jfwSjNGNnXr321RDL+6aRn/DXWw
         fT1g==
X-Gm-Message-State: AIkVDXKhiD8ms7Fx1kjCavCArakMucJsntRKRGNKeR3wG8ssHUyV1xea2mtBVbD9PRQiHB+B
X-Received: by 10.99.251.69 with SMTP id w5mr119540767pgj.124.1483468991965;
        Tue, 03 Jan 2017 10:43:11 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:10 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 09/16] pathspec: simpler logic to prefix original pathspec elements
Date:   Tue,  3 Jan 2017 10:42:34 -0800
Message-Id: <20170103184241.128409-10-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
index ee87494c7..032436bc1 100644
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

