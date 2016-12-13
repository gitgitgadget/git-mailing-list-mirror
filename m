Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D83520451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbcLMXQi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:16:38 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36134 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcLMXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:16:31 -0500
Received: by mail-pg0-f45.google.com with SMTP id f188so749091pgc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ced3WYXyWlrcKikFlNorkQTDJ/cQ4qtDMHp503wkVt8=;
        b=UfHLgLg2nbKAjyUUTyNH3DMpn4zDg+HkamXoXiBn6WwCKzvERJEfTFm0s0EU68zlNf
         ezON9AP5fK3oxEpcl2jX74U4d0dPks1OUbu7/1x8SHcxMChSsFqi1CxNFib8nAiFophU
         Jw9HimivzS9PRG1EKsfeEp+uS/n1pNmmzUWBflJj23d+36F8MsoVRqBlyd+VVzj9tirC
         yNTcCc6NdDAltPC0KLH7/rbhA1wOyxGU2zkrtDxd3NsDiv2LQBXfDxl3XFLXEXGUKFwv
         bltexepZmt5j8T+5OIMnHlTp0L/3G4A6JLUnBxT9nweMGTnLr5Ncxu/QddfzcKRks981
         +L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ced3WYXyWlrcKikFlNorkQTDJ/cQ4qtDMHp503wkVt8=;
        b=mtG+qDQDkbkhRp+PikoCYi8sghmhEeKt/L/bZadD3VzLoMX7K5c1LcSmdN6b2dRnER
         lxoEj9oVgmHLSZP+d/KxJnDMJ1ASrhyH8pXXnQnC2HLO+UqK+UAnNYlBDFVzwM0X24AC
         Sl8WjPEOjBXRXcXMRYmQQLquGAbFPvrr8oc54WrKjwXZrQJn4sc4B8yL8KmvRIq+Pzdd
         osmDKxe4BaCCPVj5rc3PDFwVLrA1/Rs2d1aXu5hUjUZWF/TaI/EUNJWkKoSvdVQGqGRe
         oc+NgeJ5OIrMlI3KNHYncmUa94jBTjowdOYzCT6GKriLqd3H6JOVyhKl0Mb1xtlcZAT6
         BpAA==
X-Gm-Message-State: AKaTC01MdvbjqLyxdyokNbW7AodNBNM0F/1zFJ+qTSYJ7s+yIwsjdPPyeKdW/mhN7Z7f8gR2
X-Received: by 10.98.200.8 with SMTP id z8mr102392965pff.176.1481670893660;
        Tue, 13 Dec 2016 15:14:53 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:52 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 09/16] pathspec: simpler logic to prefix original pathspec elements
Date:   Tue, 13 Dec 2016 15:14:23 -0800
Message-Id: <1481670870-66754-10-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
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
index 609c58f..d44f4b6 100644
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

