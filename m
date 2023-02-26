Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486CC7EE2D
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 11:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBZLu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 06:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZLuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 06:50:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F1E069
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 03:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16AD560BA0
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 11:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA49C433D2;
        Sun, 26 Feb 2023 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677412253;
        bh=YQbc0GVM9Q2ByFmQDmGltDBQskLZLau2TXPMg/dQM/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjPAVc2sspFXuowK0/L2PN/itlMkmXuKE4/EK2asX7+H6C291UymnJBVFbCNu4965
         JosB8/OWGee8dpp6vbD2p1Z5z2po92YpxDYDLawh/JmStc8bnFuRvbG7nmX1423Z+d
         T3BQD5+5hNpV6QpccfOTr84V+6PC0tRBu12m1cOhPbPvwcyNm4wPjhaVjv/rmzAc/+
         9iW8pbp/pxr4MQBNlDUQME4+5MUeVtHNYqfY/gD53Zwa8emo7T0CMVpnjzJn6pFlp/
         RTKF3+apOTKuEQaqu4jCN0jiYvHFWUyg8kBrlskmlMuBlfukZU1Ev/r9Tep5jZnPfi
         xUf57amfWW5Dw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/5] git-compat-util: add isblank() and isgraph()
Date:   Sun, 26 Feb 2023 20:50:17 +0900
Message-Id: <20230226115021.1681834-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226115021.1681834-1-masahiroy@kernel.org>
References: <20230226115021.1681834-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-compat-util.h implements most of is*() macros.

Add isblank() and isgraph(), which are useful to clean up wildmatch.c
in a consistent way (in this and later commits).

In the previous submission, I just moved isblank() and isgraph() as
implemented in wildmatch.c. I knew they were not robust against the
pointer increment like isblank(*s++), but I thought it was the same
pattern as isprint(), which has the same issue. Unfortunately, it was
more controversial than I had expected...

This version implements them as inline functions because we ran out
all bits in the sane_ctype[] table. This is the same pattern as
islower() and isupper().

Once we refactor ctype.c to create more room in sane_ctype[], isblank()
and isgraph() will be able to use sane_istest(). Probably so will
islower() and isupper(). The ctype in Linux kernel (lib/ctype.c) has
the LOWER and UPPER bits separately.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Use inline functions

 git-compat-util.h | 14 ++++++++++++++
 wildmatch.c       | 14 ++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4f0028ce60..b29c238f02 100644
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
+#define isblank(x) sane_isblank(x)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
 #define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)
+#define isgraph(x) sane_isgraph(x)
 #define islower(x) sane_iscase(x, 1)
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
@@ -1270,6 +1274,16 @@ static inline int sane_iscase(int x, int is_lower)
 		return (x & 0x20) == 0;
 }
 
+static inline int sane_isblank(int c)
+{
+	return c == ' ' || c == '\t';
+}
+
+static inline int sane_isgraph(int c)
+{
+	return isprint(c) && !isspace(c);
+}
+
 /*
  * Like skip_prefix, but compare case-insensitively. Note that the comparison
  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
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

