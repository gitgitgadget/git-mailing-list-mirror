Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E9C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 08:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjBJIAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 03:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjBJIAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 03:00:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4D7B3A2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 00:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36B17B82363
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 08:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A33C433D2;
        Fri, 10 Feb 2023 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676015999;
        bh=rE6wm1oneRdufQEVVXdEtozNifnldSeApKYLiaYlgy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khrIoVRVWe3AH3RSlmecvGJyP9mqrQKyBOJ7S6e5ctWHAzcdDxM5h9BufBzJ3UiQL
         mB1SN8R0ySJOfw+tSbPMyXNfN4CyWutsXEqDyFy8rpiHIvxFAD2qzMg3rD0kSbQ1LW
         XH+gTGfGDSmUJ5VpGUXIcpQ8lGzETXqtQrBTTbBJ2WuyTL8R+7LCT3EOJMzV0jdh4A
         21VenrqxIrg3K1J5zxTDGpgd9Ruu7sqB8e7iUY5kh5KwU/VGqzcuXBy42W0Dpi/faS
         jJt6N2oj9aAdaS5cB3lhumgM4FC/47IAkIjFiBfU3OrFXYRvSFAXoKTYNxgPLSfi7c
         XItn375zV/s5Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/5] wildmatch: use char instead of uchar
Date:   Fri, 10 Feb 2023 16:59:38 +0900
Message-Id: <20230210075939.44949-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210075939.44949-1-masahiroy@kernel.org>
References: <20230210075939.44949-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dowild() casts (char *) and (uchar *) back-and-forth, which is
ugly.

This file was imported from rsync, which started to use (unsigned char)
since the following commit:

 | commit e11c42511903adc6d27cf1671cc76fa711ea37e5
 | Author: Wayne Davison <wayned@samba.org>
 | Date:   Sun Jul 6 04:33:54 2003 +0000
 |
 |     - Added [:class:] handling to the character-class code.
 |     - Use explicit unsigned characters for proper set checks.
 |     - Made the character-class code honor backslash escapes.
 |     - Accept '^' as a class-negation character in addition to '!'.

Perhaps, it was needed because rsync relies on is*() from <ctypes.h>.

GIT has its own implementations, so the behavior is clear.

In fact, commit 4546738b58a0 ("Unlocalized isspace and friends")
says one of the motivations is "we want the right signed behaviour".

sane_istest() casts the given character to (unsigned char) anyway
before sane_ctype[] table lookup, so dowild() can use 'char'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 wildmatch.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 93800b8eac..7dffd783cb 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -12,21 +12,19 @@
 #include "cache.h"
 #include "wildmatch.h"
 
-typedef unsigned char uchar;
-
 #define CC_EQ(class, len, litmatch) ((len) == sizeof (litmatch)-1 \
 				    && *(class) == *(litmatch) \
-				    && strncmp((char*)class, litmatch, len) == 0)
+				    && strncmp(class, litmatch, len) == 0)
 
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text, unsigned int flags)
+static int dowild(const char *p, const char *text, unsigned int flags)
 {
-	uchar p_ch;
-	const uchar *pattern = p;
+	char p_ch;
+	const char *pattern = p;
 
 	for ( ; (p_ch = *p) != '\0'; text++, p++) {
 		int matched, match_slash, negated;
-		uchar t_ch, prev_ch;
+		char t_ch, prev_ch;
 		if ((t_ch = *text) == '\0' && p_ch != '*')
 			return WM_ABORT_ALL;
 		if ((flags & WM_CASEFOLD) && isupper(t_ch))
@@ -50,7 +48,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 			continue;
 		case '*':
 			if (*++p == '*') {
-				const uchar *prev_p = p - 2;
+				const char *prev_p = p - 2;
 				while (*++p == '*') {}
 				if (!(flags & WM_PATHNAME))
 					/* without WM_PATHNAME, '*' == '**' */
@@ -90,10 +88,10 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 				 * with WM_PATHNAME matches the next
 				 * directory
 				 */
-				const char *slash = strchr((char*)text, '/');
+				const char *slash = strchr(text, '/');
 				if (!slash)
 					return WM_NOMATCH;
-				text = (const uchar*)slash;
+				text = slash;
 				/* the slash is consumed by the top-level for loop */
 				break;
 			}
@@ -160,13 +158,13 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					if (t_ch <= p_ch && t_ch >= prev_ch)
 						matched = 1;
 					else if ((flags & WM_CASEFOLD) && islower(t_ch)) {
-						uchar t_ch_upper = toupper(t_ch);
+						char t_ch_upper = toupper(t_ch);
 						if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)
 							matched = 1;
 					}
 					p_ch = 0; /* This makes "prev_ch" get set to 0. */
 				} else if (p_ch == '[' && p[1] == ':') {
-					const uchar *s;
+					const char *s;
 					int i;
 					for (s = p += 2; (p_ch = *p) && p_ch != ']'; p++) {} /*SHARED ITERATOR*/
 					if (!p_ch)
@@ -237,5 +235,5 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text, unsigned int flags)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text, flags);
+	return dowild(pattern, text, flags);
 }
-- 
2.34.1

