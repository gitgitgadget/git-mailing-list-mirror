From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 5/5] tree-walk: match_entry microoptimization
Date: Wed, 30 Mar 2011 20:38:01 -0500
Message-ID: <1301535481-1085-5-git-send-email-dpmcgee@gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:38:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56qR-0003Um-2I
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940Ab1CaBiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37679 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933835Ab1CaBiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:14 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1845353iyb.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ybeHqhOn9Ko1zx3Dwu1FHtjgbazgtaaSUOCc3aTiTjw=;
        b=uIJWMjV3KYT9cAtmKPdiMfPVFMKoieeBgdybRS2Z8xjQfJUdTLeo+ZtL9plIo8vBSk
         eq+5M0KdKJNNrAIdKOhgoxfiLAvnVnRuW5rpa2dy/eCDGdjPjajvTWf3dVSqopEa58wq
         ekCot/q7KJ1K3l4w9V4uC8CoJjt8+9G6oEPGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uV/ZrcjYdezicIn6S8i3Hwgqzf59O6/gDN+1May57Gw6ieSz2yW3DaBBXO4RHOYdMl
         QNq/lr6nzapeGxK0CA62zMICmMl4R6ZFGNF1t+2BCziTCojE/nH/odrolsg5X9Bgyq0k
         sgXE80/y1tPhB0VH5ZsPA8ruy403e86D/ITr4=
Received: by 10.42.222.5 with SMTP id ie5mr2007664icb.331.1301535494451;
        Wed, 30 Mar 2011 18:38:14 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id d10sm381225ibb.51.2011.03.30.18.38.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170444>

Before calling strncmp(), see if we can get away with checking only the
first character of the passed path components instead.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 tree-walk.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 41383b0..083b951 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -488,9 +488,10 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
 		       int *never_interesting)
 {
-	int m = -1; /* signals that we haven't called strncmp() */
+	int m = -1; /* signals that we haven't compared strings */
 
 	if (*never_interesting) {
+		const int maxlen = (matchlen < pathlen) ? matchlen : pathlen;
 		/*
 		 * We have not seen any match that sorts later
 		 * than the current path.
@@ -500,10 +501,13 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 		 * Does match sort strictly earlier than path
 		 * with their common parts?
 		 */
-		m = strncmp(match, entry->path,
-			    (matchlen < pathlen) ? matchlen : pathlen);
-		if (m < 0)
-			return 0;
+		if (maxlen && match[0] > entry->path[0]) {
+			/* no good for the shortcut here, match must be <= */
+		} else {
+			m = strncmp(match, entry->path, maxlen);
+			if(m < 0)
+				return 0;
+		}
 
 		/*
 		 * If we come here even once, that means there is at
@@ -531,12 +535,17 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 			return 0;
 	}
 
-	if (m == -1)
+	if (m == -1) {
 		/*
-		 * we cheated and did not do strncmp(), so we do
+		 * we cheated and did compare strings, so we do
 		 * that here.
 		 */
-		m = strncmp(match, entry->path, pathlen);
+		if (pathlen && match[0] == entry->path[0])
+			/* invariant: matchlen == pathlen */
+			m = strncmp(match, entry->path, pathlen);
+		else
+			m = 1;
+	}
 
 	/*
 	 * If common part matched earlier then it is a hit,
@@ -552,6 +561,7 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 static int match_dir_prefix(const char *base,
 			    const char *match, int matchlen)
 {
+	/* invariant: baselen >= matchlen */
 	if (strncmp(base, match, matchlen))
 		return 0;
 
-- 
1.7.4.2
