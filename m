From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] Fix path normalization for SMB shares
Date: Wed,  5 Sep 2012 14:28:27 +0300
Message-ID: <1346844507-22998-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 13:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Dmz-0003vJ-HN
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab2IEL2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 07:28:50 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37965 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2IEL2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 07:28:49 -0400
Received: by wibhq12 with SMTP id hq12so4207305wib.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bnHmACK/QOoiHyd3GHcD/uq6fixpvpsCoLmhcbu3Axw=;
        b=FSdZYUq9ys350Ku6eFg/FF1BFC1+y3tNHM/QKEMDEfzaO0ShbN3QB2XEFyEPPwuhmC
         2xYn0zHGERENQfjVt9pFwL5r6gBnBajLnTLIL2SnOJ0P+TDbfbA5RK8SPia6i7d0i4WC
         rEBk2oQJIOY4yazt3tiNbmEO4OHqRcrEHzzpiIximWXYtHZrorFRR9oNt/oMB6oBXdM1
         qB2WjHRfWuCI4t2COYR8JstfMkUcAp8f+RfpTAsUEFuw+3Otwc/xIisia92/9IbD3Zm0
         2Hx7mAzWHIkIHNqjPs7n7pModMcjlujZqTquPzxTdS3SZm/oE0VqPEqh06DmIlb/PelS
         x4QA==
Received: by 10.180.20.11 with SMTP id j11mr37568994wie.12.1346844528512;
        Wed, 05 Sep 2012 04:28:48 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-229-111-212.inter.net.il. [84.229.111.212])
        by mx.google.com with ESMTPS id dw6sm63772wib.5.2012.09.05.04.28.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 04:28:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204815>

SMB shared are accessed using //server/share/directory...
notation.

normalize_path_copy used to leave only a single slash, which
invalidated the path.

Fix suggested by Nguyen Thai Ngoc Duy

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 path.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/path.c b/path.c
index 66acd24..6cd9c0b 100644
--- a/path.c
+++ b/path.c
@@ -503,6 +503,12 @@ int normalize_path_copy(char *dst, const char *src)
 		*dst++ = *src++;
 		*dst++ = *src++;
 	}
+#ifdef WIN32
+	else if (is_dir_sep(src[0]) && is_dir_sep(src[1])) {
+		*dst++ = '/';
+		src++;
+	}
+#endif
 	dst0 = dst;
 
 	if (is_dir_sep(*src)) {
-- 
1.7.10.4
