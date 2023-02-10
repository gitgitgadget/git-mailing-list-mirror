Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8AAC636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 08:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjBJIAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 03:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjBJIAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 03:00:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7276BABD
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 00:00:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B49461C30
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 08:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E15FC4339C;
        Fri, 10 Feb 2023 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676016001;
        bh=Dbk/T8s5W42qTw0xjSTCY3wEmHNs22jwn8fu9tbEq80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpsuCLn8otVL/6G3wo8lGPUW1NrL6zQ0WeDnDZO2UNV9gmKRFP9cUNqbNjOpHC3bE
         N94hOnjse3EX22o/3kgGS5Jv/vGnn2sfcsrxHvKIdDMS41MbCZxXAa12dP/91DvBwf
         q+Ddq0bjAuo6UsBlsF6L6MKbHTMINwGPnq6qn6XZTiai6UmaO0AGsohkpBK6OjtMON
         syDbrS8L6xxUN/KwY+P3I/+Gc8nChm/n2eLEWYJDhikkjKX6i42GtL2l9yKwKl3Kye
         6WVd191dpveIhJK3i1AO4MVcC8QRI5q+9dpYOGYPgg0jXyT8aYa5dSgv6lZdWXKVKM
         VqnqvoQukLXwQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5/5] wildmatch: more cleanups after killing uchar
Date:   Fri, 10 Feb 2023 16:59:39 +0900
Message-Id: <20230210075939.44949-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210075939.44949-1-masahiroy@kernel.org>
References: <20230210075939.44949-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the local function dowild(), which is now equivalent to
wildmatch().

Remove the local variable, slash.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 wildmatch.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 7dffd783cb..24577e9b8e 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -17,7 +17,7 @@
 				    && strncmp(class, litmatch, len) == 0)
 
 /* Match pattern "p" against "text" */
-static int dowild(const char *p, const char *text, unsigned int flags)
+int wildmatch(const char *p, const char *text, unsigned int flags)
 {
 	char p_ch;
 	const char *pattern = p;
@@ -66,7 +66,7 @@ static int dowild(const char *p, const char *text, unsigned int flags)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] == '/' &&
-					    dowild(p + 1, text, flags) == WM_MATCH)
+					    wildmatch(p + 1, text, flags) == WM_MATCH)
 						return WM_MATCH;
 					match_slash = 1;
 				} else /* WM_PATHNAME is set */
@@ -88,10 +88,9 @@ static int dowild(const char *p, const char *text, unsigned int flags)
 				 * with WM_PATHNAME matches the next
 				 * directory
 				 */
-				const char *slash = strchr(text, '/');
-				if (!slash)
+				text = strchr(text, '/');
+				if (!text)
 					return WM_NOMATCH;
-				text = slash;
 				/* the slash is consumed by the top-level for loop */
 				break;
 			}
@@ -121,7 +120,7 @@ static int dowild(const char *p, const char *text, unsigned int flags)
 					if (t_ch != p_ch)
 						return WM_NOMATCH;
 				}
-				if ((matched = dowild(p, text, flags)) != WM_NOMATCH) {
+				if ((matched = wildmatch(p, text, flags)) != WM_NOMATCH) {
 					if (!match_slash || matched != WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!match_slash && t_ch == '/')
@@ -231,9 +230,3 @@ static int dowild(const char *p, const char *text, unsigned int flags)
 
 	return *text ? WM_NOMATCH : WM_MATCH;
 }
-
-/* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text, unsigned int flags)
-{
-	return dowild(pattern, text, flags);
-}
-- 
2.34.1

