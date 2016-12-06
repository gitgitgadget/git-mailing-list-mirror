Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB211FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbcLFVxW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:22 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36646 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so72545116pfz.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VuQFA7WsLD4Pde8MwPIn/Q/gIqzMgftfNaTc1X+grWQ=;
        b=KIXe+cien0GCg7qWHzA33g/nHSnHYGbAK6svdprFeJKU1PDx/8MUyxxB/Drc4dP39B
         VuGelMTexbnPruqSZsg5kpbgIqShD6dOD/wJgaQ/hN09gGopFSKUoljWy4mgRe62/poU
         OmBKN1/ybuxhmi+WIAn5jpg38kpvOU8esnkH+NNa+SGXo3coRpchDF9cHPZce9ZB9R+R
         TPh0fozSFqUshNSAAJKgcEKjWTvi+bibxQH1pow3zXuCMTI/5F8dvhzj4Bg12KkgIlS1
         X4kj2zQFCbdN21fB03nAmaYnGM4Tvb9uE92YKv8GAzYQ4ad/i86dOKeb0ojZdKaLq8zr
         69GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VuQFA7WsLD4Pde8MwPIn/Q/gIqzMgftfNaTc1X+grWQ=;
        b=RDH6IbgXgRdy3C1wUYYdB5sdllcURq605hBRBp+oX2IpfiulEIVvOeKrobyqlLDO64
         zaYuEd3wl2ItSHzaWejXWOTKFgiQqdsFk6rqUsW5ddRD/faHV1vWOKl0RYBPvSSX9IwI
         hG7918maU3G4XQ87EfTGBIVeS/gLwq+aZWUNqeUFcHs3pm7S4BAaRcFfe6BHwj8BZHpH
         vHYpIgosXIn9SvugEvG862elmMoMto5zFpy+ffYPNVgt4O5Z/vH1na1kxlyj9XwC43Hj
         Bu+F1QgEDVtDRM5UWGVQZGvvNTTMYYHwtciKPgKEUx7T6BzyDPuew6Gkkm1f7Ad0Vxsx
         +7CQ==
X-Gm-Message-State: AKaTC02o7lj1xsI+RU7BG/zM/kqCJA08E2dOwO0/5uWlO87AYUpl0xQA0ev3aMo1wfy4Hej6
X-Received: by 10.84.210.40 with SMTP id z37mr140829265plh.32.1481061150416;
        Tue, 06 Dec 2016 13:52:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/17] pathspec: simpler logic to prefix original pathspec elements
Date:   Tue,  6 Dec 2016 13:51:39 -0800
Message-Id: <1481061106-117775-11-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
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
index 159f6db..5afebd3 100644
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
@@ -110,8 +109,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	static int glob_global = -1;
 	static int noglob_global = -1;
 	static int icase_global = -1;
-	unsigned magic = 0, short_magic = 0, global_magic = 0;
-	const char *copyfrom = elt, *long_magic_end = NULL;
+	unsigned magic = 0, element_magic = 0, global_magic = 0;
+	const char *copyfrom = elt;
 	char *match;
 	int i, pathspec_prefix = -1;
 
@@ -165,7 +164,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 				if (strlen(pathspec_magic[i].name) == len &&
 				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
-					magic |= pathspec_magic[i].bit;
+					element_magic |= pathspec_magic[i].bit;
 					break;
 				}
 				if (starts_with(copyfrom, "prefix:")) {
@@ -184,7 +183,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		}
 		if (*copyfrom != ')')
 			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
-		long_magic_end = copyfrom;
 		copyfrom++;
 	} else {
 		/* shorthand */
@@ -197,7 +195,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 				break;
 			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
 				if (pathspec_magic[i].mnemonic == ch) {
-					short_magic |= pathspec_magic[i].bit;
+					element_magic |= pathspec_magic[i].bit;
 					break;
 				}
 			if (ARRAY_SIZE(pathspec_magic) <= i)
@@ -208,7 +206,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 			copyfrom++;
 	}
 
-	magic |= short_magic;
+	magic |= element_magic;
 
 	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
@@ -243,18 +241,13 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
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

