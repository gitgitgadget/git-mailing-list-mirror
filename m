Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D7C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 07:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjBJH74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 02:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjBJH7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 02:59:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01628367C0
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 23:59:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ABEE61CCE
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA334C4339C;
        Fri, 10 Feb 2023 07:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676015993;
        bh=4u+CEUu4+EAp39zR3tPvywvv6LT92LeKzADwrVSgELI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xa3mvHIak7W/cwOkvSDTfL8qvOrNtWhFjV/QPtytwjQAF8Ndp12fzFRkUyroTxVzd
         FvcldrGxE7RiW2QXO8qpTmBeK5o1GucwruPT2Z6p9Bu/EKxg2BCFFeQYqwaE+tdC7f
         jK3bz3BbZ8Z09FEBlhjEwDSDmeBHAG59vMYDlZDIsTV5SbG+x2T+uIPyzkPOJKybkJ
         jWKbA9ZwKNVUxingDcAM/QNo0zfpkbJo4N9pu5Pui21ufU34ZnjuXKoeW4n5FyMG/6
         Ph5mp/234gwPV8bNMNMi0c1aRBxyUEU3K21aODYzD6nxaeeCycU7CK19oYE93TBZVS
         iHs2glW9o2lRA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
Date:   Fri, 10 Feb 2023 16:59:35 +0900
Message-Id: <20230210075939.44949-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210075939.44949-1-masahiroy@kernel.org>
References: <20230210075939.44949-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-compat-util.h implements most of is*() macros.

Add isblank() and isgraph(), which are useful to clean up wildmatch.c
in a consistent way (in this and later commits).

Use them with care because they are not robust against the pointer
increment, like isblank(*s++).

The same issue already exists for isspace().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 git-compat-util.h |  4 ++++
 wildmatch.c       | 14 ++------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4f0028ce60..90b43b2bc9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1212,10 +1212,12 @@ extern const unsigned char tolower_trans_tbl[256];
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
+#undef isblank
 #undef isdigit
 #undef isalpha
 #undef isalnum
 #undef isprint
+#undef isgraph
 #undef islower
 #undef isupper
 #undef tolower
@@ -1236,10 +1238,12 @@ extern const unsigned char sane_ctype[256];
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
 #define isascii(x) (((x) & ~0x7f) == 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
+#define isblank(x) (isspace(x) || (x) == '\t')
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
 #define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)
+#define isgraph(x) (isprint(x) && !isspace(x))
 #define islower(x) sane_iscase(x, 1)
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
diff --git a/wildmatch.c b/wildmatch.c
index 7e5a7ea1ea..85c4c7f8a7 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -28,18 +28,8 @@ typedef unsigned char uchar;
 # define ISASCII(c) isascii(c)
 #endif
 
-#ifdef isblank
-# define ISBLANK(c) (ISASCII(c) && isblank(c))
-#else
-# define ISBLANK(c) ((c) == ' ' || (c) == '\t')
-#endif
-
-#ifdef isgraph
-# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
-#else
-# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
-#endif
-
+#define ISBLANK(c) (ISASCII(c) && isblank(c))
+#define ISGRAPH(c) (ISASCII(c) && isgraph(c))
 #define ISPRINT(c) (ISASCII(c) && isprint(c))
 #define ISDIGIT(c) (ISASCII(c) && isdigit(c))
 #define ISALNUM(c) (ISASCII(c) && isalnum(c))
-- 
2.34.1

