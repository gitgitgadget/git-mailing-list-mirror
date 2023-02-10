Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F81BC636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 04:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjBJEwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 23:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjBJEv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 23:51:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B877150
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 20:51:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C45B3B823BA
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 04:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB6FC433D2;
        Fri, 10 Feb 2023 04:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676004686;
        bh=r/j05jubHUU2m0vDuSvE25xQLMlVjLi3/c2Jsv2jPH0=;
        h=From:To:Cc:Subject:Date:From;
        b=JmIyccuKClB0RUmWtQrkW/XRQZJ+LhUGzJiJF39FdvIo2ClYf/YuiY2xpNTm5A2Ra
         dI4hXR+ToRJV/3M4Y8HZ3OAE+zBpsZUrSDEHK+o+llAro5ZePpRXI0QhzprIDE72xc
         8MwzkfMT/6YkihX2FizE2MgB/P+cY8k8qYAQcQpAVEufwAq1INm6ULJXhQO2UHJcfU
         fKt3nhURJ5KKpa/RrUi+DHFSeCNCzfbihiP7sG8qDRpAjlWivUavxPUSooIuBaYPif
         lWzJRTJVnxqI4DIBiK5DnBkiNg4Lkj91AW7v73PmDf/K7SrJSLrSN/6e1CueY5gloi
         z6nwtpVcZFTDA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] dir: remove unneeded local variables from match_pathname()
Date:   Fri, 10 Feb 2023 13:51:19 +0900
Message-Id: <20230210045119.25190-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The local variables are unneeded - you can simply advance the 'pathname'
pointer.

IMHO, the variable 'name' is somewhat confusing. It is a relative path
to 'base', not a file name. It may contain slashes.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 dir.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index 4e99f0c868..06c6e7d79e 100644
--- a/dir.c
+++ b/dir.c
@@ -1251,9 +1251,6 @@ int match_pathname(const char *pathname, int pathlen,
 		   const char *base, int baselen,
 		   const char *pattern, int prefix, int patternlen)
 {
-	const char *name;
-	int namelen;
-
 	/*
 	 * match with FNM_PATHNAME; the pattern has base implicitly
 	 * in front of it.
@@ -1273,35 +1270,37 @@ int match_pathname(const char *pathname, int pathlen,
 	    fspathncmp(pathname, base, baselen))
 		return 0;
 
-	namelen = baselen ? pathlen - baselen - 1 : pathlen;
-	name = pathname + pathlen - namelen;
+	if (baselen > 0) {
+		pathname += baselen + 1;
+		pathlen -= baselen + 1;
+	}
 
 	if (prefix) {
 		/*
 		 * if the non-wildcard part is longer than the
 		 * remaining pathname, surely it cannot match.
 		 */
-		if (prefix > namelen)
+		if (prefix > pathlen)
 			return 0;
 
-		if (fspathncmp(pattern, name, prefix))
+		if (fspathncmp(pattern, pathname, prefix))
 			return 0;
 		pattern += prefix;
 		patternlen -= prefix;
-		name    += prefix;
-		namelen -= prefix;
+		pathname += prefix;
+		pathlen -= prefix;
 
 		/*
 		 * If the whole pattern did not have a wildcard,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && !namelen)
+		if (!patternlen && !pathlen)
 			return 1;
 	}
 
 	return fnmatch_icase_mem(pattern, patternlen,
-				 name, namelen,
+				 pathname, pathlen,
 				 WM_PATHNAME) == 0;
 }
 
-- 
2.34.1

