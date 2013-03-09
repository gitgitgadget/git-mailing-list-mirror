From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat,  9 Mar 2013 09:42:54 +0100
Message-ID: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, iveqy@iveqy.com, pclouds@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 09 09:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEFNT-0002v4-28
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab3CIInC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:43:02 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:39592 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab3CIInA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:43:00 -0500
Received: by mail-la0-f48.google.com with SMTP id fq13so2466714lab.35
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=B4jxh0a7cBHvg5uguOnliZnL4f6dJPs4U05VITPic4Q=;
        b=zl+aMDb7WWyeQJWwbSZIZrnKXbVSpcZWWLlItVNML5cUqr5JUQI7BTIa8yFTdFtfdT
         GSdtkm1sy8L1D8ZPCrYMqGyz7gnhnONo7V9yH+Mqa1NiltIgB8kNrPWLzUjYSbaSozYz
         fpFvAkC4o+UH5yBjTXhHoVns3ByClBv7GJ9GH75+9mTKx/+Rf55sWwP1NyOPVRiRi2IK
         qLmTqZJFt4x2UGHkVxYSAm+1FyoVG7oXuLStPG1QJ+e1POE2yz/v+AMdpoNhJiA7oQlJ
         h9420Haq3sSG7II8ej4oka9/yfYwKxLvtqAMrrf1Gc792MzRYKfmo8XhTGXDLUq8i/q3
         /KAg==
X-Received: by 10.112.25.202 with SMTP id e10mr2117906lbg.98.1362818577461;
        Sat, 09 Mar 2013 00:42:57 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id v7sm2408169lbg.13.2013.03.09.00.42.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 00:42:56 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UEFNA-0004On-Ht; Sat, 09 Mar 2013 09:43:20 +0100
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217712>

To improve performance.
git status before:
user    0m0.020s
user    0m0.024s
user    0m0.024s
user    0m0.020s
user    0m0.024s
user    0m0.028s
user    0m0.024s
user    0m0.024s
user    0m0.016s
user    0m0.028s

git status after:
user    0m0.012s
user    0m0.008s
user    0m0.008s
user    0m0.008s
user    0m0.008s
user    0m0.008s
user    0m0.008s
user    0m0.004s
user    0m0.008s
user    0m0.016s

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 dir.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..2b801e8 100644
--- a/dir.c
+++ b/dir.c
@@ -37,6 +37,17 @@ int fnmatch_icase(const char *pattern, const char *string, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
 }
 
+int strequal_icase(const char *first, const char *second)
+{
+	while (*first && *second) {
+		if( toupper(*first) != toupper(*second))
+			break;
+		first++;
+		second++;
+	}
+	return toupper(*first) == toupper(*second);
+}
+
 inline int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix)
 {
@@ -626,11 +637,11 @@ int match_basename(const char *basename, int basenamelen,
 		   int flags)
 {
 	if (prefix == patternlen) {
-		if (!strcmp_icase(pattern, basename))
+		if (!strequal_icase(pattern, basename))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <= basenamelen &&
-		    !strcmp_icase(pattern + 1,
+		    !strequal_icase(pattern + 1,
 				  basename + basenamelen - patternlen + 1))
 			return 1;
 	} else {
@@ -663,7 +674,7 @@ int match_pathname(const char *pathname, int pathlen,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] != '/') ||
-	    strncmp_icase(pathname, base, baselen))
+	    strequal_icase(pathname, base))
 		return 0;
 
 	namelen = baselen ? pathlen - baselen - 1 : pathlen;
-- 
1.8.1.5
