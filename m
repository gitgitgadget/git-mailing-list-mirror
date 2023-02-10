Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9CC636D3
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 07:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjBJH76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 02:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjBJH74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 02:59:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEED36690
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 23:59:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E5A61CC5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14A8C433D2;
        Fri, 10 Feb 2023 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676015994;
        bh=QBeh0AjD35U+fbGt2LkueHP4CzO0EUrItIQSSHO5/7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEU18huJdXQ6iXQG+VPFo8hjA9XdsYR+TS4UUgGcpLK/XA6Igx6Emu8cw6m6WmNm6
         irjYj7jHLUQw7sM3YG0JCLYORVPv1e+azZWzW6RQcHhfH9mcAWIoFexgFKmMsZk7HE
         DSuor7G3FnDtEHqdyQ/K9qmVCPM06YkpFxpiB+ss50SsYB2N7uOOxRLOPWTZkwgd0k
         Ss0eJUDmqT3TeNloBifBHvbBkTx+sTTzbD195QzN1ATcYDi4cRmJvK8hzVVyMkqE0G
         YaPcg8CtXFW2vFlfp3VBDfyLOgF+L5R4a9tyW69sMOc4KpvVXSVMtAAvS2jk1N4nGI
         WLFsxyY0qjTVA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/5] wildmatch: remove IS*() macros
Date:   Fri, 10 Feb 2023 16:59:36 +0900
Message-Id: <20230210075939.44949-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210075939.44949-1-masahiroy@kernel.org>
References: <20230210075939.44949-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This file was imported from rsync, which has some compatibility
layer because it relies on <ctypes.h> in C standard library.

In contrast, GIT has its own implementations in git-compat-util.h.

[1] isprint, isgraph

   They check the given char range in an obvious way

[2] isspace, isblank, isdigit, isalpha, isalnum, islower, isupper,
    iscntr, ispunct

   They look up sane_ctype[], which fills the range 0x80-0xff with 0.

[3] isxdigit

   It looks up hexval_table[], which fills the range 0x80-0xff with -1.

For all of these, ISACII() is a redundant check.

Remove IS*() macros, and directly use is*() in dowild().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 wildmatch.c | 55 ++++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 85c4c7f8a7..a510b3fd23 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -22,25 +22,6 @@ typedef unsigned char uchar;
 				    && *(class) == *(litmatch) \
 				    && strncmp((char*)class, litmatch, len) == 0)
 
-#if defined STDC_HEADERS || !defined isascii
-# define ISASCII(c) 1
-#else
-# define ISASCII(c) isascii(c)
-#endif
-
-#define ISBLANK(c) (ISASCII(c) && isblank(c))
-#define ISGRAPH(c) (ISASCII(c) && isgraph(c))
-#define ISPRINT(c) (ISASCII(c) && isprint(c))
-#define ISDIGIT(c) (ISASCII(c) && isdigit(c))
-#define ISALNUM(c) (ISASCII(c) && isalnum(c))
-#define ISALPHA(c) (ISASCII(c) && isalpha(c))
-#define ISCNTRL(c) (ISASCII(c) && iscntrl(c))
-#define ISLOWER(c) (ISASCII(c) && islower(c))
-#define ISPUNCT(c) (ISASCII(c) && ispunct(c))
-#define ISSPACE(c) (ISASCII(c) && isspace(c))
-#define ISUPPER(c) (ISASCII(c) && isupper(c))
-#define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
-
 /* Match pattern "p" against "text" */
 static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 {
@@ -52,9 +33,9 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 		uchar t_ch, prev_ch;
 		if ((t_ch = *text) == '\0' && p_ch != '*')
 			return WM_ABORT_ALL;
-		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
+		if ((flags & WM_CASEFOLD) && isupper(t_ch))
 			t_ch = tolower(t_ch);
-		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+		if ((flags & WM_CASEFOLD) && isupper(p_ch))
 			p_ch = tolower(p_ch);
 		switch (p_ch) {
 		case '\\':
@@ -133,11 +114,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 				 */
 				if (!is_glob_special(*p)) {
 					p_ch = *p;
-					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+					if ((flags & WM_CASEFOLD) && isupper(p_ch))
 						p_ch = tolower(p_ch);
 					while ((t_ch = *text) != '\0' &&
 					       (match_slash || t_ch != '/')) {
-						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
+						if ((flags & WM_CASEFOLD) && isupper(t_ch))
 							t_ch = tolower(t_ch);
 						if (t_ch == p_ch)
 							break;
@@ -186,7 +167,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					}
 					if (t_ch <= p_ch && t_ch >= prev_ch)
 						matched = 1;
-					else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
+					else if ((flags & WM_CASEFOLD) && islower(t_ch)) {
 						uchar t_ch_upper = toupper(t_ch);
 						if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)
 							matched = 1;
@@ -208,42 +189,42 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 						continue;
 					}
 					if (CC_EQ(s,i, "alnum")) {
-						if (ISALNUM(t_ch))
+						if (isalnum(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "alpha")) {
-						if (ISALPHA(t_ch))
+						if (isalpha(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "blank")) {
-						if (ISBLANK(t_ch))
+						if (isblank(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "cntrl")) {
-						if (ISCNTRL(t_ch))
+						if (iscntrl(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "digit")) {
-						if (ISDIGIT(t_ch))
+						if (isdigit(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "graph")) {
-						if (ISGRAPH(t_ch))
+						if (isgraph(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "lower")) {
-						if (ISLOWER(t_ch))
+						if (islower(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "print")) {
-						if (ISPRINT(t_ch))
+						if (isprint(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "punct")) {
-						if (ISPUNCT(t_ch))
+						if (ispunct(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "space")) {
-						if (ISSPACE(t_ch))
+						if (isspace(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "upper")) {
-						if (ISUPPER(t_ch))
+						if (isupper(t_ch))
 							matched = 1;
-						else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch))
+						else if ((flags & WM_CASEFOLD) && islower(t_ch))
 							matched = 1;
 					} else if (CC_EQ(s,i, "xdigit")) {
-						if (ISXDIGIT(t_ch))
+						if (isxdigit(t_ch))
 							matched = 1;
 					} else /* malformed [:class:] string */
 						return WM_ABORT_ALL;
-- 
2.34.1

